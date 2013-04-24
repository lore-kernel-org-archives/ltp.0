Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUw3W-00028E-99
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 09:32:02 +0000
Date: Wed, 24 Apr 2013 11:32:56 +0200
From: chrubis@suse.cz
Message-ID: <20130424093255.GA5674@rei>
References: <5177684F.7060204@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5177684F.7060204@cn.fujitsu.com>
Subject: Re: [LTP] question about a license
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> When trying to cleanup syscalls/getitimer03.c, i meet a strange license. It says:
> 
> *********************************************************************
> 
> /*
>  * $Copyright: $
>  * Copyright (c) 1984-2000
>  * Sequent Computer Systems, Inc.   All rights reserved.
>  *$
>  * This software is furnished under a license and may be used
>  * only in accordance with the terms of that license and with the
>  * inclusion of the above copyright notice.   This software may not
>  * be provided or otherwise made available to, or used by, any
>  * other person.  No title to or ownership of the software is
>  * hereby transferred.
>  */
> 
> *********************************************************************
> 
> Here is my question,
> 1. Can i change this license to GPL2? or
> 2. Can i modify code of the case under this license?
> 
> Could you please provide me any pointer/suggstion. :)

Given that the testcases is a few lines that calls getitimer() with
invalid value, I would play safe and rewrite it from scratch.

Anybody has different opinion?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
