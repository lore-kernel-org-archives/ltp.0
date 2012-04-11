Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SHvlu-0002LD-8C
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 11:31:34 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SHvlp-0007Py-GJ
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 11:31:34 +0000
Message-ID: <4F856B48.2060101@cn.fujitsu.com>
Date: Wed, 11 Apr 2012 19:30:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1334133622-24512-1-git-send-email-kai.kang@windriver.com>
	<4F855A0D.9010308@casparzhang.com>
In-Reply-To: <4F855A0D.9010308@casparzhang.com>
Subject: Re: [LTP] [PATCH] aio_cancel/3-1: increase BUF_SIZE
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 04/11/2012 06:16 PM, Caspar Zhang wrote:

> On 04/11/2012 04:40 PM, Kang Kai wrote:
>> When do aio_cancel, all the aio_write operations have finished on some
>> platforms. That cause the case return UNRESOLVED. So increase the BUF_SIZE
>> to delay aio_write finish that make one aio_write operation can be
>> cancelled at least.
>>
>> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> Reviewed-by: Caspar Zhang <caspar@casparzhang.com>


pushed, thanks all,

Wanlong Gao

> 
> ------------------------------------------------------------------------------
> Better than sec? Nothing is better than sec when it comes to
> monitoring Big Data applications. Try Boundary one-second 
> resolution app monitoring today. Free.
> http://p.sf.net/sfu/Boundary-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
