From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Dec 2018 22:13:52 +0100
Subject: [LTP] [PATCH] cpu_hotplug/cpuhotplug03.sh: Accurately select
 command name by -C option
In-Reply-To: <1542366655-3891-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1542366655-3891-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181205211352.GC21236@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Since procps v3.3.15, running cpuhotplug03.sh got the following error:
> ----------------------------------------------------------------------
> cpuhotplug03 1 TINFO: Onlining CPU 1
> cpuhotplug03 1 TBROK: No cpuhotplug_do_spin_loop processes found on any processor
> ----------------------------------------------------------------------

> On procps v3.3.15, ps command name selection is extended to 64 characters
> so procps cannot trucate normal command name to 15 characters by default.
> In addition, normal command name is truncated to 16 characters and stored
> in /proc/<pid>/stat and /proc/<pid>/status in kernel.(except workqueue worker
> because it has been extended to 64 by kernel commit 6b59808)

> References:
> procps commit: bb272580a6f3c192c61e307f9e341514d892d06e
> procps commit: 14005a371e5c14289e96a4927ffd1a827d3c9d85
> procps commit: 2cfdbbe897f0d4e41460c7c2b92acfc5804652c8
> kernel commit: 6b59808bfe482642287ddf3fe9d4cccb10756652

> Note:
> I think the lastest ps(1) manpage for command name length is confused
> because kernel only extend workqueue worker name to 64 characters by
> commit 6b59808 and still truncate normal command name to 16 characters.
> e.g:
> ---------------------------------------------------------------------
> cd /root/ltp/testcases/kernel/hotplug/cpu_hotplug/tools
> PATH=$PATH:$PWD cpuhotplug_do_spin_loop &
> [1] 8732
> cat /proc/8732/stat
> 8732 (cpuhotplug_do_s) ...
> cat /proc/8732/status | grep Name
> Name:   cpuhotplug_do_s
> ---------------------------------------------------------------------
Agree.

> I will try to update ps(1) manpage for command name length.
Good :).

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh    | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)


Kind regards,
Petr
