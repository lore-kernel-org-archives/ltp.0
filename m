From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Feb 2017 09:32:13 +0100
Subject: [LTP] Build ltp failed
In-Reply-To: <201702221515031893328@rock-chips.com>
References: <201702221515031893328@rock-chips.com>
Message-ID: <20170223083213.GA15787@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I built the ltp under Ubnuntu14.04 using the following steps:
> 
> export AR=arm-linux-gnueabihf-ar
> export LD=arm-linux-gnueabihf-ld
> export CC=arm-linux-gnueabihf-gcc
> ./configure --host=arm-linux --target=arm-linux-gnueabihf --exec-prefix=/home/
> 
> make
> 
> 
> I got the following error message:
> 
> arm-linux-gnueabihf-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition  -I/home/xxm/workspace/vts/ltp/testcases/kernel/include -I../../../../include -I../../../../include -I../../../../include/old/   -L../../../../lib  io_cancel01.c   -lltp  -o io_cancel01
> /tmp/ccpEIBGL.o: In function `main':
> /home/xxm/workspace/vts/ltp/testcases/kernel/syscalls/io_cancel/io_cancel01.c:82: undefined reference to `io_cancel'

Looks like a problem with detecting the libaio devel library. Looks like
the HAVE_LIBAIO_H is defined but AIO_LIBS is empty. Removing
HAVE_LIBAIO_H from include config.h should work around this issue.

-- 
Cyril Hrubis
chrubis@suse.cz
