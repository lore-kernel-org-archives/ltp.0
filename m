From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 29 Mar 2019 06:49:47 -0400
Subject: [LTP] [PATCH 3/3] ima: Add overlay test
In-Reply-To: <20190327161638.7407-4-pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
 <20190327161638.7407-4-pvorel@suse.cz>
Message-ID: <1553856587.9420.44.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, 2019-03-27 at 17:16 +0100, Petr Vorel wrote:

> +setup()
> +{
> +	lower="$TST_MNTPOINT/lower"
> +	upper="$TST_MNTPOINT/upper"
> +	work="$TST_MNTPOINT/work"
> +	merged="$TST_MNTPOINT/merged"
> +	mkdir -p $lower $upper $work $merged
> +
> +	device_backup="$TST_DEVICE"
> +	TST_DEVICE="overlay"
> +
> +	fs_type_backup="$TST_FS_TYPE"
> +	TST_FS_TYPE="overlay"
> +
> +	mntpoint_backup="$TST_MNTPOINT"
> +	TST_MNTPOINT="$merged"
> +
> +	params_backup="$TST_MNT_PARAMS"
> +	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
> +
> +	grep -q ima_appraise_tcb /proc/cmdline || \
> +		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"

Instead of specifying individual policies separately, the newer method
of specifying builtin IMA policies on the boot command line is
"ima_policy=", with a list of policies.  The builtin appraise policy
would be specified as "ima_policy=appraise_tcb".  Refer to
Documentation/admin-guide/kernel-parameters.txt for the list of
builtin policies.

> +}
> +
> +do_test()
> +{
> +	local file="foo.txt"
> +	local f
> +
> +	tst_mount
> +	mounted=1
> +
> +	ROD echo lower \> $lower/$file

For some reason "mntpoint/lower" isn't loopback mounted.  With the
builtin appraise policy, because it is a tmpfs filesystem,
security.ima does not exist.  Writing to the merged directory then
fails.

+ df -T mntpoint/lower
Filesystem     Type  1K-blocks   Used Available Use% Mounted on
tmpfs          tmpfs   4020348 262316   3758032   7% /tmp


+ getfattr -m '^security' --dump mntpoint/lower/foo.txt
# file: mntpoint/lower/foo.txt
security.evm=0sAq8niNi4X7cYntKSAki1Woc+Y5Yq
security.selinux="unconfined_u:object_r:user_tmp_t:s0"

Mimi

> +	if ! echo overlay > $merged/$file 2>/dev/null; then
> +		tst_res TFAIL "Cannot write to merged layer"
> +		return
> +	fi
> +
> +	for f in $(find $TST_MNTPOINT -type f); do
> +		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
> +	done
> +}

