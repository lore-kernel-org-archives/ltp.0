From: James Dong =?unknown-8bit?b?6JGj5LiW5rGf?= <dongshijiang@inspur.com>
Date: Thu, 3 Jun 2021 10:27:49 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gbHRwLWFpb2Rpby9kaW9fYXBw?=
 =?gb2312?b?ZW5kOiBmaXggZGlvX2FwcGVuZCgp?=
In-Reply-To: <60B8A96C.8080503@fujitsu.com>
References: <d87da351dd8cd8c8e51afc8922162e84@sslemail.net>
 <60B8A96C.8080503@fujitsu.com>
Message-ID: <befea6726fc7467b9410db3e3b961f3e@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi xuyang
1. if not create directory, in the function dio_append The open file returns a failure, Because the directory "aiodio" does not exist.
2. The mkdir command is called to recursively create directories

-----????-----
???: xuyang2018.jy@fujitsu.com [mailto:xuyang2018.jy@fujitsu.com] 
????: 2021?6?3? 18:05
???: James Dong (???) <dongshijiang@inspur.com>
??: ltp@lists.linux.it
??: Re: [LTP] [PATCH] ltp-aiodio/dio_append: fix dio_append()

Hi dong
> When running the dio_append test in the ltp-aiodiio.part4 test item, there was a problem that the file could not be created, but the test result was PASS. To this end, the following operations have been added.
> 1. create the directory where the file is located.
Why need to create directory?
> 2. rewrite the dio_append API. Add relevant return values.
>
> Signed-off-by: dongshijiang<dongshijiang@inspur.com>
> ---
>   testcases/kernel/io/ltp-aiodio/dio_append.c | 26 +++++++++++++++------
>   1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
> index 3f0ed29d5..500dfdc31 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -75,7 +75,7 @@ int read_eof(char *filename)
>   	return 0;
>   }
>
> -void dio_append(char *filename)
> +int dio_append(char *filename)
>   {
>   	int fd;
>   	void *bufptr;
> @@ -86,14 +86,14 @@ void dio_append(char *filename)
>
>   	if (fd<  0) {
>   		perror("cannot create file");
> -		return;
> +		return 1;
>   	}
>
>   	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
>   	if (TEST_RETURN) {
>   		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
>   		close(fd);
> -		return;
> +		return 1;
>   	}
>
>   	memset(bufptr, 0, 64 * 1024);
> @@ -102,17 +102,29 @@ void dio_append(char *filename)
>   			fprintf(stderr, "write %d returned %d\n", i, w);
>   		}
>   	}
> +	return 0;
>   }
>
>   int main(void)
>   {
> -	char filename[PATH_MAX];
> +	char filename[PATH_MAX], filepath[PATH_MAX-5];
>   	int pid[NUM_CHILDREN];
>   	int num_children = 1;
>   	int i;
> +	int ret = -1;
>
> -	snprintf(filename, sizeof(filename), "%s/aiodio/file",
> +	snprintf(filepath, sizeof(filepath), "%s/aiodio",
>   		 getenv("TMP") ? getenv("TMP") : "/tmp");
> +
> +	if (access(filepath, F_OK) == -1) {
> +		char command[PATH_MAX + 10];
> +
> +		snprintf(command, sizeof(command), "mkdir -p %s", filepath);
> +		if (system(command) != 0)
> +			return 1;
just only call mkdir syscall instead of command.
> +	}
> +
> +	snprintf(filename, sizeof(filename), "%s/file", filepath);
>
>   	printf("Begin dio_append test...\n");
>
> @@ -134,10 +146,10 @@ int main(void)
>   	 * Parent appends to end of file using direct i/o
>   	 */
>
> -	dio_append(filename);
> +	ret = dio_append(filename);
>
>   	for (i = 0; i<  num_children; i++) {
>   		kill(pid[i], SIGTERM);
>   	}
> -	return 0;
> +	return ret;
>   }
