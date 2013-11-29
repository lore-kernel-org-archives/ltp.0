Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VmK6C-0001Ij-Ky
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 09:10:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VmK6A-0000N0-Ax
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 09:10:56 +0000
Date: Fri, 29 Nov 2013 04:10:44 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1052444498.3195483.1385716244006.JavaMail.root@redhat.com>
In-Reply-To: <1385629988-12052-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1385629988-12052-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] send*: fix errno of invalid flags
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "LTP" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 28 November, 2013 10:13:08 AM
> Subject: [LTP] [PATCH] send*: fix errno of invalid flags
> 
> After following kernel commit, the tcp_fastopen
> sysctl is enabled default, so the errno will
> no be ENOTSUP any more.
> 
> Actually, the flags of send* syscall is "unsigned int",
> then our test case passed "-1" to it will not be treated
> as an invalid flags.
> 
> commit 0d41cca490c274352211efac50e9598d39a9dc80
> Author: Yuchung Cheng <ycheng@google.com>
> Date:   Thu Oct 31 09:19:32 2013 -0700
> 
>     tcp: enable sockets to use MSG_FASTOPEN by default
> 
>     Applications have started to use Fast Open (e.g., Chrome browser has
>     such an optional flag) and the feature has gone through several
>     generations of kernels since 3.7 with many real network tests. It's
>     time to enable this flag by default for applications to test more
>     conveniently and extensively.
> 
>     Signed-off-by: Yuchung Cheng <ycheng@google.com>
>     Signed-off-by: Neal Cardwell <ncardwell@google.com>
>     Acked-by: Eric Dumazet <edumazet@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/send/send01.c       | 6 ++++--
>  testcases/kernel/syscalls/sendmsg/sendmsg01.c | 6 +++++-
>  testcases/kernel/syscalls/sendto/sendto01.c   | 5 ++++-
>  3 files changed, 13 insertions(+), 4 deletions(-)

Hi,

my guess is that intention of testcase "invalid flags set"
was to get EOPNOTSUPP out of it. But this never worked for older kernels.
And on new kernels this is still likely going to depend on "sysctl_tcp_fastopen".

I'm running kernel < 3.6 and if I apply patch for send01.c
it fails with:
  send01      6  TFAIL  :  call succeeded unexpectedly

sendto(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024, MSG_OOB|MSG_DONTROUTE|MSG_PEEK|MSG_CTRUNC|MSG_PROXY|MSG_EOR|MSG_WAITALL|MSG_TRUNC|MSG_ERRQUEUE|MSG_DONTWAIT|MSG_CONFIRM|MSG_FIN|MSG_SYN|MSG_RST|MSG_NOSIGNAL|MSG_MORE|MSG_CMSG_CLOEXEC|0xbfff0000, NULL, 0) = 1024

I think we should get rid of that -1 in flags and use concrete flags we know
to be invalid. I recall suggesting SOCK_DGRAM + MSG_OOB last time this test needed update:

diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index d228422..6ebe131 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -72,7 +72,6 @@ static void setup(void);
 static void setup0(void);
 static void setup1(void);
 static void setup2(void);
-static void setup3(void);
 static void cleanup0(void);
 static void cleanup1(void);
 
@@ -143,14 +142,14 @@ static struct test_case_t tdat[] = {
 #ifndef UCLINUX
        /* Skip since uClinux does not implement memory protection */
        {.domain = PF_INET,
-        .type = SOCK_STREAM,
+        .type = SOCK_DGRAM,
         .proto = 0,
-        .buf = (void *)-1,
+        .buf = buf,
         .buflen = sizeof(buf),
-        .flags = -1,
+        .flags = MSG_OOB,
         .retval = -1,
-        .experrno = EFAULT,
-        .setup = setup3,
+        .experrno = EOPNOTSUPP,
+        .setup = setup1,
         .cleanup = cleanup1,
         .desc = "invalid flags set"}
 #endif
@@ -352,11 +351,3 @@ static void setup2(void)
                tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed connect "
                         "test %d", testno);
 }
-
-static void setup3(void)
-{
-       setup1();
-
-       if (tst_kvercmp(3, 6, 0) >= 0)
-               tdat[testno].experrno = ENOTSUP;
-}

Regards,
Jan


> 
> diff --git a/testcases/kernel/syscalls/send/send01.c
> b/testcases/kernel/syscalls/send/send01.c
> index d228422..0d91e92 100644
> --- a/testcases/kernel/syscalls/send/send01.c
> +++ b/testcases/kernel/syscalls/send/send01.c
> @@ -145,7 +145,7 @@ static struct test_case_t tdat[] = {
>  	{.domain = PF_INET,
>  	 .type = SOCK_STREAM,
>  	 .proto = 0,
> -	 .buf = (void *)-1,
> +	 .buf = buf,
>  	 .buflen = sizeof(buf),
>  	 .flags = -1,
>  	 .retval = -1,
> @@ -357,6 +357,8 @@ static void setup3(void)
>  {
>  	setup1();
>  
> -	if (tst_kvercmp(3, 6, 0) >= 0)
> +	if (tst_kvercmp(3, 12, 0) > 0)
> +		tdat[testno].experrno = EINVAL;
> +	else if (tst_kvercmp(3, 6, 0) >= 0)
>  		tdat[testno].experrno = ENOTSUP;
>  }
> diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> index 90fbb5d..890834c 100644
> --- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> +++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> @@ -730,8 +730,12 @@ static void setup7(void)
>  {
>  	setup1();
>  
> -	if (tst_kvercmp(3, 6, 0) >= 0)
> +	if (tst_kvercmp(3, 12, 0) > 0) {
>  		tdat[testno].retval = -1;
> +		tdat[testno].experrno = EISCONN;
> +	} else if (tst_kvercmp(3, 6, 0) >= 0) {
> +		tdat[testno].retval = -1;
> +	}
>  }
>  
>  static void setup8(void)
> diff --git a/testcases/kernel/syscalls/sendto/sendto01.c
> b/testcases/kernel/syscalls/sendto/sendto01.c
> index a571afd..e7c8805 100644
> --- a/testcases/kernel/syscalls/sendto/sendto01.c
> +++ b/testcases/kernel/syscalls/sendto/sendto01.c
> @@ -435,7 +435,10 @@ static void setup4(void)
>  {
>  	setup1();
>  
> -	if (tst_kvercmp(3, 6, 0) >= 0) {
> +	if (tst_kvercmp(3, 12, 0) > 0) {
> +		tdat[testno].retval = -1;
> +		tdat[testno].experrno = EISCONN;
> +	} else if (tst_kvercmp(3, 6, 0) >= 0) {
>  		tdat[testno].retval = -1;
>  		tdat[testno].experrno = ENOTSUP;
>  	}
> --
> 1.8.5.rc3
> 
> 
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics
> Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
