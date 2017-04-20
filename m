From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Apr 2017 14:11:21 +0200
Subject: [LTP] [PATCH] controllers/cpuset:check for cpuset mount status
 and prefix
In-Reply-To: <1468479240-4975-1-git-send-email-shuang.qiu@oracle.com>
References: <1468479240-4975-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <20170420121121.GA10246@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index cd7000e..72bf8e3 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -35,8 +35,10 @@ fi
>  N_NODES=${N_NODES#*-*}
>  N_NODES=$(($N_NODES + 1))
>  
> -CPUSET="/dev/cpuset"
> +CPUSET=`grep -w cpuset /proc/mounts | cut -f 2 | cut -d " " -f2`

The 'cut -f 2' does not seem to have any efect here, moreover single awk
command should do the same:

CPUSET=$(awk '/cpuset/ {print $2}' /proc/mounts)

> +[ "$CPUSET" == "" ] && CPUSET="/dev/cpuset"
>  CPUSET_TMP="/tmp/cpuset_tmp"
> +[ -e "$CPUSET/cpuset.cpus" ] && PREFIX="cpuset."

Shouldn't we do this check in the setup after we mounted the cpuset (in
a case that it wasn't mounted)?

>  HOTPLUG_CPU="1"
>  
> @@ -121,19 +123,23 @@ check()
>  # clean any group created eralier (if any)
>  setup()
>  {
> -	if [ -e "$CPUSET" ]
> -	then
> -		tst_resm TWARN "$CPUSET already exist.. overwriting"
> -		cleanup || tst_brkm TFAIL "Can't cleanup... Exiting"
> -	fi
> -
> +	try_mount=0
>  	mkdir -p "$CPUSET_TMP"
> -	mkdir "$CPUSET"
> -	mount -t cpuset cpuset "$CPUSET" 2> /dev/null
> -	if [ $? -ne 0 ]; then
> -		cleanup
> -		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
> +	if [ "$CPUSET" = "/dev/cpuset" ];then
> +		if [ -e "$CPUSET" ]
> +		then
> +			tst_resm TWARN "$CPUSET already exist.. overwriting"
> +			cleanup || tst_brkm TFAIL "Can't cleanup... Exiting"
> +		fi

The coding style in this part is inconsistent, ideally you should stick
to the style used in the rest of the file and consistently use:

	if foo; then
		...
	fi

> +		try_mount=1
> +		mkdir "$CPUSET"
> +		mount -t cpuset cpuset "$CPUSET" 2> /dev/null
> +		if [ $? -ne 0 ]; then
> +			cleanup
> +			tst_brkm TFAIL "Could not mount cgroup filesystem with"\
>  					" cpuset on $CPUSET..Exiting test"
> +		fi

We should set the try_mount after the mount here since otherwise we will
try to umount it in the cleanup if the mount here has failed.

Also it try_mount is not a good name for the flag. It should be rather
called moutned instead.

>  	fi
>  }
>  
> @@ -162,13 +168,14 @@ cleanup()
>  		fi
>  	done
>  
> +	rm -rf "$CPUSET_TMP" > /dev/null 2>&1
> +	[ "$try_mount" -ne 1 ] && return
>  	umount "$CPUSET"
>  	if [ $? -ne 0 ]; then
>  		tst_brkm TFAIL "Couldn't umount cgroup filesystem with"\
>  					" cpuset on $CPUSET..Exiting test"
>  	fi
>  	rmdir "$CPUSET" > /dev/null 2>&1
> -	rm -rf "$CPUSET_TMP" > /dev/null 2>&1
>  }

The rest of the patchset looks obviously correct.

-- 
Cyril Hrubis
chrubis@suse.cz
