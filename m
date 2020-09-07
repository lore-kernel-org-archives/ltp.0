From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Sep 2020 16:45:29 +0200
Subject: [LTP] [PATCH 7/9] syscalls/ipc: Add shmctl07 test
In-Reply-To: <CAEemH2dJhxobkJtemb8sxx0cc9gfmVc+fq=ZNE0LfKWTdiMuoA@mail.gmail.com>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-8-chrubis@suse.cz>
 <CAEemH2dJhxobkJtemb8sxx0cc9gfmVc+fq=ZNE0LfKWTdiMuoA@mail.gmail.com>
Message-ID: <20200907144529.GB10649@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Shouldn't we do update 'ds' before checking the ds.shm_perm.mode?
> 
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> @@ -42,10 +42,11 @@ static void verify_shmlock(void)
>         else
>                 tst_res(TPASS, "shmctl(%i, SHM_UNLOCK, NULL)", shm_id);
> 
> +       SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
>         if (ds.shm_perm.mode & SHM_LOCKED)
> -               tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
> -       else
>                 tst_res(TFAIL, "SMH_LOCKED bit is on in shm_perm.mode");
> +       else
> +               tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
>  }
> 
> 
> 
> > +       if (ds.shm_perm.mode & SHM_LOCKED)
> > +               tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
> >
> 
> And in this branch, the status should be "on" but not "off".

And also TFAIL.

All will be fixed in v2, thx for the review.

-- 
Cyril Hrubis
chrubis@suse.cz
