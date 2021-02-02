From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Feb 2021 19:25:18 +0800
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <YBkBZskAIFpyUGPO@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz>
 <YBRroFhaxdqCLv2i@pevik> <YBRs9sySYXT6Bwlk@pevik>
 <CAEemH2foqS4=kTPJ50f2OZmnGU7wn4Kth0Onet-a6EX1J45-Bw@mail.gmail.com>
 <YBkBZskAIFpyUGPO@pevik>
Message-ID: <CAEemH2dKrgZLj08LQbtOQse757rEBoUCe2EnBniBaea3HpgdNw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, Feb 2, 2021 at 3:38 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > On Sat, Jan 30, 2021 at 4:16 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > > Hi,
>
> > > > > +   TST_TIMEOUT=$((dev_num*200))
> > > > Actually on heavy loaded machine this is not enough due BTRFS.
> > > > I can add something like dev_num*600 or even -1 (then previous commit
> > > would not
> > > > be needed, but IMHO still useful).
>
>
> > I personally think -1 is better.
> OK. In that case we might avoid now unneeded previous commit.
>
>
>
> > > And bad thing is that it breaks other zram tests, because the timer
> > > probably
> > > does not allow to run the cleanup:
>
> > > _tst_setup_timer()
> > > {
> > > ...
> > >         sleep $sec && tst_res TBROK "test killed, timeout! If you are
> > > running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9
> > > -$pid &
>
> > > I'm not sure if shell allow us to do it better. Maybe sent different
> > > signal than
> > > SIGKILL and define 'trap _tst_do_exit' for that signal?
>
>
> > Sounds practicable. I guess sending SIGINT could make more sense, since
> > sometimes we use CTRL+C stop test in debugging by manual, test should
> > do cleanup work for that behavior too.
> We have already SIGINT defined for main shell process:
> trap "tst_brk TBROK 'test interrupted'" INT
>
> so CTRL+C is covered. So maybe run first SIGINT and then SIGKILL for safety
> reasons?
>

I'm fine with using SIGINT + SIGKILL.

Or, maybe another choice is to catch a signal SIGTERM?  Once we
cancel the specified signal in KILL command, it will try with SIGTERM
by default, if the test process can not be terminated, then a SIGKILL
may be sent.

--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -22,6 +22,7 @@ export TST_LIB_LOADED=1

 # default trap function
 trap "tst_brk TBROK 'test interrupted'" INT
+trap "_tst_do_exit" TERM

 _tst_do_exit()
 {
@@ -459,7 +460,7 @@ _tst_setup_timer()

        tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"

-       sleep $sec && tst_res TBROK "test killed, timeout! If you are
running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9
-$pid &
+       sleep $sec && tst_res TBROK "test terminated, timeout! If you are
running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill --
-$pid &

        _tst_setup_timer_pid=$!


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210202/04007113/attachment.htm>
