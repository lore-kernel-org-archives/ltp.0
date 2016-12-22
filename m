From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Dec 2016 16:17:25 +0100
Subject: [LTP] [PATCH 1/3] test_net.sh: fix netns when defined
 LHOST_IFACES or RHOST_IFACES
In-Reply-To: <a388a121-3402-e274-7b34-05257c56a98d@oracle.com>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
 <20161222130148.gn2j3vblabp4n446@dell5510>
 <a388a121-3402-e274-7b34-05257c56a98d@oracle.com>
Message-ID: <20161222151725.vd76lhusgxm4iero@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > > Any good reason to do that?
> > Yes. Currently if you define LHOST_IFACES and/or RHOST_IFACES netns is defined for
> > ltp_ns_veth2 and ltp_ns_veth1, but then there are used new variables => it's not working.
> > Or have I overlooked something?

> I understand, but why do you need to re-define these interface names?
I don't need that, but if anyone does, it will have to find what's broken. This can happen
if you migrate from existing config (ssh/rsh) into netns.
IMHO the logic should be clever enough not to break things just due bad config (or let the
user to know about it).

Kind regards,
Petr
