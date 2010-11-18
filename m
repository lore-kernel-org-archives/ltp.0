Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PIwDe-0007br-Fq
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 04:35:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PIwDc-0004tN-6Z
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 04:35:34 +0000
Message-ID: <4CE4AD0D.1050501@cn.fujitsu.com>
Date: Thu, 18 Nov 2010 12:35:25 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <000001cb798d$1aaa0210$4ffe0630$@co.jp>	<AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>	<4CCE73A6.9020901@cn.fujitsu.com>
	<AANLkTi=TyhLVZ5OOcRduBwvkxS3-u4f7A1W+bv+WO6Y1@mail.gmail.com>
In-Reply-To: <AANLkTi=TyhLVZ5OOcRduBwvkxS3-u4f7A1W+bv+WO6Y1@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Mitani <mitani@ryobi.co.jp>, =?UTF-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>, ltp-list@lists.sourceforge.net



Garrett Cooper wrote:
> On Mon, Nov 1, 2010 at 1:00 AM, Gui Jianfeng <guijianfeng@cn.fujitsu.com> wrote:
>> Garrett Cooper wrote:
>>> 2010/10/31 Mitani <mitani@ryobi.co.jp>:
>> ...
>>>>  int main()
>>>>  {
>>>> @@ -133,6 +152,12 @@
>>>>
>>>>        struct sigaction sa;
>>>>
>>>> +       /* Checking for Kernel Version */
>>>> +       if ( kernel_ver_cmp(2, 6, 21) != 0 )
>>>> +       {
>>>> +               UNTESTED( "sem_wait() returned EINTR on kernel versions
>>>> lower than 2.6.22" );
>>>> +       }
>>>> +
>>>>        /* Initialize output */
>>>>        output_init();
>>>>
>>>> ============
>>>>
>>>> Above patch is revision only for templates.
>>>> The following procedure is necessary after applying patch:
>>>> ------------
>>>> #cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
>>>> #./gentests.pl
>>>> ------------
>>>>
>>>> Similar revisions are necessary for other 25 "sigaction" tests.
>>>     Sorry, but Linux-isms can't leak into the open_posix_testsuite.
>>> Same with BSDisms (at least they shouldn't... if they do, then slap me
>>> or whoever did the commit).
>> Do you mean the culprit is Linux-isms?
> 
> Mitani-san is proposing that I `fix' the testcases to work on RHEL
> 4.8. These testcases should function with minimal change for all
> versions of Unix.
> 

  This open_posix_suite is the part of LTP(linux test project), must we
make sure it can work at all versions of unix?

What about this patch?  If you think so, other similar patchs will be post.

-------------------------------------------------------------------------------

At older linux kernel(2.6.22 before), a signal handler always interrupts a
blocked call to one of these functions, regardless of the use of the sigaction
SA_RESTART flag, so we should not test these cases at this situation.

Althought uname is not exsit at 4.3 BSD, but this open_posix_suite just
the part of LTP(linux test project), so i think it's not a problem.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../conformance/interfaces/sigaction/16-1.c        |   27 ++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
index 706dbfc..3d6e1a1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
@@ -50,6 +50,7 @@ Anyway, a false negative status cannot be returned.
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/utsname.h>
 
 #include <semaphore.h>
 #include <signal.h>
@@ -95,6 +96,27 @@ Anyway, a false negative status cannot be returned.
 volatile sig_atomic_t caught = 0;
 sem_t sem;
 
+#define KERNEL_VERSION(a, b, c)	(((a) << 16) + ((b) << 8) + (c))
+
+int check_linux()
+{
+	struct utsname tn;
+	int r1, r2, r3;
+
+	if (0 > uname(&tn)) {
+		UNRESOLVED( errno, "uname failed" );
+	}
+
+	if (strcmp(tn.sysname, "Linux") != 0)
+		return 0;
+
+	sscanf(tn.release, "%d.%d.%d", &r1, &r2, &r3);
+	if (KERNEL_VERSION(r1, r2, r3) >= KERNEL_VERSION(2, 6, 22))
+		return 1;
+
+	return 0;
+}
+
 /* Handler function */
 void handler( int signo )
 {
@@ -133,6 +155,11 @@ int main()
 
 	struct sigaction sa;
 
+	if (!check_linux())
+		UNTESTED( "A signal handler always interrupts sem_wait "
+			  "at linux release, regardless of the use of "
+			  "the sigaction SA_RESTART flag" );
+
 	/* Initialize output */
 	output_init();
 
-- 
1.6.5.2




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
