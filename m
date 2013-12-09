Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vq45Z-0001dB-Vd
	for ltp-list@lists.sourceforge.net; Mon, 09 Dec 2013 16:53:46 +0000
Date: Mon, 9 Dec 2013 17:53:09 +0100
From: chrubis@suse.cz
Message-ID: <20131209165309.GA20943@rei.suse.cz>
References: <1385101595.1552.11.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385101595.1552.11.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] fchown/fchown04.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> -char test_home[PATH_MAX];	/* variable to hold TESTHOME env */
>  char *TCID = "fchown04";
> -int TST_TOTAL = 2;
> -int exp_enos[] = { EPERM, EBADF, 0 };
> -
> -char bin_uid[] = "bin";
> -struct passwd *ltpuser;
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static int exp_enos[] = { EPERM, EBADF, 0 };
>  
> -void setup();			/* Main setup function for the tests */
> -void cleanup();			/* cleanup function for the test */
> +static void setup(void);
> +static void cleanup(void);
>  
>  int main(int ac, char **av)
>  {
>  	int lc;
> -	char *msg;
> -	int fd;			/* test file descriptor */
>  	int i;
> -	uid_t user_id;		/* Effective user id of a test process */
> -	gid_t group_id;		/* Effective group id of a test process */
> -
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> -		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

Again, please do not remove the option parsing code.

>  	setup();
>  
>  	TEST_EXP_ENOS(exp_enos);
>  
> -	user_id = geteuid();
> -	group_id = getegid();
> -
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  
>  		tst_count = 0;
>  
>  		for (i = 0; i < TST_TOTAL; i++) {
>  
> -			fd = test_cases[i].fd;
> -
> -			if (fd == 1)
> -				fd = fd1;
> -			else
> -				fd = fd2;
> -
> -			TEST(fchown(fd, user_id, group_id));
> +			TEST(fchown(*test_cases[i].fd, geteuid(), getegid()));
>  
>  			if (TEST_RETURN == -1) {
> -				if (TEST_ERRNO == test_cases[i].exp_errno)
> +				if (TEST_ERRNO == test_cases[i].exp_errno) {
>  					tst_resm(TPASS | TTERRNO,
>  						 "fchown failed as expected");
> -				else
> +				} else {
>  					tst_resm(TFAIL | TTERRNO,
>  						 "fchown failed unexpectedly; "
>  						 "expected %d - %s",
>  						 test_cases[i].exp_errno,
>  						 strerror(test_cases[i].
>  							  exp_errno));
> -			} else
> +				}
> +			} else {
>  				tst_resm(TFAIL, "fchown passed unexpectedly");
> +			}
>  		}
>  
>  	}
> @@ -171,58 +146,39 @@ int main(int ac, char **av)
>  	tst_exit();
>  }
>  
> -void setup()
> +static void setup(void)
>  {
> -	int i;
> +	struct passwd *ltpuser;
>  
>  	TEST_PAUSE;
>  
>  	tst_require_root(NULL);
>  
> -	ltpuser = SAFE_GETPWNAM(NULL, bin_uid);
> -
> -	tst_tmpdir();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	initgroups("root", getgid());
> +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
>  
> -	SAFE_SETEGID(NULL, ltpuser->pw_uid);
> -	SAFE_SETEUID(NULL, ltpuser->pw_gid);
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
>  
>  	tst_tmpdir();
>  
> -	for (i = 0; i < TST_TOTAL; i++)
> -		if (test_cases[i].setupfunc != NULL)
> -			test_cases[i].setupfunc();
> -}
> -
> -void setup1()
> -{
> -	int old_uid;
> -	struct passwd *nobody;
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
> +	/* EPERM */
>  	fd1 = SAFE_OPEN(cleanup, TEST_FILE1, O_RDWR | O_CREAT, 0666);
>  
> -	old_uid = geteuid();
> -
>  	SAFE_SETEUID(cleanup, 0);
>  
> -	nobody = SAFE_GETPWNAM(cleanup, "nobody");
> -
> -	if (fchown(fd1, nobody->pw_uid, nobody->pw_gid) < 0)
> +	if (fchown(fd1, 0, 0) < 0)
>  		tst_brkm(TBROK | TERRNO, cleanup, "fchown failed");
>  
> -	SAFE_SETEUID(cleanup, old_uid);
> -}
> -
> -void setup2()
> -{
> +	/* EBADF */
>  	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_RDWR | O_CREAT, 0666);
> +
>  	SAFE_CLOSE(cleanup, fd2);
> +
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
>  }
>  

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
