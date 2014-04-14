Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WZk7b-0003dG-Ow
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 16:52:39 +0000
Date: Mon, 14 Apr 2014 18:51:53 +0200
From: chrubis@suse.cz
Message-ID: <20140414165152.GA11169@rei>
References: <20140411183712.7ca33b6c@mats-desktop>
	<534B5C8E.1070500@cn.fujitsu.com> <20140414161209.GA15595@rei.Home>
	<0247700D01F14443B9209F90AD938CC524515766@sestoex05.enea.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0247700D01F14443B9209F90AD938CC524515766@sestoex05.enea.se>
Subject: Re: [LTP] Problems compiling
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I tried sending patches to the mailing list, but something got wrong. So if you see strange patches from me, you know why... ;-)

I can see these ;), I haven't had time to look into the second one yet.

> Anyhow, your patch fixed my problem. Any if you would have received my patch, it is based on the same idea though I removed the "-f <file>" part completely. So my patch would probably break out-of-tree builds.

Thanks for testing it. I will push my patch now.

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
