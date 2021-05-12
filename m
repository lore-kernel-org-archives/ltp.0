From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 16:20:05 +0200
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
Message-ID: <YJvkFTUWS2iuZ00H@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

...
> > To conclude:
> > - bash does not seem to care about SIGINT delivery to background
> > processes, but can be blocked using trap
> > - zsh ignores SIGINT for background processes by default, but can be
> > allowed using trap
> > - dash and busybox sh ignore the signal to background processes, and
> > this cannot be changed with trap

> > I tried with the following snippets:
> > <SHELL> -c 'trap "echo trap;" INT; (sleep 2; echo end sub) & sleep 1;
> > kill -INT -$$; echo end main'
> > <SHELL> -c 'trap "echo trap;" INT; (trap - SIGINT sleep 2; echo end sub)
> > & sleep 1; kill -INT -$$; echo end main'
> > <SHELL> -c 'trap "echo trap;" INT; (trap "exit" SIGINT sleep 2; echo end
> > sub) & sleep 1; kill -INT -$$; echo end main'
FYI (you probably know it) SIGINT is a bashism, INT needs to be used.
$ kill -s SIGINT $$
dash: 2: kill: invalid signal number or name: SIGINT

> Thanks for the demos above, it shows the difference clearly.

> > SIGINT handling for child processes is strange. This might have some
> > implication for the shell tests,
> > because it is possible, that SIGINT is not delivered to all processes
> > and some may reside as orphans.
> > Since this can happen only in case of timeouts, I guess there is no real
> > Problem.

> Yes.

> Looks like the behaviors on signal 'SIGINT' are not unify in background
> processes handling for different SHELL. So as you said that using SIGINT
> seems NOT a good idea to stop the process in timeout.

Yes, trap looks to be having some portability issues [1] [2]

> > A possible fix could be using SIGTERM instead of SIGINT. This signal
> > does not seem to have some "intelligent" handling for background processes.

> I agree. Can you make a patch to replace that INT?

> (and this is only a timeout issue, so patch merging may be delayed due
> to LTP new release)

> > I do not know why LTP used SIGINT in the first place. My first thought
> > would have been to use SIGTERM.  It is the way to "politely ask
> > processes to terminate"

> Yes, but that not strange to me, the possible reason is just to
> stop(ctrl ^c) the LTP test manually for debugging, so we went
> too far for using SIGINT but forget the original purpose :).
I'm not the author, but yes, SIGINT was used for stopping with ctrl^c during
debugging.

FYI I tried to use both SIGINT and SIGTERM, but there was some problem.
But I guess it was my error. Please *add* SIGTERM (keep SIGINT).

Kind regards,
Petr

[1] https://unix.stackexchange.com/questions/240723/exit-trap-in-dash-vs-ksh-and-bash/240736#240736
[2] https://stackoverflow.com/questions/27012762/is-trap-exit-required-to-execute-in-case-of-sigint-or-sigterm-received
