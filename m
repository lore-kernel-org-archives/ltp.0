Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q8RCx-00040w-84
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:59:43 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8RCw-0005rb-E6
	for ltp-list@lists.sourceforge.net; Sat, 09 Apr 2011 05:59:43 +0000
Received: by pxi15 with SMTP id 15so2066482pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Apr 2011 22:59:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <de84600847aa9a4caaed369f0771bf4a2e18536c.1302294850.git.aelder@sgi.com>
References: <2fb6f8d9dc82ef63e3c7cd80151cb6ea7972aae9.1302294850.git.aelder@sgi.com>
	<1302294875-6898-1-git-send-email-aelder@sgi.com>
	<de84600847aa9a4caaed369f0771bf4a2e18536c.1302294850.git.aelder@sgi.com>
Date: Fri, 8 Apr 2011 22:59:36 -0700
Message-ID: <BANLkTinJwd885ZKb67iD3ftkfhQ3kG6piQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 4/4] ltp: kill off warnings in "fsstress.c"
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
> Fix remaining warnings in "testcases/kernel/fs/fsstress/fsstress.c".
> Three of them are due to mismatches between fprintf() conversion
> specifications and the variables being formatted. =A0Fix these by
> casting the variables to the right type.
>
> Two others are due to the use of a __uint64_t local variable to
> represent a value of type __u64 (which evidently can be defined
> differently in some environments). =A0Fix these by using the exact
> matching type in the cases that produce the warning messages.

    I see different typedef'ed types when going over the xfs_ioctl.c
source. Could you please either use the kernel datatype (highly
recommended), or a POSIX equivalent if you can't use the kernel
datatype? I would really like the former because having to fix this in
2-4 years because someone changes the field size and the test doesn't
get updated properly is incredibly annoying.
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
