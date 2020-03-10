From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 Mar 2020 16:01:17 +0300
Subject: [LTP] [PATCH 1/2] nfs_lib: Unify testing on netns
In-Reply-To: <20200305192716.10313-1-pvorel@suse.cz>
References: <20200305192716.10313-1-pvorel@suse.cz>
Message-ID: <5b00a232-d175-9cb1-ba20-ccd5d6e93cdc@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 05.03.2020 22:27, Petr Vorel wrote:
> There is no need to run tests on opposite client/server when using
> $TST_USE_NETNS based setup. It's enough just to set lhost IP address.
> This simplifies code a bit.

It changes the testcase, this way nfs traffic will go through
lo interface, the test won't use ltp_ns_veth* and netns.

We could add the knob for this scenario with LTP_NFS_USE_NETNS={1|0}?

> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 66f2fb038..2d5535dc5 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -50,14 +50,6 @@ nfs_setup_server()
>  {
>  	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
>  
> -	if [ -n "$LTP_NETNS" ]; then
> -		if [ ! -d $remote_dir ]; then
> -			mkdir -p $remote_dir
> -			ROD $export_cmd
> -		fi
> -		return
> -	fi
> -
>  	if ! tst_rhost_run -c "test -d $remote_dir"; then
>  		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
>  	fi
> @@ -79,11 +71,6 @@ nfs_mount()
>  	local mnt_cmd="mount -t nfs $opts $mount_dir $local_dir"
>  
>  	tst_res TINFO "Mounting NFS: $mnt_cmd"
> -	if [ -n "$LTP_NETNS" ]; then
> -		tst_rhost_run -s -c "$mnt_cmd"
> -		return
> -	fi
> -
>  	ROD $mnt_cmd
>  }
>  
> 

