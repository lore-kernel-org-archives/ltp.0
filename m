Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XhdT6-0002OJ-5f
	for ltp-list@lists.sourceforge.net; Fri, 24 Oct 2014 11:55:44 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XhdT4-0001du-8E
	for ltp-list@lists.sourceforge.net; Fri, 24 Oct 2014 11:55:43 +0000
Date: Fri, 24 Oct 2014 07:55:34 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1762962107.14645799.1414151734065.JavaMail.zimbra@redhat.com>
In-Reply-To: <1412111759-22198-1-git-send-email-gary.robertson@linaro.org>
References: <1412111759-22198-1-git-send-email-gary.robertson@linaro.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Realtime tests: Fix bad priority
	inheritance	conditionals
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
To: "Gary S. Robertson" <gary.robertson@linaro.org>
Cc: ltp-list@lists.sourceforge.net, mike holmes <mike.holmes@linaro.org>





----- Original Message -----
> From: "Gary S. Robertson" <gary.robertson@linaro.org>
> To: ltp-list@lists.sourceforge.net
> Cc: "mike holmes" <mike.holmes@linaro.org>
> Sent: Tuesday, 30 September, 2014 11:15:59 PM
> Subject: [LTP] [PATCH] Realtime tests: Fix bad priority inheritance	conditionals
> 
> From: "Gary S. Robertson" <gary.robertson@linaro.org>
> 
> testcases/realtime/lib/librttest.c and
> testcases/realtime/stress/pi-tests/testpi-3.c
> both referenced a non-existent autoconf configuration setting variable.
> Replaced the invalid variable name with the variable actually created
> by autoconf.
> 
> Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>

Pushed.

Thank you,
Jan

> ---
>  testcases/realtime/lib/librttest.c            |    2 +-
>  testcases/realtime/stress/pi-tests/testpi-3.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/realtime/lib/librttest.c
> b/testcases/realtime/lib/librttest.c
> index c175148..3679058 100644
> --- a/testcases/realtime/lib/librttest.c
> +++ b/testcases/realtime/lib/librttest.c
> @@ -586,7 +586,7 @@ void *busy_work_us(int us)
>  
>  void init_pi_mutex(pthread_mutex_t * m)
>  {
> -#if HAVE_DECL_PTHREAD_PRIO_INHERIT
> +#if HAS_PRIORITY_INHERIT
>  	pthread_mutexattr_t attr;
>  	int ret;
>  	int protocol;
> diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c
> b/testcases/realtime/stress/pi-tests/testpi-3.c
> index 30f38f6..e483945 100644
> --- a/testcases/realtime/stress/pi-tests/testpi-3.c
> +++ b/testcases/realtime/stress/pi-tests/testpi-3.c
> @@ -365,7 +365,7 @@ int main(int argc, char *argv[])
>  
>  	printf("Start %s\n", argv[0]);
>  
> -#if HAVE_DECL_PTHREAD_PRIO_INHERIT
> +#if HAS_PRIORITY_INHERIT
>  	if (!nopi) {
>  		pthread_mutexattr_t mutexattr;
>  		int protocol;
> --
> 1.7.9.5
> 
> 
> ------------------------------------------------------------------------------
> Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
> Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
> Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
