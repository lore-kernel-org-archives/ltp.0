Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SzlKp-0000Eg-AB
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 09:16:47 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzlKo-0000AB-9Z
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 09:16:47 +0000
Date: Fri, 10 Aug 2012 05:16:40 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <446368613.3052914.1344590200420.JavaMail.root@redhat.com>
In-Reply-To: <1344508258-25054-4-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3] timer_settime/5-3: fix test hung
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng Zhao <Zhenfeng.Zhao@windriver.com>



----- Original Message -----
> From: "Kang Kai" <kai.kang@windriver.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Zhenfeng Zhao" <Zhenfeng.Zhao@windriver.com>
> Sent: Thursday, 9 August, 2012 12:30:58 PM
> Subject: [LTP] [PATCH 3/3] timer_settime/5-3: fix test hung
> 
> This case hangs on sugarbay(intel x86_64) platform.
> 
> The root cause is that the case calls timer_settime with time which
> already took place and then calls sleep. When the timer expires and
> sends signal the sleep will be break.
> 
> But on sugarbay the timer always expires before the case enters
> sleep,
> then it always sleeps NUMTESTS * LONGSLEEPTIME seconds. So it exceeds
> the time limit set by auto-run test shell script, and reports that it
> hangs.
> 
> Decrease LONGSLEEPTIME value to avoid this issue.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>

Looks good to me, 5 secs is still enough time.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

> ---
>  .../conformance/interfaces/timer_settime/5-3.c     |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
> b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
> index 0ad1957..4a47458 100644
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
> @@ -27,7 +27,7 @@
>  
>  #define SIGTOTEST SIGALRM
>  
> -#define LONGSLEEPTIME 10
> +#define LONGSLEEPTIME 5
>  
>  #define NUMTESTS 30
>  
> @@ -105,4 +105,4 @@ int main(int argc, char *argv[])
>  
>  	printf("This code should not be executed.\n");
>  	return PTS_UNRESOLVED;
> -}
> \ No newline at end of file
> +}
> --
> 1.7.5.4
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
