Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RimN0-0003rS-OG
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 12:24:34 +0000
Date: Thu, 5 Jan 2012 13:35:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105123531.GA17273@saboteur.suse.cz>
References: <1322578449-16716-1-git-send-email-salvatore.cro@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1322578449-16716-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH] creat08: fall back to nogroup if nobody
 unavailable.
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
To: Salvatore CRO' <salvatore.cro@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Partially revert commit 87bc45c477f1dc9114ec3bceab05693de8b07180
> which assumes nobody is always available when doing getgrnam.
> Patch give chance to fall back to using nogroup instead.

Commited, thanks.

(Note that I've adjusted the commit message a little)

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
