From: Li Wang <liwang@redhat.com>
Date: Thu, 3 Sep 2020 17:10:29 +0800
Subject: [LTP] [PATCH 3/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <aabe6b47c9387e5ef3fc5b2a559295b72adc3c67.1599115178.git.viresh.kumar@linaro.org>
References: <728ce5d6b7e0f3eba8015c078bfc23ec144ce1c2.1599115178.git.viresh.kumar@linaro.org>
 <aabe6b47c9387e5ef3fc5b2a559295b72adc3c67.1599115178.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2cHo=sS8b26988UmruGiK=63Zuaj7+qSM=qjuz+Wh9nnw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 3, 2020 at 2:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> select() returns a positive value on success if timeout hasn't happened,
> else returns 0. Check that and send some data to the write file
> descriptor for the same.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> Cyril,
>
> Is this what you were looking for ? I am not sure why, but the last
> test (with named pipe) times out all the time.
> ---
>  testcases/kernel/syscalls/select/select01.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/select/select01.c
> b/testcases/kernel/syscalls/select/select01.c
> index 4367e7f3af3f..b3dcf1fff6f3 100644
> --- a/testcases/kernel/syscalls/select/select01.c
> +++ b/testcases/kernel/syscalls/select/select01.c
> @@ -25,24 +25,31 @@ static struct select_info {
>         int nfds;
>         fd_set *readfds;
>         fd_set *writefds;
> +       int *writefd;
>  } tests[] = {
> -       {4, &readfds_reg, NULL},
> -       {5, &readfds_pipe, &writefds_pipe},
> -       {5, &readfds_npipe, &writefds_npipe},
> +       {4, &readfds_reg, NULL, NULL},
> +       {5, &readfds_pipe, &writefds_pipe, &fds_pipe[1]},
> +       {5, &readfds_npipe, &writefds_npipe, &fd_npipe},
>

The 'nfds' should be equal to 'fd + 1', otherwise, it gets timeout as you
mentioned above.

  {7, &readfds_npipe, &writefds_npipe, &fd_npipe}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200903/8305fd38/attachment-0001.htm>
