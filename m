Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvTHO-0003tE-R3
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 12:39:14 +0000
Date: Thu, 9 Feb 2012 13:53:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209125312.GB22269@saboteur.suse.cz>
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<1328784784-16910-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328784784-16910-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v3] safe_macros: add SAFE_STRTOL
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +
> +long safe_strtol(const char *file, const int lineno,
> +	    void (cleanup_fn)(void), char *str, long min, long max)
> +{
> +	long rval;
> +	char *endptr;

I think that we should set errno to zero here as the call itself doesn't
clear it on success.

> +
> +	rval = strtol(str, &endptr, 10);
> +	if ((errno == ERANGE && (rval == LONG_MAX || rval == LONG_MIN))
> +		    || (errno != 0 && rval == 0))
> +		tst_brkm(TBROK|TERRNO, cleanup_fn, "strtol failed at %s:%d",
> +			 file, lineno);
> +	if (rval > max || rval < min)
> +		tst_brkm(TBROK, cleanup_fn,
> +			 "converted value out of range: %ld - %ld",
> +			 min, max);
> +	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
> +		tst_brkm(TBROK, cleanup_fn, "Invalid value: %s", str);

I would consider printing the file and lineno in these two tst_brkm too
and add '' around the %s that is used to print the passed string.

> +	return rval;
> +}


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
