From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 22 Jun 2017 17:41:00 +0800
Subject: [LTP] [PATCH v2 1/3] tst_safe_sysv_ipc: add shared memory
	related macros
In-Reply-To: <1496317753-2871-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170529145709.GC6618@rei.lan>
 <1496317753-2871-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <594B90AC.9060505@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

Ping, thanks! :-)

Best Regards,
Xiao Yang.
On 2017/06/01 19:49, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  include/tst_safe_sysv_ipc.h | 25 +++++++++++++++++++
>  lib/tst_safe_sysv_ipc.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/include/tst_safe_sysv_ipc.h b/include/tst_safe_sysv_ipc.h
> index cbdefb9..e01957f 100644
> --- a/include/tst_safe_sysv_ipc.h
> +++ b/include/tst_safe_sysv_ipc.h
> @@ -18,6 +18,11 @@
>  #ifndef TST_SAFE_SYSV_IPC_H__
>  #define TST_SAFE_SYSV_IPC_H__
>  
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <sys/shm.h>
> +
>  int safe_msgget(const char *file, const int lineno, key_t key, int msgflg);
>  #define SAFE_MSGGET(key, msgflg) \
>  	safe_msgget(__FILE__, __LINE__, (key), (msgflg))
> @@ -39,4 +44,24 @@ int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
>  	(msqid) = ((cmd) == IPC_RMID ? -1 : (msqid)); \
>  	} while (0)
>  
> +int safe_shmget(const char *file, const int lineno, key_t key, size_t size,
> +		int shmflg);
> +#define SAFE_SHMGET(key, size, shmflg) \
> +	safe_shmget(__FILE__, __LINE__, (key), (size), (shmflg))
> +
> +void *safe_shmat(const char *file, const int lineno, int shmid,
> +		const void *shmaddr, int shmflg);
> +#define SAFE_SHMAT(shmid, shmaddr, shmflg) \
> +	safe_shmat(__FILE__, __LINE__, (shmid), (shmaddr), (shmflg))
> +
> +int safe_shmdt(const char *file, const int lineno, const void *shmaddr);
> +#define SAFE_SHMDT(shmaddr)	safe_shmdt(__FILE__, __LINE__, (shmaddr))
> +
> +int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
> +		struct shmid_ds *buf);
> +#define SAFE_SHMCTL(shmid, cmd, buf) do { \
> +	safe_shmctl(__FILE__, __LINE__, (shmid), (cmd), (buf)); \
> +	(shmid) = ((cmd) == IPC_RMID ? -1 : (shmid)); \
> +	} while (0)
> +
>  #endif /* TST_SAFE_SYSV_IPC_H__ */
> diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
> index cb2b304..b2b132b 100644
> --- a/lib/tst_safe_sysv_ipc.c
> +++ b/lib/tst_safe_sysv_ipc.c
> @@ -18,6 +18,7 @@
>  #include <sys/types.h>
>  #include <sys/ipc.h>
>  #include <sys/msg.h>
> +#include <sys/shm.h>
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> @@ -68,7 +69,7 @@ ssize_t safe_msgrcv(const char *file, const int lineno, int msqid, void *msgp,
>  int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
>  		struct msqid_ds *buf)
>  {
> -	int  rval;
> +	int rval;
>  
>  	rval = msgctl(msqid, cmd, buf);
>  	if (rval == -1) {
> @@ -78,3 +79,58 @@ int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
>  
>  	return rval;
>  }
> +
> +int safe_shmget(const char *file, const int lineno, key_t key, size_t size,
> +		int shmflg)
> +{
> +	int rval;
> +
> +	rval = shmget(key, size, shmflg);
> +	if (rval == -1) {
> +		tst_brk(TBROK | TERRNO, "%s:%d: shmget(%i, %li, %x) failed",
> +			file, lineno, (int)key, size, shmflg);
> +	}
> +
> +	return rval;
> +}
> +
> +void *safe_shmat(const char *file, const int lineno, int shmid,
> +		const void *shmaddr, int shmflg)
> +{
> +	void *rval;
> +
> +	rval = shmat(shmid, shmaddr, shmflg);
> +	if (rval == (void *)-1) {
> +		tst_brk(TBROK | TERRNO, "%s:%d: shmat(%i, %p, %x) failed",
> +			file, lineno, shmid, shmaddr, shmflg);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_shmdt(const char *file, const int lineno, const void *shmaddr)
> +{
> +	int rval;
> +
> +	rval = shmdt(shmaddr);
> +	if (rval == -1) {
> +		tst_brk(TBROK | TERRNO, "%s:%d: shmdt(%p) failed",
> +			file, lineno, shmaddr);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
> +		struct shmid_ds *buf)
> +{
> +	int rval;
> +
> +	rval = shmctl(shmid, cmd, buf);
> +	if (rval == -1) {
> +		tst_brk(TBROK | TERRNO, "%s:%d: shmctl(%i, %i, %p) failed",
> +			file, lineno, shmid, cmd, buf);
> +	}
> +
> +	return rval;
> +}



