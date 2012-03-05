Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filippo.arcidiacono@st.com>) id 1S4UFe-0000Xs-5d
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 09:30:42 +0000
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S4UFa-0008Mz-43
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 09:30:42 +0000
From: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
References: <1329994678-10121-1-git-send-email-filippo.arcidiacono@st.com>
	<4f50dbc8.a868320a.04b0.03b4SMTPIN_ADDED@mx.google.com>
	<4F547158.7050501@casparzhang.com>
In-Reply-To: <4F547158.7050501@casparzhang.com>
Date: Mon, 5 Mar 2012 10:30:01 +0100
Message-ID: <034c01ccfab2$8b7b7b70$a2727250$@arcidiacono@st.com>
MIME-Version: 1.0
Content-Language: en-us
Subject: Re: [LTP] [PATCH v2] getrusage04: add opportunity to increase the
	max [us]time increment
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
> Sent: Monday, March 05, 2012 8:55 AM
> To: Filippo ARCIDIACONO
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH v2] getrusage04: add opportunity to increase
> the max [us]time increment
> 
> On 03/02/2012 10:39 PM, Filippo ARCIDIACONO wrote:
> >> -----Original Message-----
> >> From: Filippo ARCIDIACONO [mailto:filippo.arcidiacono@st.com]
> >> Sent: Thursday, February 23, 2012 11:58 AM
> >> To: ltp-list@lists.sourceforge.net
> >> Cc: Filippo Arcidiacono; Salvatore Cro
> >> Subject: [PATCH v2] getrusage04: add opportunity to increase the max
> >> [us]time increment
> >>
> >> On slow systems it could be needed to increase the max value
> [us]time
> >> increment beetween two getrusage calls.
> >>
> >> Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> >> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> >> ---
> 
> ...
> 
> > Is this version ok for you, or there are any other comments?
> 
> I meet some `DOS line endings` errors when I am trying to merge this
> patch. Could you double check your patch with checkpatch.pl from kernel
> source tree? (or my mail client is broken :-(...

I checked the patch with checkpatch.pl and no issue are raised.
I sent the patch by means of "git send-email".

> 
> Thanks,
> Caspar


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
