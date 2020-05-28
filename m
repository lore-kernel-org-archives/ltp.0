From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2020 17:13:05 +0200
Subject: [LTP] Memory requirements for ltp
In-Reply-To: <64a5e1c5c8041679e3024b564f2c67ace779c110.camel@linuxfoundation.org>
References: <64a5e1c5c8041679e3024b564f2c67ace779c110.camel@linuxfoundation.org>
Message-ID: <20200528151305.GA22505@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> I work on the Yocto Project and we run ltp tests as part of our testing
> infrastructure. We're having problems where the tests hang during
> execution and are trying to figure out why as this is disruptive.

> It appears to be the controllers tests which hang. Its also clear we
> are running the tests on a system with too little memory (512MB) as
> there is OOM killer activity all over the logs (as well as errors from
> missing tools like nice, bc, gdb, ifconfig and others).
TCONF messages for missing tools are ok (although many of the dependencies are
available in busybox).

> I did dump all the logs and output I could find into a bug for tracking
> purposes, https://bugzilla.yoctoproject.org/show_bug.cgi?id=13802

> Petr tells me SUSE use 4GB for QEMU, does anyone have any other
> boundaries on what works/doesn't work?

Maybe memory itself isn't the only parameter, more would be interesting
available memory, which depends on used user space and particular kernel
configuration (which can be different embedded targets).

> Other questions that come to mind:

> Could/should ltp test for the tools it uses up front?
> Are there any particular tests we should avoid as they are known to be
> unreliable?
IMHO generally anything which haven't been changed for 10+ years :).
Thus tests which are using legacy API (test.h or test.sh).
(well, of course, some old tests are stable and new can be broken).

> The ones we're currently running are:

> "math", "syscalls", "dio", "io", "mm", "ipc", "sched", "nptl", "pty",
> "containers", "controllers", 
> "filecaps", "cap_bounds", "fcntl-locktests", "connectors", "commands",
> "net.ipv6_lib", "input",
> "fs_perms_simple", "fs", "fsx", "fs_bind"
IMHO cve (many of these are also in other runtest files, but here with CVE
number), uevent (new one), maybe pty (has found some bugs).
Maybe you're also interested to test some networking: net_stress.interface,
net_stress.ipsec_icmp are stable.

Last release there was added lvmtest.sh, which does testing filesystems over
LVM (maybe not interesting for you due not having enough disc capacity. What I
like that it detect presented filesystems via generate_lvm_runfile.sh).

> someone suggested I should just remove controllers but I'm not sure
> that is the best way forward.
Until tests are fixed, it's really better to disable them.
They need to be revised, there are bugs [1] and no support for cgroup2.

BTW C based tests in testcases/kernel/mem/ use cgroups, thus there will be some
(very limited) cgroups testing. And there is an attempt to improve these tests
[2] to fix use with cgroup2 [3].

> I will test with more memory (not sure how much yet) but I'd welcome
> more data if anyone has any.
Please report back your investigation.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues?q=is%3Aissue+is%3Aopen+cgroup
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=178573
[3] https://github.com/linux-test-project/ltp/issues/611
