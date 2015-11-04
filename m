From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Nov 2015 13:49:27 +0100
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh:load dummy module
 before collecting sysfs interface
In-Reply-To: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
References: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <20151104124927.GC17823@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 7dea52b..b5791bd 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -47,6 +47,10 @@ if [ $? -eq 1 ]; then
>  	tst_brkm TBROK "unable to create a new network namespace"
>  fi
>  TST_CLEANUP=cleanup
> +
> +#Load dummy module before collecting sysfs interface
> +lsmod | grep dummy || modprobe dummy
> +[ $? -eq 0 ] || tst_brkm TBROK "failed to load dummy module"

But this will fail when dummy wasn't compiled in the kernel, right?

Since modprobe will exit with 1 when module couldn't be found. So we
should either just call 'modprobe dummy' and ignore the return value or
change the code to ignore the default dummy interface.

-- 
Cyril Hrubis
chrubis@suse.cz
