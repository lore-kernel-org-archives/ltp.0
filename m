Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NFxLz-0002Qe-6C
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 22:07:19 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFxLq-0003X0-Sq
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 22:07:19 +0000
Received: by pwi12 with SMTP id 12so522463pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 02 Dec 2009 14:07:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca7320$90365cf0$b0a316d0$@co.jp>
References: <000001ca7245$b829af90$287d0eb0$@co.jp>
	<364299f40912010218h39e6f89eo36e49bfe9e083a23@mail.gmail.com>
	<000001ca7320$90365cf0$b0a316d0$@co.jp>
Date: Wed, 2 Dec 2009 14:07:04 -0800
Message-ID: <364299f40912021407l6f79feb8gd1d374c845e704f9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] build failure with ltp-2009-12-01 cvs
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

On Tue, Dec 1, 2009 at 11:25 PM, Mitani <mitani@ryobi.co.jp> wrote:
> I ran "runltp" with =A0"ltp-2009-12-02.tar.gz" version in system as follo=
ws.
>
> =A0(1) kernel 2.6.18-164.el5 - architecture x86
> =A0(2) kernel 2.6.18-164.el5 - architecture x86_64
>
> But same failure occured again:
>
> ------------
> make[4]: Entering directory
> `/home/LTP/ltp-2009-12-02/testcases/kernel/containers/libclone'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-2009-12-02/testcases/k
> ernel/include -I../../../../include -I../../../../include =A0-c -o libclo=
ne.o
> libclone.c
> In file included from libclone.h:31,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from libclone.c:17:
> /home/LTP/ltp-2009-12-02/testcases/kernel/include/linux_syscall_numbers.h=
:24
> : error: weak
> declaration of 'syscall_cleanup_stub' must be public
> make[4]: *** [libclone.o] Error 1
> make[4]: Leaving directory
> `/home/LTP/ltp-2009-12-02/testcases/kernel/containers/libclone'
> ------------
>
>
> Regars--
>
> -Tomonori Mitani
>
>
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, December 01, 2009 7:18 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] build failure with ltp-2009-12-01 cvs
>
> On Mon, Nov 30, 2009 at 9:18 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> Hi,
>>
>> I tried to "make" with "ltp-2009-12-01.tar.gz" version.
>> I tried it in systems as follows:
>> =A0(1) kernel 2.6.18-164.el5 - architecture x86
>> =A0(2) kernel 2.6.18-164.el5 - architecture x86_64
>>
>> But both failed with following message:
>>
>> ------------
>> [...]
>> make[3]: Entering directory
>> `/home/LTP/ltp-2009-12-01/testcases/kernel/containers'
>> make -C libclone -f
>> "/home/LTP/ltp-2009-12-01/testcases/kernel/containers/libclone/Makefil
>> e" all
>> make[4]: Entering directory
>> `/home/LTP/ltp-2009-12-01/testcases/kernel/containers/libclone
>> '
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/home/LTP/ltp-2009-12-01/testcases/k
>> ernel/include -I../../../../include -I../../../../include =A0-c -o
> libclone.o
>> libclone.c
>> In file included from libclone.h:31,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from libclone.c:17:
>>
> /home/LTP/ltp-2009-12-01/testcases/kernel/include/linux_syscall_numbers.h=
:24
>> : error: weak
>> declaration of 'syscall_cleanup_stub' must be public
>> make[4]: *** [libclone.o] Error 1
>> make[4]: Leaving directory
>> `/home/LTP/ltp-2009-12-01/testcases/kernel/containers/libclone'
>> make[3]: *** [libclone/libclone.a] Error 2
>> make[3]: Leaving directory
>> `/home/LTP/ltp-2009-12-01/testcases/kernel/containers'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/home/LTP/ltp-2009-12-01/testcases/kernel'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/home/LTP/ltp-2009-12-01/testcases'
>> make: *** [testcases-all] Error 2
>> ------------
>>
>>
>> I tried to avoid this failure by revising "${LTPROOT}/testcases
>> /kernel/include/linux_syscall_numbers.h".
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux_syscall_numbers.h.org 2009-12-01 09:52:25.000000000 +0900
>> +++ linux_syscall_numbers.h =A0 =A0 2009-12-01 11:37:10.000000000 +0900
>> @@ -21,7 +21,7 @@
>> =A0* result in compile-time errors and folks get the granularity they de=
sire
>> =A0* when writing testcases.
>> =A0*/
>> -static void syscall_cleanup_stub(void) __attribute__ ((weakref
>> ("cleanup")));
>> +void syscall_cleanup_stub(void) __attribute__ ((weakref ("cleanup")));
>>
>> =A0static void cleanup(void);
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> After applying this patch, "make" and "make install" succeeded in
>> both (1) and (2) systems.
>>
>>
>> Can I get some advice whether my revise above is right?
>
> It may work for your version of binutils, but it doesn't work for mine:
>
> make -C libclone -f
> "/scratch/ltp-dev2/ltp/testcases/kernel/containers/libclone/Makefile"
> all
> make[4]: Entering directory
> `/scratch/ltp-dev2/ltp/testcases/kernel/containers/libclone'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/scratch/ltp-dev2/ltp/testcases/kernel/include -I../../../../include
> -I../../../../include =A0-c -o libclone.o libclone.c
> In file included from libclone.h:31,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from libclone.c:17:
> /scratch/ltp-dev2/ltp/testcases/kernel/include/linux_syscall_numbers.h:24:
> error: weakref 'syscall_cleanup_stub' must have static linkage
> make[4]: *** [libclone.o] Error 1
> make[4]: Leaving directory
> `/scratch/ltp-dev2/ltp/testcases/kernel/containers/libclone'
> make[3]: *** [libclone/libclone.a] Error 2
> make[3]: Leaving directory
> `/scratch/ltp-dev2/ltp/testcases/kernel/containers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/scratch/ltp-dev2/ltp/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/scratch/ltp-dev2/ltp/testcases'
> make: *** [testcases-all] Error 2
>
> Please try the latest from CVS to see whether or not the new hidden
> refs fixes your issue.

    I grabbed Fedora Core 3 so I'll try validating and fixing this
issue on both newer and older versions of binutils by tonight.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. =

Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
