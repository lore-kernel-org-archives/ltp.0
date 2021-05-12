From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 15:26:12 +0200
Subject: [LTP] [PATCH 1/1] netns_netlink: Check ip tuntap support
In-Reply-To: <YJumsgxSkiiCnw4R@yuki>
References: <20210512100746.5907-1-pvorel@suse.cz>
 <YJumsgxSkiiCnw4R@yuki>
Message-ID: <YJvXdLQFN8oADt6A@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > 11b1fea9d removed ip version check. Although check shouldn't be needed
> > because version 100519 (v2.6.34) is old enough, add check.

> > Instead of parsing ip version just try run 'ip tuntap'.

> What is the exact problem here? Missing tuntap support in ip before
> v2.6.34?
Yes.

> The v2.6.34 was released in 2010 and v2.6.32 in 2009, so unless someone
> reports breakage during pre-release testing I wouldn't bother.

Sure, let's keep it as a backup if anybody complains. I suppose nobody bothers.

Kind regards,
Petr
