# Deploy a R Shiny App to Azure Web Apps
In this example we demonstrate how to deploy an [R Shiny App](https://shiny.rstudio.com/) to [Azure Web Apps](https://azure.microsoft.com/en-us/services/app-service/web/?msclkid=f7f24452c56111ecbd8e14405292538f). This R app can be created using [Azure Machine Learning](https://docs.microsoft.com/en-us/azure/machine-learning/overview-what-is-azure-machine-learning). This platform gives support to [R Studio](https://docs.microsoft.com/en-us/shows/Azure/R-in-Azure-ML-Studio?msclkid=5412d747c56311ecb14aa6fa584df158) and enable users to develop Shiny apps through it.

These examples were inspired in this post: https://www.puresourcecode.com/programming-languages/r/deploying-dockerized-r-shiny-apps-on-microsoft-azure/ with some adaptations.We also use a Shiny app example from this [tutorial](https://github.com/rstudio-education/shiny.rstudio.com-tutorial/blob/master/part-1-code/02-hist-app.R)

## Prerequisites

* [Docker](https://www.docker.com/) to build docker images
* [az-cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) to deploy the apps
* You must have a Pay-As-You-Go Azure account with administrator - or contributor-level access to your subscription. If you don't have an account, you can sign up for an account following the instructions here: https://azure.microsoft.com/en-au/pricing/purchase-options/pay-as-you-go/.

    <br>**IMPORTANT**: Azure free subscriptions have quota restrictions that prevent the workshop resources from being create successfully. Please use a Pay-As-You-Go subscription instead.

    <br>**IMPORTANT**: When you create the lab resources in your own subscription you are responsible for the charges related to the use of the services provisioned. For more information about the list of services and tips on how to save money when executing these labs, please visit the [Azure Cost Management Documentation](https://docs.microsoft.com/en-us/azure/cost-management-billing/cost-management-billing-overview#:~:text=%20Understand%20Azure%20Cost%20Management%20%201%20Plan,the%20Azure%20Cost%20Management%20%20Billing...%20More%20).

* Please create the resources in a separated Resource Group.
* [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/?msclkid=07577e8ac57411ec82bbee074c326fa6) to register the docker images and containers
* [Azure Web Apps](https://azure.microsoft.com/en-us/services/app-service/web/?msclkid=f7f24452c56111ecbd8e14405292538f) to host Shiny apps

## Quick start
First clone this repo in your environment.

- Build the app image
```docker build -t my-shiny-app/ .```

- Login to ACR (Azure Container Registry)
```az acr login --name labshinyapps```

- Tag your image
```docker tag my-shiny-app labshinyapps.azurecr.io/my-shiny-app```

- Push the image
```docker push labshinyapps.azurecr.io/my-shiny-app```

- Enable admin in your ACR (only once)
```az acr update -n labshinyapps --admin-enabled true```

- Create an Webapp based on your container
az webapp create --resource-group RG-SHINY-APPS --plan labshinyapps --name labshinyapps -i labshinyapps.azurecr.io/my-shiny-app:latest
