Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RENsy-0004HA-2c
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 16:11:56 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RENss-0001aQ-Rw
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 16:11:56 +0000
Received: by qadc1 with SMTP id c1so238752qad.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Oct 2011 09:11:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGH67wQnRcOzEDya5VOKYC2faenALHh8ZqOQDUvyK4ZOYY2uNg@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
	<CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
	<20111012134133.GA21367@saboteur.suse.cz>
	<CAGH67wTJVjjYHOqdcXqV8motaWeXWbin0RVDoB3iOSMh0ehyBA@mail.gmail.com>
	<CADfK0X6Rjn_+NPdO5XcZz7Ovk70RaLV4uHJ3abBTcKyRmfo9KA@mail.gmail.com>
	<CAGH67wQnRcOzEDya5VOKYC2faenALHh8ZqOQDUvyK4ZOYY2uNg@mail.gmail.com>
Date: Thu, 13 Oct 2011 09:11:45 -0700
Message-ID: <CAGH67wT0uyaiV9uitsNkUKS+bdhSpHkR4BCrDcakAno8KieHcw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp-pan: cannot execute binary file
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
To: Josh! <joshiplns@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Oct 13, 2011 at 9:07 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Oct 13, 2011 at 4:46 AM, Josh! <joshiplns@gmail.com> wrote:
>> Hi..
>>
>> Yes i need modify Make-file to my Cross_Compiler platform.
>
> =A0 =A0You're doing it wrong then. Back when I built LTP on a more
> regular linux with a group that I used to work with, I cross-compiled

s/linux/basis/

> for i386, mips, powerpc, and x86_64 on an x86_64 box.
> =A0 =A0Please share how you're building instead of spinning in the thread
> claiming that stuff is broken.

    Please note that it's been several years since I've cross-compiled
things (I've been working primarily with FreeBSD for the last year and
a half) -- which doesn't mean that a bug or two hasn't snuck into
LTP.. but I was pretty good at quashing issues like this at review
time when I was more active in the project.
-Garrett

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
