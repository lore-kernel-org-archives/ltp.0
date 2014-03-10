Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WMzfp-0000iO-2m
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 12:51:17 +0000
Date: Mon, 10 Mar 2014 13:50:58 +0100
From: chrubis@suse.cz
Message-ID: <20140310125058.GA10346@rei>
References: <531CAEB1.3060905@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <531CAEB1.3060905@xenomai.org>
Subject: Re: [LTP] out of tree build
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi,
> 
> I have tried building LTP january release, and found that the following 
> changes were necessary.

We did not test it for some time (I've looked at the history and it has
been broken for at least two years) sorry.

Now to the patch. Generally it looks good to me, most of the changes are
fixes in paths that should not break anything.

Have you tried in tree build with the changes, was it working fine?

Does the patch apply over the latest git? Ideally you should send a
signed patch against latest git (output from git format-patch).

And it would be a good idea to add out-of-tree build instructions into
the doc/mini-howto-building-ltp-from-git.txt too.

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
