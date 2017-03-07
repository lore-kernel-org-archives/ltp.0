From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Mar 2017 09:41:35 -0500 (EST)
Subject: [LTP] [PATCH/RFC] sem_post/8-1: improve "child blocked on
 semaphore" detection
In-Reply-To: <20170307141656.GB8709@rei.lan>
References: <bb0386f4e3b165f3f1897824d02bdeedbcc4bdfb.1488541575.git.jstancek@redhat.com>
 <20170307141656.GB8709@rei.lan>
Message-ID: <1323115136.4453230.1488897695040.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 7 March, 2017 3:16:56 PM
> Subject: Re: [LTP] [PATCH/RFC] sem_post/8-1: improve "child blocked on semaphore" detection

<snip> 

> >  	c_3 = fork();
> >  	switch (c_3) {
> > @@ -204,7 +206,7 @@ int main(void)
> >  		usleep(100);
> >  		sem_getvalue(sem_1, &val);
> >  	} while (val != 0);
> > -	usleep(100);
> > +	tst_process_state_wait3(c_3, 'S', 2000);
> 
> So sem_1 semaphore is used just as a counter and we are fixing race
> before the children decrement its value and lock on the second
> semaphore, right?

Yes, because we can't query "sem" (Posix semaphore) directly
to see how many processes are waiting. This is possible only
in System V semaphores: semctl(GETNCNT).
 
> The approach here seems reasonable, acked.

<snip>

> > +int tst_process_state_wait3(pid_t pid, const char state,
> > +	unsigned long maxwait_ms)
> > +{
> > +	usleep(maxwait_ms * 1000);
> 
> return 0; here?
> 
> We don't handle it anyway but missing return would produce a warning...

Right, I'll fix that before push.

Thanks,
Jan

> 
> > +}
> > +#endif
> > --
> > 1.8.3.1
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
