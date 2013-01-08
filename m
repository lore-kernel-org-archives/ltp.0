Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TsSpM-0004Ob-2w
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:38:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TsSpK-0002o4-DD
	for ltp-list@lists.sourceforge.net; Tue, 08 Jan 2013 06:38:24 +0000
Message-ID: <50EBBEF2.3020207@cn.fujitsu.com>
Date: Tue, 08 Jan 2013 14:38:42 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1357616084-1705-1-git-send-email-jshao@redhat.com>
	<20130108054041.GA32247@station.monson>
	<50EBB4A4.8040103@cn.fujitsu.com>
	<20130108062047.GB32247@station.monson>
In-Reply-To: <20130108062047.GB32247@station.monson>
Subject: Re: [LTP] [PATCH] containers: delete redundant newline in tst_resm()
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
To: monson@station.monson
Cc: ltp-list@lists.sourceforge.net

On 01/08/2013 02:20 PM, monson wrote:
> Hi Wanlong,
> 
> Is there any maitainer still taking care of the containers part? Different namespace
> test cases are in different style and the code is messy. I checked the git log and found
> it seems like be abandoned.

The container with the namespace issue is in heavy development, the test cases need to
suit it. This part is not in the default running test, but it not means to be abandoned.
Just remain to test separately or need to be fixed. If you are looking into this area,
patches are very welcome. Thank you.

Regards,
Wanlong Gao

> 
> Regards,
> monson
> 
> On Tue, Jan 08, 2013 at 01:54:44PM +0800, Wanlong Gao wrote:
>> On 01/08/2013 01:40 PM, monson wrote:
>>> Note:
>>>
>>> Some comment lines are modified because there are spaces around tab inside
>>> and my editor automaticly fixed it by the way.
>>>
>>> If it's not acceptable, I would work out another patch without those fixs.
>>
>> It's OK. Applied, thank you.
>>
>> Wanlong Gao
>>
>>>
>>> monson


------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
