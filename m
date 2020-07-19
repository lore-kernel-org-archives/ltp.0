From: Li Wang <liwang@redhat.com>
Date: Sun, 19 Jul 2020 17:50:47 +0800
Subject: [LTP] [PATCH 7/9] syscalls/ipc: Add shmctl07 test
In-Reply-To: <20200717163453.9587-8-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-8-chrubis@suse.cz>
Message-ID: <CAEemH2dJhxobkJtemb8sxx0cc9gfmVc+fq=ZNE0LfKWTdiMuoA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Jul 18, 2020 at 12:35 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> +
> +static void verify_shmlock(void)
> +{
> +       struct shmid_ds ds;
> +
> +       TEST(shmctl(shm_id, SHM_LOCK, NULL));
> +
> +       if (TST_RET != 0)
> +               tst_res(TFAIL | TTERRNO, "shmctl(%i, SHM_LOCK, NULL)",
> shm_id);
> +       else
> +               tst_res(TPASS, "shmctl(%i, SHM_LOCK, NULL)", shm_id);
> +
> +
> +       SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
> +
> +       if (ds.shm_perm.mode & SHM_LOCKED)
> +               tst_res(TPASS, "SMH_LOCKED bit is on in shm_perm.mode");
> +       else
> +               tst_res(TFAIL, "SHM_LOCKED bit is off in shm_perm.mode");
> +
> +       TEST(shmctl(shm_id, SHM_UNLOCK, NULL));
> +
> +       if (TST_RET != 0)
> +               tst_res(TFAIL | TTERRNO, "shmctl(%i, SHM_UNLOCK, NULL)",
> shm_id);
> +       else
> +               tst_res(TPASS, "shmctl(%i, SHM_UNLOCK, NULL)", shm_id);
> +
>

Shouldn't we do update 'ds' before checking the ds.shm_perm.mode?

--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
@@ -42,10 +42,11 @@ static void verify_shmlock(void)
        else
                tst_res(TPASS, "shmctl(%i, SHM_UNLOCK, NULL)", shm_id);

+       SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
        if (ds.shm_perm.mode & SHM_LOCKED)
-               tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
-       else
                tst_res(TFAIL, "SMH_LOCKED bit is on in shm_perm.mode");
+       else
+               tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
 }



> +       if (ds.shm_perm.mode & SHM_LOCKED)
> +               tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
>

And in this branch, the status should be "on" but not "off".



> +       else
> +               tst_res(TFAIL, "SMH_LOCKED bit is on in shm_perm.mode");
> +}
> +
> +static void setup(void)
> +{
> +       shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
> +}
> +
> +static void cleanup(void)
> +{
> +       if (shm_id >= 0)
> +               SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .test_all = verify_shmlock,
> +};
> --
> 2.26.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200719/7f32d3a4/attachment.htm>
