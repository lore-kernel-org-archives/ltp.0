Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SFbNF-0000Nf-G8
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:20:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SFbND-0000UA-4y
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:20:29 +0000
Message-ID: <4F7CF202.50307@cn.fujitsu.com>
Date: Thu, 05 Apr 2012 09:14:42 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1333587726-8962-1-git-send-email-penght@cn.fujitsu.com>
	<CAGH67wRCFcJO8Nhz+at-6MTGJAqqm0JGBRQEuj=hpAxhcdKZRw@mail.gmail.com>
In-Reply-To: <CAGH67wRCFcJO8Nhz+at-6MTGJAqqm0JGBRQEuj=hpAxhcdKZRw@mail.gmail.com>
Subject: Re: [LTP] [PATCH] at_deny01: fix a bug of /etc/init.d/atd is
	nonexistent
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 04/05/2012 09:07 AM, Garrett Cooper wrote:

> On Wed, Apr 4, 2012 at 6:02 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
>> /etc/init.d/atd is nonexistent in fedora16, so should use systemctl.
>>
>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> 
> Reviewed-by: Garrett Cooper <yanegomi@gmail.com>
> 


pushed, thanks,

Wanlong Gao

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
