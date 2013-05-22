Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UfAif-0003WU-Ut
	for ltp-list@lists.sourceforge.net; Wed, 22 May 2013 15:12:49 +0000
Date: Wed, 22 May 2013 17:14:00 +0200
From: chrubis@suse.cz
Message-ID: <20130522151359.GB9737@rei.suse.cz>
References: <CADqC_Hr9RkvE3feZZiAo5GLnh=OsB9Hvp146ZE0RS=gsDKAvkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADqC_Hr9RkvE3feZZiAo5GLnh=OsB9Hvp146ZE0RS=gsDKAvkQ@mail.gmail.com>
Subject: Re: [LTP] LTP Information
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
To: Asha Gowda <ashagow@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I would like to know the difference between January LTP packages and the
> MAY packages.
> 
> That is list of extra features supported in the current release.

Sorry we do not have a manpower to create such list, but you can get
that information from our git repository yourself, there was 223 patches
applied between last two releases and each of them is has reasonably
description in the commit log.

Just clone the git repository and run:

'git log --pretty=oneline 20130109..20130503'

to get summaries for all changes between these two releases.


Or run:

'git log 20130109..20130503'

to get the list with full description.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
