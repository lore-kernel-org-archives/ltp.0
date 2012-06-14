Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Sf9wk-0006ad-Ee
	for ltp-list@lists.sourceforge.net; Thu, 14 Jun 2012 13:18:46 +0000
Date: Thu, 14 Jun 2012 14:34:45 +0200
From: chrubis@suse.cz
Message-ID: <20120614123445.GB16073@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] Last release
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
To: Shubham Goyal <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
It looks like the github repo accidentally got lighweight tag instead of
the anotated one, at least git describe didn't work as expected. The
sf.net repo looked okay.

I've fixed the tags on github repo, but still I'm a bit confused...

What was the exact procedure you used to upload tags?

Ah, and I've looked into my sync script and it doesn't seem to mirror
tags from github to sf.net. I could fix my script so the tags on github
automatically appears on sf.net too.

And one more question, what is the difference between ltp-20120614 and
ltp-full-20120614 tarball on sf.net. It's a bit confusing, at least for
me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
