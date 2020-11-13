From: Joe Perches <joe@perches.com>
Date: Fri, 13 Nov 2020 08:13:36 -0800
Subject: [LTP] [mm] b6efe2fcc4: BUG:kernel_NULL_pointer_dereference,
 address
In-Reply-To: <20201113121025.GA7578@xsang-OptiPlex-9020>
References: <20201113121025.GA7578@xsang-OptiPlex-9020>
Message-ID: <97b1b575659bc87a07a308765769451d9eee4aef.camel@perches.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2020-11-13 at 20:10 +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: b6efe2fcc4e11010710ef5cd8e2bcbeb221a06c6 ("mm: slub: Convert sysfs sprintf family to sysfs_emit/sysfs_emit_at")
> url: https://github.com/0day-ci/linux/commits/Joe-Perches/mm-Convert-sysfs-sprintf-family-to-sysfs_emit/20201102-041456
[] 
> on test machine: 8 threads Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> [   41.689368] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [   41.696354] #PF: supervisor read access in kernel mode
> [   41.701508] #PF: error_code(0x0000) - not-present page
> [   41.706661] PGD 0 P4D 0 
> [   41.709205] Oops: 0000 [#1] SMP PTI
> [   41.712702] CPU: 3 PID: 4619 Comm: read_all Tainted: G          I       5.10.0-rc1-00005-gb6efe2fcc4e1 #1
> [   41.722296] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
> [   41.729714] RIP: 0010:slabs_cpu_partial_show+0x95/0xe0

Right, thanks.

I mistakenly dropped a test for page below:

@@ -5156,44 +5156,45 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 
                page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
-               if (page && len < PAGE_SIZE - 20)
-                       len += sprintf(buf + len, " C%d=%d(%d)", cpu,
-                               page->pobjects, page->pages);
+               len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
+                                    cpu, page->pobjects, page->pages);
        }

I'll correct it and resubmit.


