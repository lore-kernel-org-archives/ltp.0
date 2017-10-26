From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Oct 2017 13:04:40 +0200
Subject: [LTP] [PATCH v5 08/12] hotplug/memory_hotplug: Exit with TCONF
 when NUMA headers not available
In-Reply-To: <20171018111106.17215-9-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
 <20171018111106.17215-9-pvorel@suse.cz>
Message-ID: <20171026110440.GE7806@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> index 1a96d914a..296788e30 100644
> --- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> +++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
> @@ -24,6 +24,8 @@
>  
>  #include <stdio.h>
>  #include "config.h"
> +#include "tst_res_flags.h"
> +
>  /* Shortcut because the test requires numa and mempolicy support. */
>  #if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_LINUX_MEMPOLICY_H
>  #include <sys/types.h>
> @@ -495,6 +497,6 @@ int main(int argc, char *argv[])
>  int main(void)
>  {
>  	printf("System doesn't have required numa support.\n");
> -	return 0;
> +	return TCONF;
>  }

I was trying to figure out how is this binary executed and it seems like
it is not. There even seems to be some scripts for it. So in the long
term we should investigate if it's worth keeping or not and maybe
ressurect it.

So all in all I do not see if there is a value in patching it if we do
not run it at all and it produces strange failures on non-numa machine
anyways...

-- 
Cyril Hrubis
chrubis@suse.cz
