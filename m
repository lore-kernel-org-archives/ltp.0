From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2015 18:32:41 +0100
Subject: [LTP] [PATCH V4] controllers/pids: Add new testcases
In-Reply-To: <1448457738-8058-1-git-send-email-chnyda@suse.com>
References: <1448457738-8058-1-git-send-email-chnyda@suse.com>
Message-ID: <20151125173240.GE24599@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +start_pids_tasks2()
> +{
> +	nb=$1
> +	for i in `seq 1 $nb`; do
> +		pids_task2 &
> +		echo $! > $testpath/tasks
> +	done
> +
> +	while [ $(cat "$testpath/tasks" | wc -l) -lt $nb ]; do
> +		sleep 1
> +	done

We do not have to check that the task are attached now that we attach
the program to the cgroup tasks in the for loop here, right?

What we should do here now instead is to check that the tasks were
attached.  I.e.

if [ $(cat "$testpath/tasks" | wc -l) -ne $nb ]; then
	tst_resm TBROK "..."
fi

Or we should handle the return value from the echo, since now the
program would run on a backgound even when it couldn't be attached.

Either way the case4() could then be simplified to only run this
function and print TPASS if we do not TBROK here.

> +}
> +
> +case1()
> +{
> +	start_pids_tasks2 $max
> +
> +	# should return 0 because there is no limit
> +	pids_task1 "$testpath/tasks"
> +	ret=$?
> +
> +	killall -9 pids_task2
> +
> +	if [ "$ret" -eq "2" ]; then
> +		tst_resm TFAIL "fork failed unexpectedly"
> +	elif [ "$ret" -eq "0" ]; then
> +		tst_resm TPASS "fork didn't fail"
> +	else
> +		tst_resm TBROK "pids_task1 failed"
> +	fi
> +}
> +
> +case2()
> +{
> +	tmp=$((max - 1))
> +	tst_resm TINFO "limit the number of pid to $max"
> +	ROD echo $max > $testpath/pids.max
> +
> +	start_pids_tasks2 $tmp
> +
> +	# should return 2 because the limit of pids is reached
> +	pids_task1 "$testpath/tasks"
> +	ret=$?
> +
> +	killall -9 pids_task2
> +
> +	if [ "$ret" -eq "2" ]; then
> +		tst_resm TPASS "fork failed as expected"
> +	elif [ "$ret" -eq "0" ]; then
> +		tst_resm TFAIL "fork didn't fail despite the limit"
> +	else
> +		tst_resm TBROK "pids_task1 failed"
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
> +	start_pids_tasks2 $tmp
> +
> +	pids_task1 "$testpath/tasks"
> +	ret=$?
> +
> +	killall -9 pids_task2
> +
> +	if [ "$ret" -eq "2" ]; then
> +		tst_resm TFAIL "fork failed unexpectedly"
> +	elif [ "$ret" -eq "0" ]; then
> +		tst_resm TPASS "fork worked as expected"
> +	else
> +		tst_resm TBROK "pids_task1 failed"
> +	fi
> +}
> +
> +case4()
> +{
> +	tst_resm TINFO "limit the number of avalaible pid to 0"
> +	ROD echo 0 > $testpath/pids.max
> +
> +	start_pids_tasks2 $max
> +
> +	# count the number of attached process
> +	cnt=`jobs -p | wc -l`
> +
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
> diff --git a/testcases/kernel/controllers/pids/pids_task1.c b/testcases/kernel/controllers/pids/pids_task1.c
> new file mode 100644
> index 0000000..a470ccf
> --- /dev/null
> +++ b/testcases/kernel/controllers/pids/pids_task1.c
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
                ^
		Did you mean perror("fork()") ?
> +		return 1;
> +	}
> +	return 0;
> +}
> diff --git a/testcases/kernel/controllers/pids/pids_task2.c b/testcases/kernel/controllers/pids/pids_task2.c
> new file mode 100644
> index 0000000..130d619
> --- /dev/null
> +++ b/testcases/kernel/controllers/pids/pids_task2.c
> @@ -0,0 +1,30 @@
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
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdlib.h>

technically we only need to include the unistd.h here

> +int main(void)
> +{
> +	pause();
> +	return 0;
> +}
> -- 
> 2.1.4
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
