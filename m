Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPYlP-0005j9-M2
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 14:43:39 +0000
Date: Mon, 17 Mar 2014 15:43:18 +0100
From: chrubis@suse.cz
Message-ID: <20140317144318.GA1807@rei>
References: <1394755221-5354-1-git-send-email-vlee@freedesktop.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394755221-5354-1-git-send-email-vlee@freedesktop.org>
Subject: Re: [LTP] [PATCH] Use absolute path for losetup.
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
To: Vinson Lee <vlee@freedesktop.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> From: Vinson Lee <vlee@twitter.com>
> 
> /sbin may not be in the default $PATH.

You are supposed to start runltp as a root, if losetup is not in your
$PATH something went wrong on your end.

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
