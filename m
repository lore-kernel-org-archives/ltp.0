From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 3 Mar 2020 14:59:38 +0300
Subject: [LTP] [PATCH 1/1] nfs: Add fsid=PID to exportfs
In-Reply-To: <20200302155857.923-1-pvorel@suse.cz>
References: <20200302155857.923-1-pvorel@suse.cz>
Message-ID: <91a9db4d-fef8-12f0-d996-87bdb7365b74@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02.03.2020 18:58, Petr Vorel wrote:
> Following 0ccbcfc38 ("syscalls/statx07: add fsid= to exports"):
> 
> Not all filesystems are stored on devices, and not all filesystems
> have UUIDs. tmpfs is one of them, which lead to test failing:
> /tmp/XRzHSG/server requires fsid= for NFS export
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Alexey,
> 
> simple fix, but better to check.
> I'm working on more NFS related fixes.
> 

Agree, thanks Petr!

> Kind regards,
> Petr
> 
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index e4a0c7e27..66f2fb038 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -48,7 +48,7 @@ get_socket_type()
>  
>  nfs_setup_server()
>  {
> -	local export_cmd="exportfs -i -o no_root_squash,rw *:$remote_dir"
> +	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
>  
>  	if [ -n "$LTP_NETNS" ]; then
>  		if [ ! -d $remote_dir ]; then
> 

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
