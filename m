From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Mon, 19 Apr 2021 14:44:21 +0800
Subject: [LTP] [PATCH] Modify the test logic of mincore.
In-Reply-To: <YHgd/NDLJzz68uDl@yuki>
References: <20210330104613.1059-1-zhanglianjie@uniontech.com>
 <YHRcJOUer87SUn6v@yuki> <cded02a5-6668-8524-d588-b965ed1a7086@uniontech.com>
 <YHgd/NDLJzz68uDl@yuki>
Message-ID: <e3eabee4-6616-84dc-cc8d-bc4f23228637@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>>> This does not make any sense, the kernel commit explicitly states that
>>> all mapped pages are reported as in core. We do call mlock() in the
>>> child, which will fault all the pages and lock them in memory. So the
>>> test should work both before and after the fix as well.
>>>
>>> The kernel commit in question weakened mincore() in a sense that it's
>>> more likely to report pages in core than it previously was. Now all that
>>> is needed is to fault the pages by reading some bytes from them to make
>>> sure they are reported as in core.
>>>
>>> If the test fails for you, something is probably broken at your end.
>>>
>>
>> Using the CVE patch on mips, the test will fail because the child
>> process mlocks all pages, but the parent process cannot obtain these
>> pages through mincore and is locked.
> 
> Sounds like a kernel bug.
> 
CVE list has provided repair patches, The patch I submitted this time is 
to modify the logic of the test results, do you plan to incorporate it?


