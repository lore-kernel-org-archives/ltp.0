From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Sep 2020 17:09:31 +0800
Subject: [LTP] [PATCH V9 2/2] syscalls/semtimedop: Add failure test for
 invalid timeout pointer
In-Reply-To: <a9e6d98c722a92d1981fcc2b7ddeba547195c40e.1597839878.git.viresh.kumar@linaro.org>
References: <b0d7642a89808c93e059beda06d8519361784686.1597839878.git.viresh.kumar@linaro.org>
 <a9e6d98c722a92d1981fcc2b7ddeba547195c40e.1597839878.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2eH6YnKXfVrAQmPGK5zj1x71f=gHZcDUN-QVjZ41F8_6A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

On Wed, Aug 19, 2020 at 8:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

>
> +       {1, &valid_sem_id, NULL, &sem_op_1, 0, 0, 0, BIGOPS, 1, &valid_to,
> E2BIG},
> +       {1, &noperm_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, &valid_to,
> EACCES},
> +       {1, &valid_sem_id, &faulty_buf, &sem_op_1, 0, 0, 0, NSOPS, 1,
> &valid_to, EFAULT},
> +       {1, &valid_sem_id, NULL, &sem_op_1, 0, 0, 0, 0, 1, &valid_to,
> EINVAL},
> +       {1, &bad_sem_id, NULL, &sem_op_1, 0, 0, 0, NSOPS, 1, &valid_to,
> EINVAL},
> +       {1, &valid_sem_id, NULL, &sem_op_max, 0, 0, 0, 1, 1, &valid_to,
> ERANGE},
> +       {1, &valid_sem_id, NULL, &sem_op_1, 0, -1, SEM_UNDO, 1, 1,
> &valid_to, EFBIG},
> +       {1, &valid_sem_id, NULL, &sem_op_1, 0, PSEMS + 1, SEM_UNDO, 1, 1,
> &valid_to, EFBIG},
> +       {1, &valid_sem_id, NULL, &sem_op_zero, 2, 2, IPC_NOWAIT, 1, 1,
> &valid_to, EAGAIN},
> +       {1, &valid_sem_id, NULL, &sem_op_negative, 2, 2, IPC_NOWAIT, 1, 0,
> &valid_to, EAGAIN},
> +       {0, &valid_sem_id, NULL, &sem_op_zero, 0, 0, SEM_UNDO, 1, 1,
> &valid_to, EAGAIN},
> +       {0, &valid_sem_id, NULL, &sem_op_negative, 0, 0, SEM_UNDO, 1, 0,
> &valid_to, EAGAIN},
>


> +       {0, &valid_sem_id, NULL, &sem_op_zero, 0, 0, SEM_UNDO, 1, 1,
> &invalid_to, EFAULT},
>

This '&invalid_to' can't be passed to the semtimedop(.., timeout) correctly,
because in that wrapper function call_semop(), you invoke
tst_ts_get(timeout)
to resolve an invalid address which will be caused a segmental fault
eventually.

Apart from this, the rest code looks good to me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200902/6745afb8/attachment-0001.htm>
