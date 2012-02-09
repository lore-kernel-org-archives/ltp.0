Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RvQoR-0007ko-RZ
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 10:01:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RvQoP-0006Ag-FA
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 10:01:11 +0000
Message-ID: <4F339925.3090801@cn.fujitsu.com>
Date: Thu, 09 Feb 2012 18:00:05 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<1328780807-14132-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1328780807-14132-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v2] safe_macros: add SAFE_STRTOL
Reply-To: gaowanlong@cn.fujitsu.com
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

On 02/09/2012 05:46 PM, Caspar Zhang wrote:

> +
> +long safe_strtol(const char *file, const int lineno,
> +	    void (cleanup_fn)(void), char *str, long min, long max)
> +{
> +	int rval;


Ah, long rval?

> +	char *endptr;
> +
> +	rval = strtol(str, &endptr, 10);
> +	if ((errno == ERANGE && (rval == LONG_MAX || rval == LONG_MIN))
> +		    || (errno != 0 && rval == 0))
> +		tst_brkm(TBROK|TERRNO, cleanup_fn, "strtol failed at %s:%d",
> +			 file, lineno);
> +	if (rval >= max || rval <= min)


I'm not sure with this check. ;)

Thanks
-Wanlong Gao

> +		tst_brkm(TBROK, cleanup_fn,
> +			 "converted value out of range: %ld - %ld",
> +			 min, max);
> +	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
> +		tst_brkm(TBROK, cleanup_fn, "Invalid value: %s", str);
> +
> +	return rval;
> +}



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
