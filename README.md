# Timezone Travel

This project helps in dealing with timezone issues. Setting your
computer's clock to a different timezone is often not a good idea since
everything relies on a correctly working clock.

This project offers a Docker image that allows to safely run your
code in different timezones.


## Create Docker image 

    $ make image  

This creates an image named `timezonetravel`.
To remove the image from your docker host again use

    $ make clean


## Travel
        
Learn how to travel with        
        
    $ ./travel.sh -h


        
