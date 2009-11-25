Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDBa3-0000wc-98
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 06:42:23 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDBZy-0004pJ-Ru
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 06:42:23 +0000
Received: by pxi33 with SMTP id 33so5099253pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Nov 2009 22:42:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B0C8C98.9050007@cn.fujitsu.com>
References: <000001ca6d65$076cb650$164622f0$@co.jp>
	<4B0C8C98.9050007@cn.fujitsu.com>
Date: Tue, 24 Nov 2009 22:42:12 -0800
Message-ID: <364299f40911242242l32cd77faj8b2f0afdb40aaeca@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] build failure with 2009-11-24 cvs
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Tue, Nov 24, 2009 at 5:47 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
> Hi,
> On 11/25/2009 08:19 AM, Mitani wrote:
>> Hi,
>>
>> I ran "make" in RHEL5.4 (Kernel release : 2.6.18-164.el5) with
>> ltp-2009-11-24.tar.gz.
>> But it failed with following error message.
>> ./configure has been done before make.
>> I use "make 3.81", "autoconf 2.61", "automake 1.10.2", and "m4 1.4.7".
>>
>> ------------
>> make[3]: Entering directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
>> make[3]: *** No rule to make target
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/li
>> bevent/test/Makefile', needed by `libevent-all'. =A0Stop.
>> make[3]: Leaving directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases/kernel'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases'
>> make: *** [testcases-all] Error 2
>> ------------
>>
>> Similar failure occurred in RHEL5.4 and ltp-2009-11-20.tar.gz too.
>>
>>
>> I confirmed in "${LTPROOT}/testcases/kernel/syscalls/libevent/test"
>> directory.
>> As a result, there wasn't "Makefile" in this directory.
>> I think that the following command in
>> "${LTPROOT}/testcases/kernel/syscalls/Makefile"
>> failed by this reason.
>>
>> ------------
>> libevent-all: $(abs_srcdir)/libevent/test/Makefile libevent/test
>> =A0 =A0 =A0 =A0 $(MAKE) -C libevent/test -f "$(firstword $^)" $(LIBEVENT=
_APPS)
>> ------------
>>
>> I judged that "${LTPROOT}/testcases/kernel/syscalls/libevent/configure"
>> made "${LTPROOT}/testcases/kernel/syscalls/libevent/test/Makefile".
>> After execute this configure,
>> "${LTPROOT}/testcases/kernel/syscalls/libevent/test/Makefile"
>> was made.
>>
>>
>> I executed "make" command in "${LTPROOT}" directory again.
>> Then, this time, it failed in the following error message.
>>
>> ------------
>> make[3]: Entering directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
>> make -C libevent/test -f
>> "/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test/Makefi=
le"
>> regress test-eof test-init test-time test-weof
>> make[4]: Entering directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
>> gcc -DHAVE_CONFIG_H -I. -I. -I.. =A0 =A0 -I../compat -Wall -g -O2 -c reg=
ress.c
>> make[4]: *** No rule to make target `../libevent.a', needed by `regress'.
>> Stop.
>> make[4]: Leaving directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
>> make[3]: *** [libevent-all] Error 2
>> make[3]: Leaving directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases/kernel'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/home/LTP/ltp-2009-11-24/testcases'
>> make: *** [testcases-all] Error 2
>> ------------
>>
>>
>> This time's failure seems to be caused by the fact that there is not
>> "${LTPROOT}/testcases/kernel/syscalls/libevent/libevent.a", I think.
>>
>>
>> "libevent.a" file was made after I executed "make" command in
>> "${LTPROOT}/testcases/kernel/syscalls/libevent" directory.
>> But, following failure occurred when I executed this "make" command.
>>
>> ------------
>> Making all in test
>> make[2]: Entering directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
>> gcc -DHAVE_CONFIG_H -I. -I. -I.. =A0 =A0 -I../compat -Wall -g -O2 -c tes=
t-init.c
>> gcc =A0-I../compat -Wall -g -O2 =A0-o test-init =A0test-init.o -L.. -lev=
ent
>> gcc -DHAVE_CONFIG_H -I. -I. -I.. =A0 =A0 -I../compat -Wall -g -O2 -c tes=
t-eof.c
>> gcc =A0-I../compat -Wall -g -O2 =A0-o test-eof =A0test-eof.o -L.. -levent
>> gcc -DHAVE_CONFIG_H -I. -I. -I.. =A0 =A0 -I../compat -Wall -g -O2 -c tes=
t-weof.c
>> gcc =A0-I../compat -Wall -g -O2 =A0-o test-weof =A0test-weof.o -L.. -lev=
ent
>> gcc -DHAVE_CONFIG_H -I. -I. -I.. =A0 =A0 -I../compat -Wall -g -O2 -c tes=
t-time.c
>> gcc =A0-I../compat -Wall -g -O2 =A0-o test-time =A0test-time.o -L.. -lev=
ent
>> gcc =A0-I../compat -Wall -g -O2 =A0-o regress =A0regress.o -L.. -levent
>> gcc -DHAVE_CONFIG_H -I. -I. -I.. =A0 =A0 -I../compat -Wall -g -O2 -c ben=
ch.c
>> gcc =A0-I../compat -Wall -g -O2 =A0-o bench =A0bench.o -L.. -levent
>> make[2]: ./test.sh: Command not found
>> make[2]: *** [test] Error 127
>> make[2]: Leaving directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent/test'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory
>> `/home/LTP/ltp-2009-11-24/testcases/kernel/syscalls/libevent'
>> make: *** [all-recursive-am] Error 2
>> ------------
>>
>>
>> This failure depends on there not being "$ LTPROOT
>> /testcases/kernel/syscalls/libevent/test.sh".
>> I cannot make "test.sh", because I don't know what this "test.sh" do.
>> But, "${LTPROOT}/testcases/kernel/syscalls/libevent/libevent.a", was mad=
e,
>> then, first of all, I executed "make" command in "${LTPROOT}" directory
>> once again.
>> Then "make" succeeded.
>> After that, "make install" succeeded too.
>>
>>
>> >From the above, I think that there may be three following problems.
>>
>> (1) "${LTPROOT}/testcases/kernel/syscalls/libevent/test/Makefile" does n=
ot
>> exist.
>> =A0 =A0 For this measure, this "Makefile" should be made when
>> "${LTPROOT}/configure"
>> =A0 =A0 executed or this is offered as standard equipment, I think.
>>
>> (2) "${LTPROOT}/testcases/kernel/syscalls/libevent/libevent.a" does not
>> exist.
>> =A0 =A0 For this measure, this "libevent.a" may be necessary to be made =
when
>> =A0 =A0 "make" executed in "${LTPROOT}" directory.
>>
>> (3) "${LTPROOT}/testcases/kernel/syscalls/libevent/test/test.sh" does not
>> exist.
>> =A0 =A0 For this measure, this "test.sh" may be necessary to be offered =
as
>> standard
>> =A0 =A0 equipment.
>>
>>
>> Can I get some advice whether my thought above is right?
>>
>>
> =A0 =A0By using ltp-intermediate-20091122,
> =A0 =A0Same problems occured in my machine and same solutions to pass
> "make" step.
>
> =A0 =A0About test.sh, I think the author might forget to add test.sh to
> =A0 =A0"${LTPROOT}/testcases/kernel/syscalls/libevent/test/",
> =A0 =A0for in "${LTPROOT}/testcases/kernel/syscalls/libevent/Makefile",
> there does exist
> =A0 =A0"EXTRA_DIST =3D test/test.sh".

    Good catches guys. I've polished up the Makefile to not error out
if ./configure wasn't run, fixed some paths, and committed it -- will
work with the libevent folks upstream to commit it in their repos too.
Cheers!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
