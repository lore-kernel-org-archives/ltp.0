Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z7bV5-0008RM-S2
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 03:37:23 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z7bV4-0006cY-O0
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 03:37:23 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 24 Jun 2015 03:37:26 +0000
Message-ID: <1435117038.1794.1.camel@localhost>
References: <1435021379-2945-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<55892FA3.80800@oracle.com>
In-Reply-To: <55892FA3.80800@oracle.com>
Content-Language: en-US
Content-ID: <C1DF1764B5F621488463DAA9FE4555B3@fujitsu.local>
MIME-Version: 1.0
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
To: "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, 2015-06-23 at 13:06 +0300, Alexey Kodanev wrote:
> Hi!
> On 06/23/2015 04:02 AM, Wei,Jiangang wrote:
> > * If _POSIX_SEMAPHORES is not defined,
> >    It's no need to allocate buffer.
> >    so, allocate buffer after checking it.
> >
> > * free the memory at the end of main().
> >
> > Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> > ---
> >   testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Please look at "[LTP] [PATCH]: Fix memory leak by freeing buf" thread.

Thanks for your reminder.
I will update my patch.

Regard,
wei
> 
> Thanks,
> Alexey
> 

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
