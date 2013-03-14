Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGB3F-0005nM-HA
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:30:45 +0000
Date: Thu, 14 Mar 2013 17:31:24 +0100
From: chrubis@suse.cz
Message-ID: <20130314163124.GB8894@rei.suse.cz>
References: <1363258426-8638-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1363258426-8638-1-git-send-email-markos.chandras@gmail.com>
Subject: Re: [LTP] [PATCH] testcases/include/linux_syscall_numbers.h:
 Include missing "test.h"
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  testcases/kernel/include/linux_syscall_numbers.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
> index 545b420..e43258e 100644
> --- a/testcases/kernel/include/linux_syscall_numbers.h
> +++ b/testcases/kernel/include/linux_syscall_numbers.h
> @@ -16,6 +16,7 @@
>  #include <errno.h>
>  #include <sys/syscall.h>
>  #include "cleanup.c"
> +#include "test.h"
>  
>  #define ltp_syscall(NR, ...) ({ \
>  	int __ret; \

Hmm, this header gets included after the test.h in the testcases so this
shouldn't be needed but I don't have strong opinion whether it's better
with or without it.

Anybody has idea?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
