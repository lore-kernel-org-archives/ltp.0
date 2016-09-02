From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Date: Fri, 2 Sep 2016 18:58:51 +0300
Subject: [LTP] reason of pwritev01_64 failure on 32-bit arm
Message-ID: <27af95c6-76ee-20f1-15e3-d84d729c1738@dev.rtsoft.ru>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I've reproduced and analyzed failure of pwritev01_64 described at [1]

[1] http://lists.linux.it/pipermail/ltp/2016-March/001201.html


pwritev01_64 fail is an LTP issue

pwrite01 and pwrite01_64 are built from the same source, pwrite01.c
64-bit version is built with additional define, -D_FILE_OFFSET_BITS=64,
which causes 'off_t' type defined by glibc to become 64-bit.

Problem is that both pwrite01.o and pwrite01_64.o link against the same
utility library, libltp
From this library, a routine called safe_pread() is used.
One of arguments of this routine has type off_t.
This means that ABI for this routine is different when built with
-D_FILE_OFFSET_BITS=64 and without it.
Library is built without -D_FILE_OFFSET_BITS=64, thus on 32-bit platform
safe_pread() inside library expects ABI with 32-bit 'off_t'. And
pwrite01_64.o, built with -D_FILE_OFFSET_BITS=64, uses different ABI.

If a copy of safe_pread() is injected inside pwrite01.c (and compile
issue is resolved), test passes.

In general, it is not safe to link together object files built with and
without -D_FILE_OFFSET_BITS=64, since that code is not always
binary-compatible.


On 64-bit platform, sizeof(off_t) is 8 both with and without
-D_FILE_OFFSET_BITS=64, this issue does not show.

WBR,
Nikita Yushchenko
