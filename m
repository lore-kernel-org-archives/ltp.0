Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PHpDF-0003UJ-7v
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 02:54:33 +0000
Received: from out16.sjc.mx.trendmicro.com ([216.99.131.73])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PHpDB-0005yO-17
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 02:54:33 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.134])
	by out16.sjc.mx.trendmicro.com (Postfix) with ESMTP id 93D25980422
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Nov 2010 02:54:22 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id E9588114B839
	for <ltp-list@lists.sourceforge.net>;
	Mon, 15 Nov 2010 02:54:21 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Nov 2010 11:54:19 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 15 Nov 2010 11:54:19 +0900
Message-ID: <000001cb8470$6662ddb0$33289910$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP]  Realtime test failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

"realtime" build failed in my system with git "ltp-f388d33.tar.gz":
------------<RHEL4.8 - x86>
make[2]: Entering directory `/home/LTP/ltp-dev-20101112/testcases/realtime'
make -C lib -f "/home/LTP/ltp-dev-20101112/testcases/realtime/lib/Makefile"
all
make[3]: Entering directory
`/home/LTP/ltp-dev-20101112/testcases/realtime/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include
-I../../../include -I../../../include  -c -o librttest.o librttest.c
In file included from librttest.c:43:
/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librttest.h: In
function `atomic_add':
/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librttest.h:119
: warning: implicit declaration of function `__sync_add_and_fetch'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include
-I../../../include -I../../../include  -c -o libstats.o libstats.c
In file included from libstats.c:47:
/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librttest.h: In
function `atomic_add':
/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librttest.h:119
: warning: implicit declaration of function `__sync_add_and_fetch'
if [ -z "librttest.o libstats.o" ] ; then \
	echo "Cowardly refusing to create empty archive"; \
	exit 1; \
fi
ar -rc "librealtime.a" librttest.o libstats.o
ranlib "librealtime.a"
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101112/testcases/realtime/lib'
make[3]: Entering directory
`/home/LTP/ltp-dev-20101112/testcases/realtime/func'
make[4]: Entering directory
`/home/LTP/ltp-dev-20101112/testcases/realtime/func/async_handler'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/home/LTP/ltp-dev-20101112/testcases/realtime/include
-I../../../../include -I../../../../include
-L/home/LTP/ltp-dev-20101112/testcases/realtime/lib -L../../../../lib
async_handler.c   -lrealtime -lpthread -lrt -lm -o async_handler
In file included from async_handler.c:42:
/home/LTP/ltp-dev-20101112/testcases/realtime/include/librttest.h: In
function `atomic_add':
/home/LTP/ltp-dev-20101112/testcases/realtime/include/librttest.h:119:
warning: implicit declaration of function `__sync_add_and_fetch'
/home/LTP/ltp-dev-20101112/testcases/realtime/lib/librealtime.a(librttest.o)
(.text+0x1a7): In function `create_thread':
/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librttest.h:119
: undefined reference to `__sync_add_and_fetch'
collect2: ld returned 1 exit status
make[4]: *** [async_handler] Error 1
make[4]: Leaving directory
`/home/LTP/ltp-dev-20101112/testcases/realtime/func/async_handler'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/LTP/ltp-dev-20101112/testcases/realtime/func'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-dev-20101112/testcases/realtime'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-dev-20101112/testcases'
make: *** [testcases-all] Error 2
------------

"realtime" build failed in:
------------
RHEL4.8 -- x86, x86_64, ia64
RHEL5.4 -- x86
------------

"realtime" build succeeded in:
------------
RHEL5.4 -- x86_64, ia64
------------

It is caused by "__sync_add_and_fetch".

In following URL, "__sync_add_and_fetch" is "built-in functions for 
atomic memory access". And It is provided in "gcc":
   http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc/Atomic-Builtins.html

There is "__sync_add_and_fetch" in gcc4.1.2 (It is the gcc of RHEL5.1 -
RHEL5.4).
And there is not "__sync_add_and_fetch" in gcc3.4.6 (It is the gcc of
RHEL4.8)

In addition, "__sync_add_and_fetch" is for 64 bit environment.
 
http://stackoverflow.com/questions/130740/link-error-when-compiling-gcc-atom
ic-operation-in-32-bit-mode

   http://gcc.gnu.org/wiki/Atomic

Perhaps, the judgment that "realtime" must be built or not depends on 
gcc's version (> 4.0) and 64 bits environment, I think.



Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
