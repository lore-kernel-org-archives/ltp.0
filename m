From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Jun 2020 18:11:50 +0200
Subject: [LTP] [PATCH V2 5/6] include: Add declaration of struct
 msqid64_ds
In-Reply-To: <7616a6fa4f1502dde4417d33aa88836c8020419e.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
 <7616a6fa4f1502dde4417d33aa88836c8020419e.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <20200616161150.GA20634@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> +++ b/configure.ac
> @@ -153,6 +153,7 @@ AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
>  AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
>  AC_CHECK_TYPES([struct semid64_ds],,,[#include <sys/sem.h>])
>  AC_CHECK_TYPES([struct shmid64_ds],,,[#include <sys/shmbuf.h>])
> +AC_CHECK_TYPES([struct msqid64_ds],,,[#include <sys/msgbuf.h>])

NOTE (for next time): we try to keep items in configure.ac alphabetically sorted :).

Kind regards,
Petr
