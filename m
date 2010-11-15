Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PHrNb-0001iD-T0
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 05:13:23 +0000
Received: from out09.sjc.mx.trendmicro.com ([216.99.131.46])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PHrNX-0007JL-5L
	for ltp-list@lists.sourceforge.net; Mon, 15 Nov 2010 05:13:23 +0000
Message-ID: <000b01cb8481$c3c9a1d0$4b5ce570$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 15 Nov 2010 13:58:37 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_13_58_39_Monday_November_15_2010_15310"
References: <000001cb8470$6662ddb0$33289910$@co.jp>
	<AANLkTimGi4v_OHzZAD8BbyGKsuVzpBcokEECezPeTC8e@mail.gmail.com>
In-Reply-To: <AANLkTimGi4v_OHzZAD8BbyGKsuVzpBcokEECezPeTC8e@mail.gmail.com>
Content-Language: ja
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, =?utf-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_13_58_39_Monday_November_15_2010_15310
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Monday, November 15, 2010 12:03 PM
> To: Mitani
> Subject: Re: [LTP] Realtime test failure
> 
> On Sun, Nov 14, 2010 at 6:54 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> > "realtime" build failed in my system with git "ltp-f388d33.tar.gz":
> > ------------<RHEL4.8 - x86>
> > make[2]: Entering directory
> `/home/LTP/ltp-dev-20101112/testcases/realtime'
> > make -C lib -f
> "/home/LTP/ltp-dev-20101112/testcases/realtime/lib/Makefile"
> > all
> > make[3]: Entering directory
> > `/home/LTP/ltp-dev-20101112/testcases/realtime/lib'
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
> > -I/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include
> > -I../../../include -I../../../include  -c -o librttest.o librttest.c
> > In file included from librttest.c:43:
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
> st.h: In
> > function `atomic_add':
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
> st.h:119
> > : warning: implicit declaration of function `__sync_add_and_fetch'
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
> > -I/home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include
> > -I../../../include -I../../../include  -c -o libstats.o libstats.c
> > In file included from libstats.c:47:
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
> st.h: In
> > function `atomic_add':
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
> st.h:119
> > : warning: implicit declaration of function `__sync_add_and_fetch'
> > if [ -z "librttest.o libstats.o" ] ; then \
> >        echo "Cowardly refusing to create empty archive"; \
> >        exit 1; \
> > fi
> > ar -rc "librealtime.a" librttest.o libstats.o
> > ranlib "librealtime.a"
> > make[3]: Leaving directory
> > `/home/LTP/ltp-dev-20101112/testcases/realtime/lib'
> > make[3]: Entering directory
> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func'
> > make[4]: Entering directory
> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func/async_handler'
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
> > -I/home/LTP/ltp-dev-20101112/testcases/realtime/include
> > -I../../../../include -I../../../../include
> > -L/home/LTP/ltp-dev-20101112/testcases/realtime/lib
> -L../../../../lib
> > async_handler.c   -lrealtime -lpthread -lrt -lm -o async_handler
> > In file included from async_handler.c:42:
> > /home/LTP/ltp-dev-20101112/testcases/realtime/include/librttest.h:
> In
> > function `atomic_add':
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/include/librttest.h:11
> 9:
> > warning: implicit declaration of function `__sync_add_and_fetch'
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/librealtime.a(libr
> ttest.o)
> > (.text+0x1a7): In function `create_thread':
> >
> /home/LTP/ltp-dev-20101112/testcases/realtime/lib/../include/librtte
> st.h:119
> > : undefined reference to `__sync_add_and_fetch'
> > collect2: ld returned 1 exit status
> > make[4]: *** [async_handler] Error 1
> > make[4]: Leaving directory
> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func/async_handler'
> > make[3]: *** [all] Error 2
> > make[3]: Leaving directory
> > `/home/LTP/ltp-dev-20101112/testcases/realtime/func'
> > make[2]: *** [all] Error 2
> > make[2]: Leaving directory
> `/home/LTP/ltp-dev-20101112/testcases/realtime'
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory `/home/LTP/ltp-dev-20101112/testcases'
> > make: *** [testcases-all] Error 2
> > ------------
> >
> > "realtime" build failed in:
> > ------------
> > RHEL4.8 -- x86, x86_64, ia64
> > RHEL5.4 -- x86
> > ------------
> >
> > "realtime" build succeeded in:
> > ------------
> > RHEL5.4 -- x86_64, ia64
> > ------------
> >
> > It is caused by "__sync_add_and_fetch".
> >
> > In following URL, "__sync_add_and_fetch" is "built-in functions for
> > atomic memory access". And It is provided in "gcc":
> >   http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc/Atomic-Builtins.html
> >
> > There is "__sync_add_and_fetch" in gcc4.1.2 (It is the gcc of RHEL5.1
> -
> > RHEL5.4).
> > And there is not "__sync_add_and_fetch" in gcc3.4.6 (It is the gcc of
> > RHEL4.8)
> >
> > In addition, "__sync_add_and_fetch" is for 64 bit environment.
> >
> >
> http://stackoverflow.com/questions/130740/link-error-when-compiling-
> gcc-atom
> > ic-operation-in-32-bit-mode
> >
> >   http://gcc.gnu.org/wiki/Atomic
> >
> > Perhaps, the judgment that "realtime" must be built or not depends on
> > gcc's version (> 4.0) and 64 bits environment, I think.
> 
> Could you please attach your testcases/realtime/config.log and
> testcases/realtime/include/realtime_config.h ?
> Thanks,
> -Garrett


I understood.
Thank you and sorry for my insufficient information.

I attach following files:
   - config.log        (RHEL4.8-x86)
   - realtime_config.h (RHEL4.8-x86)
   - config.log        (RHEL5.5-x86)
   - realtime_config.h (RHEL5.5-x86)


Thank you--

-Tomonori Mitani

----=_NextPart_ST_13_58_39_Monday_November_15_2010_15310
Content-Type: application/x-zip-compressed;
	name="realtime.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="realtime.zip"

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

----=_NextPart_ST_13_58_39_Monday_November_15_2010_15310
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
----=_NextPart_ST_13_58_39_Monday_November_15_2010_15310
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_13_58_39_Monday_November_15_2010_15310--

