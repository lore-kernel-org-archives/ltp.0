Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxidR-0007tB-VQ
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:45:57 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxidL-0006DW-C5
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:45:57 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEgt1g031127
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 10:42:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEjjf5245782
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 10:45:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEgJiv020456
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 10:42:19 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910050857.n958vIGW000336@e31.co.us.ibm.com>
References: <200910050857.n958vIGW000336@e31.co.us.ibm.com>
Date: Tue, 13 Oct 2009 20:14:34 +0530
Message-Id: <1255445074.8438.80.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add tests for utimes() with NULL tv
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Sat, 2009-07-11 at 22:17 +0200, Jiri Palecek wrote: 
> Hello,
> 
> this adds some test cases for utimes(), among those one that actually should return EACCESS.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

This one also fails probably because of the same reason:

patching file testcases/kernel/syscalls/utimes/utimes01.c
Hunk #1 succeeded at 145 (offset -14 lines).
Hunk #2 succeeded at 225 (offset -2 lines).
Hunk #3 succeeded at 272 with fuzz 1 (offset -7 lines).
Hunk #4 FAILED at 284.
Hunk #5 succeeded at 317 (offset 4 lines).
1 out of 5 hunks FAILED -- saving rejects to file
testcases/kernel/syscalls/utimes/utimes01.c.rej

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/utimes/utimes01.c |   41 ++++++++++++++++++++------
>  1 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
> index 2fddb99..370db5c 100644
> --- a/testcases/kernel/syscalls/utimes/utimes01.c
> +++ b/testcases/kernel/syscalls/utimes/utimes01.c
> @@ -159,6 +159,7 @@ enum test_type {
>  		NORMAL,
>  		FILE_NOT_EXIST,
>  	        NO_FNAME,
> +         NULL_TIMES
>  };
> 
> 
> @@ -226,6 +227,19 @@ static struct test_case tcase[] = {
>                  .ret            = -1,
>                  .err            = EFAULT,
>          },
> +        { // case05
> +                .ttype          = NULL_TIMES,
> +                .a_sec          = 1000,
> +                .m_sec          = 2000,
> +                .user           = "nobody",
> +                .ret            = -1,
> +                .err            = EACCES
> +        },
> +	{ // case06
> +                .ttype          = NULL_TIMES,
> +                .ret            = 0,
> +                .err            = 0,
> +        },
>  };
> 
>  /*
> @@ -265,7 +279,8 @@ static int do_test(struct test_case *tc)
>                  fpath=FNAME_NX;
>          }
>          errno = 0;
> -        if (tc->ttype == NO_FNAME) {
> +        switch(tc->ttype) {
> +        case NO_FNAME:
>                  /**
>                   * Note (garrcoop):
>                   *
> @@ -276,12 +291,17 @@ static int do_test(struct test_case *tc)
>                   **/
>                  const char *dummy = NULL;
>                  TEST(sys_ret = utimes(dummy, tv));
> +                break;
> +        case NULL_TIMES:
> +                TEST(utimes(fpath, NULL));
> +                gettimeofday(tv, NULL);
> +                tv[1]=tv[0];
> +                break;
> +        default:
> +                TEST(utimes(fpath, tv));
> +                break;
>          }
> -	else
> -                TEST(sys_ret = utimes(fpath, tv));
> -        sys_errno = errno;
> -        if (sys_ret < 0)
> -                goto TEST_END;
> +        if(TEST_RETURN == 0) {
> 
>  	/*
>           * Check test file's time stamp
> @@ -293,14 +313,15 @@ static int do_test(struct test_case *tc)
>                  goto EXIT1;
>          }
>          tst_resm(TINFO,"E:%ld,%ld <=> R:%ld,%ld",tv[0].tv_sec, tv[1].tv_sec, st.st_atime, st.st_mtime);
> -        cmp_ok = st.st_atime == tv[0].tv_sec && st.st_mtime == tv[1].tv_sec;
> +        cmp_ok = abs( st.st_atime - tv[0].tv_sec ) <= 1 &&
> +                 abs( st.st_mtime - tv[1].tv_sec ) <= 1;
> 
> +        }
>          /*
>           * Check results
>           */
> -TEST_END:
> -        result |= (sys_errno != tc->err) || !cmp_ok;
> -        PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,cmp_ok);
> +        result |= (TEST_ERRNO != tc->err) || !cmp_ok;
> +        PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, (int)TEST_RETURN, (int)TEST_ERRNO, cmp_ok);
> 
>          /*
>           * Restore effective user id


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
