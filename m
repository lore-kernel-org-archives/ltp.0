Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W32l6-0008SQ-Pm
	for ltp-list@lists.sourceforge.net; Tue, 14 Jan 2014 12:06:16 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D4581AC44
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jan 2014 12:06:08 +0000 (UTC)
Date: Tue, 14 Jan 2014 13:05:49 +0100
From: chrubis@suse.cz
Message-ID: <20140114120548.GA24679@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] LTP release
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
I've just commited a latest pack of fixes to LTP. The last commit
included in the release will likely be 6f22494.

I will do one more build and testrun before this is final, because Mike
commited a few fixes and changes in lib looks serious enough to be
retested. You can check that the lastest git works for you too.

If nothing serious shows up (which should really be the case) I will
ping Shubham to tag the release and upload the tarballs in the
evening.

Lastly but not least big thanks to everybody who helped with LTP
development. :)

PS: Please refrain from commiting anything to git until the release is
    finished.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
