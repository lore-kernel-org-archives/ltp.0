Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YAyAz-0000IG-UH
	for ltp-list@lists.sourceforge.net; Tue, 13 Jan 2015 09:54:17 +0000
Date: Tue, 13 Jan 2015 10:53:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150113095325.GA7720@rei.suse.de>
References: <20150105144247.GA1082@rei.suse.de> <54B3FD5E.5040209@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54B3FD5E.5040209@oracle.com>
Subject: Re: [LTP] LTP release
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I'm back at work as promised and so we should start with the release
> > preparations. Let's start with the list of patches that should go in
> > before we start pre-release testing. I've looked around and good
> > candidates for what should be merged are:
> >
> > 1. timeouts for nets tests
> > 2. tbio fixes
> >
> > Anything else?
> 
> What about network/tcp_cmds/finger fixes? Though the patch v4 has minor 
> issues, but they can be fixed before push.

I'm fine with getting it in before the release. I will look at the patch
ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
