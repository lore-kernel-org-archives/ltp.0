From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jun 2021 14:05:22 +0200
Subject: [LTP] [PATCH 2/2] syscalls/fchown: Convert fchown05 to the new
 API
In-Reply-To: <20210531112522.9082-3-xieziyao@huawei.com>
References: <20210531112522.9082-1-xieziyao@huawei.com>
 <20210531112522.9082-3-xieziyao@huawei.com>
Message-ID: <YLjFgjJ94RuE7zRe@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	{"Change Owner/Group ids", 700, 701},
> -	{"Change Owner id only", 702, -1},
> -	{"Change Owner id only", 703, 701},
> -	{"Change Group id only", -1, 704},
> -	{"Change Group id only", 703, 705},
> -	{NULL, 0, 0}
> +	{700, 701},
> +	{702, 701},
> +	{702, 703},
> +	{704, 705}
>  };

Can we please keep the tests where we check that -1 does not change the
value and where we asert that the previously set value is still there
after the fchown call?

We may as well add a check that fchown(fd, -1, -1) is no-op.

> +	TST_EXP_PASS(FCHOWN(fd, tc[i].uid, tc[i].gid));

This produces a bit ugly output, what about adding format string and
parameters like:

	TST_EXP_PASS(FCHOWN(fd, tc[i].uid, tc[i].gid),
	             "fchwon(%i, %i, %i)", fd, tc[i].uid, tc[i].gid);

I guess I will push a similar patch that fixes this for fchown04 as well.

>  static void cleanup(void)
>  {
> -	if (fildes > 0 && close(fildes))
> -		tst_resm(TWARN | TERRNO, "close(%s) Failed", TESTFILE);
> -
> -	tst_rmdir();
> +	SAFE_CLOSE(fd);

We really have to check if the fd has been opened, since the test can
exit in any SAFE_MACRO() so this has to be:

	if (fd > 0)
		SAFE_CLOSE(fd);


Other than these this is a nice cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
