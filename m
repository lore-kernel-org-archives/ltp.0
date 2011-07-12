Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Qge6x-0003kw-DG
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 14:38:55 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qge6w-0006Q2-GK
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 14:38:55 +0000
Received: by vws2 with SMTP id 2so5196405vws.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 07:38:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e1c09b0.04af2a0a.2ccb.ffffab1eSMTPIN_ADDED@mx.google.com>
References: <4e1c09b0.04af2a0a.2ccb.ffffab1eSMTPIN_ADDED@mx.google.com>
Date: Tue, 12 Jul 2011 07:38:48 -0700
Message-ID: <CAGH67wQ4knG70q-bpPV0fmTOsmf9ciyPN-k65M=ysMk1o5_uFg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jul 12, 2011 at 1:45 AM, Francesco RUNDO <francesco.rundo@st.com> wrote:
> From: Francesco Rundo <francesco.rundo@st.com>
>
> The "kill05" testcase checks if EPERM is correctly raised by the system.
> The testcase manages the error exit codes correctly while it didn't return
> any exit code in case of no errors occured i.e. the system has raised EPERM.
> The correct exit-code "TPASS" has been added in case of the test works fine without
> errors.
>
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>

    Please properly styleize this; this doesn't conform to Linux
coding standards..
Thanks,
-Garrett

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
