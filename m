Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NLZG5-0001r8-By
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 09:36:25 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NLZFy-0002Gk-Ho
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 09:36:25 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <451745090.560321261122821966.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>	
	<1512172575.560341261122853904.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<364299f40912180050v4515ffa1s36c79dde6d417f4e@mail.gmail.com>
In-Reply-To: <364299f40912180050v4515ffa1s36c79dde6d417f4e@mail.gmail.com>
Date: Fri, 18 Dec 2009 18:35:44 +0900
Message-ID: <000401ca7fc5$78fafd00$6af0f700$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] Build error of "regress.c"
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
To: 'Garrett Cooper' <yanegomi@gmail.com>, Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Caspar,
Garrett,

Thank you for useful information.

I arranged the patch to match the latest file, and applied it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ./Makefile.org      2009-12-16 04:27:42.000000000 +0900
+++ ./Makefile  2009-12-18 17:47:42.000000000 +0900
@@ -35,7 +35,7 @@
 $(warning directory if you want to run this test)
 else

-LIBEVENT               :=3D libevent/lib/libevent.a
+LIBEVENT               :=3D libevent/libevent.a

 CLEAN_DEPS             :=3D libevent-clean

@@ -56,8 +56,9 @@
 libevent libevent/test: %:
        mkdir -p "$@"

-$(TEST_APPS): LDFLAGS +=3D -L$(abs_builddir)/libevent/lib
+$(TEST_APPS): LDFLAGS +=3D -L$(abs_builddir)/libevent
 $(TEST_APPS): LDLIBS +=3D -levent
+$(TEST_APPS): CPPFLAGS +=3D -I$(abs_builddir)/libevent

 $(LIBEVENT): $(abs_srcdir)/libevent/Makefile libevent
        $(MAKE) -C libevent -f "$(firstword $^)" libevent.a
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After that, "make" succeeded!


Thank you--

-Tomonori Mitani


-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] =

Sent: Friday, December 18, 2009 5:50 PM
To: Caspar Zhang
Cc: Mitani; ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Build error of "regress.c"

On Thu, Dec 17, 2009 at 11:54 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
>
> ----- "Mitani" <mitani@ryobi.co.jp> wrote:
>
>> Hi,
>>
>> I ran "make" with "ltp-2009-12-16" and "ltp-2009-12-18" cvs,
>> but it failed:
>
>
> I met same problem. try this patch.
>
> Thanks,
> Caspar
>
>> ------------
>> [...]
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I../../../include
>> -I../../../include
>> =A0 -L../../../lib
>> -L/home/mitani/LTP/ltp-2009-12-18/testcases/kernel/syscalls/libevent/lib
>> =A0libevent/test/regress.c =A0-levent -o libevent/test/regress
>> libevent/test/regress.c:44:19: error: event.h: No such file or
>> directory
>> libevent/test/regress.c: In function 'simple_read_cb':
>> libevent/test/regress.c:69: warning: implicit declaration of function
>> 'event_add'
>> libevent/test/regress.c: In function 'multiple_write_cb':
>> libevent/test/regress.c:100: warning: implicit declaration of
>> function
>> 'event_del'
>> libevent/test/regress.c: In function 'signal_cb':
>> libevent/test/regress.c:159: warning: implicit declaration of
>> function
>> 'signal_del'
>> libevent/test/regress.c: At top level:
>> libevent/test/regress.c:164: error: field 'ev' has incomplete type
>> [...]
>> libevent/test/regress.c:455: warning: implicit declaration of
>> function
>> 'bufferevent_write'
>> libevent/test/regress.c:459: warning: implicit declaration of
>> function
>> 'bufferevent_free'
>> libevent/test/regress.c: In function 'main':
>> libevent/test/regress.c:473: warning: implicit declaration of
>> function
>> 'event_init'
>> make[3]: *** [libevent/test/regress] Error 1
>> make[3]: Leaving directory
>> `/home/mitani/LTP/ltp-2009-12-18/testcases/kernel/syscalls'
>> make[2]: *** [all] Error 2
>> [...]
>> ------------
>>
>> "regress.c" was not compiled before "ltp-2009-12-15" cvs.
>> It seems to have been compiled after "ltp-2009-12-16" cvs
>> for the first time.
>>
>>
>> The results of "make" are various by environment as follows:
>>
>> =A0 (1) RHEL5.4(2.6.18-164.el5) x86 =A0 =A0: succeeded
>> =A0 (2) RHEL5.4(2.6.18-164.el5) x86_64 : failed
>> =A0 (3) RHEL5.4(2.6.18-164.el5) ia64 =A0 : failed
>> =A0 (4) RHEL4.8(2.6.9-89.ELsmp) x86 =A0 =A0: succeeded
>>
>> There is "/usr/local/include/event.h" file in the successful system.
>> There is not "/usr/local/include/event.h" file in the failed system.
>>
>> "/usr/local/include/event.h" file completely accords with
>> "${LTPROOT}/testcases/kernel/syscalls/libevent/event.h" file.
>> I think that "${LTPROOT}/testcases/kernel/syscalls/libevent/event.h"
>> copied to "/usr/local/include/event.h" when installed.
>>
>> However, depending on system, there seems to be the case that
>> this file isn't copied.
>>
>>
>> ---
>>
>> Instead of "/usr/local/include/event.h", I installed "libevent-devel"
>> (libevent-devel-1.1a-3.2.1.x86_64.rpm) to above (2) system.
>> Then "/usr/include/event.h" file was installed.
>> This "/usr/include/event.h" file does not completely accord with
>> "/usr/local/include/event.h".
>> But after that, "make" succeeded.
>>
>> I don't think that this measure is right. This is the wrong way, I
>> think.
>> Because, I judge that LTP is going to copy a
>> "/usr/local/include/event.h"
>> file by oneself.
>>
>>
>>
>> Thank you--
>>
>> -Tomonori Mitani

    Please try again off cvs Mitani-san.
Thanks,
-Garrett



---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
