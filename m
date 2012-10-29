Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TSpzO-0005pp-8x
	for ltp-list@lists.sourceforge.net; Mon, 29 Oct 2012 14:06:50 +0000
Date: Mon, 29 Oct 2012 15:04:25 +0100
From: chrubis@suse.cz
Message-ID: <20121029140424.GB12578@rei.suse.cz>
References: <b578714d08c38d1fb789ab53266109b8bd760c52.1351503873.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b578714d08c38d1fb789ab53266109b8bd760c52.1351503873.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3] ipc/shmat: pick suitable base_addr before each
 testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
> index f467389..5cbf37c 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/Makefile
> +++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
> @@ -20,4 +20,7 @@ top_srcdir              ?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
> +
> +MAKE_TARGETS            := $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))

Hm, perhaps it would be easier to rename the shmat_common.c to
shmat_common.h.

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> index 6e4dee1..1f46b23 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> @@ -56,6 +56,7 @@
>   */
>  
>  #include "ipcshm.h"
> +#include "shmat_common.c"
>  
>  char *TCID = "shmat01";
>  
> @@ -108,6 +109,7 @@ int main(int ac, char **av)
>  			/*
>  			 * Use TEST macro to make the call
>  			 */

Once you are touching the source, you are welcomed to remove 
dumbious comments like this (ideally in separate patch). ;)

> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat_common.c b/testcases/kernel/syscalls/ipc/shmat/shmat_common.c
> new file mode 100644
> index 0000000..5a920c8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat_common.c
> @@ -0,0 +1,33 @@
> +static key_t probe_key;
> +
> +void *probe_free_addr()

Add void as the function parameters here.

> +{
> +	void *p;
> +	int ret;
> +	int shm_id = -1;
> +
> +	if (probe_key == 0)
> +		probe_key = getipckey();
> +
> +	/* create a shared memory resource with read and write permissions
> +	 * We align this to SHMLBA so we should allocate at least
> +	 * SHMLBA*2 in case SHMLBA > page_size. */
> +	shm_id = shmget(probe_key, SHMLBA*2, SHM_RW | IPC_CREAT | IPC_EXCL);
> +	if (shm_id == -1)
> +		tst_brkm(TBROK, cleanup, "probe: shmget failed");
> +
> +	/* Probe an available linear address for attachment */
> +	p = shmat(shm_id, NULL, 0);
> +	if (p == (void *)-1)
> +		tst_brkm(TBROK, cleanup, "probe: shmat failed");
> +	ret = shmdt((const void *)p);

Hmm, is this cast really needed?

> +	if (ret == -1)
> +		tst_brkm(TBROK, cleanup, "probe: shmdt failed");
> +
> +	rm_shm(shm_id);
> +
> +	/* some architectures (e.g. parisc) are strange, so better always
> +	 * align to next SHMLBA address. */
> +	p = (void *)(((unsigned long)(p) + (SHMLBA - 1)) & ~(SHMLBA - 1));
> +	return p;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Windows 8 Center - In partnership with Sourceforge
Your idea - your app - 30 days.
Get started!
http://windows8center.sourceforge.net/
what-html-developers-need-to-know-about-coding-windows-8-metro-style-apps/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
