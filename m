From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 23 Dec 2016 11:54:47 +0100
Subject: [LTP] [PATCH 1/3] test_net.sh: fix netns when defined
 LHOST_IFACES or RHOST_IFACES
In-Reply-To: <e06a35be-a03a-a984-759c-740e1d30c8a5@oracle.com>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <f18cb5f0-e5d9-68e8-45c7-262c987aca28@oracle.com>
 <20161222130148.gn2j3vblabp4n446@dell5510>
 <a388a121-3402-e274-7b34-05257c56a98d@oracle.com>
 <20161222151725.vd76lhusgxm4iero@dell5510>
 <e06a35be-a03a-a984-759c-740e1d30c8a5@oracle.com>
Message-ID: <20161223105447.5frfxa4c6uh5rvow@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Basically, if we set '*_IFACES' variables before the test, we have to make
> sure they contains the names of already existed interfaces. if someone moved
> from rsh config and left eth0 interface names... LTP must setup veth pair
> with this name? More likely the names will be the same and veth pair won't
> be created.
I'm sorry, you're right, I realized that afterwards. Forget about this patch.

> With current configuration, we could create ltp_ns namespace and setup our
> own interface(s) before the test (e.g. veth/br0 -> bond -> vxlan -> vlan ...
> etc), then run the tests with new names set (skipping default setup).
Sounds good, please do it.


Kind regards,
Petr
