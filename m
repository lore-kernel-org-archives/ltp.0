From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Mon, 26 Apr 2021 20:39:01 +0800
Subject: [LTP] [PATCH] Modify the test logic of mincore.
In-Reply-To: <YH1H4qZwqSNom4RO@yuki>
References: <20210330104613.1059-1-zhanglianjie@uniontech.com>
 <YHRcJOUer87SUn6v@yuki> <cded02a5-6668-8524-d588-b965ed1a7086@uniontech.com>
 <YHgd/NDLJzz68uDl@yuki> <e3eabee4-6616-84dc-cc8d-bc4f23228637@uniontech.com>
 <YH1H4qZwqSNom4RO@yuki>
Message-ID: <f73913c8-f6ca-d8ea-60c8-e4002ac16dba@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
>>>> Using the CVE patch on mips, the test will fail because the child
>>>> process mlocks all pages, but the parent process cannot obtain these
>>>> pages through mincore and is locked.
>>>
>>> Sounds like a kernel bug.
>>>
>> CVE list has provided repair patches, The patch I submitted this time is
>> to modify the logic of the test results, do you plan to incorporate it?
> 
> Let me try to explain it once again.
> 
> As far as I can tell the CVE kernel patch you pointed out has NO effect
> on the testcase and there is NO need to modify the test at all. The test
> works fine both before and after the kernel patch.
> 
> If the test fails for you YOUR kernel is broken.
> 
> That is unless you prove that the test is actually wrong, which you
> haven't and I do not think that you actually can.
> 

The test was passed before the cve patch was applied, and the test
failed after the patch was applied, and the test results were the same
on both the x86 and mips architectures.
This cve patch changes mincore() to count "mapped" pages instead of 
"cached" pages.


