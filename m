From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 May 2016 05:02:23 -0400 (EDT)
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <20160523160257.GF25488@rei.lan>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan>
Message-ID: <1653845167.258778.1464080543100.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, ltp@lists.linux.it
> Sent: Monday, 23 May, 2016 6:02:57 PM
> Subject: Re: [LTP] [PATCH] memcg/functional: check several times if the process is killed
> 
> Hi!
> > On some systems it may take slightly more than one second
> > to kill the memcg_process. So let's check several times if the
> > process is alive.
> > 
> > Also removed sleep() before moving the process to the memory cgroup,
> > since this looks reduntant.
> > 
> > Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> > ---
> >  .../controllers/memcg/functional/memcg_lib.sh      |   14 ++++++++++----
> >  1 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > index 9b9b0fd..93c61a1 100755
> > --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > @@ -220,14 +220,20 @@ test_proc_kill()
> >  
> >  	$TEST_PATH/memcg_process $2 -s $3 &
> >  	pid=$!
> > -	sleep 1
> 
> This sleep sure is useless.

Isn't it there to make sure, that SIGUSR1 handler had time
to set up? (for example with single CPU and sched_child_runs_first == 0)

> 
> >  	echo $pid > tasks
> >  
> >  	kill -s USR1 $pid 2> /dev/null
> > -	sleep 1
> > -
> > -	ps -p $pid > /dev/null 2> /dev/null
> > -	if [ $? -ne 0 ]; then
> > +	pid_exists=1
> > +	for tpk_iter in $(seq 5); do
> > +	    if ! kill $pid 2> /dev/null; then
> > +		pid_exists=0
> > +		break
> > +	    fi
> > +	    sleep 1
> > +	done
> 
> This does no seem right to me. The original code send a SIGUSR1 signal
> to the memcg_process which caused it to allocate memory which supposedly
> provokes OOM to kill it. Hence the sleep 1 after the kill -s USR $pid.
> 
> Now this code hammers the memcg_process with SIGKILL instead.
> 
> As far as I can tell the right thing to do here is to wait with
> reasonable timeout for the memcg_process to become zombie and only kill
> it if that hasn't happened. Or did I miss something?
> 
> > +	if [ $pid_exists -eq 0 ]; then
> >  		wait $pid
> >  		if [ $? -eq 1 ]; then
> >  			result $FAIL "process $pid is killed by error"
> > --
> > 1.7.1
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
