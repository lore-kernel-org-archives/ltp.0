Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZdxn-0006ap-BB
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 10:18:07 +0000
Date: Mon, 14 Apr 2014 12:17:21 +0200
From: chrubis@suse.cz
Message-ID: <20140414101720.GB24840@rei.suse.cz>
References: <20140410180326.093f2749@mats-desktop> <20140410163245.GA28166@rei>
	<20140411105953.02bcf46e@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140411105953.02bcf46e@mats-desktop>
Subject: Re: [LTP] ltplite test case crashes
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
> This is most likely the case, since all files, including root file
> system, are in RAM. ;-)
> 
> I tried to use "-d <path>" and also used same <path> as current working
> directory in order to force file creations there, but I got the same
> error. Is "-d" the option to use to solve problems like this? Or are
> there other techniques?

I've looked at the source code and the TMPDIR is not passed to growfiles
in the runtest file nor is TMPDIR utilized in the growfiles sources so
as far as I can see it seems defaults to current directory which should
be /opt/ltp/....

I would call this a bug.

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
