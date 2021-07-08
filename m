From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 8 Jul 2021 07:26:55 +0200
Subject: [LTP] [PATCH v2 3/4] fs_bind: Convert cloneNS tests
In-Reply-To: <20210706120434.867426-4-lkml@jv-coder.de>
References: <20210706120434.867426-1-lkml@jv-coder.de>
 <20210706120434.867426-4-lkml@jv-coder.de>
Message-ID: <d862f662-c06a-74d2-5e2d-8cd7a1e77a49@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

please do not merge, I found a bug in the code

On 7/6/2021 2:04 PM, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
> index b644ef512..94e94024c 100644
> --- a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
> +++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
> @@ -28,6 +28,8 @@ FS_BIND_DISK2="disk2"
>   FS_BIND_DISK3="disk3"
>   FS_BIND_DISK4="disk4"
>   
> +FS_BIND_MNTNS_PID=
> +
>   # Creates a directory and bind-mounts it to itself.
>   # usage: fs_bind_makedir share_mode directory
>   # where
> @@ -68,16 +70,23 @@ fs_bind_makedir()
>   #              If -n is given, only two directories are allowed.
>   fs_bind_check()
>   {
> -	local expect_diff args msg dir1 dir2 fail output
> +	local expect_diff use_ns args msg dir1 dir2 fail output
>   	expect_diff=0
> -	while getopts "n" args; do
> +	use_ns=0
> +	while getopts "ns" args; do
>   		case "$args" in
>   		n) expect_diff=1; shift; ;;
> +		s) use_ns=1; shift; ;;
>   		esac
>   	done
This getopts loop does not seem to be portable. I will send a v3....

Joerg
