Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Ofx53-0008L7-4p
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 15:37:33 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id E617487567
	for <ltp-list@lists.sourceforge.net>;
	Mon,  2 Aug 2010 17:37:22 +0200 (CEST)
Date: Mon, 2 Aug 2010 17:53:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100802155347.GA1878@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] ltp buildsystem bugreport
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
To: ltp-list@lists.sourceforge.net

Hi!
I was trying to find a cause for very cryptic make errors and found that
I have colon somewhere in a path to the directory I was trying to
compile ltp in. Further examination showed that make is trying to
interpret all rules like:

$(top_builddir)/include/mk/config.mk:
	...

But found one more colon in $(top_builddir) and gets badly confused.

Also space, semicolon and may be others does the same job, so we should
either escape all top_builddir, abs_builddir, SUBDIRS, ... variables or
get rid of rules that contains them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
