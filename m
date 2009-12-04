Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NGZb8-0000PY-5d
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 14:57:30 +0000
Date: Fri, 4 Dec 2009 15:58:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091204145816.GB8628@saboteur.suse.cz>
References: <20091116151656.GB16811@schrodinger.suse.cz>
	<20091120125347.GA4858@schrodinger.suse.cz>
	<20091126141346.GA7306@saboteur.suse.cz>
	<364299f40911260622s4e5ae3c5j555b922a7b85f4b0@mail.gmail.com>
	<20091130135024.GA4304@saboteur.suse.cz>
	<1259853101.5085.36.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.2.00.0912031014590.4647@sleepy>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912031014590.4647@sleepy>
Subject: Re: [LTP] [RFC] utstest.h
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
To: manoj.iyer@canonical.com
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, "paul.larson" <paul.larson@ubuntu.com>

Hi!
> Its been a while since I looke at that code, but as a general
> comment, any clean up effort is good, but please make sure you test
> it and release a beta version for people to try so that you dont
> break existing users. I am more interested in seeing a modified
> version and trying that out, rather than reading a proposal.

Well, before I start cleaning up the code I need to know which parts of the
interface are really usefull and should be keept in ltp.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
