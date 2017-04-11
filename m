From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Apr 2017 16:44:15 +0200
Subject: [LTP] [PATCH 2/2] syscalls/quotactl03.c: add new regression test
In-Reply-To: <1490955322-7483-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1490955322-7483-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1490955322-7483-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170411144415.GB3998@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "tst_test.h"
> +
> +#if defined(HAVE_XFS_QUOTA) && (defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1))
> +
> +# ifdef Q_XGETNEXTQUOTA

Here as well, can we add fallback definition and handle EINVAL (and
possibly ENOSYS) from the quotaclt as TCONF?

> +static const char mntpoint[] = "mnt_point";
> +static uint32_t test_id = 4294967292;
                             ^
			     This would be a bit clealer when written in
			     hexadecimal which should be 0xfffffffc

> +static void verify_quota(void)
> +{
> +	struct fs_disk_quota res_dquota;
> +
> +	res_dquota.d_id = 1;
> +
> +	TEST(quotactl(QCMD(Q_XGETNEXTQUOTA, USRQUOTA), tst_device->dev,
> +		test_id, (void *)&res_dquota));
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "quotactl() found the next active ID: %u "
> +			"unexpectedly when asking for it past UINT_MAX.",
                                     ^
			  Maybe this is too verbose, we could have ended
			  the message after "unexpectedly"
> +			res_dquota.d_id);
> +		return;
> +	}
> +
> +	if (TEST_ERRNO != ENOENT) {
> +		tst_res(TFAIL | TTERRNO, "quotactl() couldn't find the next "
> +			"active ID expectedly when asking for it past UINT_MAX"
> +			", but returns %s instead of ENOENT.",

                        "quotaclt() failed unexpectedly with %s expected ENOENT"

			or something similar would suffice here, let's
			keep the message short and to the point

> +			tst_strerrno(TEST_ERRNO));
> +	} else {
> +		tst_res(TPASS, "quotactl() couldn't find the next active ID "
> +			"expectedly when asking for it past UINT_MAX, and "
> +			"return ENOENT.");

                         Here as well something as:

			 "quotaclt() failed with ENOENT as expected"

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "quotactl03",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test_all = verify_quota,
> +	.mount_device = 1,
> +	.dev_fs_type = "xfs",
> +	.mntpoint = mntpoint,
> +	.mnt_data = "usrquota",
> +};
> +# else
> +	TST_TEST_TCONF("This system didn't support Q_XGETNEXTQUOTA");
> +# endif
> +
> +#else
> +	TST_TEST_TCONF("This system didn't support quota or xfs quota");
> +#endif
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
