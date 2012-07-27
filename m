Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SuhsR-0006sb-Uh
	for ltp-list@lists.sourceforge.net; Fri, 27 Jul 2012 10:34:35 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SuhsL-0004J8-TJ
	for ltp-list@lists.sourceforge.net; Fri, 27 Jul 2012 10:34:35 +0000
Date: Fri, 27 Jul 2012 06:34:23 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <736154694.4219510.1343385263338.JavaMail.root@redhat.com>
In-Reply-To: <3ED83A9DB3B6D94CA68BF7C03F2981D35CDEA2A664@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Subject: Re: [LTP] Failure of syscalls in kernel version 3.4
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
To: Om Prakash PAL <omprakash.pal@stericsson.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Om Prakash PAL" <omprakash.pal@stericsson.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 27 July, 2012 11:12:24 AM
> Subject: RE: [LTP] Failure of syscalls in kernel version 3.4
> 
> Hi Jan,
> Thanks for your reply.
> I have moved to latest LTP.
> After that some test cases are failing like:
>  
> [1].
>  shmat01
>  shmat01     1  TFAIL  :  shmat call failed: TEST_ERRNO=EINVAL(22):
>  Invalid argument

I could reproduce this issue with following change:
----------------------------------------------------
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 7c68459..5d6e79c 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -271,6 +271,8 @@ void setup(void)
                tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
        }
 
+        printf(" ");
+
        /* some architectures (e.g. parisc) are strange, so better always align to
         * next SHMLBA address. */
        base_addr =
----------------------------------------------------

What happens in setup() is that shared memory is attached/detached, and that
address is used in the rest of the test. In case above glibc needs
extra page and mmaps one at same exact spot:
----------------------------------------------------
shmget(0x61008d5b, 4, IPC_CREAT|IPC_EXCL|0600) = 2260995
shmat(2260995, 0, 0)                    = ?
shmdt(0x7ffabd573000)                   = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ffabd573000
shmat(2260995, 0x7ffabd573000, 0)       = -1 EINVAL (Invalid argument)
----------------------------------------------------

I'm assuming something like this happens in your case too,
output from "strace ./shmat01" would be helpful.

Regards,
Jan

> 
> 
> any idea about this one?.
> 
> Best Regards,
> Om Prakash Pal
> 
> -----Original Message-----
> From: Jan Stancek [mailto:jstancek@redhat.com]
> Sent: Friday, July 27, 2012 2:30 PM
> To: Om Prakash PAL
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Failure of syscalls in kernel version 3.4
> 
> 
> ----- Original Message -----
> > From: "Om Prakash PAL" <omprakash.pal@stericsson.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Monday, 2 July, 2012 8:49:20 AM
> > Subject: [LTP] Failure of syscalls in kernel version 3.4
> >
> > Hi,
> >
> > I am currently using ltp-full-20110915.bz2.
> > When I switched to  kernel 3.4(from kernel 3.0)  then these
> > syscalls ltp are failing.
> 
> I'd suggest you try latest LTP from git. Some of these failures
> should be already fixed.
> (Latest I ran was kernel 3.3 and it ran fine for the ones you listed)
> 
> > [1]. get_robust_list01
> > get_robust_list01    1  TPASS  :  get_robust_list failed as
> > expected with EFAULT
> > get_robust_list01    2  TPASS  :  get_robust_list failed as
> > expected with EFAULT
> > get_robust_list01    3  TPASS  :  get_robust_list failed as
> > expected with ESRCH
> > get_robust_list01    4  TFAIL  :  get_robust_list succeeded
> > unexpectedly
> > get_robust_list01    5  TPASS  :  get_robust_list succeeded
> > 
> > [2]. gettimeofday02
> > gettimeofday02    0  TINFO  :  checking if gettimeofday is
> > monotonous, takes 30s
> > gettimeofday02    1  TFAIL  :  Time is going backwards: old 946
> >  
> > 
> > [3]. lseek03
> > lseek03     1  TFAIL  :  lseek(tfile_16887, 1, 4) Failed, errno=6
> > No such device or address, expected 22(EINVAL)
> > lseek03     2  TPASS  :  lseek(tfile_16887, 1, -1) Failed, errno=22
> > : Invalid argument
> > lseek03     3  TPASS  :  lseek(tfile_16887, 1, 7) Failed, errno=22
> > : Invalid argument
> 
> > [4]. readlink03
> > readlink03    1  TPASS  :  readlink(), No Search permissions to
> > process, returned errno 13
> > readlink03    2  TPASS  :  readlink(), No Search permissions to
> > process, returned errno 13
> > readlink03    3  TPASS  :  readlink(), Buffer size is not positive,
> > returned errno 22
> > readlink03    4  TPASS  :  readlink(), Buffer size is not positive,
> > returned errno 22
> > readlink03    5  TPASS  :  readlink(), File is not symbolic link,
> > returned errno 22
> > readlink03    6  TPASS  :  readlink(), File is not symbolic link,
> > returned errno 22
> > readlink03    7  TPASS  :  readlink(), Symlink path too long,
> > returned errno 36
> > readlink03    8  TPASS  :  readlink(), Symlink path too long,
> > returned errno 36
> > readlink03    9  TFAIL  :  readlink() failed, Symlink Pathname is
> > empty, errno=2, expected errno=22
> > 
> > [5] shmat01
> > shmat01     1  TFAIL  :  shmat call failed: TEST_ERRNO=EINVAL(22):
> > Invalid argument
> > 
> > [6] sysctl01
> > sysctl01    1  TFAIL  :  sysctl(2) failed unexpectedly errno:38
> > sysctl01    2  TFAIL  :  sysctl(2) failed unexpectedly errno:38
> > sysctl01    3  TFAIL  :  sysctl(2) failed unexpectedly errno:38
> 38 is ENOSYS, this works only if your kernel supports it
> (CONFIG_SYSCTL=y).
> 
> > 
> > any idea why these testcases are failing now?.
> Kernel implementation moved forward, your LTP is almost year old.
> 
> Regards,
> Jan
> 
> > How can I resolve it?.
> > 
> > Best Regards,
> > Om Prakash Pal
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
