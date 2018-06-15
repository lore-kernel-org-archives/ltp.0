From: Rafael Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 15 Jun 2018 15:27:37 -0300
Subject: [LTP] [PATCH] fcntl36: fix 32-bit sporadic failures
In-Reply-To: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
References: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
Message-ID: <CADtBP2CCPTXgy7QhESn-qMUv2wSM+xpEksMT1hWwfcFvk50HqA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan,

Running in a container, armhf userland, with arm64 kernel (real HW: hikey):

$ uname -a
Linux ltpfcntl36 4.16.0-2-arm64 #1 SMP Debian 4.16.12-1 (2018-05-27)
armv8l GNU/Linux

$ file ./fcntl36
./fcntl36: ELF 32-bit LSB pie executable ARM, EABI5 version 1 (SYSV),
dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for
GNU/Linux 3.2.0,
BuildID[sha1]=074ba3622d50f62108260d2912ae5dc0e8d52d46, with
debug_info, not stripped

My un-patched binary shows me:

[pid  3501] fcntl64(11, F_OFD_SETLK, {l_type=F_UNLCK,
l_whence=SEEK_SET, l_start=16384, l_len=4096} <unfinished ...>

no F_SETLK for this binary.

Running in a container, arm64 userland, with arm64 kernel (real HW: hikey):

$ file ./fcntl36
./fcntl36: ELF 64-bit LSB pie executable ARM aarch64, version 1
(SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1,
for GNU/Linux 3.7.0,
BuildID[sha1]=8fb1d0e0e0d027fce5c8d11742ce5bdb7678749b, with
debug_info, not stripped

Same un-patched binary shows me:

[pid   483] fcntl(10, F_OFD_SETLKW, {l_type=F_UNLCK,
l_whence=SEEK_SET, l_start=13312, l_len=4096} <unfinished ...>

Do you want me to test patched LTP in arm32/64 to make sure they work
and you check if it fixes the issue for i686 on your side ? Or should
I compile it some other way ?

Let me know what you need.

Rafael

On 15 June 2018 at 14:22, Jan Stancek <jstancek@redhat.com> wrote:

> No kernel bug, problem was found in my reproducer.
> Can anyone confirm this fixes 32-bit arm too?
