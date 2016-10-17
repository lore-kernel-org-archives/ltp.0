From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Oct 2016 16:04:33 +0200
Subject: [LTP] [PATCH 1/1] controllers/cgroup_fj: fix longtime wait
 cgroup_fj_proc.
In-Reply-To: <227857597.6660541.1476432433891.JavaMail.zimbra@redhat.com>
References: <1476327906-8985-1-git-send-email-shuwang@redhat.com>
 <20161013142604.GA14300@rei>
 <227857597.6660541.1476432433891.JavaMail.zimbra@redhat.com>
Message-ID: <20161017140433.GA28490@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The case cgroup_fj_stress.sh creates many cgroup subgroups according to
> $1 (subgroup_num) and $2 (subgroup_depth) parameters, and if $3 
> attach_operation is 'each', it creates cgroup_fj_proc on the background
> attached to each subgroup.
> 
> The race here is to use 'killall -9 cgroup_fj_proc' right after background
> processes cgroup_fj_proc were created. And a few cgroup_fj_proc processes
> may not be killed, still running on the background, stalls the wait command.
> 
> reproducer:
> for i in `seq 10`
> do
>  sleep 10000 &
> done;
> killall -9 sleep;
> wait;                  #stall here

This reproducer should have been in the commit message. I've managed to
hit the problem with this once redirected the output from this script
into a file. Possibly printing output into stdout slowed it down enough
so that the issue haven't shown.

I was thinking if it's safe to use variable to store the pids, since in the
each case we fork fair amount of pids (it tops at ~1000) and there is a
limit on the command line argument lenght.

For our case it should suffice, even when counting 10 characters to
store pid and number we have string that is ~10000 chars long, that is
still ~100x times less than usuall limit on the number of pids.

It may still break if someone really wants to stress a machine with a
large amount of memory though. If you pass a large enough parameters to
the script, it will run probably for a day or two then may fail to kill
the processes because the kill command line was too long. So maybe it
would be better to store these into a file, but that may slow down the
test significantly, which should be avoided as well.


-- 
Cyril Hrubis
chrubis@suse.cz
