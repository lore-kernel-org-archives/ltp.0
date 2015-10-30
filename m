From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 30 Oct 2015 05:29:01 -0400 (EDT)
Subject: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root
 user run it
In-Reply-To: <563330C4.2060809@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
 <20151029115746.GA23990@rei> <563330C4.2060809@huawei.com>
Message-ID: <492224674.39010592.1446197341093.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cui Bixuan" <cuibixuan@huawei.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com, ltp@lists.linux.it
> Sent: Friday, 30 October, 2015 9:56:36 AM
> Subject: Re: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root user run it
> 
> On 2015/10/29 19:57, Cyril Hrubis wrote:
> > Hi!
> >> Add tst_require_root() to testcase for open /proc/self/pagemap file.
> > 
> > On my machines the /proc/self/pagemap is readable by the process (it's
> > owned by the user that has started the program).
> > 
> > What is output of ls -l /proc/self/pagemap on your machine?
> I look my system and others:
> 1) SUSE SP2: 3.0.13-0.27-default (uname -a); test PASS;  -r--r--r-- 1 root
> root 0 Oct 30 16:13 /proc/self/pagemap
> 2) Ubuntu: 3.13.0-32-generic;                test PASS;  -r--r--r--. 1
> cuibixuan cuibixuan 0 10? 30 16:19 /proc/self/pagemap
> 3) SUSE: 4.2.0-0.11-default;                 test FAIL;  -r-------- 1 root
> root 0 Nov 13 01:39 /proc/self/pagemap
> 4) arm64: linux 4.1.6;                       test FAIL;  -r-------- 1 root
> root 0 Jan 18 01:53 /proc/self/pagemap
> 
> Maybe the higher version of the kernel change the file attributes
> of /proc/self/pagemap, I think.

commit 32ed74a4b968a4faff7aaaff557035ce5d5e70ab
Author: Djalal Harouni <tixxdz@opendz.org>
Date:   Mon Apr 7 15:38:38 2014 -0700

    procfs: make /proc/*/pagemap 0400
    
    The /proc/*/pagemap contain sensitive information and currently its mode
    is 0444.  Change this to 0400, so the VFS will prevent unprivileged
    processes from getting file descriptors on arbitrary privileged
    /proc/*/pagemap files.

but that doesn't explain why process can't read its own pagemap.
For 3) and 4): Did you run that as unprivileged user or as a root?

Can you paste full output from mmap12 run (the one that fails)?

Regards,
Jan

> 
> But I read the Documentation/vm/pagemap.txt and look at the source code in
> kernel,
> can't get it. :-(
> 
> Someone help?
> > 
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
