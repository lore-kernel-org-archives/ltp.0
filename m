From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2015 15:14:49 +0100
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh:load dummy module
 before collecting sysfs interface
In-Reply-To: <563CE067.90803@redhat.com>
References: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
 <563CE067.90803@redhat.com>
Message-ID: <20151109141449.GA23375@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> However - wouldn't it be simply easier to add an exception for dummy0
> during the comparison check? The test operates with iface names other
> than dummy0, so a possible namespace bug would be found anyway.
> (See attached diff.)
> 
> However the (quite possibly) best solution would be a one which cleans
> up after itself, so maybe the [ -d /sys/module/dummy ] solution with
> explicit modprobe / modprobe -r would work better.

Either one works for me.

> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 7dea52b..e725a50 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -47,7 +47,10 @@ if [ $? -eq 1 ]; then
>  	tst_brkm TBROK "unable to create a new network namespace"
>  fi
>  TST_CLEANUP=cleanup
> -ls /sys/class/net >sysfs_before
> +
> +# exclude dummy0 from comparison as it gets automatically created by the
> +# dummy device driver upon insmod/modprobe (during ip link add)
> +ls /sys/class/net | grep -v dummy0 >sysfs_before

Maybe we should do grep -v dummy[0-9].* in order to skipp all dummy
interfaces if someone changes the number of interfaces created. If we
decide to go this way.

-- 
Cyril Hrubis
chrubis@suse.cz
