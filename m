From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 15:49:44 +0100
Subject: [LTP] [PATCH v5 1/1] syscalls/mq_unlink: convert to use new
 test library API
In-Reply-To: <20161205143258.8102-1-pvorel@suse.cz>
References: <20161205143258.8102-1-pvorel@suse.cz>
Message-ID: <20161205144943.GI22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	pw = SAFE_GETPWNAM("nobody");
> I don't like hardwired constants, but nobody user name is used across whole
> codebase. I'd be happier to have some constant in lib (although it's unlikely
> one day we might want to allow user to choose their "nobody" user).

Yep, I've been thinking of adding uid_t tst_get_nobody_uid(void) or
uid_t tst_get_unprivileged_uid(void) and the same for gid_t or something
similar into the test library for some time. Haven't had time to do so
yet.

> > We may also run the test for nobody in a child process so
> > that we don't have to take care restoring the euid at the end of the
> > function.
> It's require to restore euid for other tests (to be running as root again). Or
> have I overlooked something?

If you fork() then call setuid() in the child, do the test and exit then
parent will still run under the same uid it has been started. No need to
resetore anything.

-- 
Cyril Hrubis
chrubis@suse.cz
