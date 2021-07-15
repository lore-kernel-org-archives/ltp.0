From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jul 2021 12:05:18 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: Fix running tests in a loop
In-Reply-To: <YO/e3wcY8oXyFCO5@pevik>
References: <20210714180840.160798-1-amir73il@gmail.com>
 <YO/e3wcY8oXyFCO5@pevik>
Message-ID: <CAOQ4uxj_vJVXTJex1W1cAJ_LQkbNqUnasuiUTsp=Bgrznm472A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 15, 2021 at 10:08 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > Both fanotify19 and fanotify18 leaked fds when run in a loop.
> > fanotify19 was not checking child process exit status correctly
> > which resulted in random failures.
>
> Thanks for a quick fix!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> FYI both fixes prolonged running for about 100% (comparing with runs on master
> which don't fail). Of course, that's not a problem at all, it's just interesting
> for me how simple closing of file descriptor can be expensive.
>

Nice observation! LTP is not the only test suite that observed this issue. See:
https://lore.kernel.org/linux-fsdevel/CAC-ggsFLmFpz5Y=-9MMLwxuO2LOS9rhpewDp_-u2hrT9J79ryg@mail.gmail.com/

In order to fix that issue we will need some LTP helpers to take care of closing
fanotify/inotify fds in batches for loop runs, which is kind of what
happened before
the fd leak fix only the batch was infinite...

Attached sample patch for fanotify18.
You will need to run some more experiments to see if it is worth it or not
and then if it is worth it, probably generalize the helpers.

Thanks,
Amir.




> Kind regards,
> Petr
>
> # time ./fanotify19 -i40
>
> Summary:
> passed   360
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> real    0m0,871s
> user    0m0,028s
> sys     0m0,116s
>
> vs.
>
> Summary:
> passed   360
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> real    0m0,387s
> user    0m0,016s
> sys     0m0,122s
>
> # time ./fanotify19 -i10
> Summary:
> passed   160
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> real    0m0,436s
> user    0m0,032s
> sys     0m0,128s
>
> vs.
>
> Summary:
> passed   160
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> real    0m0,876s
> user    0m0,052s
> sys     0m0,105s
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-fanotify-Closing-group-fd-in-batches.patch
Type: text/x-patch
Size: 3862 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210715/3b5dbd3e/attachment.bin>
