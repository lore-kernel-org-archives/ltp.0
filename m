From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Apr 2021 13:19:14 +0200
Subject: [LTP] [PATCH 0/4] RTNetlink and network device management library
Message-ID: <20210426111918.4304-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset is still a work in progress and I've sent it mainly to open
discussion about network management API design. SAFE_REALLOC() and SAFE_RECV()
patches are trivial and can be merge right away, though.

The network management API has two separate parts:
- rtnetlink library (patch 3)
- device management library (patch 4)

The rtnetlink API is stateful. First you need to create a netlink context
(netlink socket with dynamic message buffer), then you can add arbitrary list
of messages and attributes and send them all at once. If you don't need to
process any complex response, you can use the shorthand send function which
automatically receives and validates ACKs for each sent message. You can reuse
the same context for multiple send calls.

Device management API is stateless, only one function call per operation.

Example how to use rtnetlink API (add new IPv4 address to eth0):
================================================================

struct nlmsghdr header = {
	.nlmsg_type = RTM_NEWADDR,
	.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL | NLM_F_ACK
};
struct ifaddrmsg info = {
	.ifa_family = AF_INET,
	.ifa_prefix = 24,
	.ifa_index = eth0_index
};
in_addr_t addr = inet_addr("192.168.0.1");
ctx = RTNL_CREATE_CONTEXT();
RTNL_ADD_MESSAGE(ctx, &header, &info, sizeof(info));
RTNL_ADD_ATTR(ctx, IFA_LOCAL, &addr, sizeof(addr));
if (!RTNL_SEND_VERIFY(ctx))
	// error handling
RTNL_FREE_CONTEXT(ctx);


Example how to create and configure veth pair using device management API:
==========================================================================

CREATE_VETH_PAIR("veth0", "veth1");
NETDEVICE_ADD_ADDRESS_INET("veth0", inet_addr("192.168.0.1"));
NETDEVICE_ADD_ADDRESS_INET("veth1", inet_addr("192.168.0.2"));
NETDEVICE_ACTIVATE("veth0", 1);
NETDEVICE_ACTIVATE("veth1", 1);
NETDEVICE_ADD_ROUTE_INET("veth0", 0, 0, inet_addr("192.168.1.0"), 24, 0);


Martin Doucha (4):
  Add SAFE_REALLOC() helper function to LTP library
  Add SAFE_RECV() helper function to LTP library
  RFC: Add rtnetlink helper library
  RFC: Add helper functions for managing network interfaces

 include/safe_net_fn.h     |   3 +
 include/tst_netdevice.h   | 120 +++++++++
 include/tst_rtnetlink.h   | 105 ++++++++
 include/tst_safe_macros.h |   5 +
 include/tst_safe_net.h    |   3 +
 lib/safe_net.c            |  25 ++
 lib/tst_netdevice.c       | 506 ++++++++++++++++++++++++++++++++++++++
 lib/tst_rtnetlink.c       | 399 ++++++++++++++++++++++++++++++
 lib/tst_safe_macros.c     |  15 ++
 9 files changed, 1181 insertions(+)
 create mode 100644 include/tst_netdevice.h
 create mode 100644 include/tst_rtnetlink.h
 create mode 100644 lib/tst_netdevice.c
 create mode 100644 lib/tst_rtnetlink.c

-- 
2.31.1

