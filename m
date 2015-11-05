From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Nov 2015 15:02:42 +0100
Subject: [LTP] [PATCH V2] controllers/cgroup_fj: fix and clean up
In-Reply-To: <1446458018-20866-1-git-send-email-chnyda@suse.com>
References: <1446458018-20866-1-git-send-email-chnyda@suse.com>
Message-ID: <20151105140242.GC7226@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +mounted=1;
>  
>  expected=1;
>  
> @@ -132,6 +133,12 @@ if [ "$#" -ne "9" ]; then
>  	exit -1;
>  fi
>  
> +mount_point=$(get_mount_point)
> +if [ "$mount_point" == "" ] ; then
> +	mounted=0
> +	mount_point=/dev/cgroup
> +fi
> +
>  check_para;
>  if [ $? -ne 0 ]; then
>  	usage;
> @@ -139,7 +146,9 @@ if [ $? -ne 0 ]; then
>  fi
>  setup;
>  
> -mount_cgroup;
> +if [ $mounted -ne 1 ]; then
> +	mount_cgroup;
> +fi


It would be more elegant if this snippets of code that detect if cgroup
is mounted and mount it if it isn't were part of the setup() function
instead of being copied in each test.

...

> +get_mount_point()
> +{
> +	check_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`

I would do even more specific:

grep -w "^$subsystem"

which would match only lines that begin with word "$subsystem".


Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
