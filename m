Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filippo.arcidiacono@st.com>) id 1S4VkM-0000iG-2u
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 11:06:30 +0000
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S4VkH-00032r-Rr
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 11:06:30 +0000
From: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
References: <1329994678-10121-1-git-send-email-filippo.arcidiacono@st.com>
	<4f50dbc8.a868320a.04b0.03b4SMTPIN_ADDED@mx.google.com>
	<4F547158.7050501@casparzhang.com>
	<034c01ccfab2$8b7b7b70$a2727250$@arcidiacono@st.com>
	<4F548854.9030403@cn.fujitsu.com>
	<4F549AC2.7040108@casparzhang.com>
In-Reply-To: <4F549AC2.7040108@casparzhang.com>
Date: Mon, 5 Mar 2012 12:05:44 +0100
Message-ID: <035001ccfabf$e98cad30$bca60790$@arcidiacono@st.com>
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
To: 'Caspar Zhang' <caspar@casparzhang.com>, gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net



> -----Original Message-----
> From: Caspar Zhang [mailto:caspar@casparzhang.com]
> Sent: Monday, March 05, 2012 11:52 AM
> To: gaowanlong@cn.fujitsu.com
> Cc: Filippo ARCIDIACONO; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH v2] getrusage04: add opportunity to increase
> the max [us]time increment
> 
> On 03/05/2012 05:33 PM, Wanlong Gao wrote:
> > On 03/05/2012 05:30 PM, Filippo ARCIDIACONO wrote:
> >
> >>
> >>
> >>> -----Original Message-----
> >>> From: Caspar Zhang [mailto:caspar@casparzhang.com]
> >>> Sent: Monday, March 05, 2012 8:55 AM
> >>> To: Filippo ARCIDIACONO
> >>> Cc: ltp-list@lists.sourceforge.net
> >>> Subject: Re: [LTP] [PATCH v2] getrusage04: add opportunity to
> increase
> >>> the max [us]time increment
> >>>
> >>> On 03/02/2012 10:39 PM, Filippo ARCIDIACONO wrote:
> >>>>> -----Original Message-----
> >>>>> From: Filippo ARCIDIACONO [mailto:filippo.arcidiacono@st.com]
> >>>>> Sent: Thursday, February 23, 2012 11:58 AM
> >>>>> To: ltp-list@lists.sourceforge.net
> >>>>> Cc: Filippo Arcidiacono; Salvatore Cro
> >>>>> Subject: [PATCH v2] getrusage04: add opportunity to increase the
> max
> >>>>> [us]time increment
> >>>>>
> >>>>> On slow systems it could be needed to increase the max value
> >>> [us]time
> >>>>> increment beetween two getrusage calls.
> >>>>>
> >>>>> Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> >>>>> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> >>>>> ---
> >>>
> >>> ...
> >>>
> >>>> Is this version ok for you, or there are any other comments?
> >>>
> >>> I meet some `DOS line endings` errors when I am trying to merge
> this
> >>> patch. Could you double check your patch with checkpatch.pl from
> kernel
> >>> source tree? (or my mail client is broken :-(...
> >>
> >> I checked the patch with checkpatch.pl and no issue are raised.
> >> I sent the patch by means of "git send-email".
> >
> >
> > Yes, it's all right.
> > see here:
> https://github.com/gaowanlong/ltp/commit/9d12e835fdcd3624619be8b47e0f10
> 9343fc35e4
> >
> 
> Yup, my thunderbird should be blamed :-(
> 
> BTW, according to the style guide, it's recommended to send patches in
> attachment format, you can generate such patches by adding --attach
> option with `git format-patch` command.

Thanks for the  suggestion.
I'll take into account next time.

> 
> Thanks,
> Caspar

Thanks,
Filippo


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
