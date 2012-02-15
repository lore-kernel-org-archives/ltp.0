Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rxc2w-0002Ia-Qh
	for ltp-list@lists.sourceforge.net; Wed, 15 Feb 2012 10:25:10 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rxc2r-0006Ph-9a
	for ltp-list@lists.sourceforge.net; Wed, 15 Feb 2012 10:25:10 +0000
Received: by ghbf19 with SMTP id f19so600815ghb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Feb 2012 02:24:59 -0800 (PST)
Message-ID: <4F3B87D7.4090700@casparzhang.com>
Date: Wed, 15 Feb 2012 18:24:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1329233615-16625-1-git-send-email-filippo.arcidiacono@st.com>
	<4F3B2FFD.3020408@casparzhang.com>
	<4f3b6c8d.c1cb0e0a.3e38.354dSMTPIN_ADDED@mx.google.com>
In-Reply-To: <4f3b6c8d.c1cb0e0a.3e38.354dSMTPIN_ADDED@mx.google.com>
Subject: Re: [LTP] [PATCH] getrusage03: add opportunity to reduce memory
 allocation's size
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
To: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
Cc: ltp-list@lists.sourceforge.net

On 02/15/2012 04:27 PM, Filippo ARCIDIACONO wrote:
>>> > >  static void inherit_fork2(void)
>>> > >  {
>>> > >  	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
>>> > >
>>> > >  	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
>>> > >  	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
>>> > > -	if (is_in_delta(ru.ru_maxrss - 102400))
>>> > > -		tst_resm(TPASS, "initial.children ~= 100MB");
>>> > > +	if (is_in_delta(ru.ru_maxrss - (10240 * factor_nr)))
>>> > > +		tst_resm(TPASS, "initial.children ~= %dMB", size);
>> > 
>> > `size` in this function is not initialized?
> 'size' is globally defined, it is initialized in the main().
> 

Yes, but seems that you missed a "size = 10240 * factor_nr" here.

Thanks,
Caspar

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
