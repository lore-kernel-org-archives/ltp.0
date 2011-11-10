Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ROWey-0004dr-Ex
	for ltp-list@lists.sourceforge.net; Thu, 10 Nov 2011 15:35:24 +0000
Date: Thu, 10 Nov 2011 16:41:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111110154125.GB14190@saboteur.suse.cz>
References: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
	<20111102172631.GA14582@saboteur.suse.cz>
	<CAGH67wQu7Yx8=GMHxXWXsz=i9736jva89QNeobWku=0YJQwTQQ@mail.gmail.com>
	<20111102180024.GB12153@saboteur.suse.cz> <4EB69D63.8080603@st.com>
	<20111109091554.GA31394@saboteur.suse.cz> <4EBBE5C5.6000903@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EBBE5C5.6000903@st.com>
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

> >Hmm, that wouldn't work for released tarbals that are shipped without
> >the .git/ directory. We need to look if there is a git repository first
> >and then decide to use VERSION or git describe. I'll fix these soon.
> >
> 
> I was proposing to create the VERSION from the git in the install
> step, and then package it with the released tarball (out of git).

Hmm, that creates a chicken and egg problem. The commit that changes
VERSION file content is then tagged with the new version tag. Or did I
misunderstand you?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
