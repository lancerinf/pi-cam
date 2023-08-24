# pi-cam
Here is a script that I can use to take a camera pic on my rPi and upload it to some well-known locations on S3 for later use


## Prerequisites

### fswebcam
The CLI utility we'll use to take the pic and save it to file
```bash
apt install fswebcam
```

### awscli
The CLI utility we'll use to upload the picture to S3
```bash
pip install awscli
```

### S3 bucket/buckets and IAM user
This script assumes the presence of local credentials sufficient to call `aws s3 cp` and one or more destination buckets that the user has permissions to upload to.
