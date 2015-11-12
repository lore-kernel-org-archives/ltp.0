From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2015 15:36:57 +0100
Subject: [LTP] [PATCH V4] controllers/cgroup_fj: fix and clean up
In-Reply-To: <1447257305-14696-1-git-send-email-chnyda@suse.com>
References: <1447257305-14696-1-git-send-email-chnyda@suse.com>
Message-ID: <20151112143657.GC19653@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  setup()
>  {
> -	if [ -e /dev/cgroup ]; then
> +	# Current test will fail if the previous one failed to rmdir
> +	# so try to remove all subgroups
> +	mount_point=$(get_mount_point)
> +	rmdir $mount_point/subgroup_*

I've removed this rmdir now, since if cgroups are not mounted it will
expand to rmdir /subgroup_* which is mostly harmless but will generate
confusing error in the output.

> +	if [ "$mount_point" == "" ] ; then
                                   ^
				   Removed this space
> +		mounted=0
> +		mount_point=/dev/cgroup
> +	fi
> +
> +	if [ -e $mount_point ] && [ $mounted -ne 1 ]; then
> +		rm -rf $mount_point
>  		cleanup;
                       ^
		       This useless semicolon

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
