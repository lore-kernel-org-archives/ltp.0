Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1ObVZB-00071v-Bw
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 09:26:17 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObVZA-0001Cf-Hx
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 09:26:17 +0000
Received: by iwn34 with SMTP id 34so9188118iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Jul 2010 02:26:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523981765.524681279528364312.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <817263552.524511279528077317.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1523981765.524681279528364312.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Wed, 21 Jul 2010 02:26:10 -0700
Message-ID: <AANLkTikRUsqGqWOsKXkPjI3Rso-dfm7T-wTakoQb2bw0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix false alarm in pselect01
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, Jul 19, 2010 at 1:32 AM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>
>> On Sun, Jul 18, 2010 at 11:55 PM, Caspar Zhang <czhang@redhat.com>
>> wrote:
>> >
>> > ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>> >
>> >>
>> >> =A0 =A0 The fact that the test is using time(3) to calculate the
>> elapsed
>> >> period instead of clock_gettime is dubious at best, because the
>> >> precision of time is in seconds. Maybe it should be converted to
>> >> clock_gettime calls for improved precision?
>> >
>> > Use clock_gettime instead of time(3), patch attached.
>>
>> Looks better, but being strict it's still buggy. POSIX defines struct
>> timespec as:
>>
>> The <time.h> header shall declare the structure timespec, which has
>> at
>> least the following members:
>>
>> time_t =A0tv_sec =A0 =A0Seconds.
>> long =A0 =A0tv_nsec =A0 Nanoseconds.
>>
>> So you're losing precision in one case, and time_t can be variable
>> (the spec for types.h is rather fluid):
>>
>> time_t and clock_t shall be integer or real-floating types.
>>
>> The (struct timeval *) casts are also unnecessary because you're
>> getting the address of a struct timeval object (which is in both
>> cases
>> struct timeval*).
>>
>> > Another question, since POSIX.1-2008 marks gettimeofday() as
>> obsolete
>> > (man gettimeofday), should the usec test part be changed to
>> > clock_getime as well?
>>
>> Sure, if you want.
>
> Updated patch, FYI.
>
> Thanks,
> Caspar
>
>
>
> Hi all,
>
> =A0 1. In my recent tests, not all desired time be equal to exact executi=
on
> =A0 time in sec test part, use clock_gettime to improve precision.
> =A0 2. gettimeofday is marked as obsolete in POSIX.1-2008 according to
> =A0 man gettimeofday, so change gettimeofday to clock_gettime in nsec test
> =A0 part.
>
> =A0 Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> diff -Naur a/testcases/kernel/syscalls/pselect/Makefile b/testcases/kerne=
l/syscalls/pselect/Makefile
> --- a/testcases/kernel/syscalls/pselect/Makefile =A0 =A0 =A0 =A02010-04-0=
1 14:23:10.000000000 +0800
> +++ b/testcases/kernel/syscalls/pselect/Makefile =A0 =A0 =A0 =A02010-07-1=
9 14:54:38.984482305 +0800
> @@ -21,6 +21,7 @@
> =A0include $(top_srcdir)/include/mk/testcases.mk
> =A0include $(abs_srcdir)/../utils/newer_64.mk
>
> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -lpthread -lrt
> =A0%_64: CPPFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
>
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff -Naur a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/ke=
rnel/syscalls/pselect/pselect01.c
> --- a/testcases/kernel/syscalls/pselect/pselect01.c =A0 =A0 2010-04-01 14=
:23:10.000000000 +0800
> +++ b/testcases/kernel/syscalls/pselect/pselect01.c =A0 =A0 2010-07-19 16=
:08:32.402482397 +0800
> @@ -61,14 +61,12 @@
>
> =A0int main()
> =A0{
> - =A0 =A0 =A0 int ret_pselect, total_sec, fd, total_nsec;
> + =A0 =A0 =A0 int ret_pselect, fd;
> =A0 =A0 =A0 =A0fd_set readfds;
> - =A0 =A0 =A0 struct timespec tv;
> =A0 =A0 =A0 =A0int retval;
> - =A0 =A0 =A0 time_t t;
> - =A0 =A0 =A0 unsigned start, end;
> - =A0 =A0 =A0 struct timeval tv_start, tv_end;
> - =A0 =A0 =A0 int real_usec;
> + =A0 =A0 =A0 struct timespec tv, tv_start, tv_end;
> + =A0 =A0 =A0 long real_nsec, total_nsec;
> + =A0 =A0 =A0 int real_sec, total_sec;
>
> =A0 =A0 =A0 =A0setup();
>
> @@ -103,17 +101,20 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Testing basic pselect sa=
nity,Sleeping for %jd secs",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (intmax_t)tv.tv_sec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D time(&t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock_gettime(CLOCK_REALTIME, &tv_start);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pselect(0, &readfds, NULL, NULL, (s=
truct timespec *)&tv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pselect(0, &readfds, NULL, NULL, &t=
v,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D time(&t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock_gettime(CLOCK_REALTIME, &tv_end);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((end - start) =3D=3D total_sec) || ((e=
nd - start) =3D=3D total_sec + 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* do a rounding */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 real_sec =3D (int)(0.5 + (tv_end.tv_sec - t=
v_start.tv_sec +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1e-9 * (tv_=
end.tv_nsec - tv_start.tv_nsec)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (real_sec =3D=3D total_sec)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "Sleep tim=
e was correct");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "Sleep tim=
e was incorrect:%d !=3D %d",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0total_se=
c, (end - start));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0total_se=
c, real_sec);
> =A0 =A0 =A0 =A0}
>
> =A0#ifdef DEBUG
> @@ -129,19 +130,19 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Testing basic pselect sa=
nity,Sleeping for %ld nano secs",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_nsec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gettimeofday(&tv_start, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock_gettime(CLOCK_REALTIME, &tv_start);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pselect(0, &readfds, NULL, NULL, &=
tv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gettimeofday(&tv_end, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock_gettime(CLOCK_REALTIME, &tv_end);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Changed total_sec compare to an at leas=
t vs an exact compare */
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 real_usec =3D (tv_end.tv_sec - tv_start.tv_=
sec) * 1e6 +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv_end.tv_usec - tv_start.t=
v_usec;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 real_nsec =3D (tv_end.tv_sec - tv_start.tv_=
sec) * 1e9 +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv_end.tv_nsec - tv_start.t=
v_nsec;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* allow 10% error*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (abs(real_usec - tv.tv_nsec / 1000) < 0.=
1 * total_nsec / 1000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (abs(real_nsec - tv.tv_nsec) < 0.1 * tot=
al_nsec)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "Sleep tim=
e was correct");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TWARN,
> @@ -150,8 +151,8 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "due to t=
he limitation of the way it calculates the");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TWARN, "system ca=
ll execution time.");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Sleep time=
 was incorrect:%d usec vs expected %d usec",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0real_use=
c, total_nsec / 1000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Sleep time=
 was incorrect:%ld nsec vs expected %ld nsec",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0real_nse=
c, total_nsec);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0cleanup();

ACK (and thanks for the hard work)!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
