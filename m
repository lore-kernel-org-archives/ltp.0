From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jun 2021 16:47:34 +0200
Subject: [LTP] [PATCH v3 2/4] syscalls/msgstress04: fix fork failure on
 small memory systems
In-Reply-To: <20210623135912.81156-3-krzysztof.kozlowski@canonical.com>
References: <20210623135912.81156-1-krzysztof.kozlowski@canonical.com>
 <20210623135912.81156-3-krzysztof.kozlowski@canonical.com>
Message-ID: <YNnhBhN6bzUCfqdk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof,

nit: Instead of git commit subject "syscalls/msgstress04: fix fork failure
on small memory systems". I'd use "tst_pid.c: fix fork ...".

> Running syscalls/msgstress04 on a system with less than ~4 GB of RAM fails:

>     Fork failure in the first child of child group 4396
>     Fork failure in the second child of child group 4413
>     msgstress04    1  TFAIL  :  msgstress04.c:222: Child exit status = 1

> The reason is cgroups pid limit set by systemd user.slice.  The limit is
> set for login session, also for root user.  For example on 2 GB RAM
> machine it is set as:
>     /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207

> Read the maximum number of pids and adjust the test limit.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  include/tst_pid.h |  4 ++-
>  lib/tst_pid.c     | 79 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 81 insertions(+), 2 deletions(-)

> diff --git a/include/tst_pid.h b/include/tst_pid.h
> index 6c42f73a57e7..8d999a655f1a 100644
> --- a/include/tst_pid.h
> +++ b/include/tst_pid.h
> @@ -14,7 +14,9 @@ pid_t tst_get_unused_pid_(void (*cleanup_fn)(void));

>  /*
>   * Returns number of free pids by subtraction of the number of pids
> - * currently used ('ps -eT') from max_pids
> + * currently used ('ps -eT') from maximum number of processes.
> + * The limit of processes come from kernel pid_max and cgroup session limits
> + * (e.g. configured by systemd user.slice).
>   */
>  int tst_get_free_pids_(void (*cleanup_fn)(void));

> diff --git a/lib/tst_pid.c b/lib/tst_pid.c
> index 9568cc9e91d2..c1ea3fe90e83 100644
> --- a/lib/tst_pid.c
> +++ b/lib/tst_pid.c
> @@ -18,14 +18,20 @@
>   *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */

> +#include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
>  #include <sys/types.h>
> +#include <unistd.h>
>  #include "test.h"
>  #include "tst_pid.h"
>  #include "old_safe_file_ops.h"

>  #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
> +#define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
> +#define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"

>  pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
>  {
> @@ -36,10 +42,77 @@ pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
>  	return pid;
>  }

> +/*
> + * Get the effective session UID - either one invoking current test via sudo
> + * or the real UID.
> + */
> +static int get_session_uid(void)
> +{
> +	const char *sudo_uid;
> +
> +	sudo_uid = getenv("SUDO_UID");
> +	if (sudo_uid) {
> +		int real_uid;
> +
> +		TEST(sscanf(sudo_uid, "%u", &real_uid));
FYI We recently decided to not use TEST() macro in library itself.
See Richard's effort [1]. We should document it in LTP Library API Writing Guidelines [2]

> +		if (TEST_RETURN != 1) {
> +#ifdef DEBUG
FYI we don't support DEBUG. Either the information is always important or not.
In this case I'd probably avoid printing it.

> +			tst_resm(TINFO, "No SUDO_UID from env");
> +#endif
> +		} else {
> +			return real_uid;
> +		}
> +	}
> +
> +	return getuid();
> +}
> +
> +static int read_session_pids_limit(const char *path_fmt, int uid,
> +				   void (*cleanup_fn) (void))
> +{
> +	int max_pids, ret;
> +	char path[PATH_MAX];
> +
> +	ret = snprintf(path, sizeof(path), path_fmt, uid);
> +	if (ret < 0 || (size_t)ret >= sizeof(path))
> +		return -1;
> +
> +	if (access(path, R_OK) != 0) {
> +		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
> +		return -1;
> +	}
> +
> +	SAFE_FILE_SCANF(cleanup_fn, path, "%d", &max_pids);
> +	tst_resm(TINFO, "Found limit of processes %d (from %s)", max_pids, path);
> +
> +	return max_pids;
> +}
> +
> +static int get_session_pids_limit(void (*cleanup_fn) (void))
> +{
> +	int max_pids, uid;
> +
> +	uid = get_session_uid();
> +	if (TEST_RETURN != 1) {
and here as well 
> +		tst_resm(TINFO, "Cannot get UID");
> +		return -1;
> +	}

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210621113804.26179-2-rpalethorpe@suse.com/
[2] https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines
