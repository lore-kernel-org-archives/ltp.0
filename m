Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z87RV-00065X-E9
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 13:43:49 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z87RT-0006sh-Kg
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 13:43:49 +0000
Message-ID: <558C0652.8060309@oracle.com>
Date: Thu, 25 Jun 2015 16:46:58 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <55892FA3.80800@oracle.com>
	<1435117293-16126-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1435117293-16126-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] sem_conpro: cleanup code
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
On 06/24/2015 06:41 AM, Wei,Jiangang wrote:
> * It's reasonable to allocate memory after checking
>    _POSIX_SEMAPHORES.
>    Allocate 'buf' on the stack to avoid the problem.
>
> * remove meaningless printf()
>

Patch applied. Also removed not needed void cast and fix commit message.

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
