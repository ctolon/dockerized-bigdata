For the first time, we need to build the base image with the following command:

```bash
bash build-base-image.sh
```

```bash
docker-compose up --scale spark-worker=3
```

Makefile, we can submit the job with the following command:

```bash
make submit app=data_analysis_book/chapter03/word_non_null.py
```

it executes the following command:

```bash
docker exec da-spark-master spark-submit --master spark://spark-master:7077 --deploy-mode client ./apps/data_analysis_book/chapter03/word_non_null.py
```