From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 25 Feb 2019 21:16:14 +0800
Subject: [LTP] [PATCH] syscalls/cma: fix the failure of compiling with
 O2 option
In-Reply-To: <1507968555.2666255.1551091645854.JavaMail.zimbra@redhat.com>
References: <20190223062135.GB49700@linux.alibaba.com>
 <1551082945-75385-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <1507968555.2666255.1551091645854.JavaMail.zimbra@redhat.com>
Message-ID: <20190225131614.GC49700@casparzhang.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 25, 2019 at 05:47:25AM -0500, Jan Stancek wrote:
>
>
> ----- Original Message -----
> > This issue is triggered by the commit 9b02cd465f70 which I wrote. If
> > compile the process_vm_readv03.c with O2 option and run, it will return
> > TFAIL. By casting the int type to long type in the ltp_syscall calling
> > functions can we avoid this failure.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
> > ---
> >  testcases/kernel/syscalls/cma/process_vm_readv03.c | 8 ++++----
>
> What about other tests that were changed by commit 9b02cd465f70 ?

I downgraded my glibc from 2.17-196 (a centos 7.4 version) to
2.17-157 was able to reproduce this issue. I also tried modifying
the params in all `TEST(ltp_syscall(__NR_process_vm...` calls, seemd
that this is the only one causes (and solves) the failure:

        TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local, NUM_LOCAL_VECS,
-                                  remote, nr_iovecs, 0));
+                                  remote, nr_iovecs, 0UL));

If we have enough time we might want to do a bisect between
glibc-2.17-157 and 196 to dig into the real problem behind the simple
fix, but for now I'm agree to convert all int params to correct unsigned
long changed by this commit, so that we can get rid of any potential
failures.

Jason, can you make an updated patch to include Li Wang's and Jan's
advices?

Thanks,
Caspar
