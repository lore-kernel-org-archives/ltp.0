From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 26 May 2020 09:54:17 +0100
Subject: [LTP] Memory requirements for ltp
Message-ID: <64a5e1c5c8041679e3024b564f2c67ace779c110.camel@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I work on the Yocto Project and we run ltp tests as part of our testing
infrastructure. We're having problems where the tests hang during
execution and are trying to figure out why as this is disruptive.

It appears to be the controllers tests which hang. Its also clear we
are running the tests on a system with too little memory (512MB) as
there is OOM killer activity all over the logs (as well as errors from
missing tools like nice, bc, gdb, ifconfig and others).

I did dump all the logs and output I could find into a bug for tracking
purposes, https://bugzilla.yoctoproject.org/show_bug.cgi?id=13802

Petr tells me SUSE use 4GB for QEMU, does anyone have any other
boundaries on what works/doesn't work?

Other questions that come to mind:

Could/should ltp test for the tools it uses up front?
Are there any particular tests we should avoid as they are known to be
unreliable?

The ones we're currently running are:

"math", "syscalls", "dio", "io", "mm", "ipc", "sched", "nptl", "pty",
"containers", "controllers", 
"filecaps", "cap_bounds", "fcntl-locktests", "connectors", "commands",
"net.ipv6_lib", "input",
"fs_perms_simple", "fs", "fsx", "fs_bind"

someone suggested I should just remove controllers but I'm not sure
that is the best way forward.

I will test with more memory (not sure how much yet) but I'd welcome
more data if anyone has any.

Cheers,

Richard

