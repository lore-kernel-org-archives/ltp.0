From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 21:23:49 +0800
Subject: [LTP] [PATCH v2 5/5] Use SAFE_CMD()
In-Reply-To: <20200330124338.6764-6-pvorel@suse.cz>
References: <20200330124338.6764-1-pvorel@suse.cz>
 <20200330124338.6764-6-pvorel@suse.cz>
Message-ID: <CAEemH2dQfpn9mEBY=CFfVj_8dLETD7zh4=j3KP-bt95m_CCBxg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 30, 2020 at 8:43 PM Petr Vorel <pvorel@suse.cz> wrote:

> Reviewed-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/test-writing-guidelines.txt                 |  4 ++--
>  include/tst_safe_macros.h                       |  5 ++---
>  testcases/kernel/syscalls/add_key/add_key05.c   | 14 ++++----------
>  testcases/kernel/syscalls/quotactl/quotactl01.c | 11 ++---------
>  testcases/kernel/syscalls/quotactl/quotactl06.c |  9 +--------
>  5 files changed, 11 insertions(+), 32 deletions(-)
>
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 6f1eee490..75c2e517a 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1283,8 +1283,8 @@ return value is '255' if 'execvp()' failed with
> 'ENOENT' and '254' otherwise.
>  'stdout_path' and 'stderr_path' determine where to redirect the program
>  stdout and stderr I/O streams.
>
> -The 'SAFE_CMD()' macro can be used automatic handling non zero exits
> (exits
> -with 'TBROK') or 'ENOENT' (exits with 'TCONF').
> +The 'SAFE_CMD()' macro can be used automatic handling non-zero exits
> (exits
> +with 'TBROK') and 'ENOENT' (exits with 'TCONF').
>
>  .Example
>  [source,c]
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 38eb67d1d..bcd4b9c9e 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -540,9 +540,8 @@ void safe_cmd(const char *file, const int lineno,
> const char *const argv[],
>  {
>         int rval;
>
> -       switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path,
> -                                   TST_RUN_CMD_PASS_EXIT_VAL |
> -                                   TST_RUN_CMD_CHECK_CMD))) {
> +       switch ((rval = tst_cmd(argv, stdout_path, stderr_path,
> TST_CMD_PASS_RETVAL
> +                                                       |
> TST_CMD_CHECK_CMD))) {
>

Oh, you did the renaming in patch 5/5, but pity that the
TST_CMD_TCONF_ON_MISSING still not being used:). I guess this modification
should belong to patch4/5.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/6433524c/attachment.htm>
