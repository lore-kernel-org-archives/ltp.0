From: Bird, Tim <Tim.Bird@sony.com>
Date: Wed, 16 Sep 2020 22:25:40 +0000
Subject: [LTP] ltp-selftest-quick runtest file (was RE:  LTP release)
In-Reply-To: <20200916070440.GA1433@dell5510>
References: <CY4PR13MB11752979CBBBBCAD98EC86E0FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916070440.GA1433@dell5510>
Message-ID: <CY4PR13MB11750B438B7F73126B88240BFD210@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> 
> Hi Tim,
> 
> ...
> > > e.g. route tests with netlink also uses shell API and it's really quick (real
> > > time 0m0,687s):
> > > route6-change-netlink-dst route-change-netlink-dst.sh -6
> > This particular one gives me:
> > ...
> >  route-change-netlink-dst 1 TINFO: running route-change-netlink -c 10000 -6 -p 65535 -d ltp_ns_veth2 -r
> 'fd00:23:4::1,fd00:23:3::1,fd00:23:2::1,fd00:23:1::1,fd00:23::1,'
> > tst_test.c:871: CONF: libmnl library and headers are required
> > route-change-netlink-dst 1 TCONF: not supported configuration
> 
> > Is there a networking one with less requirements, that is basically guaranteed to work?
> Good catch. Although TCONF is also a test for shell API :), let's use plan shell
> implementation:
> route6-change-dst route-change-dst.sh -6

This one worked on some of my boards and not others, due to ipv6 not being
configured on some of them.

How about this instead:
route4-change-dst route-change-dist.sh

 -- Tim

