Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QA3Z3-00061D-SM
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 17:09:13 +0000
Date: Wed, 13 Apr 2011 19:33:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110413173333.GC3206@saboteur.suse.cz>
References: <20110401144407.GA24854@saboteur.suse.cz>
	<b262ce2a7b471caa002c96fbef62b10c3229b56a.1302595212.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b262ce2a7b471caa002c96fbef62b10c3229b56a.1302595212.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v2] [syscalls] io_submit: fix broken testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> -int TST_TOTAL = 3;
> +int TST_TOTAL = 8;
>  
>  #ifdef HAVE_LIBAIO_H
>  #include <libaio.h>
>  #include <errno.h>
>  #include <string.h>
> -
> -static void cleanup(void)
> -{
> -	TEST_CLEANUP;
> +#include <fcntl.h>
> +
> +#define TESTFILE	"testfile"
> +#define NEG_RESULT(exp, act) {\
> +	if (act == 0) {\
> +			tst_resm(TFAIL, "call succeeded unexpectedly");\
> +		} else if (act == exp) {\
> +			tst_resm(TPASS, "expected failure - "\
> +				"returned value = %ld : %s", \
> +				act, strerror(-1 * act));\
> +		} else {\
> +			tst_resm(TFAIL, "unexpected failure - "\
> +				"returned value = %ld : %s, "\
> +				"expected value = %d : %s",\
> +				act, strerror(-1 * act),\
> +				exp, strerror(-1 * exp));\
> +		} \
>  }
> -
> -static void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +#define POS_RESULT(act) {\
> +	if (act >= 0) {\
> +		tst_resm(TPASS, "expected success - "\
> +			"returned value = %ld", act);\
> +	} else {\
> +		tst_resm(TFAIL, "unexpected failure - "\
> +			"returned value = %ld : %s",\
> +			act, strerror(-1 * act));\
> +	} \
>  }

Any particular reason why these couldn't be functions? Macros are harder
to read and easier to misuse, so generally they shouldn't be used unless
it's really necessary.

Or maybe even better to have a funciton that gets io_submit parameters
and expected result as an arguments and does the test itself.

And also please avoid unnecessary code moving. If you contributed a test
that has setup() and cleanup() after main, that's ok. But there is no
need to shuffle that code in the existings testcases.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
