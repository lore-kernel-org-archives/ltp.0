From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 May 2021 17:07:16 +0200
Subject: [LTP] [RFC] Shell API timeout sleep orphan processes
In-Reply-To: <651cb158-c640-e0b5-a2f2-4b77efcfa288@jv-coder.de>
References: <f781c0d8-6707-56ba-fa14-e0dbc1b645a1@jv-coder.de>
 <YJDvIcgdl8ae58YB@pevik>
 <5fdefbf3-2b4e-f44b-6cb2-c133ecf36975@jv-coder.de>
 <YJEKFLmcKvnHvlIV@pevik>
 <651cb158-c640-e0b5-a2f2-4b77efcfa288@jv-coder.de>
Message-ID: <YJFjJGTpxUNAMroo@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi Petr,

> > > > > The only way to fix this really portable I can think of is moving the
> > > > > timeout code (including the logic in _tst_kill_test) into c code. This way
> > > > > there would only be one binary, that can be killed flawlessly.
> > > > Maybe set -m would be enough. But sure, rewriting C is usually the best approach
> > > > for shell problems, we use quite a lot of C helpers for shell already.
> > > I will send the patch, if this introduces any new issues, we can still
> > > switch to a c based implementation.
> > Thank you!

> I guess I will not submit the fix with set -m...
> My colleague working testing on a new target just ran into a problem with
> out fix using set -m.
> For busybox sh, it only works, if a tty is allocated, otherwise it refuses
> to enable job monitor mode and the whole construct fails...
OK, C will be needed (unless anybody has an idea how to safely implement it in
shell).

> Since using the monitor mode only exploits the side effect, that it creates
> a process group and we already found a first issue, I think the only
> solution is switching to a c-based solution for the timeout stuff.
> Personally I like that it is written in shell script, but I see no other
> option to do it in pure shell. There is no builtin way, to create a process
> group and just redirecting the output of sleep to null does not seem to be a
> very good solution to me, because there would still be a lot of orphans
> around.

There will be git freeze in very soon, so I guess the fix won't make it to the
release (unless you have time to work on it next week).

Kind regards,
Petr
