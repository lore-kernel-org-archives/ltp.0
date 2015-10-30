From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 30 Oct 2015 16:56:36 +0800
Subject: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root
 user run it
In-Reply-To: <20151029115746.GA23990@rei>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
 <20151029115746.GA23990@rei>
Message-ID: <563330C4.2060809@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2015/10/29 19:57, Cyril Hrubis wrote:
> Hi!
>> Add tst_require_root() to testcase for open /proc/self/pagemap file.
> 
> On my machines the /proc/self/pagemap is readable by the process (it's
> owned by the user that has started the program).
> 
> What is output of ls -l /proc/self/pagemap on your machine?
I look my system and others:
1) SUSE SP2: 3.0.13-0.27-default (uname -a); test PASS;  -r--r--r-- 1 root root 0 Oct 30 16:13 /proc/self/pagemap
2) Ubuntu: 3.13.0-32-generic;                test PASS;  -r--r--r--. 1 cuibixuan cuibixuan 0 10? 30 16:19 /proc/self/pagemap
3) SUSE: 4.2.0-0.11-default;                 test FAIL;  -r-------- 1 root root 0 Nov 13 01:39 /proc/self/pagemap
4) arm64: linux 4.1.6;                       test FAIL;  -r-------- 1 root root 0 Jan 18 01:53 /proc/self/pagemap

Maybe the higher version of the kernel change the file attributes
of /proc/self/pagemap, I think.

But I read the Documentation/vm/pagemap.txt and look at the source code in kernel,
can't get it. :-(

Someone help?
> 

