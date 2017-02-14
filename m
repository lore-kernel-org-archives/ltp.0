From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Feb 2017 09:06:14 -0500 (EST)
Subject: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
In-Reply-To: <20170213090837.GA16973@rei.lan>
References: <CAEemH2ddpwBet_2crzv+sOJ9P84fscFH1re4SCo1dD_PKGgsgA@mail.gmail.com>
 <20170213090837.GA16973@rei.lan>
Message-ID: <227667312.4337607.1487081174657.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Li Wang" <liwang@redhat.com>
> Cc: richiejp@f-m.fm, ltp@lists.linux.it
> Sent: Monday, 13 February, 2017 10:08:37 AM
> Subject: Re: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
> 
> Hi!
> > I'm trying to run ltp on upstream kernel-4.10.0-rc7, and found that
> > madvise07 always failing with no SIGBUS received when mmap the PRIVATE
> > memory. I hope to know if there're some relevant stuff about this
> > issue.
> > Any discussion or document for that?
> 
> Looks like a plain old kernel bug to me.

Or maybe MADV_HWPOISON is supposed to work only for faulted-in pages?
It works fine for me with change below:

diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index 2f8c42e..f5fd4b7 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -44,13 +44,13 @@ static int maptypes[] = {
 
 static void run_child(int maptype)
 {
-       const size_t msize = 4096;
+       const size_t msize = getpagesize();
        void *mem = NULL;
 
        mem = SAFE_MMAP(NULL,
                        msize,
                        PROT_READ | PROT_WRITE,
-                       MAP_ANONYMOUS | maptype,
+                       MAP_ANONYMOUS | maptype | MAP_POPULATE,
                        -1,
                        0);
 

> 
> > # uname -r
> > 4.10.0-rc7
> > 
> > # ./madvise07
> > tst_test.c:794: INFO: Timeout per run is 0h 05m 00s
> > madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
> > madvise07.c:72: FAIL: Did not receive SIGBUS after accessing
> > MAP_PRIVATE memory marked with MADV_HWPOISON
> 
> If you reach this TFAIL the child wasn't killed with a signal after it
> accessed memory marked with MADV_HWPOISON.
> 
> What hardware is this?

I'm seeing it on x86 KVM guest, with 2.6.32 (RHEL6.0), 3.10 (RHEL7), 4.8 and 4.9 kernels.

> 
> > madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
> > madvise07.c:90: PASS: madvise(..., MADV_HWPOISON) on MAP_SHARED memory
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
