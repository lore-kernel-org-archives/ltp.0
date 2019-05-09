From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 May 2019 11:50:32 -0400 (EDT)
Subject: [LTP] [PATCH v2 2/2] libltpnuma: remove restrictions on numa
 node-id
In-Reply-To: <20190509064535.GA6096@dhcp-9-109-247-167.in.ibm.com>
References: <20190508084447.18191-1-liwang@redhat.com>
 <20190508084447.18191-2-liwang@redhat.com>
 <20190509064535.GA6096@dhcp-9-109-247-167.in.ibm.com>
Message-ID: <756800992.21902100.1557417032413.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, May 08, 2019 at 04:44:47PM +0800, Li Wang wrote:
> > For some ppc64le systems, it has non-continuous numa nodes in
> > hardware configuration. So we're hitting the below warnings while
> > running set_mempolicy tests on that. To fix this issue, let's just
> > remove restrictions on numa node-id in get_mempolicy().
> > 
> > Error Log
> > ---------
> > tst_test.c:1096: INFO: Timeout per run is 0h 50m 00s
> > tst_numa.c:190: INFO: Found 2 NUMA memory nodes
> > set_mempolicy01.c:63: PASS: set_mempolicy(MPOL_BIND) node 0
> > tst_numa.c:26: INFO: Node 0 allocated 16 pages
> > tst_numa.c:26: INFO: Node 8 allocated 0 pages
> > set_mempolicy01.c:82: PASS: child: Node 0 allocated 16
> > set_mempolicy01.c:63: PASS: set_mempolicy(MPOL_BIND) node 8
> > tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 8
> > tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 8
> > tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 8
> > ...
> > tst_numa.c:26: INFO: Node 0 allocated 0 pages
> > tst_numa.c:26: INFO: Node 8 allocated 0 pages
> > set_mempolicy01.c:86: FAIL: child: Node 8 allocated 0, expected 16
> > 
> > lscpu
> > -----
> > Architecture:        ppc64le
> > ...
> > CPU(s):              128
> > Core(s) per socket:  16
> > Socket(s):           2
> > NUMA node(s):        2
> > Model name:          POWER9, altivec supported
> > ...
> > NUMA node0 CPU(s):   0-63
> > NUMA node8 CPU(s):   64-127
> > 
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  libs/libltpnuma/tst_numa.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/libs/libltpnuma/tst_numa.c b/libs/libltpnuma/tst_numa.c
> > index 0ba6daf39..56c8640ff 100644
> > --- a/libs/libltpnuma/tst_numa.c
> > +++ b/libs/libltpnuma/tst_numa.c
> > @@ -88,8 +88,9 @@ void tst_nodemap_count_pages(struct tst_nodemap *nodes,
> >  		if (ret < 0)
> >  			tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
> >  
> > -		if (node < 0 || (unsigned int)node >= nodes->cnt) {
> > -			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
> > +		if (node < 0) {
> 
> It is better to have check for powerpc and remove restriction as it will
> still hold good for other arch.

Unless memory gets offlined or test harness restricts LTP to run only on
some nodes (via numactl). Here's example of former:

# uname -m
x86_64

# numactl -H
available: 8 nodes (0-7)
node 0 cpus: 0 4 8 12
node 0 size: 4061 MB
node 0 free: 3437 MB
node 1 cpus: 16 20 24 28
node 1 size: 0 MB
node 1 free: 0 MB
node 2 cpus: 1 5 9 13
node 2 size: 4096 MB
node 2 free: 3871 MB
node 3 cpus: 17 21 25 29
node 3 size: 0 MB
node 3 free: 0 MB
node 4 cpus: 2 6 10 14
node 4 size: 4096 MB
node 4 free: 3568 MB
node 5 cpus: 18 22 26 30
node 5 size: 0 MB
node 5 free: 0 MB
node 6 cpus: 19 23 27 31
node 6 size: 0 MB
node 6 free: 0 MB
node 7 cpus: 3 7 11 15
node 7 size: 4095 MB
node 7 free: 3802 MB

tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
tst_numa.c:190: INFO: Found 4 NUMA memory nodes
...
tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 4
tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 7

> 
> -- Bala
> 
> > +			tst_res(TWARN,
> > +				"get_mempolicy(...) returned invalid node %i\n", node);
> >  			continue;
> >  		}
> >  
> > --
> > 2.20.1
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
