Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDYrz-0000I2-Vx
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 13:29:23 +0000
Date: Tue, 20 Jan 2015 14:28:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120132826.GA11824@rei>
References: <20150119122310.GA27065@rei>
	<CA+icZUV53AWik-bS4a3DwgExD26nhCWxJWb-kGN_nAOWsikuLA@mail.gmail.com>
	<CA+icZUVSnYv3-rh6sBr8vgDsc80Qnr3yK_OZ6AezVHPrDcKXbg@mail.gmail.com>
	<20150120115625.GB11013@rei>
	<CA+icZUW3=TkMvEzs3DXZYt0BC5JjUtXiCsVSt3ikHwxPyzu3=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUW3=TkMvEzs3DXZYt0BC5JjUtXiCsVSt3ikHwxPyzu3=A@mail.gmail.com>
Subject: Re: [LTP] The Linux Test Project has been released for JANUARY 2015
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net, libc-alpha@sourceware.org, LKML <linux-kernel@vger.kernel.org>, lwn@lwn.net, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi!
> > Most of the failures comes from EBUSY while trying to umount
> > filesystems. Do you have gvfsd-trash running? That thing is known to
> > probe newly mounted filesystems preventing them from being unmounted for
> > a certain amount of time.
> >
> 
> Yupp, that popped up.
> How can I disable that gvfsd (here: Ubuntu/precise?

Just kill the process, or run the testcases via ssh session.

> And can this issue be documented?

Hmm, maybe we can change the test cases to complain loudly if the
process is found running.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
