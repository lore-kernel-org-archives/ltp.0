From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 09:36:23 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <20160608131515.GA27367@rei.lan>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
 <20160608123056.GA26573@rei.lan>
 <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
 <20160608131515.GA27367@rei.lan>
Message-ID: <1570517895.4619774.1465392983796.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 8 June, 2016 3:15:15 PM
> Subject: Re: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
> 
> Hi!
> > > The cleanup_ipc() is intended to be executed just before the main pid
> > > exits since it unlinks the shm file.
> > 
> > So, if we fail a SAFE macro somewhere in lib/tst_test.c,
> > I don't see we ever call cleanup_ipc().
> > 
> > tst_run_tcases
> >  SAFE_WAITPID(test_pid, &status, 0);
> >   tst_brkm
> >    tst_brkm_
> >     tst_brk_
> >      tst_vbrk_
> >       exit
> > 
> > > If child TBROKs it's catched in the
> > > check_child_status() in the parent, tst_brk() is called which will call
> > > the cleanup_ipc().
> > 
> > Not anymore. After this patch the only place that now calls
> > cleanup_ipc() is do_exit().
> 
> Ah, right, that is since what was previously main_pid has been split
> into the library process and main test process.
> 
> Indeed the cleanup_ipc() should be called from the library in the
> tst_vbrk_().
...
> Looks good to me, acked.

Pushed.

Regards,
Jan
