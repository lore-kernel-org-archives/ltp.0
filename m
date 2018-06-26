From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jun 2018 17:27:42 +0200
Subject: [LTP] [PATCH 1/2] syscalls/fchmod03.c: Convert to new API &&
 merge fchmod04 into fchmod03
In-Reply-To: <1528975762-10624-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1528975762-10624-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180626152742.GB20724@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	struct stat stat_buf;
> +	mode_t modes;
> +
> +	for (i = 0; i < 2; i++) {

Huh, wouldn't it be easier if we set .tcnt = 2 in the test structure?

Then the test function would be executed twice and you will get the i as
a parameter...

> +		TEST(fchmod(fd[i], PERMS));
> +		if (TEST_RETURN == -1)
> +			tst_res(TFAIL | TTERRNO, "fchmod() failed unexpectly");
> +
> +		SAFE_FSTAT(fd[i], &stat_buf);
> +		modes = stat_buf.st_mode;
> +
> +		if ((modes & PERMS) != PERMS) {
> +			tst_res(TFAIL,
> +				"%s: Incorrect modes 0%3o, Expected 0%03o",
> +				TESTFILE, modes, PERMS);
> +		} else {
> +			tst_res(TPASS,
> +				"Functionality of fchmod(%d, %#o) successful",
> +				fd[i], PERMS);
>  		}
> -		/*
> -		 * Get the file information using
> -		 * fstat(2).
> -		 */
> -		if (fstat(fd, &stat_buf) == -1)
> -			tst_brkm(TFAIL | TERRNO, cleanup,
> -				 "fstat failed");
> -		file_mode = stat_buf.st_mode;
> -
> -		/* Verify STICKY BIT set on testfile */
> -		if ((file_mode & PERMS) != PERMS)
> -			tst_resm(TFAIL, "%s: Incorrect modes 0%3o, "
> -				 "Expected 0777", TESTFILE, file_mode);
> -		else
> -			tst_resm(TPASS, "Functionality of fchmod(%d, "
> -				 "%#o) successful", fd, PERMS);
>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }

Also the test only checks for "the process is owner of the file" we
should test for the second case the description lists, i.e. "the
effective group ID or one of the supplementary group ID's of the process
is equal to the group ID of the file." as well, shouldn't we? Well since
that does not seem to be part of the original tests it would be better
if we added that in a subseqent patch though.


-- 
Cyril Hrubis
chrubis@suse.cz
