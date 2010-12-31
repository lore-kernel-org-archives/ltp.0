Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PYhLQ-0003ZA-Ec
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 15:56:44 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYhLO-0006WD-7e
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 15:56:44 +0000
Received: by iyj18 with SMTP id 18so10785384iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Dec 2010 07:56:37 -0800 (PST)
References: <2f593033cef8fce7afbeaf2276c867fc7c8c1da7.1293815859.git.ext-hannu.m.heikkinen@nokia.com>
In-Reply-To: <2f593033cef8fce7afbeaf2276c867fc7c8c1da7.1293815859.git.ext-hannu.m.heikkinen@nokia.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <B13F18F8-B5AE-4E1D-84FE-1761EBF43020@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Fri, 31 Dec 2010 07:56:21 -0800
Subject: Re: [LTP] [PATCH 1/1] open_posix_testsuite: sigqueue 9-1,
	fix sigpending handling, and check purged signal queue
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
To: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

No. This is an illegal linuxism. Please try again...

Sent from my iPhone

On Dec 31, 2010, at 9:18 AM, Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com> wrote:

> Fix sigpending handling in sigqueue (9-1), by checking
> current pendings from /proc/<pid>/status -> SigQ.
> Also, added new functionality, check that purged signals
> received correctly.
> 
> Signed-off-by: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
> ---
> .../conformance/interfaces/sigqueue/9-1.c          |  183 +++++++++++++++++---
> 1 files changed, 160 insertions(+), 23 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> index e8592d5..fa8ad20 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/9-1.c
> @@ -24,63 +24,200 @@
> #define SIGTOTEST SIGRTMIN
> #define NUMCALLS 5
> 
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> #include <signal.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> +#include <string.h>
> #include <errno.h>
> #include "posixtest.h"
> 
> -void myhandler(int signo, siginfo_t *info, void *context) {
> -    printf ("Inside Handler\n");
> +static long purged = 0;
> +
> +void myhandler(int signo, siginfo_t *info, void *context)
> +{
> +    purged++;
> }
> 
> -int main()
> +int get_proc_sig(int pid, long *current_sig, long *max_sig)
> {
> +    int f;
> +    char procdir[128]="";
> +    char line[1024]="";
> +    char *pos, *pos2;
> +    char *sig;
> +    char c;
> +    long curr, max;
> +    int len;
> +    int ret;
> 
> -    int pid, i;
> -    long syslimit;
> -    union sigval value;
> +    snprintf(procdir, sizeof(procdir)-1, "/proc/%d/status", pid);
> +    procdir[sizeof(procdir)-1] = '\0';
> +
> +    f = open(procdir, O_RDONLY);
> +    if (f == -1)
> +        return -1;
> +
> +    len = read(f, line, sizeof(line)-1);
> +    close(f);
> +
> +    if (len <= 0)
> +        return -1;
> +    else
> +        line[len] = '\0';
> +
> +    pos = strstr(line, "SigQ:");
> +    if (pos == NULL)
> +        return -1;
> +
> +    pos2 = strchr(pos, '\n');
> +    if (pos2 == NULL)
> +        return -1;
> +
> +    sig = pos;
> +    sig[pos2-pos] = '\0';
> +    sig = strrchr(sig, '\t');
> +    if (sig == NULL)
> +        return -1;
> +
> +    printf("%s: from proc: %s\n", __func__, sig);
> +    if ((ret = sscanf(sig, "%ld%c%ld", &curr, &c, &max)) != 3) {
> +        printf("%s: Matching only %d items...\n",
> +            __func__, ret);
> +        return -1;
> +    }
> +    printf("%s: %s -> matched: %ld%c%ld\n",
> +        __func__, sig, curr, c, max);
> +
> +    *current_sig = curr;
> +    *max_sig = max;
> +
> +    return 0;
> +}
> +
> +int set_signals(sigset_t *new, sigset_t *old)
> +{
>    struct sigaction act;
> +    sigset_t new_set, old_set;
> 
>    act.sa_flags = SA_SIGINFO;
>    act.sa_sigaction = myhandler;
>    sigemptyset(&act.sa_mask);
>    sigaction(SIGTOTEST, &act, 0);
> 
> -    value.sival_int = 0;    /* 0 is just an arbitrary value */
> -    pid = getpid();
> +    printf("SIGRTMIN signals blocked\n");
> +    sigemptyset(&new_set);
> +    sigaddset(&new_set, SIGTOTEST);
> +    sigprocmask(SIG_BLOCK, &new_set, &old_set);
> +    *old = old_set;
> +    *new = new_set;
> 
> -    sighold(SIGTOTEST);
> +    return 0;
> +}
> 
> -    syslimit = sysconf(_SC_SIGQUEUE_MAX);
> +int do_purge_test(sigset_t old, long syslimit)
> +{
> +    int sanity = 12;
> 
> -    printf("sigqueuemax %ld\n", syslimit);
> -        
> -    if (syslimit == -1) {
> -        printf("Test PASSED: Actually, test is not applicable to this implementation. This system has no defined limit."
> -            " Note: it is optional whether an implementation has this limit, so this is"
> -            " not a bug.\n");
> -        return PTS_PASS;
> +    printf("SIGRTMIN signals unblocked\n");
> +    sigprocmask(SIG_SETMASK, &old, NULL);
> +
> +    while (purged < syslimit && sanity > 0) {
> +        sleep(1);
> +        sanity--;
>    }
> 
> -    for (i=0; i<syslimit; i++) {
> -        if (sigqueue(pid, SIGTOTEST, value) != 0) {
> -            printf("Test UNRESOLVED: call to sigqueue did not return success\n");
> +    return purged;
> +}
> +
> +int do_queue_test(int pid, long syslimit)
> +{
> +    int ret;
> +    int i;
> +    union sigval value;
> +
> +    value.sival_int = 0;    /* 0 is just an arbitrary value */
> +
> +    for (i = 0; i < syslimit; i++) {
> +        errno = 0;
> +        if ((ret = sigqueue(pid, SIGTOTEST, value)) != 0) {
> +            printf("Test UNRESOLVED: sigqueue ERROR: ret: %d errno: %d (%s), "
> +                   "sigqueues succeeded: %d, but syslimit: %d\n",
> +                ret,
> +                (int)errno,
> +                strerror(errno),
> +                i,
> +                (int)syslimit);
>            return PTS_UNRESOLVED;
>        }
>    }
> 
> +    errno = 0;
>    if (sigqueue(pid, SIGTOTEST, value) != -1) {
> -        printf("Test FAILED: sigqueue did not return -1 even though the process has already queued {SIGQUEUE_MAX} signals that are still pending.\n");
> +        printf("Test FAILED: sigqueue ERROR: ret: %d errno %d (%s). "
> +            "sigqueue should return -1 because the process already queued signals, which are pending\n",
> +            ret,
> +            (int)errno,
> +            strerror(errno));
>        return PTS_FAIL;
>    }
> -    
> +
>    if (errno != EAGAIN) {
> -        printf("Test FAILED: errno was not set to [EAGAIN] even though the process has already queued {SIGQUEUE_MAX} signals that are still pending.\n");
> +        printf("Test FAILED: errno was not set to [EAGAIN] even "
> +            "though the process has already queued {SIGQUEUE_MAX} signals "
> +            "that are still pending.\n");
>    }
>    
>    return PTS_PASS;
> }
> 
> +int main()
> +{
> +    long syslimit;
> +    long curr, max;
> +    sigset_t new_set, old_set;
> +    int ret = PTS_FAIL;
> +
> +    syslimit = sysconf(_SC_SIGQUEUE_MAX);
> +    printf("sigqueuemax %ld\n", syslimit);
> +
> +    if (syslimit == -1) {
> +        printf("Test PASSED: Actually, test is not applicable to this implementation."
> +            " This system has no defined limit."
> +            " Note: it is optional whether an implementation has this limit, so this is"
> +            " not a bug.\n");
> +        return PTS_PASS;
> +    }
> +
> +    sleep(1);
> +    if (get_proc_sig(getpid(), &curr, &max) == 0) {
> +        if (curr >= syslimit) {
> +            printf("Test UNRESOLVED: syslimit %ld less or equal to current pending %ld\n",
> +                syslimit, curr);
> +            return PTS_UNRESOLVED;
> +        }
> +        printf("reducing syslimit %ld -> %ld due to current pending %ld\n",
> +            syslimit,
> +            syslimit-curr,
> +            curr);
> +        syslimit -= curr;
> +    }
> 
> +    set_signals(&new_set, &old_set);
> +    ret = do_queue_test(getpid(), syslimit);
> +    if (ret == PTS_PASS) {
> +        int purged = do_purge_test(old_set, syslimit);
> +        printf("Purged %d of %d pending signals, not-purged %d\n",
> +            (int)purged,
> +            (int)syslimit,
> +            (int)(syslimit-purged));
> +        if (purged != syslimit)
> +            return PTS_FAIL;
> +    }
> +
> +    return ret;
> +}
> -- 
> 1.7.3
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
