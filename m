From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Nov 2015 13:41:30 +0100
Subject: [LTP] [PATCH 1/3] diotest: cleanup & fix
In-Reply-To: <1446137758-27267-1-git-send-email-chnyda@suse.com>
References: <1446137758-27267-1-git-send-email-chnyda@suse.com>
Message-ID: <20151104124130.GB17823@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void fail_clean(int fd1, int fd2, char *infile, char *outfile)
>  {
>  	close(fd1);
>  	close(fd2);
> @@ -98,7 +93,8 @@ int main(int argc, char *argv[])
>  	while ((i = getopt(argc, argv, "b:n:i:o:")) != -1) {
>  		switch (i) {
>  		case 'b':
> -			if ((bufsize = atoi(optarg)) <= 0) {
> +			bufsize = atoi(optarg);
> +			if (bufsize <= 0) {
>  				fprintf(stderr, "bufsize must be > 0\n");
>  				prg_usage();
>  			}
> @@ -109,7 +105,8 @@ int main(int argc, char *argv[])
>  			}
>  			break;
>  		case 'n':
> -			if ((numblks = atoi(optarg)) <= 0) {
> +			numblks = atoi(optarg);
> +			if (numblks <= 0) {
>  				fprintf(stderr, "numblks must be > 0\n");
>  				prg_usage();
>  			}
> @@ -126,21 +123,25 @@ int main(int argc, char *argv[])
>  	}
>  
>  	/* Test for filesystem support of O_DIRECT */
> -	if ((fd = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
> -		tst_brkm(TCONF,
> -			 NULL,
> -			 "O_DIRECT is not supported by this filesystem.");
> -	} else {
> -		close(fd);
> -	}
> +	fd = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666);
> +	if (fd < 0 && errno == EINVAL)
> +		tst_brkm(TCONF, NULL,
> +			 "O_DIRECT is not supported by this filesystem. %s",
> +			 strerror(errno));
> +	else if (fd < 0)

Well LKML coding style preffers to have curly braces if the statement
spans across multiple lines, even if it's one function call. Not that
this is a big problem, we have quite a lot of code that does not reflect
that.

> +		tst_brkm(TBROK, NULL, "Couldn't open test file %s: %s",
> +			 infile, strerror(errno));
> +	close(fd);
>  
>  	/* Open files */
> -	if ((fd1 = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666)) < 0) {
> +	fd1 = open(infile, O_DIRECT | O_RDWR | O_CREAT, 0666);
> +	if (fd1 < 0) {
>  		tst_brkm(TFAIL, NULL, "open infile failed: %s",
>  			 strerror(errno));
>  	}

Can you pretty please change all the open statements into to
SAFE_OPEN()?

You would have to convert the fail_clean() into cleanup() without any
parameters (make fd1, fd2 global...) in this case but that shouldn't be
that hard...


Otherwise the changes looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
