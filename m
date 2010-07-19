Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oakf1-0000Am-FI
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 07:21:11 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oakf0-0002Na-CS
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 07:21:11 +0000
Received: by iwn34 with SMTP id 34so5956600iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Jul 2010 00:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <717420931.522261279522531955.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1686792840.522211279522425828.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<717420931.522261279522531955.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Mon, 19 Jul 2010 00:21:05 -0700
Message-ID: <AANLkTilfXhCYO63J-Seg_hE8ln_pFY1eFawYHv1RiZyT@mail.gmail.com>
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

On Sun, Jul 18, 2010 at 11:55 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>
>>
>> =A0 =A0 The fact that the test is using time(3) to calculate the elapsed
>> period instead of clock_gettime is dubious at best, because the
>> precision of time is in seconds. Maybe it should be converted to
>> clock_gettime calls for improved precision?
>
> Use clock_gettime instead of time(3), patch attached.

Looks better, but being strict it's still buggy. POSIX defines struct
timespec as:

The <time.h> header shall declare the structure timespec, which has at
least the following members:

time_t  tv_sec    Seconds.
long    tv_nsec   Nanoseconds.

So you're losing precision in one case, and time_t can be variable
(the spec for types.h is rather fluid):

time_t and clock_t shall be integer or real-floating types.

The (struct timeval *) casts are also unnecessary because you're
getting the address of a struct timeval object (which is in both cases
struct timeval*).

> Another question, since POSIX.1-2008 marks gettimeofday() as obsolete
> (man gettimeofday), should the usec test part be changed to
> clock_getime as well?

Sure, if you want.

Thanks!
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
