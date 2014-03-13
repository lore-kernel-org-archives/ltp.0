Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WO7NY-0005fS-DT
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 15:17:04 +0000
Date: Thu, 13 Mar 2014 16:16:45 +0100
From: chrubis@suse.cz
Message-ID: <20140313151645.GB3628@rei.suse.cz>
References: <37DEC8B3-1B3C-4FD3-99F8-3E5436311195@gmx.net>
	<20140219144112.GC2138@rei>
	<4682076F-14CA-486F-9DFD-6E001FE036F7@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4682076F-14CA-486F-9DFD-6E001FE036F7@gmx.net>
Subject: Re: [LTP] runltplite access06 test relies on DEVICE and
 DEVICE_FS_TYPE
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
To: Harry Weppner <harry.weppner@gmx.net>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Hi Cyril,
> 
> here?s a patch that adds the block device (and block device file
> system type) options to the runltplite script. Assumption is that
> runltp and runltplite will (continue to) reside in the same directory.

Applied in LTP and closed the pull request.

Note that the review for LTP still primarily happens on the ML, so
please send the patches to the ML as well. Thanks.

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
