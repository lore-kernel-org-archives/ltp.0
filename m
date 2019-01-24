From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Jan 2019 17:17:33 +0100
Subject: [LTP] [RFC PATCH 0/2] Rewrite route stress tests into C
Message-ID: <20190124161735.19609-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

this is prove of concept of route stress tests rewrite into C.  I'm
myself not convinced it's a good way. The main motivation for rewriting
tests from shell to C is speed and thus more efficient stress testing.

Some issues:
* The test is only on lhost, no attempt to set iface on rhost and check
connection. The only check is done via error of libnl used. It's
questionable whether this way is good enough.
If we want to have established connection, it'd be better to get back to
shell testing [1], just replace netstress to new tool (I'd prefer not
use ns-udpsender).

* rtnetlink is used via libnl, which is very lazy approach.
As subject of testing is route testing and not rtnetlink testing I
didn't reimplement rtnetlink socket communication from scratch, but I
guess I should. Also using link caching (used by functions from libnl-cli)
might not be a good idea (maybe using libmnl or only libnl-route would
be better if using library).

* C code needs environment variables, that's the only reason for having
shell. It'd be possible to load variables in runtest file:
route4-change-dst-test TST_NO_DEFAULT_RUN=1 . tst_net.sh; route-change-dst -d ltp_ns_veth2 -c 5
route6-change-dst-test TST_NO_DEFAULT_RUN=1 . tst_net.sh; route-change-dst -6 -d $(tst_iface) -c 5

but I don't want to introduce more commands in runtest files (it looks
non-standard to me, one day we'll have new shell runner, which might not
be compatible with it).

If we agreed on it, I'd add functionality for changing gateway and
interface (i.e. route{4,6}-change-{gw,if} + rename C source to
route-change.c).

Comments are more than welcome.

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2018-July/008778.html

Petr Vorel (2):
  tst_net: Add missing includes, make functions inline
  net/route: Rewrite route{4,6}-change-dst into C

 configure.ac                                  |   1 +
 include/mk/config.mk.default                  |   3 +
 include/mk/config.mk.in                       |   2 +
 include/tst_net.h                             |  16 ++-
 m4/ltp-libnl.m4                               |   7 +
 runtest/net_stress.route                      |   4 +-
 testcases/network/stress/route/.gitignore     |   1 +
 testcases/network/stress/route/Makefile       |   7 +-
 .../network/stress/route/route-change-dst.c   | 129 ++++++++++++++++++
 .../network/stress/route/route-change-dst.sh  |  16 +++
 travis/debian.cross-compile.aarch64.sh        |   6 +-
 travis/debian.cross-compile.ppc64le.sh        |   9 +-
 travis/debian.i386.sh                         |   3 +-
 travis/debian.sh                              |   5 +-
 travis/fedora.sh                              |   1 +
 travis/tumbleweed.sh                          |   3 +
 16 files changed, 198 insertions(+), 15 deletions(-)
 create mode 100644 m4/ltp-libnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100644 testcases/network/stress/route/route-change-dst.c
 create mode 100755 testcases/network/stress/route/route-change-dst.sh

-- 
2.19.2

