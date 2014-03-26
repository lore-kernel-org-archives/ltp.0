Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSkzB-0000Hy-QD
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 10:23:05 +0000
Date: Wed, 26 Mar 2014 11:22:37 +0100
From: chrubis@suse.cz
Message-ID: <20140326102237.GA8207@rei.suse.cz>
References: <4506ACC2AE90484D87F9A883BA36C21C548C89@LCHQEX03.lancope.local>
	<20140325153431.GA10754@rei>
	<4506ACC2AE90484D87F9A883BA36C21C548D90@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C548D90@LCHQEX03.lancope.local>
Subject: Re: [LTP] Suggested patch for Debian distro testing, part 1 of 2
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
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Thanks for the feedback, Cyril.
> Glad the m4 correction gets in quickly.
> 
> > And for the testcases, I would rather see them fixed to be able to run with POSIX shell because there were people running LTP on embedded HW with BusyBox. Are the required changes more complicated than [[ vs. [?
> 
> I've not explored all of them.  For many the answer is definitely "yes, more complicated":  'let' and '[[' and '((' and goodness knows what else.
> I wanted greatest coverage for a little effort invested, and didn't want that to go completely to waste.

Fair enough. What about fixing these that are easy to fix and for the
rest we change the shebang to bash and add a
"This test contains bashism that needs to be fixed!" warning?

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
