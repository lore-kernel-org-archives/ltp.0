Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NteWr-0007Gg-47
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 10:06:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NteWo-0002Du-Vt
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 10:06:36 +0000
Message-ID: <4BA74116.9020009@cn.fujitsu.com>
Date: Mon, 22 Mar 2010 18:06:14 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B9B0B3A.3080008@cn.fujitsu.com>	
	<364299f41003122227w6859d6f3i829466a6fc5099f2@mail.gmail.com>
	<364299f41003122313i47334168u25a6b12c6c64a7d9@mail.gmail.com>
In-Reply-To: <364299f41003122313i47334168u25a6b12c6c64a7d9@mail.gmail.com>
Subject: Re: [LTP] [BUG?] proc01: read /proc/acpi/event failed if acpi
	daemon stopped
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi Garrett

at 2010-3-13 15:13, Garrett Cooper wrote:
> On Fri, Mar 12, 2010 at 10:27 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Fri, Mar 12, 2010 at 7:49 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>>> An error message occured when i tested proc01.
>>> ---------
>>> proc01      1  TFAIL  :  read failed: /proc/acpi/event: errno=EAGAIN(11): Resource temporarily unavailable
>>> ---------
>>>
>>> If "service acpid start", this message will be turned to:
>>> ---------
>>> proc01      0  TINFO  :  /proc/acpi/event: known issue: errno=EBUSY(16): Device or resource busy
>>> ---------
>>>
>>> I think we should to add a check of acpi daemon's status in testcases/kernel/fs/proc/proc01.c.
>>
>>    No, that's making things too complicated and won't scale as every
>> distro has developed a different means for specifying the status for a
>> service. Why not just add EAGAIN for that /proc node?
> 
>     And FWIW the error condition is correct in my opinion if kernel
> acpi hasn't been enabled, which was the case here.

I think we should to give a warning message to LTP users.
How do you think the following patch?

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 2d4a5fd..62d44b1 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -101,6 +101,7 @@ const Mapping known_issues[] = {
     {"read", "/proc/fs/nfsd/filehandle", EINVAL},
     {"read", "/proc/fs/nfsd/.getfs", EINVAL},
     {"read", "/proc/fs/nfsd/.getfd", EINVAL},
+    {"read", "/proc/acpi/event", EAGAIN}, //EAGAIN will be returned if acpi daemon disabled
     {"", "", 0}
 };

> Thanks,
> -Garrett
> 
> 

-- 
Shi Weihua

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
