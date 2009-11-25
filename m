Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDCWf-0006Tx-5B
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 07:42:57 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDCWY-00031m-RM
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 07:42:57 +0000
Received: by pzk31 with SMTP id 31so5088699pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Nov 2009 23:42:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911250236.22440.vapier@gentoo.org>
References: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
	<200911250033.23404.vapier@gentoo.org>
	<364299f40911242226g68c37f59r1fcfd23ad87dd1e@mail.gmail.com>
	<200911250236.22440.vapier@gentoo.org>
Date: Tue, 24 Nov 2009 23:42:25 -0800
Message-ID: <364299f40911242342v795a0fe3pe217e982d614b9c0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] mbind01 test failed with after ltp-2009-11-12.tar.gz
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Nate Straz <nate@refried.org>, Mitani <mitani@ryobi.co.jp>

On Tue, Nov 24, 2009 at 11:36 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 25 November 2009 01:26:20 Garrett Cooper wrote:
>> On Tue, Nov 24, 2009 at 9:33 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> > On Wednesday 25 November 2009 00:17:16 Garrett Cooper wrote:
>> >> --- regen.sh =A019 Nov 2009 19:35:15 -0000 =A0 =A0 =A01.12
>> >> +++ regen.sh =A025 Nov 2009 05:12:13 -0000
>> >> @@ -32,8 +32,13 @@ static void cleanup(void);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "syscall " #NR "=
 not supported on
>> >> your arch"); \\ errno =3D ENOSYS; \\
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ret =3D -1; \\
>> >> - =A0 =A0 } else \\
>> >> + =A0 =A0 } else { \\
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ret =3D syscall(NR, ##__VA_ARGS__); \\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (__ret =3D=3D -1 && errno =3D=3D ENOSYS)=
 { \\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "s=
yscall " #NR " not
>> >> supported on your arch"); \\ + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =
=3D ENOSYS; \\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 } \\
>> >> + =A0 =A0 } \\
>> >> =A0 =A0 =A0 __ret; \\
>> >> =A0})
>> >> =A0EOF
>> >
>> > i'd prefer this change
>> > --- testcases/kernel/include/regen.sh =A0 9 Oct 2009 17:55:48 -0000
>> > 1.11 +++ testcases/kernel/include/regen.sh =A0 25 Nov 2009 05:28:27 -0=
000
>> > @@ -30,11 +30,12 @@ static void cleanup(void);
>> > =A0#define syscall(NR, ...) ({ \\
>> > =A0 =A0 =A0 =A0int __ret; \\
>> > =A0 =A0 =A0 =A0if (NR =3D=3D 0) { \\
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "syscall " #NR =
" not supported
>> > on your arch"); \\ errno =3D ENOSYS; \\
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ret =3D -1; \\
>> > =A0 =A0 =A0 =A0} else \\
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ret =3D syscall(NR, ##__VA_ARGS__); \\
>> > + =A0 =A0 =A0 if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) \\
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "syscall " #NR =
" not supported
>> > on your arch"); \\ __ret; \\
>> > =A0})
>> > =A0EOF
>>
>> =A0 =A0 Ok -- that makes more sense.. besides, I think gcc was optimizing
>> out the first branch with -O2 if it always evaluated to false. Here's
>> the new patch (I'm keeping the errno =3D ENOSYS part because I want to
>> make sure that tst_brkm doesn't mess up the errno value if a write(2)
>> fails or something).
>
> i thought tst_brkm exited when called with a cleanup func like we do here

    tst_brkm exits when cleanup is non-NULL:

        /*
         * If no cleanup function was specified, just return to the caller.
         * Otherwise call the specified function.  If specified function
         * returns, call tst_exit().
         */
        if (func !=3D NULL) {
                (*func)();
                tst_exit();
        }

    It's always defined for us in linux_syscall_numbers.h, thus it
always exits...
Cheers,
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
