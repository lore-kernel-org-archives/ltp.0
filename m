Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8R7F-0003t3-5J
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:53:49 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8R7E-00068S-DF
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:53:49 +0000
Received: by pzk35 with SMTP id 35so2202754pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 22:53:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d639d5426d92155704bca0ab640ccf1257283b1f.1302294850.git.aelder@sgi.com>
References: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
	<1302294875-6898-1-git-send-email-aelder@sgi.com>
	<d639d5426d92155704bca0ab640ccf1257283b1f.1302294850.git.aelder@sgi.com>
Date: Fri, 8 Apr 2011 22:53:42 -0700
Message-ID: <BANLkTikBfGcLLDjb9S4Bte7a_4gTEf=EeQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] ltp: kill warnings related to formatting
 off_t in "growfiles.c"
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
To: Alex Elder <aelder@sgi.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Apr 8, 2011 at 1:34 PM, Alex Elder <aelder@sgi.com> wrote:
> In "testcases/kernel/fs/doio/growfiles.c" there are a number of
> variables of type off_t which are formatted using a "%ld" conversion
> specification. =A0When I build on an i386 system I get warnings,
> because evidently off_t is not defined as a long in this
> environment.
>
> Since off_t is a 32-bit signed type, it should be safe to just
> explicitly cast the off_t arguments to (long) in these cases.

    Ugh. tmp is abused way too much in this application for off_t //
size_t-ish cases (which is incredibly contradictory because off_t is
signed and size_t is unsigned according to POSIX and definition in
Linux). This really should be sorted out according to the function
being called/tested.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
