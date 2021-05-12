From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 15:24:10 +0200
Subject: [LTP] [PATCH 1/1] netns_helper.sh: Fix parsing recent iproute2
 versions
In-Reply-To: <YJu/L3HssZY14vQa@yuki>
References: <20210512103052.9646-1-pvorel@suse.cz>
 <YJu/L3HssZY14vQa@yuki>
Message-ID: <YJvW+spXh4za9v5p@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> > index a5b77a0aa..4dac0e306 100755
> > --- a/testcases/kernel/containers/netns/netns_helper.sh
> > +++ b/testcases/kernel/containers/netns/netns_helper.sh
> > @@ -47,16 +47,21 @@ IFCONF_IN6_ARG=

> >  tst_check_iproute()
> >  {
> > -	local cur_ipver="$(ip -V)"
> > -	local spe_ipver="$1"
> > +	local current_ver="$(ip -V)"
> > +	local expected_ver="111010"

> So if I'm reading this right, this is 2010 again. I wonder if we can
> just remove this check as well.
Thanks for your input. FYI it's about iproute2 v3.0.0 (2011).

> I guess that the most safe variant at the moment would be pushing this
> patch, then dropping the check completely after the release.
I'm ok if we don't want to bother with this (and with patch for
netns_netlink.c [1]). But if you're ok to fix it for the release,
I'd send new patch which fixes it similar way as the fix for netns_netlink.c:
here just run "ip netns" to detect required support instead of checking version
info.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210512100746.5907-1-pvorel@suse.cz/
