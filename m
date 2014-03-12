Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNiLX-0006rM-E4
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 12:33:19 +0000
Date: Wed, 12 Mar 2014 13:33:00 +0100
From: chrubis@suse.cz
Message-ID: <20140312123300.GA21693@rei>
References: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
	<20140311165448.GA11407@rei> <532024B6.9080603@oracle.com>
	<20140312104505.GA13689@rei.Home> <53204BC4.5040605@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53204BC4.5040605@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers/rcu: add wrapper script for
 rcutorture test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >>> This is quite fragile, if anything has added a line into dmesg while the
> >>> test was running it will fail. Better approach would be to save the
> >>> dmesg output into a file and grep it for the rcutorture resutl.
> >> Why copy it to a file? I'm thinking about changing to this command, it
> >> will return the last test result.
> >>
> >> result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
> > I was just thinking how to make the race window as small as possible. In
> > order to do that I would save the output right after the test has
> > finished etc.
> >
> > But it's quite unlikely that the whole kernel log buffer will be filled
> > with messages meanwhile.
> >
> Got it, so I will save it to a file, then parse the file with sed, OK?

Giving it second though piping it to sed directly is also acceptable.
The kernel log buffer is not that small and the code will be a bit less
complicated.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
