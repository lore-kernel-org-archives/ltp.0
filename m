From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Oct 2018 23:57:41 +0200
Subject: [LTP] [PATCH 1/4] net/dhcp: Use paths allowed by AppArmor for
	dnsmasq
In-Reply-To: <85563193-f74e-8287-8f59-debbf9ff6705@oracle.com>
References: <20181011220525.24628-1-pvorel@suse.cz>
 <20181011220525.24628-2-pvorel@suse.cz>
 <85563193-f74e-8287-8f59-debbf9ff6705@oracle.com>
Message-ID: <20181023215741.GA26131@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for you review!

> On 12.10.2018 01:05, Petr Vorel wrote:
> > Fixes for --log-facility and --dhcp-leasefile.

> > Path for log file expects AppArmor commit
> > 025c7dc6 ("dnsmasq: Add permission to open log files").

> > NOTE: AppArmor optimization isn't needed for dhcpd.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Changing path to /var/log require root, but we run most of network tests
> > under root anyway, at least for network  namespaces.
> > I didn't add TST_NEEDS_ROOT=1, maybe I should.

...
> >  common_opt="--no-hosts --no-resolv --dhcp-authoritative \
> > -	--log-facility=./tst_dnsmasq.log --interface=$iface0 \
> > -	--dhcp-leasefile=tst_dnsmasq.lease --port=0 --conf-file= "
> > +	--log-facility=$log --interface=$iface0 \

> It could be stderr with writing the output of dnsmasq to the test directory:

>   --log-facility=-
Yes, I noticed the possibility to use stderr as well. But it's since 2.53, which
breaks old distros (centos6/rhel6) and would require check for version.
Is it worth of it?
And isn't there anything else requiring root anyway on SSH/RSH based testing?
(default netns testing requires root).

> > +	--dhcp-leasefile=/var/lib/misc/dnsmasq.tst.leases --port=0 --conf-file= "

> What if this directory doesn't exist? Why not to use the standard one for dnsmasq /var/lib/dnsmasq/?
No, default path for linux is /var/lib/misc/dnsmasq.leases [1]:
define LEASEFILE "/var/lib/misc/dnsmasq.leases"

AppArmor also expects it there [2]:
/var/lib/misc/dnsmasq.leases rw, # Required only for DHCP server usage

but also accept different paths:
/var/lib/misc/dnsmasq.*.leases rw,
/var/lib/lxd-bridge/dnsmasq.*.leases rw,
/var/lib/NetworkManager/dnsmasq-*.leases rw,

> Forgot to remove this file in cleanup?
Yes, I should be consistent. But is it really needed to cleanup files, when
temporary directory is being deleted after test?  I was actually thinking to
remove cleanup_dhcp at all from both test scripts.

> BTW, it's better to have "ltp" instead of "tst" in this path.
Yes, but I wanted to be consistent with dhcpd_tests.sh - there is:
tst_dhcpd.conf, tst_hdcpd.lease

BTW: Others possible improvements of DHCP tests (not planning them before
finishing this):
* I was also thinking about passing file location of config file instead of
  changing content of global files in setup_dhcpd_conf().
* Handle situation when dhclient is already running in daemon mode (rare
  situation nowadays, probably started manually).
* Handle situation, when DHCP server is already running (and blocking port)


Kind regards,
Petr

[1] http://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=blob;f=src/config.h;h=762c49b586bb26fb05d0eceac87d28f939693a6f;hb=HEAD#l193
[2] https://gitlab.com/apparmor/apparmor/blob/master/profiles/apparmor.d/usr.sbin.dnsmasq#L58
