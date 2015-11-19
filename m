From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2015 15:49:42 +0100
Subject: [LTP] [PATCH v2] controllers/pids: Add new testcases
In-Reply-To: <1447337289-15226-1-git-send-email-chnyda@suse.com>
References: <1447337289-15226-1-git-send-email-chnyda@suse.com>
Message-ID: <20151119144941.GE28969@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/controllers/pids/pids.sh
> @@ -0,0 +1,109 @@
> +#!/bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2015 SUSE                                                    ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301   ##
> +## USA                                                                        ##
> +##                                                                            ##
> +## Author: Cedric Hnyda <chnyda@suse.com>                                     ##
> +##                                                                            ##
> +################################################################################
> +
> +# Usage
> +# ./pids.sh
> +#
> +# Description
> +#
> +# 1) Find if pids is mounted, if not mounted, pids will be mounted
> +# 2) Limit the number of pid avalaible and try to fork with pid_task
> +#

Can we do this a bit more versatile? I.e. pass the limit to test to the
pids.sh script and change the pids_task to expect failure after N - 1
forks?

I would like to test this with limit set to 1, 2, 10, 50 and make sure
that we can fork limit-1 tasks. That way we will do only one test in the
script and call the script several times instead.

And actually what happens when the limit is reached and we try to attach
process to it, does it fail too? And what happens when we set it to 0?
(these are candidates for subsequent tests)

> +export TCID="pids"
> +export TST_TOTAL=2
> +mounted=1
> +
> +. test.sh
> +
> +cleanup()
> +{
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
> +setup;
        ^
	Useless semicolon

> +tst_resm TINFO "Restrict the number of pid to 1"
> +ROD echo 1 > $testpath/pids.max
> +
> +pids_task "$testpath/tasks"
> +ret=$?
> +
> +if [ "$ret" -eq "2" ]; then
> +	tst_resm TPASS "fork failed as expected"
> +elif [ "$ret" -eq "0" ]; then
> +	tst_resm TFAIL "fork didn't fail despite the limit"
> +else
> +	tst_resm TBROK "failed to open $testpath/tasks"

Actually we may get here when the fork() failed unexpectedly as well.

It would be better to do just tst_resm TBROK "pids_task failed" here and
print more detailed description of the failure from the pids_task
instead.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
