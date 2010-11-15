Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PHrUK-00022Z-8K
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 05:20:20 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PHrUF-0003NS-F0
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 05:20:20 +0000
Received: by wwe15 with SMTP id 15so4501995wwe.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Nov 2010 21:20:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000b01cb8481$c3c9a1d0$4b5ce570$@co.jp>
References: <000001cb8470$6662ddb0$33289910$@co.jp>
	<AANLkTimGi4v_OHzZAD8BbyGKsuVzpBcokEECezPeTC8e@mail.gmail.com>
	<000b01cb8481$c3c9a1d0$4b5ce570$@co.jp>
Date: Sun, 14 Nov 2010 21:20:09 -0800
Message-ID: <AANLkTim3wqv3fS8Sg9TNvZ=nDuXGcTB4GmPcH4d9pEee@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Realtime test failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>

2010/11/14 Mitani <mitani@ryobi.co.jp>:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Monday, November 15, 2010 12:03 PM
>> To: Mitani
>> Subject: Re: [LTP] Realtime test failure
>>
>> On Sun, Nov 14, 2010 at 6:54 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> > Hi,
>> >
>> > "realtime" build failed in my system with git "ltp-f388d33.tar.gz":
>> > ------------<RHEL4.8 - x86>
>> > make[2]: Entering directory
>> `/home/LTP/ltp-dev-20101112/testcases/realtime'
>> > make -C lib -f
>> "/home/LTP/ltp-dev-20101112/testcases/realtime/lib/Makefile"
>> > all
>> > make[3]: Entering directory
>> > `/home/LTP/ltp-dev-20101112/testcases/realtime/lib'
>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
>> > -I/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include
>> > -I../../../include -I../../../include =A0-c -o librttest.o librttest.c
>> > In file included from librttest.c:43:
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
>> st.h: In
>> > function `atomic_add':
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
>> st.h:119
>> > : warning: implicit declaration of function `__sync_add_and_fetch'
>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
>> > -I/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include
>> > -I../../../include -I../../../include =A0-c -o libstats.o libstats.c
>> > In file included from libstats.c:47:
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
>> st.h: In
>> > function `atomic_add':
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
>> st.h:119
>> > : warning: implicit declaration of function `__sync_add_and_fetch'
>> > if [ -z "librttest.o libstats.o" ] ; then \
>> > =A0 =A0 =A0 =A0echo "Cowardly refusing to create empty archive"; \
>> > =A0 =A0 =A0 =A0exit 1; \
>> > fi
>> > ar -rc "librealtime.a" librttest.o libstats.o
>> > ranlib "librealtime.a"
>> > make[3]: Leaving directory
>> > `/home/LTP/ltp-dev-20101112/testcases/realtime/lib'
>> > make[3]: Entering directory
>> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func'
>> > make[4]: Entering directory
>> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func/async_handler'
>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
>> > -I/home/LTP/ltp-dev-20101112/testcases/realtime/include
>> > -I../../../../include -I../../../../include
>> > -L/home/LTP/ltp-dev-20101112/testcases/realtime/lib
>> -L../../../../lib
>> > async_handler.c =A0 -lrealtime -lpthread -lrt -lm -o async_handler
>> > In file included from async_handler.c:42:
>> > /home/LTP/ltp-dev-20101112/testcases/realtime/include/librttest.h:
>> In
>> > function `atomic_add':
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/include/librttest.h:11
>> 9:
>> > warning: implicit declaration of function `__sync_add_and_fetch'
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/librealtime.a(libr
>> ttest.o)
>> > (.text+0x1a7): In function `create_thread':
>> >
>> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
>> st.h:119
>> > : undefined reference to `__sync_add_and_fetch'
>> > collect2: ld returned 1 exit status
>> > make[4]: *** [async_handler] Error 1
>> > make[4]: Leaving directory
>> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func/async_handler'
>> > make[3]: *** [all] Error 2
>> > make[3]: Leaving directory
>> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func'
>> > make[2]: *** [all] Error 2
>> > make[2]: Leaving directory
>> `/home/LTP/ltp-dev-20101112/testcases/realtime'
>> > make[1]: *** [all] Error 2
>> > make[1]: Leaving directory `/home/LTP/ltp-dev-20101112/testcases'
>> > make: *** [testcases-all] Error 2
>> > ------------
>> >
>> > "realtime" build failed in:
>> > ------------
>> > RHEL4.8 -- x86, x86_64, ia64
>> > RHEL5.4 -- x86
>> > ------------
>> >
>> > "realtime" build succeeded in:
>> > ------------
>> > RHEL5.4 -- x86_64, ia64
>> > ------------
>> >
>> > It is caused by "__sync_add_and_fetch".
>> >
>> > In following URL, "__sync_add_and_fetch" is "built-in functions for
>> > atomic memory access". And It is provided in "gcc":
>> > =A0 http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc/Atomic-Builtins.html
>> >
>> > There is "__sync_add_and_fetch" in gcc4.1.2 (It is the gcc of RHEL5.1
>> -
>> > RHEL5.4).
>> > And there is not "__sync_add_and_fetch" in gcc3.4.6 (It is the gcc of
>> > RHEL4.8)
>> >
>> > In addition, "__sync_add_and_fetch" is for 64 bit environment.
>> >
>> >
>> http://stackoverflow.com/questions/130740/link-error-when-compiling-
>> gcc-atom
>> > ic-operation-in-32-bit-mode
>> >
>> > =A0 http://gcc.gnu.org/wiki/Atomic
>> >
>> > Perhaps, the judgment that "realtime" must be built or not depends on
>> > gcc's version (> 4.0) and 64 bits environment, I think.
>>
>> Could you please attach your testcases/realtime/config.log and
>> testcases/realtime/include/realtime_config.h ?
>> Thanks,
>> -Garrett
>
>
> I understood.
> Thank you and sorry for my insufficient information.
>
> I attach following files:
> =A0 - config.log =A0 =A0 =A0 =A0(RHEL4.8-x86)
> =A0 - realtime_config.h (RHEL4.8-x86)
> =A0 - config.log =A0 =A0 =A0 =A0(RHEL5.5-x86)
> =A0 - realtime_config.h (RHEL5.5-x86)

    Could you please try compiling the following C sources in both scenario=
s?
Thanks,
-Garrett

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdlib.h>
int main(void) {
        char *c;
        return __sync_add_and_fetch(c, 1);
}

---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
