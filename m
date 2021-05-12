From: Li Wang <liwang@redhat.com>
Date: Wed, 12 May 2021 17:49:11 +0800
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
Message-ID: <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

On Tue, May 11, 2021 at 1:52 PM Joerg Vehlow <lkml@jv-coder.de> wrote:
>
> Hi Li,
>
> first of all thanks for fixing my patchset and getting it merged.
>
> On 5/8/2021 7:51 AM, Li Wang wrote:
> > We have to guarantee _tst_kill_test alive for a while to check if
> > the target test eixst or not, so ignore SIGINT in _tst_kill_test
> > is necessary, otherwise it will be stopped by the SIGINT sending
> > by itself.
> >
> > The timeout03.sh verify this mechanism proccess well in output:
> >
> >    timeout03 1 TBROK: Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> >    timeout03 1 TBROK: test interrupted or timed out
> >    timeout03 1 TPASS: test run cleanup after timeout
> >    timeout03 1 TINFO: Test is still running, waiting 10s
> >    timeout03 1 TINFO: Test is still running, waiting 9s
> >    timeout03 1 TINFO: Test is still running, waiting 8s
> >    timeout03 1 TINFO: Test is still running, waiting 7s
> >    timeout03 1 TINFO: Test is still running, waiting 6s
> >    timeout03 1 TINFO: Test is still running, waiting 5s
> >    timeout03 1 TINFO: Test is still running, waiting 4s
> >    timeout03 1 TINFO: Test is still running, waiting 3s
> >    timeout03 1 TINFO: Test is still running, waiting 2s
> >    timeout03 1 TINFO: Test is still running, waiting 1s
> >    timeout03 1 TBROK: Test still running, sending SIGKILL
> >    Killed
> At first I did bot understand the problem you found, because I tried
> with dash, busybox sh and zsh.
> All three shells had no problem here. But then I tried with bash and it
> failed.
>
> I wonder if this is a bug in bash or in the other shells. I guess
> sending the signal to the whole
> process group should also send it to the process running _tst_kill_test.
>
> I did some digging into this while writing this (see conclusion below
> for results only):
> 1. All shells have their own implementation of kill (compare <SHELL> -c
> kill with /usr/bin kill)
> 2. When replacing "just" kill in the script with /usr/bin/kill, it still
> only fails in bash.
> 3. zsh seems to ignore SIGINT, but it can be caught using trap. busybox
> sh, and dash can't even get it when trapped
> 4. zsh disables SIGINT by callling "trap '' INT" internally somehow.
> When resetting SIGINT to default behavior, it is the same as bash.
>
> For zsh this seems to be default behavior for background processes,
> probably to prevent keyboard interruption by CTRL+C:
> zsh -c "trap&"
> trap -- '' INT
> trap -- '' QUIT
>
> zsh -c "trap"
> # No output
>
>
>
> To conclude:
> - bash does not seem to care about SIGINT delivery to background
> processes, but can be blocked using trap
> - zsh ignores SIGINT for background processes by default, but can be
> allowed using trap
> - dash and busybox sh ignore the signal to background processes, and
> this cannot be changed with trap
>
> I tried with the following snippets:
> <SHELL> -c 'trap "echo trap;" INT; (sleep 2; echo end sub) & sleep 1;
> kill -INT -$$; echo end main'
> <SHELL> -c 'trap "echo trap;" INT; (trap - SIGINT sleep 2; echo end sub)
> & sleep 1; kill -INT -$$; echo end main'
> <SHELL> -c 'trap "echo trap;" INT; (trap "exit" SIGINT sleep 2; echo end
> sub) & sleep 1; kill -INT -$$; echo end main'
>

Thanks for the demos above, it shows the difference clearly.

> SIGINT handling for child processes is strange. This might have some
> implication for the shell tests,
> because it is possible, that SIGINT is not delivered to all processes
> and some may reside as orphans.
> Since this can happen only in case of timeouts, I guess there is no real
> Problem.

Yes.

Looks like the behaviors on signal 'SIGINT' are not unify in background
processes handling for different SHELL. So as you said that using SIGINT
seems NOT a good idea to stop the process in timeout.

>
> A possible fix could be using SIGTERM instead of SIGINT. This signal
> does not seem to have some "intelligent" handling for background processes.

I agree. Can you make a patch to replace that INT?

(and this is only a timeout issue, so patch merging may be delayed due
to LTP new release)

> I do not know why LTP used SIGINT in the first place. My first thought
> would have been to use SIGTERM.  It is the way to "politely ask
> processes to terminate"

Yes, but that not strange to me, the possible reason is just to
stop(ctrl ^c) the LTP test manually for debugging, so we went
too far for using SIGINT but forget the original purpose :).

-- 
Regards,
Li Wang

