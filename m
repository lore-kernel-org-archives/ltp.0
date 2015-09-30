From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2015 14:18:58 +0200
Subject: [LTP] [PATCH 2/2] cpuhotplug_hotplug.sh: do/done should be
 left-aligned
In-Reply-To: <1443583556-20470-2-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1443583556-20470-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1443583556-20470-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <20150930121858.GB8132@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> index d9cf965..ad8675a 100644
> --- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> @@ -28,7 +28,7 @@ migrate_irq()
>      MASK=$((1<<${CPU}))
>      IRQS=$2
>      for irq in ${IRQS}
> -      do
> +    do

The rest of the file has for cycles with semicolon and do on the same
line. Let's be consistent and change this one to the same style as well.

-- 
Cyril Hrubis
chrubis@suse.cz
