Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SUJAu-0005Mj-2o
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 14:56:32 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SUJAo-0006ab-8f
	for ltp-list@lists.sourceforge.net; Tue, 15 May 2012 14:56:32 +0000
Date: Tue, 15 May 2012 10:56:17 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FAA6A83.8010100@casparzhang.com>
MIME-Version: 1.0
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
To: Caspar Zhang <caspar@casparzhang.com>, Christopher Yeoh <cyeoh@au1.ibm.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Christopher Yeoh" <cyeoh@au1.ibm.com>
> Cc: ltp-list@lists.sourceforge.net, "Jan Stancek" <jstancek@redhat.com>
> Sent: Wednesday, 9 May, 2012 3:00:51 PM
> Subject: Re: [LTP] [PATCH] Simple tests for cross memory attach (process_vm_[readv|writev] syscalls)
> Hi Chris, thanks very much for the patch, I tried to backport your
> testcases in http://ozlabs.org/~cyeoh/cma/ to LTP and composed an
> unfinished version, then I was busy for other things. I'm happy to
> see
> you can backport it by yourself :) There are some more new cma
> patches
> (aims on testing retcode and errnos) sent by Jan Stancek (cc-ed) [1],
> I
> think we need to discuss the testcase organization..
> 
> And I will review the testcases when I get more free time.

Hi,

I looked at testcases sent by Chris. Good news is, they
do not overlap (in terms of functionality) with mine :-).

The patch need some polishing to match the style guide:
- indentation
- I think output should be TINFO, rather than plain printf
- single statement if without { }
- I would split some code to more functions, for example process_vm_writev01.c
  main function seems complex

As for test organization, I think we need to decide 2 issues:
1. directory structure
a)
  testcases/kernel/syscalls/cma/
  testcases/kernel/syscalls/cma/process_vm_readv
  testcases/kernel/syscalls/cma/process_vm_writev
b)
  testcases/kernel/syscalls/process_vm_readv
  testcases/kernel/syscalls/process_vm_writev

I'm preferring a) as these 2 syscalls are closely related,
and we already have need to share code.

2. how to invoke new syscalls
a)
Patch from Chris is defining new syscall numbers in test and
using syscall(2).

b)
My patch adds configure check for glibc wrappers process_vm_readv/writev
and if those does not exists it checks for __NR_process_vm_readv.

I think we should not define syscall numbers in tests directly,
but I'm relying on LTP maintainers to provide guidance here.
In any case, if you run it on older kernel it should end with TCONF.

I would go with using Chris' process_vm.h, but remove syscall number
defines and use names that wont conflict with glibc wrappers:
test_process_vm_readv
test_process_vm_writev

These could be function pointers, that would get initialized with
function using glibc wrapper
function using syscall(__NR_process_vm_readv,..)
or NULL

each testcase could check in setup for NULL, and end with TCONF,
if there is no way invoke that syscall.

There was question from Caspar, if we should check for both glibc wrapper
and syscall number (http://thread.gmane.org/gmane.linux.ltp/16055).
I think we should, as we use glibc wrappers by default.

Any thoughts?

Regards,
Jan

> 
> Thanks,
> Caspar
> 
> [1]
> http://thread.gmane.org/gmane.linux.ltp/16052
> http://thread.gmane.org/gmane.linux.ltp/16053
> http://thread.gmane.org/gmane.linux.ltp/16054
> http://thread.gmane.org/gmane.linux.ltp/16055
> 

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
