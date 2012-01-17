Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RnCP5-0004an-GZ
	for ltp-list@lists.sourceforge.net; Tue, 17 Jan 2012 17:00:59 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnCOz-0002Tr-VB
	for ltp-list@lists.sourceforge.net; Tue, 17 Jan 2012 17:00:59 +0000
Message-ID: <4F15A93E.10405@imgtec.com>
Date: Tue, 17 Jan 2012 17:00:46 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1325672810-5247-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1325672810-5247-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH 12/21] syscalls/{getcontext,
	profil}: Multiple fixes
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

On 01/04/2012 10:26 AM, Markos Chandras wrote:
> - Include test.h header even when __UCLIBC__ is defined. It is required for the
> tst_brkm function
> - Move TCID variable definition to the top so I can be independent of whether
>    __UCLIBC is used or not.
>
> Signed-off-by: Markos Chandras<markos.chandras@imgtec.com>
> ---
>   .../kernel/syscalls/getcontext/getcontext01.c      |    7 +++++--
>   testcases/kernel/syscalls/profil/profil01.c        |    7 +++++--
>   2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
> index 7cadc67..1cf2896 100644
> --- a/testcases/kernel/syscalls/getcontext/getcontext01.c
> +++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
> @@ -34,6 +34,9 @@
>    **********************************************************/
>
>   #include<features.h>
> +
> +char *TCID = "getcontext01";	/* Test program identifier.    */
> +
>   #if !defined(__UCLIBC__)
>
>   #include<stdio.h>
> @@ -47,7 +50,6 @@
>   void setup();
>   void cleanup();
>
> -char *TCID = "getcontext01";	/* Test program identifier.    */
>   int TST_TOTAL = 1;		/* Total number of test cases. */
>
>   int exp_enos[] = { 0 };		/* must be a 0 terminated list */
> @@ -98,8 +100,9 @@ void cleanup()
>   }
>
>   #else /* systems that dont support obsolete getcontext */
> +#include "test.h"
>   int main()
>   {
>   	tst_brkm(TCONF, NULL, "system doesn't have getcontext support");
>   }
> -#endif
> \ No newline at end of file
> +#endif
> diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
> index 63bed83..571e6f0 100644
> --- a/testcases/kernel/syscalls/profil/profil01.c
> +++ b/testcases/kernel/syscalls/profil/profil01.c
> @@ -41,6 +41,9 @@
>   #endif
>
>   #include<features.h>
> +
> +char *TCID = "profil01";
> +
>   #ifndef __UCLIBC__
>
>   #ifdef __arm__
> @@ -73,7 +76,6 @@ volatile int t_flag;
>   //char progname[]= "profil1()";
>
>   /*****	LTP Port	*****/
> -char *TCID = "profil01";
>   int local_flag = PASSED;
>   int block_number;
>   FILE *temp;
> @@ -305,9 +307,10 @@ void fail_exit()
>   /*****	**	**	*****/
>
>   #else
> +#include "test.h"
>   int main(void)
>   {
>   	/* uClibc does not have profiling support */
>   	tst_exit();
>   }
> -#endif
> \ No newline at end of file
> +#endif

Ping?

Any comments on this? It fixes a build failure on uClibc platforms.

-- 
markos


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
