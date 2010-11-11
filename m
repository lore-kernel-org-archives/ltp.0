Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGSkE-0008Jr-6z
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:42:58 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGSkD-0003E6-5g
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 08:42:58 +0000
Received: by wwe15 with SMTP id 15so865498wwe.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 00:42:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001cb816d$dbdec820$939c5860$@co.jp>
References: <000001cb816d$dbdec820$939c5860$@co.jp>
Date: Thu, 11 Nov 2010 00:42:50 -0800
Message-ID: <AANLkTinR0mq5i9quvyecGE0AkOe8BSEDK12cTxw_i36P@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About "realtime" build failure
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
Cc: ltp-list@lists.sourceforge.net

On Wed, Nov 10, 2010 at 10:58 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> Build error occured with recent git "ltp-a997c94.tar.gz".
> This failure was caused by "realtime" as follows:
> ------------
> [root@RHEL48-LTP-x86 LTP]# less gitMMDD-makeYYYYMMDD.txt
> [...]
> make[1]: Entering directory `/home/LTP/ltp-a997c94/lib'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o cloner.o cloner.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o dataascii.o dataascii.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o databin.o databin.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o datapid.o datapid.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o file_lock.o file_lock.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o forker.o forker.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o get_high_address.o get_high_address.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o get_path.o get_path.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o libtestsuite.o libtestsuite.c
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../include
> -I../include =A0-
> c -o open_flags.o open_flags.c
> ...skipping...
> p-a997c94/testcases/realtime/include -I../../../../include
> -I../../../../include
> =A0 -L/home/LTP/ltp-a997c94/testcases/realtime/lib -L../../../../lib
> async_handl
> er.c =A0 -lrealtime -lpthread -lrt -lm -o async_handler
> In file included from async_handler.c:42:
> /home/LTP/ltp-a997c94/testcases/realtime/include/librttest.h: In function
> `atomi
> c_add':
> /home/LTP/ltp-a997c94/testcases/realtime/include/librttest.h:117: warning:
> impli
> cit declaration of function `__sync_add_and_fetch'
> /home/LTP/ltp-a997c94/testcases/realtime/lib/librealtime.a(librttest.o)(.=
tex
> t+0x
> 1a7): In function `create_thread':
> /home/LTP/ltp-a997c94/testcases/realtime/lib/../include/librttest.h:117:
> undefin
> ed reference to `__sync_add_and_fetch'
> collect2: ld returned 1 exit status
> make[4]: *** [async_handler] Error 1
> make[4]: Leaving directory
> `/home/LTP/ltp-a997c94/testcases/realtime/func/async_
> handler'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/home/LTP/ltp-a997c94/testcases/realtime/func'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/LTP/ltp-a997c94/testcases/realtime'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/LTP/ltp-a997c94/testcases'
> make: *** [testcases-all] Error 2

    If you had a more recent compiler this wouldn't be an issue. I
guess I'll add another autoconf test -_-...
-Garrett

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
