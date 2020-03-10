From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 Mar 2020 16:34:22 +0300
Subject: [LTP] [PATCH 2/2] nfs: Detect disabled UDP
In-Reply-To: <20200305192716.10313-2-pvorel@suse.cz>
References: <20200305192716.10313-1-pvorel@suse.cz>
 <20200305192716.10313-2-pvorel@suse.cz>
Message-ID: <21baaca8-7c4e-7c11-2ff3-d10cf3e492e5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05.03.2020 22:27, Petr Vorel wrote:
> nfs-utils disabled serving NFS over UDP in version 2.2.1,
> which produce TBROK:
> 
> nfs01 1 TBROK: 'mount -t nfs -o proto=udp,vers=3
> 10.0.0.2:/tmp/LTP_nfs01.3pixnljzEv/3/udp /tmp/LTP_nfs01.3pixnljzEv/3/0'
> failed on '': 'mount.nfs: requested NFS version or transport protocol is
> not supported'
> 
> Detect UDP configuration (parsing all configs) and return TCONF when disabled.
> 
> NOTE: Debian based distros still use older version, once it upgrades, it
> will might keep using current configuration files
> (/etc/default/nfs-kernel-server, /etc/default/nfs-common), therefore
> code might need to be adjusted.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 2d5535dc5..2ba79dfdd 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -46,6 +46,15 @@ get_socket_type()
>  	done
>  }
>  
> +nfs_server_udp_enabled()
> +{
> +	local config f
> +
> +	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
> +	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ] && printf "$f "; done')
> +	tst_rhost_run -c "grep -q '^[[:space:]]*udp[[:space:]]*=[[:space:]]*y' /etc/nfs.conf $config"

Looks like the pattern doesn't detect when udp enabled by
default and the config has commented default values,
i.e. '# udp=y'.

grep '^[# ]*udp *= *y' /etc/nfs.conf $config


> +}
> +
>  nfs_setup_server()
>  {
>  	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
> @@ -93,6 +102,10 @@ nfs_setup()
>  		type=$(get_socket_type $n)
>  		tst_res TINFO "setup NFSv$i, socket type $type"
>  
> +		if [ "$type" = "udp" ] && ! nfs_server_udp_enabled; then
> +			tst_brk TCONF "UDP support disabled on NFS server"
> +		fi
> +
>  		local_dir="$TST_TMPDIR/$i/$n"
>  		remote_dir="$TST_TMPDIR/$i/$type"
>  		mkdir -p $local_dir
> 

