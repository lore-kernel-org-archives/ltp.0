From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 17 Jun 2020 10:00:39 +0530
Subject: [LTP] [PATCH V2 5/6] include: Add declaration of struct
 msqid64_ds
In-Reply-To: <20200616161150.GA20634@dell5510>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
 <7616a6fa4f1502dde4417d33aa88836c8020419e.1592302358.git.viresh.kumar@linaro.org>
 <20200616161150.GA20634@dell5510>
Message-ID: <20200617043039.x25qtumipozkhjma@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16-06-20, 18:11, Petr Vorel wrote:
> Hi Viresh,
> 
> > +++ b/configure.ac
> > @@ -153,6 +153,7 @@ AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
> >  AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
> >  AC_CHECK_TYPES([struct semid64_ds],,,[#include <sys/sem.h>])
> >  AC_CHECK_TYPES([struct shmid64_ds],,,[#include <sys/shmbuf.h>])
> > +AC_CHECK_TYPES([struct msqid64_ds],,,[#include <sys/msgbuf.h>])
> 
> NOTE (for next time): we try to keep items in configure.ac alphabetically sorted :).

I normally keep such things sorted, looks like I need to watch some
"ABCD" youtube videos with my 3 yrs old daughter now :)

-- 
viresh
