From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Jun 2021 16:11:08 +0200
Subject: [LTP] [LTP PATCH v2 1/3] nfs_lib.sh: Detect unsupported protocol
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
Message-ID: <YLY//HUlsrK2eBb2@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

could you please have look on v2 before I merge it?

Kind regards,
Petr

> Caused by disabled CONFIG_NFSD_V[34] in kernel config.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> new in v2

>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 3fad8778a..b80ee0e18 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -94,9 +94,15 @@ nfs_mount()

>  	if [ $? -ne 0 ]; then
>  		cat mount.log
> +
>  		if [ "$type" = "udp" -o "$type" = "udp6" ] && tst_kvcmp -ge 5.6; then
>  			tst_brk TCONF "UDP support disabled with the kernel config NFS_DISABLE_UDP_SUPPORT?"
>  		fi
> +
> +		if grep -i "Protocol not supported" mount.log; then
> +			tst_brk TCONF "Protocol not supported"
> +		fi
> +
>  		tst_brk TBROK "mount command failed"
>  	fi
>  }
