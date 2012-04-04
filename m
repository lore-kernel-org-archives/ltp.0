Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFU3E-0003wC-1S
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:31:20 +0000
Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFU3A-00083a-D9
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:31:20 +0000
Received: by vbbfr13 with SMTP id fr13so549291vbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 10:31:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201204041322.39735.vapier@gentoo.org>
References: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
	<201204041322.39735.vapier@gentoo.org>
Date: Wed, 4 Apr 2012 10:31:10 -0700
Message-ID: <CAGH67wR-2oyoiqiP1mBzinJ_AokW4Ce0yj5riuih1KTO0kUBcA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 0/4] Replace commonly used perl tools with awk
	equivalents
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
Cc: ltp-list@lists.sourceforge.net

On Wed, Apr 4, 2012 at 10:22 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 04 April 2012 01:23:43 Garrett Cooper wrote:
>> The intent behind these changes are to remove unnecessary perl
>> dependencies in LTP by using awk in its stead. It was something that was
>> discussed a while ago on ltp-list@.
>
> i like awk over perl a lot. =A0my only concern is non-POSIX stuff slippin=
g in
> (such as people who have gawk installed). =A0should we add a local wrapper
> script that sees if the awk accepts a --posix flag and automatically pass=
 it ?

That's actually a gawk-ism :)...

$ uname -a
FreeBSD bayonetta.local 9.0-STABLE FreeBSD 9.0-STABLE #7 r233759M: Sun
Apr  1 11:35:59 PDT 2012
gcooper@bayonetta.local:/usr/obj/store/freebsd/stable/9/sys/BAYONETTA
amd64
$ man awk | grep -- --posix || echo 'not found'
not found

Seeing how Android and some other Linux distros like borrowing bits
and pieces from BSD, I think that using --posix might not guarantee
much (on the bright side it doesn't error out either with 'the
one-true-awk'):

$ man awk | awk --posix 'END { exit 0 }'
$ echo $?
0

Debian's awk really cares though:

# cat /etc/debian_version
6.0.4
# awk --posix
awk: not an option: --posix
# echo $?
2

I understand the goals, but looking at the manpage on opengroup and
through one-true-awk's source, there's nothing consistent that
guarantees that POSIX is adhered to in awk (but there probably should
be a flag, environment variable, etc).

The constructs I used are simple though and should work on all variants of =
awk.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
