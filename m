From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 02 Mar 2021 13:50:03 +0000
Subject: [LTP] Determinism issue for swapon/swapoff tests
Message-ID: <ae126f8484a916daa5e9b3970461dd3ac4083273.camel@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I've been ensuring the ltp binaries/packages used by Yocto Project
are reproducible. I've sent two patches which address most of the issues,
the remaining one was with the swapon/swapoff tests.

The challenge there is they share libswapon.o. There is a race over
building it depending on whether swapon or swapoff is built first.
The issue is that in one case "../swapon/libswapon.c" is referenced
in libswapon.o and in the other, "libswapon.c" is referenced. This
means the build isn't deterministic/reproducible.

I've worked around this in Yocto Project by executing:

"make -C XXX/testcases/kernel/syscalls/swapon/"

before running the main compile. That ensures we're deterministic
but I wanted to mention the issue in case you had a better solution
to fix the Makefiles?

Cheers,

Richard

