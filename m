Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RENop-0007ZD-1r
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 16:07:39 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RENoo-0001Cv-Be
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 16:07:39 +0000
Received: by qadc1 with SMTP id c1so232508qad.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Oct 2011 09:07:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADfK0X6Rjn_+NPdO5XcZz7Ovk70RaLV4uHJ3abBTcKyRmfo9KA@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
	<CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
	<20111012134133.GA21367@saboteur.suse.cz>
	<CAGH67wTJVjjYHOqdcXqV8motaWeXWbin0RVDoB3iOSMh0ehyBA@mail.gmail.com>
	<CADfK0X6Rjn_+NPdO5XcZz7Ovk70RaLV4uHJ3abBTcKyRmfo9KA@mail.gmail.com>
Date: Thu, 13 Oct 2011 09:07:32 -0700
Message-ID: <CAGH67wQnRcOzEDya5VOKYC2faenALHh8ZqOQDUvyK4ZOYY2uNg@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Josh! <joshiplns@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Oct 13, 2011 at 4:46 AM, Josh! <joshiplns@gmail.com> wrote:
> Hi..
>
> Yes i need modify Make-file to my Cross_Compiler platform.

    You're doing it wrong then. Back when I built LTP on a more
regular linux with a group that I used to work with, I cross-compiled
for i386, mips, powerpc, and x86_64 on an x86_64 box.
    Please share how you're building instead of spinning in the thread
claiming that stuff is broken.
Thanks,
-Garrett

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
