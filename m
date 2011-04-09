Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8QxF-00022N-U7
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:43:29 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8QxF-0004zf-4Z
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:43:29 +0000
Received: by pwj9 with SMTP id 9so2234593pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 22:43:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
References: <1302294875-6898-1-git-send-email-aelder@sgi.com>
	<2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
Date: Fri, 8 Apr 2011 22:43:23 -0700
Message-ID: <BANLkTi=-b=AGXeU4D7WhpnRrV8hNg987Jg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/4] ltp: kill remaining warnings in "lib/tlibio.c"
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
> There remain a few warnings when I build "lib/tlibio.c":
> - _GNU_SOURCE is defined on the command line, then defined
> =A0unconditionally in this file. =A0Fix by making the definition
> =A0in the file conditional on whether it's already defined.
> - The function random_bit() has a full, standard declaration in
> =A0"include/random_range.h", so just include that file rather than
> =A0doing an incomplete declaration in lio_random_methods().

    Committed, but please note the item about contributing patches via
the mailing list next time as is stated in the "CONTRIBUTING TO THE
PROJECT" section under doc/style-guide.txt ; it makes our lives a lot
easier and increases throughput reviewing and committing patches.
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
