From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 21 Jul 2020 16:32:08 +0200
Subject: [LTP] [PATCH 1/9] syscalls/ipc: shmctl02: Convert to the new
 library
In-Reply-To: <20200717163453.9587-2-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-2-chrubis@suse.cz>
Message-ID: <7109b5c3-d923-688a-9521-ae0a39a52d81@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
Li Wang already suggested the most important fixes so I'll just add two
more typos on top. Otherwise it looks good.

On 17. 07. 20 18:34, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

> ---
>  testcases/kernel/syscalls/ipc/shmctl/Makefile |   4 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl02.c     | 263 ++++++------------
>  2 files changed, 89 insertions(+), 178 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> index 0b97bb240..7b05325ee 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> @@ -1,213 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> ...
>   *
> - *      06/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
> - *      - Fix concurrency issue. The second key used for this test could
> - *        conflict with the key from another task.
> + * * EACCES - segment has no read or write permissions
> + * * EFAULT - IPC_SET & buf isn't valid
> + * * EFAULT - IPC_STAT & buf isn't valid
> + * * EINVAL - the command is not valid
> + * * EINVAL - the shmid is not valid
> + * * EINVAL - the shmid belongs to removed shm
>   *
> - * RESTRICTIONS
> - *	none
> + * * EPERM - attempt to stat root owned shm

^ "root-owned" is missing a dash throughout this file

> + * * EPERM - attempt delete root owned shm

^ attempt *TO* delete ...

> + * * EPERM - attempt to change root owned shm
> + * * EPERM - attempt to lock root owned shm
> + * * EPERM - attempt to unlock root owned shm
>   */
>  
> -#include "ipcshm.h"
>  #include <pwd.h>
>  
> ...
> +} tc[] = {
> +	{&shm_id1, IPC_STAT, &buf, EACCES},
> +	{&shm_id2, IPC_SET, (struct shmid_ds *)-1, EFAULT},
> +	{&shm_id2, IPC_STAT, (struct shmid_ds *)-1, EFAULT},
> +	{&shm_id2, -1, &buf, EINVAL},
> +	{&shm_bad, IPC_STAT, &buf, EINVAL},
> +	{&shm_rem, IPC_STAT, &buf, EINVAL},
> +	/* Operations on root owned shm */

^ Last instance of "root-owned" without a dash

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
