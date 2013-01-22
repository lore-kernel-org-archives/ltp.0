Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TxZiK-0005mx-2g
	for ltp-list@lists.sourceforge.net; Tue, 22 Jan 2013 09:00:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TxZiH-0000d4-UR
	for ltp-list@lists.sourceforge.net; Tue, 22 Jan 2013 09:00:16 +0000
Message-ID: <50FE5021.1010604@cn.fujitsu.com>
Date: Tue, 22 Jan 2013 16:38:57 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1329795813-12550-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F4313F6.9020408@cn.fujitsu.com>
	<loom.20130117T133157-543@post.gmane.org>
In-Reply-To: <loom.20130117T133157-543@post.gmane.org>
Subject: Re: [LTP] [PATCH] mem/tunable: fix the overcommitting possible
	failure
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
To: Sravan V Dodla <sravan@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 01/17/2013 08:37 PM, Sravan V Dodla wrote:
> Wanlong Gao <gaowanlong@...> writes:
> 
>>
>> On 02/21/2012 11:43 AM, Wanlong Gao wrote:
>>
>>> 1. CommitLimit may be changed when set another overcommit_memory
>>>    value.
>>> 2. Test overcommit_memory=2 first to avoid the condition
>>>    committed > CommitLimited.
>>
>> Below is my failure before this patch.
> 
> Some how even after the patch I still hit this issue.
> Wanlong, is it good to skip this case of test when CommitLimit < Committed_AS.
> Please comment.

Sorry for the late reply, according to your log, it seems that you disabled
your system swap or even don't have a swap.
Since the CommitLimit=Swap+RAM*overcommit_ratio, now the ratio is 0, so the
commit limit comes to 0, this cause the unexpected error here.
You'd better enable your swap then test again, or change the ratio.

Thanks,
Wanlong Gao

> 
> ./overcommit_memory -R 0
> overcommit_memory    0  TINFO  :  set overcommit_ratio to 0
> overcommit_memory    0  TINFO  :  MemTotal is 1020764 kB
> overcommit_memory    0  TINFO  :  SwapTotal is 0 kB
> overcommit_memory    0  TINFO  :  CommitLimit is 0 kB
> overcommit_memory    0  TINFO  :  set overcommit_memory to 2
> overcommit_memory    0  TINFO  :  CommmitLimit is 0, Committed_AS is 241680
> overcommit_memory    1  TBROK  :  Unexpected error: CommitLimit < Committed_AS
> overcommit_memory    2  TBROK  :  Remaining cases broken
> overcommit_memory    0  TINFO  :  set overcommit_memory to 0
> overcommit_memory    0  TINFO  :  set overcommit_ratio to 50
> 
>> ---
>> # ./overcommit_memory -R 0 ; cat /proc/meminfo 
>> overcommit_memory    0  TINFO  :  set overcommit_ratio to 0
>> overcommit_memory    0  TINFO  :  MemTotal is 5780068 kB
>> overcommit_memory    0  TINFO  :  SwapTotal is 4095996 kB
>> overcommit_memory    0  TINFO  :  CommitLimit is 4095996 kB
>> overcommit_memory    0  TINFO  :  set overcommit_memory to 0
>> overcommit_memory    0  TINFO  :  malloc 2127578 kB successfully
>> overcommit_memory    1  TPASS  :  alloc passed as expected
>> overcommit_memory    0  TINFO  :  malloc 8510312 kB failed
>> overcommit_memory    2  TPASS  :  alloc failed as expected
>> overcommit_memory    0  TINFO  :  malloc 9876064 kB failed
>> overcommit_memory    3  TPASS  :  alloc failed as expected
>> overcommit_memory    0  TINFO  :  set overcommit_memory to 2
>> overcommit_memory    0  TINFO  :  CommmitLimit is 4095996, Committed_AS is 
> 4096060
>> overcommit_memory    4  TBROK  :  Unexpected error: CommitLimit < Committed_AS
>> overcommit_memory    5  TBROK  :  Remaining cases broken
>> overcommit_memory    0  TINFO  :  set overcommit_memory to 0
>> overcommit_memory    0  TINFO  :  set overcommit_ratio to 50
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
> MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
> with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
> MVPs and experts. ON SALE this month only -- learn more at:
> http://p.sf.net/sfu/learnmore_122712
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
