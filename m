Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvR1V-0008BX-KI
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 10:14:41 +0000
Date: Thu, 9 Feb 2012 11:28:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209102832.GA22269@saboteur.suse.cz>
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<1328780807-14132-1-git-send-email-caspar@casparzhang.com>
	<4F339925.3090801@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F339925.3090801@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] safe_macros: add SAFE_STRTOL
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > +	char *endptr;
> > +
> > +	rval = strtol(str, &endptr, 10);
> > +	if ((errno == ERANGE && (rval == LONG_MAX || rval == LONG_MIN))
> > +		    || (errno != 0 && rval == 0))
> > +		tst_brkm(TBROK|TERRNO, cleanup_fn, "strtol failed at %s:%d",
> > +			 file, lineno);
> > +	if (rval >= max || rval <= min)
> 
> 
> I'm not sure with this check. ;)

I would expect that the converted  value could reach both max and min.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
