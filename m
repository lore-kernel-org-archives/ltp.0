Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiShw-0004Ev-2t
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 15:24:52 +0000
Date: Wed, 4 Jan 2012 16:35:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104153539.GB17717@saboteur.suse.cz>
References: <4F02CBDE.70400@imgtec.com>
	<CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
	<4F02D122.7090704@imgtec.com> <4F02DB32.1050503@imgtec.com>
	<20120104142010.GA15845@saboteur.suse.cz>
	<4F045E94.3060004@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F045E94.3060004@imgtec.com>
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
> Thanks. I will next time. However, I think there is a problem with
> the patch now that I had some time to look at in again. The last
> chunk is wrong. This statement
> 
> +	    tst_brkm(TBROK, "Could not change to %s for child", child_dir);
> 
> should be
> 
> +	    tst_brkm(TBROK, NULL, "Could not change to %s for child", child_dir);
> 
> Could you please commit this fix as well?

Will do, but please send a patch next time.

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
