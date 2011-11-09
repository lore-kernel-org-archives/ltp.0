Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RO4AN-0005p4-EC
	for ltp-list@lists.sourceforge.net; Wed, 09 Nov 2011 09:09:55 +0000
Date: Wed, 9 Nov 2011 10:15:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111109091554.GA31394@saboteur.suse.cz>
References: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
	<20111102172631.GA14582@saboteur.suse.cz>
	<CAGH67wQu7Yx8=GMHxXWXsz=i9736jva89QNeobWku=0YJQwTQQ@mail.gmail.com>
	<20111102180024.GB12153@saboteur.suse.cz> <4EB69D63.8080603@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EB69D63.8080603@st.com>
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
> >>> Right, but there is one more thing to fix.
> >>>
> >>> The Version is generated from Changelog, which is abandoned for some
> >>> time. But we introduced a VERSION file that carries latest version. So
> >>> the best woul be to drop Changelog completly and use the VERSION file
> >>> instead, anybody objects to that?
> >>
> >> I'd just generate the version like so:
> >>
> >> VERSION ?= $(shell echo ltp-nightly-`env LANG=C date +%Y%m%d`)
> >>
> >> in the Makefile, or something like that... I just did it based on the
> >> ChangeLog as it was the defacto source of truth in the LTP 'release
> >> process' (which fizzled after Subrata couldn't lead that effort
> >> anymore).
> > 
> > Now we have the VERSION file, that should defacto carry on that
> > information for the future. So there is no problem with that, changing
> > 'head ChangeLog' to 'cat VERSION' should be enough. Maybe it would be
> > nice to use 'git describe' for builds from git repository too.
> > 
> I'd propose to remove VERSION from the git and let the buildsys to
> create it at install time.
> 
> Some like that:
> 
> .PHONY: VERSION
> VERSION:
> 	git describe --abbrev=0 > $@
> 
> At the end it will replace the old file 'Version'.
> 

Hmm, that wouldn't work for released tarbals that are shipped without
the .git/ directory. We need to look if there is a git repository first
and then decide to use VERSION or git describe. I'll fix these soon.

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
