Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1QgfPk-0000zv-1t
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 16:02:24 +0000
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QgfPg-0001ia-6g
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 16:02:24 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5CB141A6
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 16:02:06 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C49A22F7
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 16:02:06 +0000 (GMT)
Message-ID: <4E1C6FCE.1010402@st.com>
Date: Tue, 12 Jul 2011 18:01:18 +0200
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <4e1c09b0.04af2a0a.2ccb.ffffab1eSMTPIN_ADDED@mx.google.com>
	<CAGH67wQ4knG70q-bpPV0fmTOsmf9ciyPN-k65M=ysMk1o5_uFg@mail.gmail.com>
In-Reply-To: <CAGH67wQ4knG70q-bpPV0fmTOsmf9ciyPN-k65M=ysMk1o5_uFg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Added proper return code (TPASS) in case of exit
 without errors.
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
To: ltp-list@lists.sourceforge.net

On 12/07/2011 16.38, Garrett Cooper wrote:
> On Tue, Jul 12, 2011 at 1:45 AM, Francesco RUNDO <francesco.rundo@st.com> wrote:
>> From: Francesco Rundo <francesco.rundo@st.com>
>>
>> The "kill05" testcase checks if EPERM is correctly raised by the system.
>> The testcase manages the error exit codes correctly while it didn't return
>> any exit code in case of no errors occured i.e. the system has raised EPERM.
>> The correct exit-code "TPASS" has been added in case of the test works fine without
>> errors.
>>
>> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
>> Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> 
>     Please properly styleize this; this doesn't conform to Linux
> coding standards..

I've noted there is a trailing white space ?
is this the only problem ?

carmelo


> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> All of the data generated in your IT infrastructure is seriously valuable.
> Why? It contains a definitive record of application performance, security 
> threats, fraudulent activity, and more. Splunk takes this data and makes 
> sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-d2d-c2
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
