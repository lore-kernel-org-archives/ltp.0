Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz5hY-0005Bs-EH
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 14:58:32 +0000
Date: Mon, 23 Jun 2014 16:58:15 +0200
From: chrubis@suse.cz
Message-ID: <20140623145815.GA982@rei.suse.cz>
References: <7CF842D49929104A9E5360C8FA9370998CF0D0@POCITMSEXMB03.LntUniverse.com>
	<1368345307.28778797.1403523788999.JavaMail.zimbra@redhat.com>
	<7CF842D49929104A9E5360C8FA9370998CF23D@POCITMSEXMB03.LntUniverse.com>
	<20140623140900.GA32755@rei.suse.cz>
	<7CF842D49929104A9E5360C8FA9370998CF26D@POCITMSEXMB03.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7CF842D49929104A9E5360C8FA9370998CF26D@POCITMSEXMB03.LntUniverse.com>
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
> statfs  is not there in strace output. Can you please tell me what can be the reason for strace not showing those functions?

No idea :(

Without carefull analysis this can range from missing implementation in
strace to bugs in strace implementation.

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
