Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Y8R3B-00087c-74
	for ltp-list@lists.sourceforge.net; Tue, 06 Jan 2015 10:07:45 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y8R39-0006Kz-BL
	for ltp-list@lists.sourceforge.net; Tue, 06 Jan 2015 10:07:45 +0000
Date: Tue, 6 Jan 2015 05:07:34 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <53591103.3121779.1420538854789.JavaMail.zimbra@redhat.com>
In-Reply-To: <20141001171032.698f1356@as>
References: <20141001171032.698f1356@as>
MIME-Version: 1.0
Subject: Re: [LTP] recvfrom01: fix test for invalid message flags
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
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Chuck Ebbert" <cebbert.lkml@gmail.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 2 October, 2014 12:10:32 AM
> Subject: [LTP] recvfrom01: fix test for invalid message flags
> 


> Note that this introduces a failure on kernels before 3.17, which has
> a bug fix for MSG_ERRQUEUE flag handling. This failure is a legitimate
> bug on these older kernels. (They should not be returning success with
> no data available.)

I hit a failure in this testcase while trying latest LTP before release.
Are you sure this is a bug?

Looking at commit history and man-pages, this looks more like new feature to me,
flag that has not been supported before and now it is.

"MSG_ERRQUEUE is illegal on SOCK_STREAM sockets." [1]
"TCP timestamping introduced MSG_ERRQUEUE handling for TCP sockets." [2][3]

Until commit [3], tcp_recvmsg() has ignored this flag and it was also documented
that way. So, I don't see why TFAIL is valid result on <3.17 for MSG_ERRQUEUE test:

 socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
 connect(3, {sa_family=AF_INET, sin_port=htons(59273), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
 select(4, [3], NULL, NULL, {2, 0})      = 1 (in [3], left {1, 999998})
 recvfrom(3, "hoser\n", 1024, MSG_ERRQUEUE, NULL, NULL) = 6

Regards,
Jan

[1] https://lkml.org/lkml/2006/9/18/182
[2] f4713a3dfad045d46afcb9c2a7d0bba288920ed4
[3] 4ed2d765dfaccff5ebdac68e2064b59125033a3b

> 
> [1] http://marc.info/?t=141148149900006&r=1&w=2
> 
> ---
> 
> Additional test cases for invalid flags could be added after these two.
> And the recv01 and recvmsg01 tests need still need to be fixed, assuming
> this is the right solution.
> 
> --- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> +++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
> @@ -115,9 +115,14 @@
>  		    -1, EFAULT, setup1, cleanup1, "invalid recv buffer"},
>  /* 6 */
>  	{
> -	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), -1,
> +	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), MSG_OOB,
>  		    (struct sockaddr *)&from, &fromlen,
> -		    -1, EINVAL, setup1, cleanup1, "invalid flags set"},};
> +		    -1, EINVAL, setup1, cleanup1, "invalid MSG_OOB flag set"},
> +/* 7 */
> +	{
> +	PF_INET, SOCK_STREAM, 0, (void *)buf, sizeof(buf), MSG_ERRQUEUE,
> +		    (struct sockaddr *)&from, &fromlen,
> +		    -1, EAGAIN, setup1, cleanup1, "invalid MSG_ERRQUEUE flag set"},};
>  
>  int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
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
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
