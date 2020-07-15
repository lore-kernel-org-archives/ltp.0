From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Jul 2020 10:18:57 +0200
Subject: [LTP] [PATCH 1/2] IMA: Verify that the kernel cmdline is passed
 and measured correctly through the kexec barrier.
In-Reply-To: <20200702153545.3126-2-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
Message-ID: <20200715081857.GB10916@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Add a testcase that verifies that kexec correctly logs the
> kernel command line to the IMA buffer and that the command
> line is then correctly measured.

> This test must be run standalone, since it runs kexec
> multiple times (and therefore reboots several times).

> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
...
> +++ b/testcases/kexec/utils.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +install() {
> +    local arg="$1"
> +
> +    if [ ! -d "/etc/init.d" ]; then
> +        mkdir /etc/init.d
> +    fi
I'm not sure if tests like this are suitable for LTP.
Ideal LTP test is a normal test, which is able to run with runltp, cleanup after
itself and use LTP C or/and shell API. LTP is full of tests which needs special
handling and thus not being run, not sure if it's a good idea to introduce yet
another one.

Also test shouldn't not significantly modify SUT to make it unbootable, which
I'm not sure in this case. This is a big difference to kselftests which are
meant to help during kernel development which somehow expects some system
modifications (as you install your custom build kernel).

I wonder if using QEMU would help to implement this test while not touching SUT
(thus be able to run this test with runltp). If you miss something in LTP API
just let us know.

Kind regards,
Petr
