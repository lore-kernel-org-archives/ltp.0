Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkbdV-0006vZ-Do
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 16:02:29 +0000
Date: Wed, 14 May 2014 18:02:19 +0200
From: chrubis@suse.cz
Message-ID: <20140514160219.GA16987@rei>
References: <1389409991.2061.14.camel@G08JYZSD130126>
	<20140224193305.GC31562@rei>
	<1393309618.1952.52.camel@G08JYZSD130126>
	<5368A32E.7070805@oracle.com> <20140506144740.GA7908@rei.Home>
	<1399450341.2397.16.camel@G08JYZSD130126>
	<20140507122714.GB20240@rei>
	<1399517273.2102.8.camel@G08JYZSD130126>
	<20140513114628.GB12144@rei>
	<1400048364.2768.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400048364.2768.1.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2] linkat/linkat02.c: fix xfs with EMLINK issue
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
I've changed the code to store the fs_type into an variable in setup()
rather than calling the function on each iteration and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
