Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W2lTs-00055O-LO
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 17:39:20 +0000
Date: Mon, 13 Jan 2014 18:38:55 +0100
From: chrubis@suse.cz
Message-ID: <20140113173855.GD1945@rei>
References: <52CFC6D1.4060006@oracle.com>
	<1389605723-17937-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389605723-17937-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] setregid02, setresuid03: inval_user fix
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
> index 9bb0abd..085ed7b 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid03.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
> @@ -70,10 +70,12 @@
>  #include <errno.h>
>  #include <sys/wait.h>
>  
> +#include <compat_16.h>
> +
>  char *TCID = "setresuid03";
>  
>  uid_t neg_one = -1;
> -uid_t inval_user = (USHRT_MAX - 2);
> +uid_t inval_user;
>  
>  /* flag to tell parent if child passed or failed. */
>  int flag = 0;
> @@ -232,6 +234,10 @@ void setup(void)
>  	bin = *(getpwnam("bin"));
>  	bin_pw_uid = bin.pw_uid;
>  
> +	inval_user = GET_UNUSED_UID();
> +	if (inval_user == -1)
> +		tst_brkm(TBROK, NULL, "No free uid found");
> +
>  	/* Pause if that option was specified
>  	 * TEST_PAUSE contains the code to fork the test with the -i option.
>  	 * You want to make sure you do this before you create your temporary

Hmm, the setresuid03 did not fail because the EPERM check kicks in even
before the check for correct uid/gid. Which should probably be fixed
because there does not seem to be a setresuid test for invalid values
that would actually excercise such checks, but that can be fixed after
the release.

Thanks for the patches, I will commit them right after packages are
build and I have tested that everything is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
