From: Shu Wang <shuwang@redhat.com>
Date: Fri, 14 Oct 2016 04:07:13 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] controllers/cgroup_fj: fix longtime wait
 cgroup_fj_proc.
In-Reply-To: <20161013142604.GA14300@rei>
References: <1476327906-8985-1-git-send-email-shuwang@redhat.com>
 <20161013142604.GA14300@rei>
Message-ID: <227857597.6660541.1476432433891.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: shuwang@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Thursday, October 13, 2016 10:26:04 PM
> Subject: Re: [LTP] [PATCH 1/1] controllers/cgroup_fj: fix longtime wait cgroup_fj_proc.
> 
> Hi!
> > On some machines, when many cgroup_fj_proc created on the background,
> > killall may failed to find and kill them all as the processes are
> > just created and not ready. And that will cause the ltp testrun wait
> > forever. So changed to use kill -9 instead.
> 
> What is the exact race here? What exactly "just created and not ready"
> means here?

The case cgroup_fj_stress.sh creates many cgroup subgroups according to
$1 (subgroup_num) and $2 (subgroup_depth) parameters, and if $3 
attach_operation is 'each', it creates cgroup_fj_proc on the background
attached to each subgroup.

The race here is to use 'killall -9 cgroup_fj_proc' right after background
processes cgroup_fj_proc were created. And a few cgroup_fj_proc processes
may not be killed, still running on the background, stalls the wait command.

reproducer:
for i in `seq 10`
do
 sleep 10000 &
done;
killall -9 sleep;
wait;                  #stall here


> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
