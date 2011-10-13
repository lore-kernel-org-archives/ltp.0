Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1REKAp-0001BH-TW
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 12:14:07 +0000
Date: Thu, 13 Oct 2011 14:17:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111013121742.GA23592@saboteur.suse.cz>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
	<CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
	<20111012134133.GA21367@saboteur.suse.cz>
	<CADfK0X435BeEb91Jsp96kRJgkaW-4aHHsLqNdU2WU+59HTPdug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADfK0X435BeEb91Jsp96kRJgkaW-4aHHsLqNdU2WU+59HTPdug@mail.gmail.com>
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

Hi!
> I exported CROSS_COMPILER path and ran configure the path from where LTP
> execute.
> and did make and make install as *ROOT* user.
> 
> I think , i want to modify Make-file in latest LTP for setting to my tool
> chain.
> 
> Could any one share Knowledge on 'How to modify the LTP-Make-file to our
> cross_compiler platform'

As Garrett said in previous mail, you need to pass correct parameters to
configure script, and these pointed out were --host, --build, CC,
CFLAGS, LDFLAGS. And as I said earlier, I didn't tried to cross compile
LTP so I do not have definitive answer how to do that. All I have are
hints.

-- 
Cyril Hrubis
chrubis@suse.cz

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
