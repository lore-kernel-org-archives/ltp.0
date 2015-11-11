From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2015 15:19:14 +0100
Subject: [LTP] [PATCH V3] controllers/cpuacct: rewrote testcases
In-Reply-To: <1447237853-26134-1-git-send-email-chnyda@suse.com>
References: <1447237853-26134-1-git-send-email-chnyda@suse.com>
Message-ID: <20151111141914.GB26695@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, see below.

> +export TCID="cpuacct_$1_$2"
> +export TST_TOTAL=3

The test prints PASS/FAIL twice -> corrected TST_TOTAL=2

> +. test.sh
> +
> +setup()
> +{

I've added tst_require_root here since the test needs root permissions
and moved the TST_CLEANUP=cleanup after the tst_require_root (since
otherwise the cleanup would be called even when the tst_require_root
exits the test before any setup was done).

> +	mount_point=`grep -w cpuacct /proc/mounts | cut -f 2 | cut -d " " -f2`
> +	tst_resm TINFO "cpuacct: $mount_point"
> +	if [ "$mount_point" = "" ]; then
> +		mounted=0
> +		mount_point=/dev/cgroup
> +	fi
> +
> +	testpath=$mount_point/ltp_$TCID
> +
> +	if [ "$mounted" -eq "0" ]; then
> +		ROD mkdir -p $mount_point
> +		ROD mount -t cgroup -o cpuacct none $mount_point
> +	fi
> +	ROD mkdir $testpath
> +}
> +
> +cleanup()
> +{
> +	tst_resm TINFO "removing created directories"
> +	rmdir $testpath/subgroup_*;
> +	rmdir $testpath;
> +	if [ "$mounted" -ne 1 ] ; then

I've removed the useless semicolons and the space before "; then"

> +
> +   

And two trailing whitespaces here.

> +for job in `jobs -p`; do
> +	wait $job
> +done

...

> +/*
> +* Description:
> +* Write the current process in argv[1]
> +*/
> +
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char **argv)
> +{
> +	FILE *f;

And added:

        if (argc != 2) {
                fprintf(stderr, "Usage: %s /cgroup/.../tasks\n", argv[0]);
                return 1;
        }

here mostly to silence the unused argc warning.

> +	f = fopen(argv[1], "a");
> +	if (!f) {


And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
