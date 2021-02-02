From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 2 Feb 2021 08:38:14 +0100
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <CAEemH2foqS4=kTPJ50f2OZmnGU7wn4Kth0Onet-a6EX1J45-Bw@mail.gmail.com>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz> <YBRroFhaxdqCLv2i@pevik>
 <YBRs9sySYXT6Bwlk@pevik>
 <CAEemH2foqS4=kTPJ50f2OZmnGU7wn4Kth0Onet-a6EX1J45-Bw@mail.gmail.com>
Message-ID: <YBkBZskAIFpyUGPO@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On Sat, Jan 30, 2021 at 4:16 AM Petr Vorel <pvorel@suse.cz> wrote:

> > > Hi,

> > > > +   TST_TIMEOUT=$((dev_num*200))
> > > Actually on heavy loaded machine this is not enough due BTRFS.
> > > I can add something like dev_num*600 or even -1 (then previous commit
> > would not
> > > be needed, but IMHO still useful).


> I personally think -1 is better.
OK. In that case we might avoid now unneeded previous commit.



> > And bad thing is that it breaks other zram tests, because the timer
> > probably
> > does not allow to run the cleanup:

> > _tst_setup_timer()
> > {
> > ...
> >         sleep $sec && tst_res TBROK "test killed, timeout! If you are
> > running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9
> > -$pid &

> > I'm not sure if shell allow us to do it better. Maybe sent different
> > signal than
> > SIGKILL and define 'trap _tst_do_exit' for that signal?


> Sounds practicable. I guess sending SIGINT could make more sense, since
> sometimes we use CTRL+C stop test in debugging by manual, test should
> do cleanup work for that behavior too.
We have already SIGINT defined for main shell process:
trap "tst_brk TBROK 'test interrupted'" INT

so CTRL+C is covered. So maybe run first SIGINT and then SIGKILL for safety
reasons?

Kind regards,
Petr

diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
index 4fa1674cd..61a6fbcdd 100644
--- testcases/lib/tst_test.sh
+++ testcases/lib/tst_test.sh
@@ -459,7 +459,7 @@ _tst_setup_timer()
 
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
-	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
+	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && { kill -2 -$pid; sleep 5; kill -9 -$pid; } &
 
 	_tst_setup_timer_pid=$!
 }
