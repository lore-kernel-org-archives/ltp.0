From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Mar 2017 21:56:17 +0100
Subject: [LTP] Building LTP without old rpc headers
In-Reply-To: <201703221835.v2MIZm8t023461@sellcey-dt.caveonetworks.com>
References: <201703221835.v2MIZm8t023461@sellcey-dt.caveonetworks.com>
Message-ID: <20170322205617.oanie4igc3dzc324@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This may be a known issue but I have been using LTP to test some new glibc
> versions that I build and I found that if I did not configure the glibc
> that I build with "--enable-obsolete-rpc" then when I build LTP and link
> it against that glibc (and its headers) I get this error during the LTP
> build:


> gcc -mabi=ilp32 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition  -I../../../../../../include -I../../../../../../include -I../../../../../../include/old/  -c -o librpc01.o librpc01.c
> librpc01.c:19:10: fatal error: rpc/xdr.h: No such file or directory
>  #include <rpc/xdr.h>
>           ^~~~~~~~~~~
> compilation terminated.
> <builtin>: recipe for target 'librpc01.o' failed
> make[6]: *** [librpc01.o] Error 1
> make[6]: Leaving directory '/home/sellcey/ltp/src-32/ltp/testcases/network/rpc/basic_tests/rpc01/lib'


> I did not see any way to configure LTP to disable its use of this obsolete
> header file but it would be nice if there was one so that I did not need to
> include it in my glibc builds.

> Should I open an issue for this?

Is it worth of checking it with AC_CHECK_HEADERS and #if HAVE_RPC_XDR_H?

These headers have been disabled since glibc 2.14 [1].

Kind regards,
Petr

[1]: https://savannah.gnu.org/forum/forum.php?forum_id=7288
