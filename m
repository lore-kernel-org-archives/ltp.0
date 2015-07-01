Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZA8Bc-000681-1P
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 02:55:44 +0000
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZA8Bb-0005ob-3g
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 02:55:44 +0000
Received: by obbkm3 with SMTP id km3so19733063obb.1
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2015 19:55:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434987065-23739-1-git-send-email-alexey.kodanev@oracle.com>
References: <1434987065-23739-1-git-send-email-alexey.kodanev@oracle.com>
Date: Wed, 1 Jul 2015 10:55:38 +0800
Message-ID: <CAPwn2JTduVBP9hgynOwyaNHN427aKAWPq4eyePUSSNzL0beCow@mail.gmail.com>
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] sctp: sctputils.c: fix test_peer_addr()
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, LTP list <ltp-list@lists.sourceforge.net>

I also got this issue while running sctp test and confirm this patch fixed the
problem. Please push this patch to the repo.

Thanks
Hangbin

2015-06-22 23:31 GMT+08:00 Alexey Kodanev <alexey.kodanev@oracle.com>:
> Test always fails with TBROK because inner loop will reset all the
> previous set values if we use else branch.
>
> Fixes 7cfe1586b8ed ("sctp: sctputil.c: make 'found' a static array")
>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  utils/sctp/testlib/sctputil.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
> index c678072..564925c 100644
> --- a/utils/sctp/testlib/sctputil.c
> +++ b/utils/sctp/testlib/sctputil.c
> @@ -371,6 +371,7 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
>         socklen_t addrs_size = 0;
>         void *addrbuf;
>         char found[count];
> +       memset(found, 0, count);
>
>         error = sctp_getpaddrs(sk, asoc, &addrs);
>         if (-1 == error) {
> @@ -404,8 +405,6 @@ int test_peer_addr(int sk, sctp_assoc_t asoc, sockaddr_storage_t *peers, int cou
>                         if (cmp_addr((sockaddr_storage_t *)sa_addr,
>                                      &peers[j]) == 0) {
>                                 found[j] = 1;
> -                       } else {
> -                               found[j] = 0;
>                         }
>                 }
>         }
> --
> 1.7.1
>
>
> ------------------------------------------------------------------------------
> Monitor 25 network devices or servers for free with OpManager!
> OpManager is web-based network management software that monitors
> network devices and physical & virtual servers, alerts via email & sms
> for fault. Monitor 25 devices for free with no restriction. Download now
> http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
