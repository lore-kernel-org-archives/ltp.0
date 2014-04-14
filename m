Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZhR9-0008FT-JW
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 14:00:39 +0000
Date: Mon, 14 Apr 2014 15:59:52 +0200
From: chrubis@suse.cz
Message-ID: <20140414135952.GA25967@rei.suse.cz>
References: <20140410165203.GA28293@rei> <5346F29E.7020402@oracle.com>
	<20140414115810.GB25624@rei.suse.cz> <534BE117.3070008@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <534BE117.3070008@oracle.com>
Subject: Re: [LTP] LTP Release
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> >> The warning was added 11 years ago and even at that time it was quite
> >> old... so gcc-2.95.3 (embedded systems?) doesn't have it.
> > Strange, it fails with gcc-3.3.3 on SLES for me. Anyway it's a matter of
> > simple configure check which I will write :).
> I did it in the following patch: 
> http://sourceforge.net/p/ltp/mailman/message/32213977

Faster than me :)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
