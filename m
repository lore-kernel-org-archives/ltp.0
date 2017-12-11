From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Dec 2017 16:07:57 +0100
Subject: [LTP] [PATCH v2] scripts: Dump /proc and /sys
In-Reply-To: <20171128090644.27648-1-rpalethorpe@suse.com>
References: <20171128090644.27648-1-rpalethorpe@suse.com>
Message-ID: <20171211150757.GB12716@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks very good in general a few comments below.

Also have you tried to run it with dash or some alternative shell? I
haven't spotted any bashism but testing for compatibility never hurts :-)

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> V2:
> * Fixed numerous style problems
> * Instead of spawning X subshells per iteration I now only spawn $(nproc)
>   subshells and pass files to them to through named pipes. This is much faster.
> * Add some extra options
> 
>  scripts/proc_sys_dump.sh | 145 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100755 scripts/proc_sys_dump.sh
> 
> diff --git a/scripts/proc_sys_dump.sh b/scripts/proc_sys_dump.sh
> new file mode 100755
> index 000000000..a6be95c2e
> --- /dev/null
> +++ b/scripts/proc_sys_dump.sh
> @@ -0,0 +1,145 @@
> +#!/bin/sh
> +
> +my_name=${0##*/}
> +dump_dir=/tmp/dump
> +dump_tar=
> +white_list=/tmp/dump/white.list
> +use_white_list=
> +timeout=1
> +proc_exclude="/proc/\(self\|thread-self\|[0-9]+\)/.*"
> +page_sz=$(getconf PAGESIZE)
> +nproc=$(nproc)
> +
> +echo "Dump /proc and /sys script, written by rpalethorpe@suse.com"
> +
> +while getopts d:c:w:u:t:b:h arg; do
> +    case $arg in
> +       d) dump_dir="$OPTARG" ;;
> +       c) dump_tar="$OPTARG" ;;
> +       w) white_list="$OPTARG" ;;
> +       u) use_white_list="$OPTARG" ;;
> +       t) timeout="$OPTARG" ;;
> +       b) batch_size="$OPTARG" ;;
> +       h) cat <<-EOF >&1
> +
> +This script partially dumps the contents of /proc and /sys to a folder. It can
> +attempt to dump all the contents and then write out which files were
> +successful to a white list. Or use a previously generated white list.
> +
> +usage:
> +$my_name	[ -d dump_dir ]
> + 	 		[ -w white_list ] [ -u use_white_list ]
> + 			[ -t timeout ]
> + 			[ -b batch_size ]
> +$my_name	-h
> +
> +-d dump_dir	  The output directory, note that this will be recreated.
> +   		  Set to $dump_dir
> +
> +-c dump_tar	  Compress the output directory contents into a tar file
> +		  specified by dump_tar.

This should say that we are compressing to tar.xz, "compressing to tar"
does not make any sense since tar just puts several files into a single
one.

Moreover xz is not supported on slightly older distros so we may as well
be more conservative and use bz2 that is more widely supported instead.
Or eventually we may add fallback to bz2 if xz compression fails.

> +-w white_list	  The white list to output after dumping the files.
> +   		  Set to $white_list
> +
> +-u use_white_list The list of files to dump, if this is unset then 'find' is
> +   		  used to create a list.

I would have dropped the use_ from the use_white_list since IMHO that is
more confusing than helping here.

> +-t timeout	  How long, in seconds, we should wait for operations to finish.
> +   		  Set to $timeout.
> +
> +-h		  Print this help message and exit.
> +
> +Files are added to the white list if they are small, but not empty and can be
> +copied quickly. The idea is that when running the script with -w white_list
> +the majority of useful information can be quickly saved during automated
> +testing.
> +
> +It is best to run this script as root otherwise sensitive information will be
> +filtered out by the kernel e.g. memory layout. Which happens to be the most
> +useful information in most situations.
> +
> +EOF
> +	  exit 0 ;;
> +   esac
> +done
> +
> +files=
> +if [ ! $use_white_list ]; then
> +    echo "Finding files in /proc and /sys"
> +    proc_files=$(find -L /proc -maxdepth 4 -perm /u=r,g=r -not -regex "$proc_exclude" -not -type d 2> /dev/null)
> +    sys_files=$(find -L /sys -maxdepth 4 -perm /u=r,g=r -not -type d 2> /dev/null)
> +    files="$proc_files $sys_files"
> +else
> +    echo "Using file list $use_white_list"
> +    files=$(cat $use_white_list)
> +fi
> +
> +dump_dir=${dump_dir%/}
> +echo "Dumping to $dump_dir"
> +rm -rf $dump_dir
> +mkdir $dump_dir
> +
> +# This is run inside background subshells with stdin redirected to a named pipe.
> +spawn_dd () {
> +    local f=
> +
> +    read -r f
> +    until [ "$f" = "EXIT" ]; do
> +	mkdir -p $dump_dir$(dirname $f)
> +	timeout $timeout dd if=$f of=$dump_dir$f bs=$page_sz count=63 status=none
> +	if [ $? -eq 124 ]; then
> +	    echo "dd $f took too long"
> +	    rm $dump_dir$f
> +	fi
> +	read -r f
> +    done
> +}
> +
> +for i in $(seq $nproc); do
> +    mkfifo "$dump_dir/fifo$i"
> +    ( spawn_dd ) < "$dump_dir/fifo$i" &
> +done
> +
> +count=$nproc
> +for f in $files; do
> +    if [ $count -gt 0 ]; then
> +	echo "$f" > "$dump_dir/fifo$count"
> +	count=$((count - 1))
> +    else
> +	count=$nproc
> +    fi

Uh, shouldn't the be line with echo "$f" here? Since otherwise we will
skipp each $nproc+1 file in $files.

> +done
> +
> +for i in $(seq $nproc); do
> +    echo "EXIT" > "$dump_dir/fifo$i"
> +done

-- 
Cyril Hrubis
chrubis@suse.cz
