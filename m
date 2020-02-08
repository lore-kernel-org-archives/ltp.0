From: Li Wang <liwang@redhat.com>
Date: Sat, 8 Feb 2020 14:35:54 +0800
Subject: [LTP] [PATCH v2 1/3] Redesign TST_RETRY_FUNC()
In-Reply-To: <20200207112236.16462-1-mdoucha@suse.cz>
References: <20200207112236.16462-1-mdoucha@suse.cz>
Message-ID: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

On Fri, Feb 7, 2020 at 7:22 PM Martin Doucha <mdoucha@suse.cz> wrote:

> The TST_RETRY_FUNC() macro requires a single return value that'll be
> considered
> success. This cannot be used with system calls that e.g. return a new file
> descriptor because the success value is somewhat unpredictable.
>
> Redesign TST_RETRY_FUNC() to accept arbitrary macro/function ECHCK as the
> second
> parameter for validating the FUNC return value.
> - The loop will end succesfully if ECHCK(ret) evaluates to non-zero.
> - The loop will fall through on timeout instead of calling tst_brk().
> - errno will be cleared before every FUNC call.
> - Add standard check macros for the most common call conventions:
>   - TST_RETVAL_EQ0(x) - x == 0
>   - TST_RETVAL_NOTNULL(x) - x != 0 or x != NULL
>   - TST_RETVAL_GE0(x) - x >= 0


Nice to see this enhancement! Few comments as below:

1. We need to update the doc/test-writing-guidelines.txt too.

2. Maybe better to let the shell version is consistent with this new?

3. I remember there were discussions to support enabling infinite loop
in TST_RETRY_FUNC, but not sure if it is possible to add in this patch, or
we can do that after your patch merged.
http://lists.linux.it/pipermail/ltp/2019-October/013896.html

...
>         sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(),
> defunct_tid);
> -       TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK), -1, 15);
> +       ret = TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK),
> +               CHECK_ENOENT, 15);
>

The test total timeout is set to 20 seconds, here reserve 15 seconds is too
much for the macro looping because doing exponential backoff in
15secs(1us+2us+4us+..) actually larger than the 20secs. So I suggest
raising the tst_test.timeout at the same time or set a smaller value to
MAX_DELAY.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200208/6c9f4ea9/attachment.htm>
