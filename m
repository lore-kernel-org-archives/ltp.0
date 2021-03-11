From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Mar 2021 15:47:21 +0100
Subject: [LTP] [PATCH 6/7] tst_test.sh: Run cleanup also after test
 timeout
In-Reply-To: <YEofzk8nrVepc78j@yuki.lan>
References: <20210301220222.22705-1-pvorel@suse.cz>
 <20210301220222.22705-7-pvorel@suse.cz>
 <CAEemH2c2Bma-xXTcf+1M4CFVjM7ZQS36rV_6i9kJ6Es-19kghA@mail.gmail.com>
 <YD4RairzgAuyBn7S@pevik> <YEofzk8nrVepc78j@yuki.lan>
Message-ID: <YEoteW3o3A7eijkB@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Li,

> > > > +_tst_run_timer()

> > > Hmm, this name is not good than before, or rename to _tst_kill_timer_pid(),
> > > _tst_stop_timer()?

> > Good point. I slightly prefer _tst_stop_timer, but no hard feeling about it.

> Or _tst_kill_test()?
+1

> > > > +{
> > > > +       tst_res TBROK "test killed, timeout! If you are running on slow
> > > > machine, try exporting LTP_TIMEOUT_MUL > 1"
> > > > +       kill -INT -$pid
> > > > +       sleep 5
> > > > +       kill -KILL -$pid

> Maybe we should change the messages to reflect what is happening and
> maybe we should check if the test is still running before sending
> SIGKILL with kill -0 $pid?

> 	tst_res TBROK "Test timeouted, sending SIGINT, ...."
> 	kill -INT -$pid

> 	sleep 5

> 	if kill -0 $pid 2>&1 > /dev/null; then
> 		tst_res TBROK "Test still running, sending SIGKILL"
> 		kill -KILL -$pid
> 	fi

> We can also bussy loop wait for the process to terminate, e.g. loop 10
> times with sleep 1 in the body and break the loop if kill -0 $pid
> returns failure.
Busy loop wait 10 times + final -KILL make sense to me. I'm going to merge first
five commits and send v2 this + the last commit.

Kind regards,
Petr
