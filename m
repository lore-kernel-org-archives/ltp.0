From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Jan 2019 13:42:06 +0100
Subject: [LTP] [PATCH]  Fix cgroup_lib.sh helper
In-Reply-To: <20190111161017.52307-1-cristian.marussi@arm.com>
References: <20190111161017.52307-1-cristian.marussi@arm.com>
Message-ID: <20190114124206.GA17760@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

...
>  	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
> -	[ -z "$mountpoint" ] && return 1
> +	[ -z "$mntpoint" ] && return 1
Thanks for fix, merged.

I'm sorry, that was introduced by me, while do some changes in your commit.


Kind regards,
Petr
