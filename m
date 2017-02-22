From: xxm@rock-chips.com <xxm@rock-chips.com>
Date: Wed, 22 Feb 2017 15:15:03 +0800
Subject: [LTP] Build ltp failed
Message-ID: <201702221515031893328@rock-chips.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I built the ltp under Ubnuntu14.04 using the following steps:

export AR=arm-linux-gnueabihf-ar
export LD=arm-linux-gnueabihf-ld
export CC=arm-linux-gnueabihf-gcc
./configure --host=arm-linux --target=arm-linux-gnueabihf --exec-prefix=/home/

make


I got the following error message:

arm-linux-gnueabihf-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition  -I/home/xxm/workspace/vts/ltp/testcases/kernel/include -I../../../../include -I../../../../include -I../../../../include/old/   -L../../../../lib  io_cancel01.c   -lltp  -o io_cancel01
/tmp/ccpEIBGL.o: In function `main':
/home/xxm/workspace/vts/ltp/testcases/kernel/syscalls/io_cancel/io_cancel01.c:82: undefined reference to `io_cancel'

anyone meet the same issue ?


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170222/c48b48f8/attachment.html>
