From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 May 2019 09:49:23 -0400 (EDT)
Subject: [LTP] [PATCH] shmctl01: don't use hardcoded index == 0 for
 SHM_STAT test
In-Reply-To: <20190521095833.GA12205@rei>
References: <a5e65ca65d88177d9142cbd2d5a3ddf5dda174b5.1558379215.git.jstancek@redhat.com>
 <20190521095833.GA12205@rei>
Message-ID: <224303782.23845756.1558446563195.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > +static void func_sstat_setup(void)
> > +{
> > +	struct shm_info tmp;
> > +	int ret;
> > +
> > +	ret = shmctl(shm_id_1, SHM_INFO, (void *)&tmp);
> > +	if (ret < 0)
> > +		tst_resm(TFAIL|TERRNO, "shmctl(SHM_INFO)");
> 
> I wonder if it makes sense to continue here if shmctl() has failed,
> maybe we should do tst_brkm(TBROK ...) instead.

It is 'setup phase', but it also is kind-of test for shmctl() as well.
We don't risk much if we continue, worst case is we get one more fail.

@Petr: Do you have any preference?

> 
> Otherwise it looks good, acked.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
