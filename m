From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Oct 2018 17:53:32 +0200
Subject: [LTP] [PATCH 1/4] net/dhcp: Use paths allowed by AppArmor for
	dnsmasq
In-Reply-To: <911cf2d7-7716-33d4-0329-168ba3660431@oracle.com>
References: <20181011220525.24628-1-pvorel@suse.cz>
 <20181011220525.24628-2-pvorel@suse.cz>
 <85563193-f74e-8287-8f59-debbf9ff6705@oracle.com>
 <20181023215741.GA26131@dell5510>
 <911cf2d7-7716-33d4-0329-168ba3660431@oracle.com>
Message-ID: <20181024155332.GA10380@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,
> On 24.10.2018 00:57, Petr Vorel wrote:
> ...
> >> What if this directory doesn't exist? Why not to use the standard one for dnsmasq /var/lib/dnsmasq/?
> > No, default path for linux is /var/lib/misc/dnsmasq.leases [1]:
> > define LEASEFILE "/var/lib/misc/dnsmasq.leases"

> > AppArmor also expects it there [2]:
> > /var/lib/misc/dnsmasq.leases rw, # Required only for DHCP server usage

> > but also accept different paths:
> > /var/lib/misc/dnsmasq.*.leases rw,
> > /var/lib/lxd-bridge/dnsmasq.*.leases rw,
> > /var/lib/NetworkManager/dnsmasq-*.leases rw,

> May be it is for the newest versions only, I was looking at 2.48/2.76 and it is
> /var/lib/dnsmasq/dnsmasq.leases.
It's not upstream, src/config.h haven't changed for linux since 2.0.
/var/lib/dnsmasq/ is Fedora/RHEL/CentOS/Oracle Linux (RHEL*) specific [1], changed since
2.41 (in 2007) [2] [3]. I checked various other distros and others (SUSE, Debian,
Archlinux, Gentoo, Ubuntu) use default location in /var/lib/misc/.

/var/lib/misc/ also exists on RHEL* (filesystem package, which is on every RHEL*
system), so maybe we could be happy about that.

But RHEL* doesn't use AppArmor and SELinux supports wildcard on /var/lib/dnsmasq/
but in /var/lib/misc/ support just dnsmasq.leases [4]:
	/var/lib/misc/dnsmasq\.leases	--	gen_context(system_u:object_r:dnsmasq_lease_t,s0)
	/var/lib/dnsmasq(/.*)?	gen_context(system_u:object_r:dnsmasq_lease_t,s0)

so for RHEL* it'd be really better to use /var/lib/misc/.

Therefore could use /var/lib/misc/ as default and if directory not exist use
/var/lib/dnsmasq/ (as it's probably RHEL*). Writing into either of them
requires root, so we need to add TST_NEEDS_ROOT=1.
But still paths aren't compatible, either SELinux or AppArmor need to be more
relax (add star for both log and lease file).

Similar situation is for logging file:
SELinux [4]
	/var/log/dnsmasq.*	--	gen_context(system_u:object_r:dnsmasq_var_log_t,s0)
AppArmor [5]:
	/var/log/*dnsmasq.log w,

I'll report it to both projects. In meanwhile we could workaround with adjusting
dnsmasq's policy/profile (AppArmor: create /etc/apparmor.d/local/usr.sbin.dnsmasq,
SELinux: create /etc/selinux/targeted/contexts/files/file_contexts.local).
Or just to temporarily disable AppArmor or SELinux).

Not sure what is a better approach. Unfortunately these tests look to me more
like userspace related and catching AppArmor or SELinux policy/profile bugs than
kernel networking problems.

> >> Forgot to remove this file in cleanup?
> > Yes, I should be consistent. But is it really needed to cleanup files, when
> > temporary directory is being deleted after test?  I was actually thinking to
> > remove cleanup_dhcp at all from both test scripts.

> But the file now outside of LTP temp directory, in /var/lib/misc/...
OK, that needs to be removed.


Kind regards,
Petr

[1] https://src.fedoraproject.org/cgit/rpms/dnsmasq.git/tree/dnsmasq.spec#n67
[2] https://src.fedoraproject.org/cgit/rpms/dnsmasq.git/commit/?id=91d4b30e7b55bbb561547312e83ce4d709e505e2
[3] https://bugzilla.redhat.com/show_bug.cgi?id=407901
[4] https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/services/dnsmasq.fc
[5] https://gitlab.com/apparmor/apparmor/blob/master/profiles/apparmor.d/usr.sbin.dnsmasq
