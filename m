From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 01:54:35 +0100
Subject: [LTP] [PATCH] syscalls: epoll_pwait01: Work around a race
In-Reply-To: <20210112132911.4031-1-chrubis@suse.cz>
References: <20210112132911.4031-1-chrubis@suse.cz>
Message-ID: <X/5Ey68D0T8oYInJ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> There was a race that would manifest on slower machines.

> The call to epoll_pwait() could time out before the child has chance to
> run, and that would cause the signal to be sent to the parent when it
> was already sleeping in wait().

> Ideally the whole test should be rewritten into new library and fixed
> properly, however as we are just before a release this is an attempt for
> a minimal fix.

> The logic in the test is changed so that:

> - epoll_wait() sleeps indefinitely
> - the child:
>   - waits for the parent to get asleep
>   - sends the signal
>   - sleeps
>   - writes to the pipe

> This causes the child to actually run, while the parent is blocked in
> the epoll_wait(), which greatly increases the changes of the signal
> arriving at the right time.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

> Fixes: #765

Kind regards,
Petr
