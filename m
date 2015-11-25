From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2015 12:13:30 +0100
Subject: [LTP] [PATCH V3] controllers/pids: Add new testcases
In-Reply-To: <1448026487-6079-1-git-send-email-chnyda@suse.com>
References: <1448026487-6079-1-git-send-email-chnyda@suse.com>
Message-ID: <20151125111329.GB24599@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/controllers/pids/.gitignore
> @@ -0,0 +1,2 @@
> +/pids_task
> +/pids_task2

I would have renamed the pids_task to pids_task1 just for consistency.


> +cleanup()
> +{
> +	killall -9 pids_task2 > /dev/null
> +
> +	tst_resm TINFO "removing created directories"
> +	rmdir $testpath
> +	if [ "$mounted" -ne "1" ]; then
> +		tst_resm TINFO "Umounting pids"
> +		umount $mount_point
> +		rmdir $mount_point
> +	fi
> +}
> +
> +setup()
> +{
> +	tst_require_root
> +
> +	exist=`grep -w pids /proc/cgroups | cut -f1`;
> +	if [ "$exist" = "" ]; then
> +		tst_brkm TCONF NULL "pids not supported"
> +	fi
> +
> +	mount_point=`grep -w pids /proc/mounts | cut -f 2 | cut -d " " -f2`
> +
> +	if [ "$mount_point" = "" ]; then
> +		mounted=0
> +		mount_point=/dev/cgroup
> +	fi
> +
> +	TST_CLEANUP=cleanup
> +
> +	testpath=$mount_point/ltp_$TCID
> +
> +	if [ "$mounted" -eq "0" ]; then
> +		ROD mkdir -p $mount_point
> +		ROD mount -t cgroup -o pids none $mount_point
> +	fi
> +	ROD mkdir -p $testpath
> +}
> +
> +case1()
> +{
> +	for i in `seq 1 $max`; do
> +		pids_task2 "$testpath/tasks" &
> +	done
> +
> +	sleep 1

The sleep is here to make sure all tasks are attached to the subgroup
right?

If so we should rather watch the "$testpath/tasks" file if it has enough
lines and sleep only if it doesn't.

Something as:

while [ $(cat "$testpath/tasks" | wc -l) -lt $max ]; do
	sleep 1
done

> +	# should return 0 because there is no limit
> +	pids_task "$testpath/tasks"
> +	ret=$?
> +
> +	killall -9 pids_task2
> +
> +	if [ "$ret" -eq "2" ]; then
> +		tst_resm TFAIL "fork failed unexpectedly"
> +	elif [ "$ret" -eq "0" ]; then
> +		tst_resm TPASS "fork didn't fail"
> +	else
> +		tst_resm TBROK "pids_task failed"
> +	fi
> +}
> +
> +case2()
> +{
> +	tmp=$((max - 1))
> +	tst_resm TINFO "limit the number of pid to $max"
> +	ROD echo $max > $testpath/pids.max
> +
> +	for i in `seq 1 $tmp`; do
> +		pids_task2 "$testpath/tasks" &
> +	done
> +
> +	sleep 1

Here as well.

> +	# should return 2 because the limit of pids is reached
> +	pids_task "$testpath/tasks"
> +	ret=$?
> +
> +	killall -9 pids_task2
> +
> +	if [ "$ret" -eq "2" ]; then
> +		tst_resm TPASS "fork failed as expected"
> +	elif [ "$ret" -eq "0" ]; then
> +		tst_resm TFAIL "fork didn't fail despite the limit"
> +	else
> +		tst_resm TBROK "pids_task failed"
> +	fi
> +}
> +
> +case3()
> +{
> +	tmp=$((max + 1))
> +	tst_resm TINFO "limit the number of avalaible pid to $tmp"
> +	ROD echo $tmp > $testpath/pids.max
> +
> +	tmp=$((max - 2))
> +	for i in `seq 1 $tmp`; do
> +		pids_task2 "$testpath/tasks" &
> +	done
> +
> +	sleep 1

And here as well. We should probably create a function to start N
pids_task2 processes and to wait until they are attached.

> +	pids_task "$testpath/tasks"
> +	ret=$?
> +
> +	killall -9 pids_task2
> +
> +	if [ "$ret" -eq "2" ]; then
> +		tst_resm TFAIL "fork failed unexpectedly"
> +	elif [ "$ret" -eq "0" ]; then
> +		tst_resm TPASS "fork worked as expected"
> +	else
> +		tst_resm TBROK "pids_task failed"
> +	fi
> +}
> +
> +case4()
> +{
> +	tst_resm TINFO "limit the number of avalaible pid to 0"
> +	ROD echo 0 > $testpath/pids.max
> +
> +	for i in `seq 1 $max`; do
> +		pids_task2 "$testpath/tasks" &
> +	done
> +
> +	sleep 1
> +
> +	# count the number of attached process
> +	cnt=0
> +	for job in `jobs -p`; do
> +		cnt=$((cnt + 1))
> +	done

Hmm, shouldn't cat $testpath/tasks | wc -l or jobs -p | wc -l do the
same job?

> +	killall -9 pids_task2
> +
> +	if [ "$cnt" -ne "$max" ]; then
> +		cnt=$((max - cnt))
> +		tst_resm TFAIL "$cnt process were not attached successfully"
> +	else
> +		tst_resm TPASS "all process were attached"
> +	fi
> +}
> +
> +case5()
> +{
> +	tst_resm TINFO "try to limit the number of avalaible pid to -1"
> +	echo -1 > $testpath/pids.max
> +
> +	if [ "$?" -eq "0" ]; then
> +		tst_resm TFAIL "managed to set the limit to -1"
> +	else
> +		tst_resm TPASS "didn't manage to set the limit to -1"
> +	fi
> +}
> +
> +setup
> +
> +if [ "$#" -ne "2" ]; then
> +	usage
> +else
> +	case$caseno
> +fi
> +
> +tst_exit
> diff --git a/testcases/kernel/controllers/pids/pids_task.c b/testcases/kernel/controllers/pids/pids_task.c
> new file mode 100644
> index 0000000..a470ccf
> --- /dev/null
> +++ b/testcases/kernel/controllers/pids/pids_task.c
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +/*
> +* Description:
> +* Write the current process in argv[1]
> +* and returns:
> +*	-> 2 if fork fails with EAGAIN,
> +*	-> 1 if there is another problem
> +*	-> 0 if everything worked
> +*/
> +
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +int main(int argc, char **argv)
> +{
> +	FILE *f;
> +	int newpid;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Usage: %s /cgroup/.../tasks\n", argv[0]);
> +		return 1;
> +	}
> +
> +	f = fopen(argv[1], "a");
> +	if (!f) {
> +		perror("fopen failed");
> +		return 1;
> +	}
> +
> +	fprintf(f, "%i\n", getpid());
> +	fclose(f);
> +
> +	newpid = fork();
> +	if (newpid == -1 && errno == EAGAIN)
> +		return 2;
> +	if (newpid == -1) {
> +		strerror(errno);
> +		return 1;
> +	}
> +	return 0;
> +}

Hi!

> +/*
> +* Description:
> +* Write the current process in argv[1],
> +* return 1 if there is a problem in attaching the process,
> +* otherwise do an infinite loop
> +*/
> +
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +int main(int argc, char **argv)
> +{
> +	FILE *f;
> +	int i;
> +
> +	i = 0;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Usage: %s /cgroup/.../tasks\n", argv[0]);
> +		return 1;
> +	}
> +
> +	f = fopen(argv[1], "a");
> +	if (!f) {
> +		perror("fopen failed");
> +		return 1;
> +	}
> +
> +	i = fprintf(f, "%i\n", getpid());
> +
> +	fclose(f);
> +	if (i < 0)
> +		return 1;
> +
> +	while (1) {
> +	}
> +	return 0;
> +}

Given that this process doesn't do anything else than attaching the
process to the cgroup, we can simplify it to call only the pause(2) and
attach the process to the cgroup in the main test script
(echo $! > $testpath/tasks). That way we do not have to wait until the
processes are attached in the main script and the code would be much
simpler.

-- 
Cyril Hrubis
chrubis@suse.cz
