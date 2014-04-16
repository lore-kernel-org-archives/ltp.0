Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WaS96-0002wu-Li
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 15:53:08 +0000
Date: Wed, 16 Apr 2014 17:52:15 +0200
From: chrubis@suse.cz
Message-ID: <20140416155215.GA3135@rei>
References: <20140416091527.40612b3c@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140416091527.40612b3c@mats-desktop>
Subject: Re: [LTP] More informative error messages from SAFE_*?
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I ran into problems when using SAFE_OPEN, it complained about a
> non-existing path. It didn't tell me what path it tried, which made
> debugging more difficult than necessary.
> 
> I'm prepared to change the error messages in safe_macros.c to have a
> syntax similar to what I plan for safe_open():
> 
> 		tst_brkm(TBROK | TERRNO, cleanup_fn,
> 			"%s:%d: open(%s,%d) failed",
> 			file, lineno, pathname, oflags);
> 
> 
> I skipped the creation mode parameter since it was too much work
> handling an optional parameter...
> 
> Would anyone see a point in having all functions using a similar error
> syntax?

Sounds good to me.

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
