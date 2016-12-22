From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Dec 2016 14:01:48 +0100
Subject: [LTP] [PATCH 1/3] test_net.sh: fix netns when defined
 LHOST_IFACES or RHOST_IFACES
In-Reply-To: <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
Message-ID: <20161222130148.gn2j3vblabp4n446@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 12/22/2016 02:04 AM, Petr Vorel wrote:
> > Tested with:
> > TST_USE_NETNS=1 LHOST_IFACES=localpeer RHOST_IFACES=remotepeer \
> >    ./testscripts/network.sh -6

> Any good reason to do that?
Yes. Currently if you define LHOST_IFACES and/or RHOST_IFACES netns is defined for
ltp_ns_veth2 and ltp_ns_veth1, but then there are used new variables => it's not working.
Or have I overlooked something?

Kind regards,
Petr
