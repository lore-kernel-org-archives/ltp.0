From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Apr 2019 17:27:48 +0200
Subject: [LTP] [PATCH v2 1/3] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <6639dd7a9ff9929ce79f4f353f3e1db075594ea2.1555763787.git.mbobrowski@mbobrowski.org>
References: <cover.1555763787.git.mbobrowski@mbobrowski.org>
 <6639dd7a9ff9929ce79f4f353f3e1db075594ea2.1555763787.git.mbobrowski@mbobrowski.org>
Message-ID: <20190426152748.GA31769@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've tried these tests on buildservice to check that there are no
problems on slightly older distributions and found two.

The first one is that we do define fallback definitions in fanotify.h
but then ifdef the whole test code in #if defined(HAVE_SYS_FANOTIFY_H)
so that it's efectively disabled on older distros even with fallback
definitions in place. Also it's TST_TEST_TCONF() but that is just easy
to fix typo. I guess that we can remove the ifdef and sys/fanotify.h
include from the test sources since we conditionally include the
sys/fanotify.h in the local fanotify.h already.

The second one is that we fail to compile on older distributions because
of missing name_to_handle_at() so we need configure check for that
syscall and fallback definition in lapi/ header, or at least configure
check and ifdef in the fanotify_get_fid() function. Which should be as
easy as adding a name_to_handle_at line to AC_CHECK_FUNCS() in the
configure.ac and using the macro from config.h.

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2b8ca71..dfdc6cb 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -537,6 +537,7 @@ fanotify09 fanotify09
>  fanotify10 fanotify10
>  fanotify11 fanotify11
>  fanotify12 fanotify12
> +fanotify13 fanotify13
>  
>  ioperm01 ioperm01
>  ioperm02 ioperm02
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index 4256b8c..16bdd99 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -10,4 +10,5 @@
>  /fanotify10
>  /fanotify11
>  /fanotify12
> +/fanotify13
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 14654b7..e9b23cc 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -29,6 +29,11 @@
>  #define	__FANOTIFY_H__
>  
>  #include "config.h"
> +#include <sys/statfs.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <fcntl.h>
>  
>  #if defined(HAVE_SYS_FANOTIFY_H)
>  
> @@ -57,9 +62,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
>  #ifndef FAN_REPORT_TID
>  #define FAN_REPORT_TID		0x00000100
>  #endif
> -#ifndef FAN_REPORT_FID
> -#define FAN_REPORT_FID		0x00000200
> -#endif
>  
>  #ifndef FAN_MARK_INODE
>  #define FAN_MARK_INODE		0
> @@ -89,6 +91,50 @@ struct fanotify_mark_type {
>  	const char * name;
>  };
>  
> +#ifndef FAN_REPORT_FID
> +#define FAN_REPORT_FID		0x00000200
> +
> +struct fanotify_event_info_header {
> +	uint8_t info_type;
> +	uint8_t pad;
> +	uint16_t len;
> +};
> +
> +struct fanotify_event_info_fid {
> +	struct fanotify_event_info_header hdr;
> +	__kernel_fsid_t fsid;
> +	unsigned char handle[0];
> +};
> +
> +/*
> + * Helper function used to obtain __kernel_fsid_t and file_handle objects
> + * for a given path. Used by test files correlated to FAN_REPORT_FID
> + * functionality.
> + */
> +static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
> +			struct file_handle *handle)
> +{
> +	int mount_id;
> +	struct statfs stats;
> +
> +	if (statfs(path, &stats) == -1)
> +		tst_brk(TBROK | TERRNO,
> +			"statfs(%s, ...) failed", path);
> +	memcpy(fsid, &stats.f_fsid, sizeof(stats.f_fsid));
> +
> +	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_res(TCONF,
> +				"filesystem %s does not support file handles",
> +				tst_device->fs_type);

Btw, here the tst_res() does not make much sense sice the code will
continue and we will exit the test with the tst_brk() below. Shouldn't
we use tst_brk() here as well?

> +		}
> +		tst_brk(TBROK | TERRNO,
> +			"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
> +	}
> +}
> +
> +#endif
> +
>  #define INIT_FANOTIFY_MARK_TYPE(t) \
>  	{ FAN_MARK_ ## t, "FAN_MARK_" #t }

-- 
Cyril Hrubis
chrubis@suse.cz
