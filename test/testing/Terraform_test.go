package test

import (
	"fmt"
	"testing"
	"time"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformAwsUnir(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../environments/testing",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	publicIp := terraform.Output(t, terraformOptions, "testing_alb_url")

	url := fmt.Sprintf("http://%s", publicIp)

	timer := time.NewTimer(120 * time.Second)

    <-timer.C

	http_helper.HttpGet(t, url, nil)

}
