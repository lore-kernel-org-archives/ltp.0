From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 Nov 2019 07:01:36 -0500 (EST)
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <20191128093610.6903-2-mdoucha@suse.cz>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz>
Message-ID: <26933665.14359191.1575028896043.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

<snip>

>  
>  static void run(void)
>  {
> -	char buf[FALLOCATE_SIZE];
> -	ssize_t ret;
> +	size_t bufsize, i;
> +	struct stat statbuf;
>  
>  	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
>  
> -	if (fallocate(fd, 0, 0, FALLOCATE_SIZE)) {
> -		if (errno == EOPNOTSUPP) {
> -			tst_res(TCONF | TERRNO, "fallocate() not supported");
> +	// Use real FS block size, otherwise fallocate() call will test
> +	// different things on different platforms

Style guide favors c-style comments.

> +	SAFE_FSTAT(fd, &statbuf);
> +	bufsize = FALLOCATE_BLOCKS * statbuf.st_blksize;
> +	buf = realloc(buf, bufsize);
> +
> +	if (!buf) {
> +		tst_brk(TBROK, "Buffer allocation failed");
> +		SAFE_CLOSE(fd);
> +		return;

Anything after TBROK will be unreachable.

> +	}
> +
> +	TEST(fallocate(fd, 0, 0, bufsize));
> +
> +	if (TST_RET) {
> +		if (errno == ENOTSUP) {

TEST_ERR

> +			tst_res(TCONF | TTERRNO, "fallocate() not supported");

tst_brk would make more sense here. If we fail here we can end the test.

>  			SAFE_CLOSE(fd);
>  			return;
>  		}
>  
> -		tst_brk(TBROK | TERRNO,
> -			"fallocate(fd, 0, 0, %i)", FALLOCATE_SIZE);
> +		tst_brk(TBROK | TTERRNO, "fallocate(fd, 0, 0, %i)", bufsize);
>  	}
>  
>  	tst_fill_fs(MNTPOINT, 1);
>  
> -	ret = write(fd, buf, sizeof(buf));
> +	TEST(write(fd, buf, bufsize));
>  
> -	if (ret < 0)
> -		tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
> +	if (TST_RET < 0)
> +		tst_res(TFAIL | TTERRNO, "write() failed unexpectedly");
> +	else if (TST_RET != bufsize)
> +		tst_res(TFAIL,
> +			"Short write(): %ld bytes (expected %zu)",
> +			TST_RET, bufsize);
>  	else
> -		tst_res(TPASS, "write() wrote %zu bytes", ret);
> +		tst_res(TPASS, "write() wrote %ld bytes", TST_RET);
>  
> -	ret = fallocate(fd, 0, FALLOCATE_SIZE, FALLOCATE_SIZE);
> -	if (ret != -1)
> +	// fallocate(1 block) may pass here on XFS. Original test allocated
> +	// 8KB (2 blocks on x86) so keep the original behavior.
> +	TEST(fallocate(fd, 0, bufsize, 2 * statbuf.st_blksize));

I don't understand why there is need to find minimum value that can
satisfy this check. It looks like we are testing tst_fill_fs() more
than fallocate().

In other words, what is wrong with current test? Is the problem that
FALLOCATE_SIZE (1M) is not aligned on all platforms? Or is the test
invalid with FALLOCATE_SIZE that big? Or both?

<snip>

>  
> @@ -80,6 +102,9 @@ static void cleanup(void)
>  {
>  	if (fd > 0)
>  		SAFE_CLOSE(fd);
> +
> +	if (buf)

Check is not needed, free() can handle NULL.

