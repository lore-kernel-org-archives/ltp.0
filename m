Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filippo.arcidiacono@st.com>) id 1RxcNl-0001VL-FL
	for ltp-list@lists.sourceforge.net; Wed, 15 Feb 2012 10:46:41 +0000
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxcNf-0001iV-QA
	for ltp-list@lists.sourceforge.net; Wed, 15 Feb 2012 10:46:41 +0000
From: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
References: <1329233615-16625-1-git-send-email-filippo.arcidiacono@st.com>
	<4F3B2FFD.3020408@casparzhang.com>
	<4f3b6c8d.c1cb0e0a.3e38.354dSMTPIN_ADDED@mx.google.com>
	<4F3B87D7.4090700@casparzhang.com>
In-Reply-To: <4F3B87D7.4090700@casparzhang.com>
Date: Wed, 15 Feb 2012 11:46:26 +0100
Message-ID: <01e601ccebcf$11c89f20$3559dd60$@arcidiacono@st.com>
MIME-Version: 1.0
Content-Language: en-us
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
To: 'Caspar Zhang' <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net



> -----Original Message-----
> From: Caspar Zhang [mailto:caspar@casparzhang.com]
> Sent: Wednesday, February 15, 2012 11:24 AM
> To: Filippo ARCIDIACONO
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] getrusage03: add opportunity to reduce
> memory allocation's size
> 
> On 02/15/2012 04:27 PM, Filippo ARCIDIACONO wrote:
> >>> > >  static void inherit_fork2(void)
> >>> > >  {
> >>> > >  	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> >>> > >
> >>> > >  	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> >>> > >  	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> >>> > > -	if (is_in_delta(ru.ru_maxrss - 102400))
> >>> > > -		tst_resm(TPASS, "initial.children ~= 100MB");
> >>> > > +	if (is_in_delta(ru.ru_maxrss - (10240 * factor_nr)))
> >>> > > +		tst_resm(TPASS, "initial.children ~= %dMB", size);
> >> >
> >> > `size` in this function is not initialized?
> > 'size' is globally defined, it is initialized in the main().
> >
> 
> Yes, but seems that you missed a "size = 10240 * factor_nr" here.


No, size is in MB. What I'm doing is pass to inherit_fork2() 'size' as parameter,
In this function is used only to format the output string.
I'm going to repost the reworked patch shortly.

> 
> Thanks,
> Caspar


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
