Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiChf-0000W7-Gu
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 22:19:31 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiChe-00048G-T4
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 22:19:31 +0000
Received: by obcwn6 with SMTP id wn6so18442718obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 14:19:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201201031557.08072.vapier@gentoo.org>
References: <4F02DBAF.5040202@imgtec.com>
	<201201031537.17888.vapier@gentoo.org>
	<CAGH67wRYtWO91esDJ2KUF0Db4_K=M+N1q2+r7JiE-A2BOOeO9Q@mail.gmail.com>
	<201201031557.08072.vapier@gentoo.org>
Date: Tue, 3 Jan 2012 14:19:25 -0800
Message-ID: <CAGH67wSrnkWdC8vYubfur6p2-Vs03F6LKvnZumtb-ZW-dWLy8g@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to proper
	integers
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
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

On Tue, Jan 3, 2012 at 12:57 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 03 January 2012 15:51:52 Garrett Cooper wrote:
>> On Tue, Jan 3, 2012 at 12:37 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> > On Tuesday 03 January 2012 05:42:55 Markos Chandras wrote:
>> >> Hi, please review the attached patch
>> >
>> > casting to a (long) would be better
>>
>> Or uintmax_t...
>
> that would work too, and better. =A0i thought nlinks could be signed, but=
 it
> seems not, so any signed type would be not as good.

   FreeBSD seems to typedef it to uint32_t, so unsigned integers seems
like the best way to go... yeah. The 'solution' for the issues with
format strings and long integers is generally cast to [u]intmax_t,
then use %zd or %zu.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create =

new or port existing apps to sell to consumers worldwide. Explore the =

Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
