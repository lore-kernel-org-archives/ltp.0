From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Oct 2017 12:53:44 +0200
Subject: [LTP] [PATCH v5 07/12] hotplug/memory_hotplug: Remove unused
 header
In-Reply-To: <20171018111106.17215-8-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
 <20171018111106.17215-8-pvorel@suse.cz>
Message-ID: <20171026105344.GD7806@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #include "config.h"
> -#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H
> -#include <linux/mempolicy.h>
> +#if HAVE_NUMA_H && HAVE_NUMAIF_H

I guess that we have the same definitions in the linux/mempolicy.h and
numaif.h, right? I wonder how we even could include both of them without
producing warnings for constant redefinitions, etc.

Anyway, can you please include a bit more explanation in the commit
message? Something along the lines that the constant are present in both
headers and that we only need to include one?

Otherwise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
