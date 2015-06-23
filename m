Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z7L3A-0000Vx-Sy
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2015 10:03:28 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z7L38-0005Xt-VG
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2015 10:03:28 +0000
Message-ID: <55892FA3.80800@oracle.com>
Date: Tue, 23 Jun 2015 13:06:27 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1435021379-2945-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1435021379-2945-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] sem_conpro: fix memory leak
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
To: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

Hi!
On 06/23/2015 04:02 AM, Wei,Jiangang wrote:
> * If _POSIX_SEMAPHORES is not defined,
>    It's no need to allocate buffer.
>    so, allocate buffer after checking it.
>
> * free the memory at the end of main().
>
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>   testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Please look at "[LTP] [PATCH]: Fix memory leak by freeing buf" thread.

Thanks,
Alexey


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
