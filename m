Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RngGt-0000wC-F7
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 00:54:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RngGr-0005qH-Sw
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 00:54:31 +0000
Message-ID: <4F1769B1.7080405@cn.fujitsu.com>
Date: Thu, 19 Jan 2012 08:54:09 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F14F368.80507@cn.fujitsu.com>
	<201201170001.13851.vapier@gentoo.org>
	<201201180524.53760.vapier@gentoo.org>
In-Reply-To: <201201180524.53760.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 8/8] Add test usage_in_bytes
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net


Mike Frysinger said the following on 2012-1-18 18:24:
> On Tuesday 17 January 2012 00:01:12 Mike Frysinger wrote:
>> On Monday 16 January 2012 23:04:56 Peng Haitao wrote:
>>> +. memcg_lib.sh || exit 1
>>
>> you have to use paths else the source searches $PATH.  relying on $PWD is
>> not portable.
>>
>> . ./memcg_lib.sh || exit 1
> 
> btw, i was talking about all your patches having this problem and not just 
> this particular one.  you'll have to update them all.
> -mike
> 

yeah, I know.
Thanks for your reminder:)

-- 
Best Regards,
Peng

> 
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
