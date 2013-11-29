Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VmMMy-0000dA-GO
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 11:36:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VmMMw-0003mp-95
	for ltp-list@lists.sourceforge.net; Fri, 29 Nov 2013 11:36:24 +0000
Message-ID: <52987BE0.20801@cn.fujitsu.com>
Date: Fri, 29 Nov 2013 19:34:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <2ad340abd08f682ea74269d96df3bcf6e4e10a67.1385721415.git.jstancek@redhat.com>
In-Reply-To: <2ad340abd08f682ea74269d96df3bcf6e4e10a67.1385721415.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] send*: use concrete flags for 'invalid flags set'
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net

On 11/29/2013 06:39 PM, Jan Stancek wrote:
> Use a concrete set of flags instead of '-1', which is
> known to fail with EOPNOTSUPP.
> 
> Tested with:
>   2.6.18-128.37.1.el5
>   2.6.32-358.el6
>   3.10.0-54.el7
>   upstream 3.13.0-rc1+

Great! thank you Jan.

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/send/send01.c       |   19 +++++--------------
>  testcases/kernel/syscalls/sendmsg/sendmsg01.c |   17 ++++-------------
>  testcases/kernel/syscalls/sendto/sendto01.c   |   21 +++++----------------
>  3 files changed, 14 insertions(+), 43 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
> index d228422..6ebe131 100644
> --- a/testcases/kernel/syscalls/send/send01.c
> +++ b/testcases/kernel/syscalls/send/send01.c
> @@ -72,7 +72,6 @@ static void setup(void);
>  static void setup0(void);
>  static void setup1(void);
>  static void setup2(void);
> -static void setup3(void);
>  static void cleanup0(void);
>  static void cleanup1(void);
>  
> @@ -143,14 +142,14 @@ static struct test_case_t tdat[] = {
>  #ifndef UCLINUX
>  	/* Skip since uClinux does not implement memory protection */
>  	{.domain = PF_INET,
> -	 .type = SOCK_STREAM,
> +	 .type = SOCK_DGRAM,
>  	 .proto = 0,
> -	 .buf = (void *)-1,
> +	 .buf = buf,
>  	 .buflen = sizeof(buf),
> -	 .flags = -1,
> +	 .flags = MSG_OOB,
>  	 .retval = -1,
> -	 .experrno = EFAULT,
> -	 .setup = setup3,
> +	 .experrno = EOPNOTSUPP,
> +	 .setup = setup1,
>  	 .cleanup = cleanup1,
>  	 .desc = "invalid flags set"}
>  #endif
> @@ -352,11 +351,3 @@ static void setup2(void)
>  		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed connect "
>  			 "test %d", testno);
>  }
> -
> -static void setup3(void)
> -{
> -	setup1();
> -
> -	if (tst_kvercmp(3, 6, 0) >= 0)
> -		tdat[testno].experrno = ENOTSUP;
> -}
> diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> index 90fbb5d..c385631 100644
> --- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> +++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
> @@ -87,7 +87,6 @@ static void setup3(void);
>  static void setup4(void);
>  static void setup5(void);
>  static void setup6(void);
> -static void setup7(void);
>  static void setup8(void);
>  
>  static void cleanup(void);
> @@ -337,19 +336,19 @@ struct test_case_t tdat[] = {
>  	 .desc = "invalid flags set w/ control"}
>  	,
>  	{.domain = PF_INET,
> -	 .type = SOCK_STREAM,
> +	 .type = SOCK_DGRAM,
>  	 .proto = 0,
>  	 .iov = iov,
>  	 .iovcnt = 1,
>  	 .buf = buf,
>  	 .buflen = sizeof(buf),
>  	 .msg = &msgdat,
> -	 .flags = ~MSG_CMSG_COMPAT,
> +	 .flags = MSG_OOB,
>  	 .to = (struct sockaddr *)&sin1,
>  	 .tolen = sizeof(sin1),
> -	 .retval = 0,
> +	 .retval = -1,
>  	 .experrno = EOPNOTSUPP,
> -	 .setup = setup7,
> +	 .setup = setup1,
>  	 .cleanup = cleanup1,
>  	 .desc = "invalid flags set"}
>  	,
> @@ -726,14 +725,6 @@ static void setup6(void)
>  	controllen = control->cmsg_len = 0;
>  }
>  
> -static void setup7(void)
> -{
> -	setup1();
> -
> -	if (tst_kvercmp(3, 6, 0) >= 0)
> -		tdat[testno].retval = -1;
> -}
> -
>  static void setup8(void)
>  {
>  	setup4();
> diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
> index a571afd..e2422ea 100644
> --- a/testcases/kernel/syscalls/sendto/sendto01.c
> +++ b/testcases/kernel/syscalls/sendto/sendto01.c
> @@ -72,7 +72,6 @@ static void setup0(void);
>  static void setup1(void);
>  static void setup2(void);
>  static void setup3(void);
> -static void setup4(void);
>  static void cleanup(void);
>  static void cleanup0(void);
>  static void cleanup1(void);
> @@ -212,16 +211,16 @@ struct test_case_t tdat[] = {
>  	 .desc = "local endpoint shutdown"}
>  	,
>  	{.domain = PF_INET,
> -	 .type = SOCK_STREAM,
> +	 .type = SOCK_DGRAM,
>  	 .proto = 0,
>  	 .buf = buf,
>  	 .buflen = sizeof(buf),
> -	 .flags = -1,
> +	 .flags = MSG_OOB,
>  	 .to = &sin1,
>  	 .tolen = sizeof(sin1),
> -	 .retval = 0,
> -	 .experrno = EPIPE,
> -	 .setup = setup4,
> +	 .retval = -1,
> +	 .experrno = EOPNOTSUPP,
> +	 .setup = setup1,
>  	 .cleanup = cleanup1,
>  	 .desc = "invalid flags set"}
>  };
> @@ -430,13 +429,3 @@ static void setup3(void)
>  	if (s < 0)
>  		tst_brkm(TBROK | TERRNO, cleanup, "socket setup failed");
>  }
> -
> -static void setup4(void)
> -{
> -	setup1();
> -
> -	if (tst_kvercmp(3, 6, 0) >= 0) {
> -		tdat[testno].retval = -1;
> -		tdat[testno].experrno = ENOTSUP;
> -	}
> -}
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
