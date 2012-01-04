Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiRWs-0001Qm-Va
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 14:09:22 +0000
Date: Wed, 4 Jan 2012 15:20:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104142010.GA15845@saboteur.suse.cz>
References: <4F02CBDE.70400@imgtec.com>
	<CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
	<4F02D122.7090704@imgtec.com> <4F02DB32.1050503@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F02DB32.1050503@imgtec.com>
Subject: Re: [LTP] [PATCH 02/21] lib/self_exec: Remove extra argument from
 tst_resm function call
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> On 01/03/2012 09:57 AM, Markos Chandras wrote:
> >On 01/03/2012 09:50 AM, Garrett Cooper wrote:
> >>On Tue, Jan 3, 2012 at 1:35 AM, Markos Chandras
> >><Markos.Chandras@imgtec.com>   wrote:
> >>>Hi, please review the attached patch
> >>
> >>      Converting the function to tst_brkm and removing the tst_exit call
> >>below it would be better.
> >>Thanks!
> >>-Garrett
> >Agreed, but to make this consistent, all the tst_resm&&  tst_exit pairs
> >should be replaced with tst_brkm. I will prepare a patch
> >
> Here is a patch that converts all tst_resm && tst_exit calls to
> tst_brkm. Please review it.

Commited, thanks.

And please add better patch description next time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
