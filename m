Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SVMRs-0004tX-HS
	for ltp-list@lists.sourceforge.net; Fri, 18 May 2012 12:38:24 +0000
Date: Fri, 18 May 2012 14:35:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120518123534.GA21982@saboteur.suse.cz>
References: <4FAA6A83.8010100@casparzhang.com>
	<4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] Simple tests for cross memory attach
 (process_vm_[readv|writev] syscalls)
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I looked at testcases sent by Chris. Good news is, they
> do not overlap (in terms of functionality) with mine :-).
> 
> The patch need some polishing to match the style guide:
> - indentation
> - I think output should be TINFO, rather than plain printf
> - single statement if without { }
> - I would split some code to more functions, for example process_vm_writev01.c
>   main function seems complex
> 
> As for test organization, I think we need to decide 2 issues:
> 1. directory structure
> a)
>   testcases/kernel/syscalls/cma/
>   testcases/kernel/syscalls/cma/process_vm_readv
>   testcases/kernel/syscalls/cma/process_vm_writev
> b)
>   testcases/kernel/syscalls/process_vm_readv
>   testcases/kernel/syscalls/process_vm_writev
> 
> I'm preferring a) as these 2 syscalls are closely related,
> and we already have need to share code.

Also please omit meaningless comments like:

/******************************************************
 * main
 ******************************************************/

I'm also not a friend of keeping the HISTORY, FILENAME and others inside
of the file. We do have git that keeps this information in more
structured and useful manner. So this is a relict from a times
developers were distributing source code in tarballs. Simple credits
with your name in the top comment should be enough ;).

We use LKML coding style for LTP so you can use checkpatch.pl[1] to
check that your platches are okay.

1. https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl

> 2. how to invoke new syscalls
> a)
> Patch from Chris is defining new syscall numbers in test and
> using syscall(2).

Don't do that, use testcases/kernel/include/linux_syscall_numbers.h
instead (note that this file is generated and doesn't exists in the git
repo).

> b)
> My patch adds configure check for glibc wrappers process_vm_readv/writev
> and if those does not exists it checks for __NR_process_vm_readv.

That is generally what we should do, although sometimes there is a
difference between the libc wrapper and doing the syscall manually. In
some of the cases you can't get EFAULT because the pointer is
dereferenced in the userspace before it's passed to the kernel... Just
keep that in mind.

> I think we should not define syscall numbers in tests directly,
> but I'm relying on LTP maintainers to provide guidance here.
> In any case, if you run it on older kernel it should end with TCONF.

Yes, please use the generated header. ;)

> I would go with using Chris' process_vm.h, but remove syscall number
> defines and use names that wont conflict with glibc wrappers:
> test_process_vm_readv
> test_process_vm_writev
> 
> These could be function pointers, that would get initialized with
> function using glibc wrapper
> function using syscall(__NR_process_vm_readv,..)
> or NULL
>
> each testcase could check in setup for NULL, and end with TCONF,
> if there is no way invoke that syscall.

Once you actually _did_ the configure check, this complications aren't
really needed. Or have I missed something?

> There was question from Caspar, if we should check for both glibc wrapper
> and syscall number (http://thread.gmane.org/gmane.linux.ltp/16055).
> I think we should, as we use glibc wrappers by default.
> 
> Any thoughts?

As I said, once you are sure that glibc wrapper and bare syscall do the
same in your case preffering glibc wrapper is good idea as this covers
the codepath as whole. Otherwise just do the syscall and it either works
or you get ENOSYS.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
