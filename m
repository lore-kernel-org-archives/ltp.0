From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 Oct 2018 13:40:59 +0300
Subject: [LTP] [PATCH 1/4] net/dhcp: Use paths allowed by AppArmor for
	dnsmasq
In-Reply-To: <20181023215741.GA26131@dell5510>
References: <20181011220525.24628-1-pvorel@suse.cz>
 <20181011220525.24628-2-pvorel@suse.cz>
 <85563193-f74e-8287-8f59-debbf9ff6705@oracle.com>
 <20181023215741.GA26131@dell5510>
Message-ID: <911cf2d7-7716-33d4-0329-168ba3660431@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 24.10.2018 00:57, Petr Vorel wrote:
...
>> What if this directory doesn't exist? Why not to use the standard one for dnsmasq /var/lib/dnsmasq/?
> No, default path for linux is /var/lib/misc/dnsmasq.leases [1]:
> define LEASEFILE "/var/lib/misc/dnsmasq.leases"
> 
> AppArmor also expects it there [2]:
> /var/lib/misc/dnsmasq.leases rw, # Required only for DHCP server usage
> 
> but also accept different paths:
> /var/lib/misc/dnsmasq.*.leases rw,
> /var/lib/lxd-bridge/dnsmasq.*.leases rw,
> /var/lib/NetworkManager/dnsmasq-*.leases rw,
>

May be it is for the newest versions only, I was looking at 2.48/2.76 and it is
/var/lib/dnsmasq/dnsmasq.leases.
 
>> Forgot to remove this file in cleanup?
> Yes, I should be consistent. But is it really needed to cleanup files, when
> temporary directory is being deleted after test?  I was actually thinking to
> remove cleanup_dhcp at all from both test scripts.

But the file now outside of LTP temp directory, in /var/lib/misc/...
