From: Steve Ellcey <sellcey@cavium.com>
Date: Wed, 22 Mar 2017 11:35:48 -0700
Subject: [LTP] Building LTP without old rpc headers
Message-ID: <201703221835.v2MIZm8t023461@sellcey-dt.caveonetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This may be a known issue but I have been using LTP to test some new glibc
versions that I build and I found that if I did not configure the glibc
that I build with "--enable-obsolete-rpc" then when I build LTP and link
it against that glibc (and its headers) I get this error during the LTP
build:


gcc -mabi=ilp32 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition  -I../../../../../../include -I../../../../../../include -I../../../../../../include/old/  -c -o librpc01.o librpc01.c
librpc01.c:19:10: fatal error: rpc/xdr.h: No such file or directory
 #include <rpc/xdr.h>
          ^~~~~~~~~~~
compilation terminated.
<builtin>: recipe for target 'librpc01.o' failed
make[6]: *** [librpc01.o] Error 1
make[6]: Leaving directory '/home/sellcey/ltp/src-32/ltp/testcases/network/rpc/basic_tests/rpc01/lib'


I did not see any way to configure LTP to disable its use of this obsolete
header file but it would be nice if there was one so that I did not need to
include it in my glibc builds.

Should I open an issue for this?

Steve Ellcey
