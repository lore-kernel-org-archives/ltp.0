From: Bird, Tim <Tim.Bird@sony.com>
Date: Tue, 15 Sep 2020 20:51:45 +0000
Subject: [LTP] ltp-selftest-quick runtest file (was RE:  LTP release)
Message-ID: <CY4PR13MB11752979CBBBBCAD98EC86E0FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> Sent: Monday, September 14, 2020 11:28 PM
> To: Bird, Tim <Tim.Bird@sony.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>; ltp@lists.linux.it
> Subject: Re: [LTP] LTP release
> 
> Hi Tim, Cyril,
> 
> > I'm also open to suggestions for possible tests.  I'd like a shell script command
> > to add to the list of binary programs.  Here is what I've chosen so far:
> > access01 access01
> > chdir01 chdir01
> > fork01 fork01
> > time01 time01
> > wait02 wait02
> > write01 write01
> > symlink01 symlink01
> > stat04 symlink01 -T stat04
> > utime01A symlink01 -T utime01
> > rename01A symlink01 -T rename01
> > splice02 seq 1 20 | splice02
> Could we please add at least one network test program?
That sounds good.

> e.g. route tests with netlink also uses shell API and it's really quick (real
> time 0m0,687s):
> route6-change-netlink-dst route-change-netlink-dst.sh -6
This particular one gives me:
...
 route-change-netlink-dst 1 TINFO: running route-change-netlink -c 10000 -6 -p 65535 -d ltp_ns_veth2 -r 'fd00:23:4::1,fd00:23:3::1,fd00:23:2::1,fd00:23:1::1,fd00:23::1,'
tst_test.c:871: CONF: libmnl library and headers are required
route-change-netlink-dst 1 TCONF: not supported configuration

Is there a networking one with less requirements, that is basically guaranteed to work?
 -- Tim
