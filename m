From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2015 19:45:56 +0100
Subject: [LTP] [RFC] Getting rid of cleanup parameter
In-Reply-To: <56437277.8020901@redhat.com>
References: <20151110141426.GG23947@rei>
 <138416734.6863400.1447237258306.JavaMail.zimbra@redhat.com>
 <20151111133042.GA26695@rei.lan> <56437277.8020901@redhat.com>
Message-ID: <20151111184555.GC19399@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This may be the case when a test spawns multiple children to do the
> testing in parallel, with the children creating shared resources of
> unpredictable names/references (so the cleanup cannot be done from
> the parent).
> 
> I currently cannot think of any such resource,
> 
>  * files can use tmpdir, removed recursively from parent
>  * spawned processes can be walked from the parent
>  * losetup-created devices can have a common prefix
>  * IPC shared resources can be pre-created by the parent
>    (or be found via a unique key or a dedicated unix user)
>  * linux namespaces die automatically with the children
>  * ...
> 
> The general pattern is that the parent is always able to somehow use
> an identifier common for all children or pre-create the resources for
> them, collecting a list to be used for cleanup.
> 
> However it would be good to keep the use case in mind for the future.

That is the same reasoning as I did. So I would go for disabling the
ability for cleanup function in child processes util we find that it's
necessary or that it fairly simplifies a solution to a given problem.

> Regarding tst_set_cleanup() - if it hooks the cleanup function into
> signal handlers as well, it will need to be called before sigaction
> setup in signal-testing tests. Nothing extraordinary, I guess, but
> still something to note.

Right, I do not expect it to be called anywhere else than beginning of
the setup fuction.

And we also have tst_sig() function that is able to install a cleanup
for unexpected signals that 99% of the time installs the common test
cleanup(). I guess that we should remove the tst_sig() in favor of the
tst_set_cleanup() as well. We would have to be able to tell the
tst_set_cleanup() not to install the the "poisoned" handler at least for
SIGCHLD.

Or we should simply install only handlers that actually make sense to
exit the test with TBROK. I find it silly that the LTP testcases break
when you change the terminal size while they are running and the test
exits because it does not expectet to get SIGWINCH.

On the other way as it is now we would catch situations where kernel
send wrong signal to the process. Not sure if that actually had
happened.

> About shell tests - maybe something similar would be useful, for
> consistency (same function name) as well as signal handling (trap)
> in shells that support it. Again - same signal handling limitations
> apply (if test re-defines trap, it may be an issue).

Actually this change would get us closer to the shell interface, since
the test.sh library currently has TST_CLEANUP variable that is evaluated
before the test exits. So if we add the tst_set_cleanup() function that
would do export TST_CLEANUP="$1" we will end up with the same interface.

The traps are not there at the moment but that would be just a few lines
of code.

-- 
Cyril Hrubis
chrubis@suse.cz
