Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PhIvR-0003xC-DG
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 09:41:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhIvP-0006Gh-JC
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 09:41:29 +0000
Message-ID: <4D3D490C.4000902@cn.fujitsu.com>
Date: Mon, 24 Jan 2011 17:40:28 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CEE2299.1080605@cn.fujitsu.com>
	<AANLkTikJjKXKrCxHa8hnjRHfaM6hGM-xy28ps6ca0Yep@mail.gmail.com>
In-Reply-To: <AANLkTikJjKXKrCxHa8hnjRHfaM6hGM-xy28ps6ca0Yep@mail.gmail.com>
Subject: Re: [LTP] [RFC][POSIX][PATCH]Get rid of the test of
	pthread_mutex_getprioceiling
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



Garrett Cooper wrote:
> On Thu, Nov 25, 2010 at 12:47 AM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
>> Hi,
>>
>>  The 1-1 and 3-3 do the same test, but they expect different result.
>> I do not know why?
>>
>> However, i think we should get rid of 3-3. Because it looks like not a POSIX
>> compliant case.
> 
> I'll look at cleaning this up. I didn't clean everything up yet in
> that area as I was going through and adding testcases for missing
> POSIX assertions.

Hi Garrett,

 Would you like to pick up it.

Regards
 Bian

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
