Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1SAGiP-0006b9-Qt
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 08:16:17 +0000
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SAGiJ-00064G-K4
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 08:16:17 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A81AA138
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Mar 2012 08:16:04 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 391AB1961
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Mar 2012 08:16:04 +0000 (GMT)
Message-ID: <4F698E13.2070909@st.com>
Date: Wed, 21 Mar 2012 09:15:15 +0100
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <1332257989-22829-1-git-send-email-salvatore.cro@st.com>
In-Reply-To: <1332257989-22829-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH] setrlimit01: wait for all children to exit in
	test3
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
To: ltp-list@lists.sourceforge.net

On 20/03/2012 16.39, Salvatore CRO' wrote:
> In test3, parent just wait for one child to exit but it
> actually has 10.
> As it could happen there may be other children around that
> didn't get yet the chance to exit, they will get signaled
> by ltp-pan (SIGTERM) and pollute the output of subsequent
> test (setrlimit02).
> Parent definitely needs to wait for all children to exit.
> 
> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>

Acked-by: Carmelo Amoroso <carmelo.amoroso@st.com>

> ---
>  testcases/kernel/syscalls/setrlimit/setrlimit01.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> index ac32450..430835c 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> @@ -267,7 +267,7 @@ void test3()
>  			exit(0);
>  		}
>  	}
> -	waitpid(pid, &status, 0);
> +	while(wait(&status) > 0) { /* no-op */ ; }
>  	if (WEXITSTATUS(status) != 0) {
>  		tst_resm(TFAIL, "RLIMIT_NPROC functionality is not correct");
>  	} else {


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
