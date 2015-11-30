From: $rik@nth  <srikanth007m@gmail.com>
Date: Mon, 30 Nov 2015 19:04:13 +0530
Subject: [LTP]  64bit ld terminates for time01.c & write04.c
Message-ID: <CANKSX+E504F87K-3ZhaDPNcFLEVgv1oyRLeVV=vz69fMjSxtOw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi LTP,

I'm trying to cross compile the LTP to ARM 64bit and i am using
aarch64-linux-gnu- tool chain for cross compiling. Entire LTP got
compiled successfully except time01 and write04 tests due to ld
returned with signal 11 and core is not dumped either for debugging.
So i have collected strace for reference and attached is for time01.

aarch64-linux-gnu-gcc-4.8 -static -g -O2 -fno-strict-aliasing -pipe
-Wall -W -Wold-style-definition
-I/home/Srikanth/ltp-working/testcases/kernel/include
-I../../../include -I../../../include -static -pthread  -L../../../lib
 time01.c   -lltp -o time01
collect2: error: ld terminated with signal 11 [Segmentation fault], core dumped
make: *** [time01] Error 1

This issue is seen only for time01.c and write04.c Does these tests
really require some sort with 64bit? Or do i need some workarounds for
64bit arch?

-- 
Thanks & Regards,
M.Srikanth Kumar.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: strace.log
Type: application/octet-stream
Size: 1676643 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151130/6c446b65/attachment-0001.obj>
