From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 5 Mar 2020 11:56:02 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E7-60528b7=2Ecki_=28stable-queue=29?=
In-Reply-To: <2065777364.10425170.1583425488638.JavaMail.zimbra@redhat.com>
References: <cki.EED856DF66.LLEP90YP5M@redhat.com>
 <2065777364.10425170.1583425488638.JavaMail.zimbra@redhat.com>
Message-ID: <173385062.10432633.1583427362328.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > 
> > Hello,
> > 
> > We ran automated tests on a recent commit from this kernel tree:
> > 
> >        Kernel repo:
> >        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >             Commit: 60528b79e30a - kvm: nVMX: VMWRITE checks unsupported
> >             field before read-only field
> > 
> > The results of these automated tests are provided below.
> > 
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: OK
> >              Tests: FAILED
> > 
> > All kernel binaries, config files, and logs are available for download
> > here:
> > 
> >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/04/471505
> > 
> > One or more kernel tests failed:
> > 
> >     s390x:
> >      ? LTP
> 
> All instances of similar panics [1] manifest mostly on s390 and at
> first glance look like memory corruptions.
> 
> I'm looking to confirm, whether this has been fixed by:
> 
>   commit 6fcca0fa48118e6d63733eb4644c6cd880c15b8f
>   Author: Suren Baghdasaryan <surenb@google.com>
>   Date:   Mon Feb 3 13:22:16 2020 -0800
> 
>     sched/psi: Fix OOB write when writing 0 bytes to PSI files

It's unrelated. The test does read, not write.

5.6.0-0.rc3 crashed as well. On s390x I'm using it's enough to
"cat /sys/fs/cgroup/cpu.pressure" to trigger.

