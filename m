From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 17:26:07 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2016-8655
In-Reply-To: <20200505143135.GC27810@yuki.lan>
References: <20200505102456.13004-1-mdoucha@suse.cz>
 <20200505131724.GA21884@dell5510> <20200505143135.GC27810@yuki.lan>
Message-ID: <20200505152607.GC9949@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I wanted to propose after release dropping gcc 4 support by deleting CentOS 6
> > from Travis (but maybe we should drop it even now). To keep the support, it'd be
> > good to add lapi/if_packet.h with this definition.

> That mainly depends on if someone wants to still carry on supporting it.

> Does someone out there still need CentOS 6?
Should we send separate RFC about dropping support for this oldest distro in
Travis? If nobody interested and unless it requires too much effort I'd keep it
for this release.

Kind regards,
Petr
