From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 16:44:22 +0100
Subject: [LTP] [PATCH v3 3/5] llistxattr: improved code readability and
In-Reply-To: <1478084391-30192-4-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478084391-30192-4-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102154422.GF28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void verify_llistxattr(unsigned int n)
> @@ -59,7 +57,7 @@ static void verify_llistxattr(unsigned int n)
>  
>  	TEST(llistxattr(name, NULL, 0));
>  	if (TEST_RETURN == -1) {
> -		tst_res(TFAIL | TERRNO, "llistxattr() failed");
> +		tst_res(TFAIL | TTERRNO, "llistxattr() failed");

The TERRNO -> TTERRNO has been fixed by:

https://github.com/linux-test-project/ltp/commit/00b4cdeed78d43e3f9dca769ef444f68cbb681c1

Please rebase this patch.

>  		return;
>  	}
>  
> @@ -71,8 +69,6 @@ static void verify_llistxattr(unsigned int n)
>  
>  static void setup(void)
>  {
> -	int ret;
> -

This removal should have been part of the prevous patch, right?

>  	SAFE_TOUCH(filename[0], 0644, NULL);
>  
>  	SAFE_TOUCH(filename[1], 0644, NULL);

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
