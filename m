From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Sep 2020 08:58:16 +0200
Subject: [LTP] [PATCH v2 09/10] syscalls/ipc: Add shmctl IPC_SET test
In-Reply-To: <4a6a5c02-1d93-de12-cdd5-811e6a3610ce@cn.fujitsu.com>
References: <20200907150157.23886-1-chrubis@suse.cz>
 <20200907150157.23886-10-chrubis@suse.cz>
 <4a6a5c02-1d93-de12-cdd5-811e6a3610ce@cn.fujitsu.com>
Message-ID: <20200908065816.GA2475@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> > index 409203db7..39b9ad78a 100644
> > --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> > +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> > @@ -42,10 +42,12 @@ static void verify_shmlock(void)
> >   	else
> >   		tst_res(TPASS, "shmctl(%i, SHM_UNLOCK, NULL)", shm_id);
> >   
> > +	SAFE_SHMCTL(shm_id, IPC_STAT, &ds);
> > +
> >   	if (ds.shm_perm.mode & SHM_LOCKED)
> > -		tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
> > -	else
> >   		tst_res(TFAIL, "SMH_LOCKED bit is on in shm_perm.mode");
> > +	else
> > +		tst_res(TPASS, "SHM_LOCKED bit is off in shm_perm.mode");
> >   }
> >   
> This change should belong to "syscalls/ipc: Add shmctl07 test" patch.

My bad I messed up, will fix that later on.

Anything else I missed there?

-- 
Cyril Hrubis
chrubis@suse.cz
