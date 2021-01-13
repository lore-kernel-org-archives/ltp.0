From: Li Wang <liwang@redhat.com>
Date: Wed, 13 Jan 2021 16:41:34 +0800
Subject: [LTP] [PATCH] syscalls: epoll_pwait01: Work around a race
In-Reply-To: <20210112132911.4031-1-chrubis@suse.cz>
References: <20210112132911.4031-1-chrubis@suse.cz>
Message-ID: <CAEemH2evAAGHhyMm+qpXjWEK6uJi1zOhD0HT05VNOAzJR1VkJg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 12, 2021 at 9:28 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> There was a race that would manifest on slower machines.
>
> The call to epoll_pwait() could time out before the child has chance to
> run, and that would cause the signal to be sent to the parent when it
> was already sleeping in wait().
>
> Ideally the whole test should be rewritten into new library and fixed
> properly, however as we are just before a release this is an attempt for
> a minimal fix.
>
> The logic in the test is changed so that:
>
> - epoll_wait() sleeps indefinitely
> - the child:
>   - waits for the parent to get asleep
>   - sends the signal
>   - sleeps
>   - writes to the pipe
>
> This causes the child to actually run, while the parent is blocked in
> the epoll_wait(), which greatly increases the changes of the signal
> arriving at the right time.
>
> Fixes: #765
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210113/13811696/attachment-0001.htm>
