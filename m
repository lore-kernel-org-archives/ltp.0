From: kamal p <pkamalbhaskar@gmail.com>
Date: Wed, 23 Sep 2015 12:43:55 +0530
Subject: [LTP] LTP cross compilation
Message-ID: <CAO0kMxDo9Q_qs4GSxA3x10wBV6+yW4KdUciP8n8mS1mrSBu=pA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

   when I cross compiling the LTP i've faced an issue ,which is related to
linking error such as undefined reference to 'pthread_mutex_lock'. In
additon to './configure' i've given CFLAGS="-static"
LDFLAGS="-static-pthread" ..Is these was the correct? If no, please tell me
how will I cross compile LTP with relevent and clear procedure.

     Error which I got is as follows:
      make -C "lib" \
        -f
"/home/kamal/Desktop/CrossCom_ltp/ltp-full-20150903/lib/Makefile" all
make[1]: Entering directory
`/home/kamal/Desktop/CrossCom_ltp/ltp-full-20150903/lib'
make[2]: Entering directory
`/home/kamal/Desktop/CrossCom_ltp/ltp-full-20150903/lib/tests'
arm-none-linux-gnueabi-gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall
-W -static -Wold-style-definition -W  -I../../include -I../../include
-static-lpthread  -L../../lib  trerrno.c   -lltp -o trerrno
arm-none-linux-gnueabi-gcc: unrecognized option '-static-lpthread'
../../lib/libltp.a(safe_macros.o): In function `safe_getpwnam':
/home/kamal/Desktop/CrossCom_ltp/ltp-full-20150903/lib/safe_macros.c:118:
warning: Using 'getpwnam' in statically linked applications requires at
runtime the shared libraries from the glibc version used for linking
../../lib/libltp.a(tst_res.o): In function `tst_environ':
/home/kamal/Desktop/CrossCom_ltp/ltp-full-20150903/lib/tst_res.c:587:
undefined reference to `pthread_mutex_lock'
/home/kamal/Desktop/CrossCom_ltp/ltp-full-20150903/lib/tst_res.c:592:
undefined reference to `pthread_mutex_unlock'

Regards,
Kamal bhaskar
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20150923/038809c7/attachment.html>
