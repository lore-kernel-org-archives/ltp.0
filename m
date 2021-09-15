From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Sep 2021 01:01:28 +0200
Subject: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
In-Reply-To: <YUJ2XA7W3JPODyNC@pevik>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
Message-ID: <YUJ7SC/FoA8wTaf2@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, all,

> Hi Li, all,

[ Cc Cyril and Alexey ]

> > We'd better avoid using SIGINT for process terminating becuasue,
> > it has different behavoir on kind of shell.

> > From Joerg Vehlow's test:

> >  - bash does not seem to care about SIGINT delivery to background
> >    processes, but can be blocked using trap

> >  - zsh ignores SIGINT for background processes by default, but can be
> >    allowed using trap

> >  - dash and busybox sh ignore the signal to background processes, and
> >    this cannot be changed with trap

> > This patch cover the below situations:

> >  1. SIGINT (Ctrl^C) for terminating the main process and do cleanup
> >     correctly before a timeout

> >  2. Test finish normally and retrieves the _tst_timeout_process in the
> >     background via SIGTERM(sending by _tst_cleanup_timer)

> >  3. Test timed out occurs and _tst_kill_test sending SIGTERM to
> >     terminating all process, and the main process do cleanup work

> >  4. Test timed out occurs but still have process alive after _tst_kill_test
> >     sending SIGTERM, then sending SIGKILL to the whole group

> >  5. Test terminated by SIGTERM unexpectly (e.g. system shutdown or process
> >     manager) and do cleanup work as well

> > Co-authored-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Reviewed-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ...

> > +++ b/testcases/lib/tst_test.sh
> > @@ -21,7 +21,8 @@ export TST_LIB_LOADED=1
> >  . tst_security.sh

> >  # default trap function
> > -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> > +trap "tst_brk TBROK 'test interrupted'" INT
> > +trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

> FYI this commit (merged as 4a6b8a697 ("tst_test: using SIGTERM to terminate process"))
> broke net_stress_interface tests, particularly tst_require_cmds() call (which
> calls tst_brk TCONF:

> # ./if-addr-adddel.sh -c ifconfig
> if-addr-adddel 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> if-addr-adddel 1 TINFO: add local addr 10.0.0.2/24
> if-addr-adddel 1 TINFO: add local addr fd00:1:1:1::2/64
> if-addr-adddel 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> if-addr-adddel 1 TINFO: add remote addr 10.0.0.1/24
> if-addr-adddel 1 TINFO: add remote addr fd00:1:1:1::1/64
> if-addr-adddel 1 TINFO: Network config (local -- remote):
> if-addr-adddel 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> if-addr-adddel 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> if-addr-adddel 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> if-addr-adddel 1 TINFO: timeout per run is 0h 5m 0s
> if-addr-adddel 1 TCONF: 'ifconfig' not found
> => waits till timeout
> if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> if-addr-adddel 1 TWARN: test terminated

> Debugging it hangs in wait in _tst_cleanup_timer():

> kill -TERM $_tst_setup_timer_pid 2>/dev/null
> wait $_tst_setup_timer_pid 2>/dev/null

> because kill does not kill the test.

> The problem looks to be that unset actually does not work.
> trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

> It looks to be something setup specific, because I discovered this on SLES on
> both bash and dash. Running it on current Debian testing it works on both bash
> and dash. I checked shopt output on both, but don't see anything obvious. It
> must be something else.
OK, repeatedly running on Debian with dash I managed to get hang as well:

Here it does not even quit the test:

if-addr-adddel 1 TCONF: 'ifconfig' not found
if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
if-addr-adddel 1 TBROK: Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
if-addr-adddel 1 TWARN: test terminated

Maybe not only SIGINT, but even SIGTERM is not reliable to background process?
Minimal reproducible example, on Dash needs few runs to hang:

cat > debug.sh <<EOF
#!/bin/sh

TST_SETUP="setup"
TST_TESTFUNC="do_test"
. tst_test.sh

setup()
{
	tst_brk TCONF "quit now!"
}

do_test()
{
	tst_res TPASS "pass :)"
}

tst_run
EOF

# while true; do ./debug.sh; done

Kind regards,
Petr

> Kind regards,
> Petr

> >  _tst_do_exit()
> >  {
> > @@ -439,9 +440,9 @@ _tst_kill_test()
> >  {
> >  	local i=10

> > -	trap '' INT
> > -	tst_res TBROK "Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> > -	kill -INT -$pid
> > +	trap '' TERM
> > +	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> > +	kill -TERM -$pid
> >  	tst_sleep 100ms

> >  	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
