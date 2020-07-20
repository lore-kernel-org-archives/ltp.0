From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jul 2020 10:26:58 +0800
Subject: [LTP] [PATCH 8/9] syscalls/ipc: Add shmctl IPC_SET test
In-Reply-To: <20200717163453.9587-9-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-9-chrubis@suse.cz>
Message-ID: <CAEemH2c6CKEgyUtk3B=Gm+GL4wH=3cR=h3TA2d7WHg1-0Vg5pg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Jul 18, 2020 at 12:36 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> +static void verify_shmset(void)
> +{
> +       struct shmid_ds ds;
> +       unsigned short old_mode;
> +       time_t old_ctime;
> +
> +       SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
> +
> +       old_mode = ds.shm_perm.mode;
> +       old_ctime = ds.shm_ctime;
> +
> +       sleep(1);
> +
> +       ds.shm_perm.mode &= ~0066;
> +
> +       if (test_ipc_set(&ds))
> +               return;
> +
> +       memset(&ds, 0, sizeof(ds));
> +       SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
> +       check_mode(&ds, old_mode & ~0066);
> +
> +       if (ds.shm_ctime - old_ctime > 10) {
>

Maybe we also need to consider a situation that timestamp is just as
previous value?
i.e.
    if (ds.shm_ctime - old_ctime > 10 || ds.shm_ctime - old_ctime == 0)

> +               tst_res(TFAIL, "shm_ctime not updated old %li new %li",
> +                       (long)old_ctime, (long)ds.shm_ctime);
> +       } else {
> +               tst_res(TPASS, "shm_ctime updated correctly diff=%li",
> +                       (long)(ds.shm_ctime - old_ctime));
> +       }
> +
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200720/3ac9f733/attachment.htm>
