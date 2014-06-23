Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz4vs-0007p2-U2
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 14:09:16 +0000
Date: Mon, 23 Jun 2014 16:09:00 +0200
From: chrubis@suse.cz
Message-ID: <20140623140900.GA32755@rei.suse.cz>
References: <7CF842D49929104A9E5360C8FA9370998CF0D0@POCITMSEXMB03.LntUniverse.com>
	<1368345307.28778797.1403523788999.JavaMail.zimbra@redhat.com>
	<7CF842D49929104A9E5360C8FA9370998CF23D@POCITMSEXMB03.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7CF842D49929104A9E5360C8FA9370998CF23D@POCITMSEXMB03.LntUniverse.com>
Subject: Re: [LTP] fstatfs02 issue on mips64
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
To: Ajoymon Joseph <AJOY.JOSEPH@LNTTECHSERVICES.COM>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I am not seeing fstatfs call itself when comparing the system call. I
> hope this is the reason?

That is strange but I would not call this to be the reason for the test
fail.

> Also fstatfs02 was working fine. Only fstatfs02_64 was having the
> issue. I saw in ../utils/newer_64.mk makefile. It will be good if you
> tell little more about the 64 here.

The difference is that the _64 testcases are compiled with
-D_FILE_OFFSET_BITS=64 so it's possible that there is something wrong
with large file support on your platform.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
