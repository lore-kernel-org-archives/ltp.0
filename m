Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uctha-0002g5-GE
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 08:38:18 +0000
Date: Thu, 16 May 2013 10:39:24 +0200
From: chrubis@suse.cz
Message-ID: <20130516083923.GA31149@rei>
References: <1368610801-25821-1-git-send-email-alexey.kodanev@oracle.com>
	<20130515123826.GA22782@rei> <51939CB6.3020808@oracle.com>
	<20130515145652.GB25137@rei.suse.cz> <5194838B.2060104@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5194838B.2060104@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of cgroups and extended attributes
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > I do not want to add custom printf() format strings on purpose, as that
> > would:
> >
> > 1) create confusion
> >
> > 2) possibly break the checks on the format done by compiler
> >
> > Anybody else has better idea?
> Since we're going to print buf in hex, may be we can use
> tst_resm_hex(flags, buf, buf_len, fmt, ...) to make it more descriptive?

Naming things right is hard. I agree that 'hex' should be part of the
name but ideally something like 'dump' or 'buf' should be there as well
at least in form of the first letter (to keep the name reasonably short).

tst_resm_bhex() or tst_resm_dhex() ?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
