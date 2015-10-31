From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 31 Oct 2015 04:15:22 -0400 (EDT)
Subject: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root
 user run it
In-Reply-To: <5634112F.1030203@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
 <20151029115746.GA23990@rei> <563330C4.2060809@huawei.com>
 <492224674.39010592.1446197341093.JavaMail.zimbra@redhat.com>
 <5634112F.1030203@huawei.com>
Message-ID: <322055225.38333.1446279322374.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cui Bixuan" <cuibixuan@huawei.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Cyril Hrubis" <chrubis@suse.cz>, zhuyanpeng@huawei.com, zhanyongming@huawei.com, ltp@lists.linux.it
> Sent: Saturday, 31 October, 2015 1:54:07 AM
> Subject: Re: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root user run it
> 
> On 2015/10/30 17:29, Jan Stancek wrote:
> > 
> > 
> > 
> > 
> > ----- Original Message -----
> >> From: "Cui Bixuan" <cuibixuan@huawei.com>
> >> To: "Cyril Hrubis" <chrubis@suse.cz>
> >> Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com, ltp@lists.linux.it
> >> Sent: Friday, 30 October, 2015 9:56:36 AM
> >> Subject: Re: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root
> >> user run it
> >>
> >> On 2015/10/29 19:57, Cyril Hrubis wrote:
> >>> Hi!
> >>>> Add tst_require_root() to testcase for open /proc/self/pagemap file.
> >>>
> >>> On my machines the /proc/self/pagemap is readable by the process (it's
> >>> owned by the user that has started the program).
> >>>
> >>> What is output of ls -l /proc/self/pagemap on your machine?
> >> I look my system and others:
> >> 1) SUSE SP2: 3.0.13-0.27-default (uname -a); test PASS;  -r--r--r-- 1 root
> >> root 0 Oct 30 16:13 /proc/self/pagemap
> >> 2) Ubuntu: 3.13.0-32-generic;                test PASS;  -r--r--r--. 1
> >> cuibixuan cuibixuan 0 10? 30 16:19 /proc/self/pagemap
> >> 3) SUSE: 4.2.0-0.11-default;                 test FAIL;  -r-------- 1 root
> >> root 0 Nov 13 01:39 /proc/self/pagemap
> >> 4) arm64: linux 4.1.6;                       test FAIL;  -r-------- 1 root
> >> root 0 Jan 18 01:53 /proc/self/pagemap
> >>
> >> Maybe the higher version of the kernel change the file attributes
> >> of /proc/self/pagemap, I think.
> > 
> > commit 32ed74a4b968a4faff7aaaff557035ce5d5e70ab
> > Author: Djalal Harouni <tixxdz@opendz.org>
> > Date:   Mon Apr 7 15:38:38 2014 -0700
> > 
> >     procfs: make /proc/*/pagemap 0400
> >     
> >     The /proc/*/pagemap contain sensitive information and currently its
> >     mode
> >     is 0444.  Change this to 0400, so the VFS will prevent unprivileged
> >     processes from getting file descriptors on arbitrary privileged
> >     /proc/*/pagemap files.
> > 
> > but that doesn't explain why process can't read its own pagemap.
> > For 3) and 4): Did you run that as unprivileged user or as a root?
> > 

Looks like the EPERM is from this patch, which disabled reading for non-privileged users:

commit ab676b7d6fbf4b294bf198fb27ade5b0e865c7ce
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Mon Mar 9 23:11:12 2015 +0200
    pagemap: do not leak physical addresses to non-privileged userspace

it was later removed in:

commit 1c90308e7a77af6742a97d1021cca923b23b7f0d
Author: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date:   Tue Sep 8 15:00:07 2015 -0700
    pagemap: hide physical addresses from non-privileged users

So I'm thinking that we should check "if euid != 0 and opening pagemap gives EPERM",
then quit with TCONF.

Regards,
Jan

> 
> > Regards,
> > Jan
> > 
> >>
> >> But I read the Documentation/vm/pagemap.txt and look at the source code in
> >> kernel,
> >> can't get it. :-(
> >>
> >> Someone help?
> >>>
> >>
> >>
> >> --
> >> Mailing list info: http://lists.linux.it/listinfo/ltp
> >>
> > 
> > .
> > 
> 
> 
