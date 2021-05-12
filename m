From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 16:04:06 +0200
Subject: [LTP] [PATCH 1/1] netns_helper.sh: Fix parsing recent iproute2
 versions
In-Reply-To: <YJvW+spXh4za9v5p@pevik>
References: <20210512103052.9646-1-pvorel@suse.cz> <YJu/L3HssZY14vQa@yuki>
 <YJvW+spXh4za9v5p@pevik>
Message-ID: <YJvgVi5g+NePDeqE@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that the most safe variant at the moment would be pushing this
> > patch, then dropping the check completely after the release.
> I'm ok if we don't want to bother with this (and with patch for
> netns_netlink.c [1]). But if you're ok to fix it for the release,
> I'd send new patch which fixes it similar way as the fix for netns_netlink.c:
> here just run "ip netns" to detect required support instead of checking version
> info.

I do not have a strong opinion here. If you want to spend time fix these
tests for this release I'm fine with that as long as the fix is minimal
and works fine.

-- 
Cyril Hrubis
chrubis@suse.cz
