From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Dec 2018 18:00:19 +0100
Subject: [LTP] [PATCH v2 2/6] net/dhcp: Use paths allowed by AppArmor
 for dnsmasq
In-Reply-To: <20181207123516.30867-3-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
 <20181207123516.30867-3-pvorel@suse.cz>
Message-ID: <20181211170019.GA23604@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Fixes for --log-facility and --dhcp-leasefile.
...

> +++ b/testcases/network/dhcp/dnsmasq_tests.sh
> @@ -8,10 +8,25 @@
>  dhcp_name="dnsmasq"

>  . dhcp_lib.sh
> +TST_SETUP="setup"
> +
> +log="/var/log/tst_dnsmasq.log"
This is going to be
log="/var/log/dnsmasq.tst.log"
As I updated it in upstream co match SELinux path [1].

Lease file isn't handled by SELinux (for AppArmor we use path, which is reserved
for lxc-net). maybe it'd make sense use /var/lib/dnsmasq/ directory, when
SELinux enabled (checked with tst_selinux_enabled() from 5th commit).

Kind regards,
Petr

[1] https://gitlab.com/apparmor/apparmor/commit/3ef8df6ac05057e46720b2eba099bad3416f763b
