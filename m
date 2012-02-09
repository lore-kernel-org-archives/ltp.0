Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RvQZi-0005QO-LL
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 09:45:58 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RvQZd-0005jn-1g
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 09:45:58 +0000
Received: by iaby12 with SMTP id y12so2841385iab.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Feb 2012 01:45:47 -0800 (PST)
Message-ID: <4F3395B0.9060109@casparzhang.com>
Date: Thu, 09 Feb 2012 17:45:20 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328775194-10631-1-git-send-email-caspar@casparzhang.com>
	<4F339228.7000708@cn.fujitsu.com>
In-Reply-To: <4F339228.7000708@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] safe_macros: add SAFE_STRTOL
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 02/09/2012 05:30 PM, Wanlong Gao wrote:
> On 02/09/2012 04:13 PM, Caspar Zhang wrote:
> 
>> +
>> +long safe_strtol(const char *file, const int lineno,
>> +	    void (cleanup_fn)(void), char *str, long min, long max)
>> +{
>> +	int rval;
>> +	char *endptr;
>> +
>> +	rval = strtol(str, &endptr, 10);
>> +	if (rval == LONG_MAX || rval == LONG_MIN)
> 
> 
> Shouldn't we check the errno here?

Ah yes. I'll make a v2 soon.

> 
> Thanks
> -Wanlong Gao
> 
>> +		tst_brkm(TBROK|TERRNO, cleanup_fn, "strtol failed at %s:%d",
>> +			 file, lineno);
>> +	if (rval >= max || rval <= min)
>> +		tst_brkm(TBROK, cleanup_fn,
>> +			 "converted value out of range: %ld - %ld",
>> +			 min, max);
>> +	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
>> +		tst_brkm(TBROK, cleanup_fn, "Invalid value: %s", str);
>> +
>> +	return rval;
>> +}
> 
> 


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
