From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Nov 2019 06:25:31 -0500 (EST)
Subject: [LTP] question about the EPERM error of LTP bpf test
In-Reply-To: <77525b33-67e5-2cfd-e735-6fc9485087e4@cn.fujitsu.com>
References: <008a677b-644d-615f-6c4f-0961af928700@cn.fujitsu.com>
 <1706711917.10302442.1572864628434.JavaMail.zimbra@redhat.com>
 <77525b33-67e5-2cfd-e735-6fc9485087e4@cn.fujitsu.com>
Message-ID: <623915519.10305094.1572866731625.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> on 2019/11/04 18:50, Jan Stancek wrote:
> 
> >
> > ----- Original Message -----
> >> Hi All
> >>
> >> Now, I test bpf_prog02 and bpf_prog03 in my system(4.18.0-107.el8.x86_64).
> >>
> >> #./bpf_prog03
> >> tst_buffers.c:55: INFO: Test is using guarded buffers
> >> tst_test.c:1137: INFO: Timeout per run is 0h 05m 00s
> >> bpf_common.h:18: INFO: Raising RLIMIT_MEMLOCK to 262143
> >> tst_capability.c:29: INFO: Dropping CAP_SYS_ADMIN(21)
> >> bpf_common.h:37: CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM
> >> (1)
> >> #
> >>
> >> Jan Stancek has added rlimit_bump_memlock function to avoid EPERM errno,
> >> but I still can meet this problem every time even though I have increased
> >> BPF_MEMLOCK_ADD limit.
> > This is likely not related to rlimit. Can you check if unprivileged bpf is
> > allowed:
> >    cat /proc/sys/kernel/unprivileged_bpf_disabled
> 
> Hi Jan
> 
> Thanks for your quick reply. this value in my system is 1.
> unprivileged bpf isn't allowed. Do we need to check it before run in case?

Yes, we should check that and TCONF, or better still run test without
dropping CAP_SYS_ADMIN.

> 
> >
> >> How can I run the two cases normally? Also, this error log(requires
> >> CAP_SYS_ADMIN on this system: EPERM
> >> ) makes me confused in this situation(because case drops CAP_SYS_ADMIN,
> >> but
> >> log reports need CAP_SYS_ADMIN)
> >> and I think we may change it into "require CAP_SYS_ADMIN or max locked
> >> memory
> >> limit is too low".
> >>
> >> Or, can I keep CAP_SYS_ADMIN cap in bpf_prog02/[3]?
> >>
> >>
> >> Thanks
> >> Yang Xu
> >>    
> >>
> >>
> >>
> >>
> >
> >
> 
> 
> 

