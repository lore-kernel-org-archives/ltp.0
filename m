Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WfSxk-0008K6-RL
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 11:46:08 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WfSxh-00067t-H8
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 11:46:08 +0000
Date: Wed, 30 Apr 2014 07:45:59 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2047274155.12547340.1398858359123.JavaMail.zimbra@redhat.com>
In-Reply-To: <1398840825-9252-1-git-send-email-shuang.qiu@oracle.com>
References: <1398840825-9252-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syscalls/clone08: Skip test_clone_stopped from
 kernel	2.6.38
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
To: shuang qiu <shuang.qiu@oracle.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 30 April, 2014 8:53:45 AM
> Subject: [LTP] [PATCH] syscalls/clone08: Skip test_clone_stopped from kernel	2.6.38
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> According to CLONE manual page "This flag was deprecated from Linux
> 2.6.25 onward, and was removed altogether in Linux 2.6.38." skip
> test_clone_stopped test from kernel 2.6.38.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Pushed with small changes to commit message and whitespace fix for
closing bracket.

Thanks,
Jan

> ---
>  testcases/kernel/syscalls/clone/clone08.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clone/clone08.c
> b/testcases/kernel/syscalls/clone/clone08.c
> index 14ebf60..6857ab1 100644
> --- a/testcases/kernel/syscalls/clone/clone08.c
> +++ b/testcases/kernel/syscalls/clone/clone08.c
> @@ -238,6 +238,11 @@ static void test_clone_stopped(int t)
>  	int flag;
>  	pid_t child;
>  
> +	if (tst_kvercmp(2, 6, 38) >= 0) {
> +		tst_resm(TINFO, "CLONE_STOPPED skipped for kernels >= 2.6.38");
> +		return;
> +		}
> +
>  	stopped_flag = 0;
>  	child = clone_child(&test_cases[t], 1);
>  
> --
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> Instantly run your Selenium tests across 300+ browser/OS combos.  Get
> unparalleled scalability from the best Selenium testing platform available.
> Simple to use. Nothing to install. Get started now for free."
> http://p.sf.net/sfu/SauceLabs
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
