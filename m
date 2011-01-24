Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PhEVM-0006Ui-QU
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 04:58:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhEVH-0003qD-T2
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 04:58:14 +0000
Message-ID: <4D3D06E8.9080907@cn.fujitsu.com>
Date: Mon, 24 Jan 2011 12:58:16 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <1044F3871F984514ACE11A23C55DAFB3@FM38572274>	<AANLkTikGkTqAyoDoPaV5YVxgFqx=DQsqeTCpNRbUtHVt@mail.gmail.com>	<4D3CE628.5050509@cn.fujitsu.com>
	<AANLkTin2bEtPoZqm67v0pujcGCy3OxF+cCQR-fLqzLf3@mail.gmail.com>
In-Reply-To: <AANLkTin2bEtPoZqm67v0pujcGCy3OxF+cCQR-fLqzLf3@mail.gmail.com>
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
> On Sun, Jan 23, 2011 at 6:38 PM, Gui Jianfeng
> <guijianfeng@cn.fujitsu.com> wrote:
>> Garrett Cooper wrote:
>>> On Sun, Jan 16, 2011 at 4:38 PM, Kazuki Seki <k-seki@np.css.fujitsu.com> wrote:
>>>> Hi,
>>>>
>>>> Did you confirm the following email which I posted before?
>>>     I can't because I don't have the resources and FWIW no one else
>>> has ACKed this issue.
>> Hi Garrett,
>>
>> Would you try the kernel option "numa=fake=<N>" to create several fake nodes to
>> confirm this patch. This patch seems good to me.
> 
>     If someone ACKs a patch, that's generally sufficient enough to
> warrant a commit... if it worked before, I would just like to know
> where and when the change was made to affect the output to cause the
> failure seen, but seeing as how this is Linux and things are not
> generally documented, I guess I'll just commit for now and hope that
> people don't change the output unnecessarily again.

Thanks a lot.

Gui

> Thanks,
> -Garrett
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
