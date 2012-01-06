Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rj9ag-0005FL-Lu
	for ltp-list@lists.sourceforge.net; Fri, 06 Jan 2012 13:12:14 +0000
Date: Fri, 6 Jan 2012 14:23:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120106132316.GA23266@saboteur.suse.cz>
References: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
	<20111102172631.GA14582@saboteur.suse.cz>
	<CAGH67wQu7Yx8=GMHxXWXsz=i9736jva89QNeobWku=0YJQwTQQ@mail.gmail.com>
	<20111102180024.GB12153@saboteur.suse.cz> <4EB69D63.8080603@st.com>
	<20111109091554.GA31394@saboteur.suse.cz> <4EBBE5C5.6000903@st.com>
	<20111110154125.GB14190@saboteur.suse.cz> <4EBC0026.4030401@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EBC0026.4030401@st.com>
Subject: Re: [LTP] [PATCH] runltp: fix printing of LTP Version
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
I finally had a time to look at this again. The solution is not the
cleanest but at least it works now. (See the git)

Now the Version file is generated either from 'git describe' if there is
git repository found. And when there isn't, which is the case of a
release tarball, VERSION file is used instead.

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
