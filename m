From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Nov 2018 21:02:07 +0100
Subject: [LTP] [PATCH 4/6] network/mpls02: new test with lwtunnel
In-Reply-To: <1540818202-11247-5-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
 <1540818202-11247-5-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20181102200207.GA17405@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Setup MPLS encapsulation over the default test network setup,
> use ICMP, UDP and TCP inner protocols.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Just some minor things bellow.

> +TST_MIN_KVER="4.3"
> +TST_NEEDS_TMPDIR=1
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_DRIVERS="mpls_router mpls_iptunnel"
Here is missing mpls_gso

...
> +mpls_setup()
> +{
> +	local label="$1"
> +
> +	ROD modprobe mpls_router
> +	ROD modprobe mpls_iptunnel
> +	ROD modprobe mpls_gso
Maybe just?
ROD modprobe mpls_gso $TST_NEEDS_DRIVERS

> +	ROD sysctl -q net.mpls.conf.$(tst_iface).input=1
> +	ROD sysctl -q net.mpls.conf.lo.input=1
This one can be set with tst_set_sysctl, as it's the same for both lhost and
rhost.
> +	ROD sysctl -q net.mpls.platform_labels=$label
The same is for this one ...
> +	rpf_loc="$(sysctl -n net.ipv4.conf.all.rp_filter)"
> +	ROD sysctl -q net.ipv4.conf.all.rp_filter=2
... and this one.

> +	tst_rhost_run -s -c "modprobe mpls_router"
> +	tst_rhost_run -s -c "modprobe mpls_iptunnel"
> +	tst_rhost_run -s -c "modprobe mpls_gso"
tst_rhost_run -s -c "modprobe $TST_NEEDS_DRIVERS"

> +	tst_rhost_run -s -c "sysctl -q net.mpls.conf.$(tst_iface rhost).input=1"
> +	tst_rhost_run -s -c "sysctl -q net.mpls.conf.lo.input=1"
> +	tst_rhost_run -s -c "sysctl -q net.mpls.platform_labels=$label"
> +	rpf_rmt="$(tst_rhost_run -c 'sysctl -n net.ipv4.conf.all.rp_filter')"
> +	tst_rhost_run -s -c "sysctl -q net.ipv4.conf.all.rp_filter=2"
> +}


Kind regards,
Petr
