Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PhCK7-0007NW-Ff
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 02:38:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhCK5-0007de-EL
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 02:38:31 +0000
Message-ID: <4D3CE628.5050509@cn.fujitsu.com>
Date: Mon, 24 Jan 2011 10:38:32 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <1044F3871F984514ACE11A23C55DAFB3@FM38572274>
	<AANLkTikGkTqAyoDoPaV5YVxgFqx=DQsqeTCpNRbUtHVt@mail.gmail.com>
In-Reply-To: <AANLkTikGkTqAyoDoPaV5YVxgFqx=DQsqeTCpNRbUtHVt@mail.gmail.com>
Subject: Re: [LTP] Fix the test04 of testcases/kernel/numa/numa01.sh
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
Cc: ltp-list@lists.sourceforge.net, Kazuki Seki <k-seki@np.css.fujitsu.com>

Garrett Cooper wrote:
> On Sun, Jan 16, 2011 at 4:38 PM, Kazuki Seki <k-seki@np.css.fujitsu.com> wrote:
>> Hi,
>>
>> Did you confirm the following email which I posted before?
> 
>     I can't because I don't have the resources and FWIW no one else
> has ACKed this issue.

Hi Garrett,

Would you try the kernel option "numa=fake=<N>" to create several fake nodes to
confirm this patch. This patch seems good to me.

Thanks,
Gui

> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand 
> malware threats, the impact they can have on your business, and how you 
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
