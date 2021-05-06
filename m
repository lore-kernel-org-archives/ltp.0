From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 13:57:00 +0200
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <0c99f4553e894db4bfc8bd3141e092d8@huawei.com>
References: <0c99f4553e894db4bfc8bd3141e092d8@huawei.com>
Message-ID: <YJPZjMS5jU1n8u7W@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Gongyi,

> I have reviewed the patch for some time, but I have not find the possible reason of it. Theoretically the patch didn't change the logic.
I don't see the problem on first quick look.

> Because I have not the i386 machine, so I can't run it.
FYI You can compile 32bit on 64bit machine:

$ PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure \
&& make && make install

NOTE: PKG_CONFIG_LIBDIR can vary, see INSTALL file. Or you can build LTP 32bit
with build.sh script:

$ ./build.sh -t 32

Kind regards,
Petr
