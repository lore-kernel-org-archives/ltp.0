Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X2K2B-0006Zu-Nk
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 12:53:11 +0000
Date: Wed, 2 Jul 2014 14:52:48 +0200
From: chrubis@suse.cz
Message-ID: <20140702125248.GB3714@rei.scz.novell.com>
References: <1404294010-18698-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1404294010-18698-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404294010-18698-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/3] lib/tst_res.c: introduce function
 tst_record_childstatus()
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 079fc42..24fb4d9 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -101,6 +101,9 @@
>  #include <stdarg.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
>  #include "test.h"
>  #include "usctest.h"
>  #include "ltp_priv.h"
> @@ -228,6 +231,40 @@ void tst_reset_exitval(void)
>  {
>  	T_exitval = 0;
>  }
> +
> +int tst_record_childstatus(int status, int *sig)
> +{
> +	int ret = 0, ttype_result, s = 0;
> +
> +	if (WIFEXITED(status)) {
> +		ret = WEXITSTATUS(status);
> +		ttype_result = TTYPE_RESULT(ret);
> +		T_exitval |= ttype_result;
> +		s = 0;
> +		ret = CHILD_EXIT_NORMALLY;
> +	} else if (WIFSIGNALED(status)) {
> +		s = WTERMSIG(status);
> +		tst_resm(TINFO, "child process is killed by signal: %s(%d)",
> +			 tst_strsig(s), s);
> +		ret = CHILD_EXIT_SIGNALED;

I would not bother with the return value and just do tst_brkm() with
TBROK in the rest of the cases. Because child killed by a signal is a
very special case and testcases that needs to assert it can do the
wait() and WIFSIGNALED() themselves.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
