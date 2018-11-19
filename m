From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Nov 2018 06:44:26 -0500 (EST)
Subject: [LTP] [PATCH 1/4] syscalls/migrate_pages02: convert to newlib
In-Reply-To: <766642984.70693100.1541602462622.JavaMail.zimbra@redhat.com>
References: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
 <CAEemH2fHHZ0-pVS+N7eVM6K8z=yTGhBHF1fKFOr516LyyyrZcQ@mail.gmail.com>
 <766642984.70693100.1541602462622.JavaMail.zimbra@redhat.com>
Message-ID: <620856561.76271418.1542627866232.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> ----- Original Message -----
> > Jan Stancek <jstancek@redhat.com> wrote:
> > 
> > >
> > >                 /* wait until child1 is ready on node1, then migrate and
> > >                  * signal to check current node */
> > > -               if (read(child1_ready[0], &tmp, 1) != 1)
> > > -                       tst_brkm(TBROK | TERRNO, NULL, "read #2 failed");
> > > +               TST_CHECKPOINT_WAIT(1);
> > >
> > 
> > Just curious why not start from 0? TST_CHECKPOINT_WAIT(0)
> 
> No special reason, I just had in my mind child1 and child2.
> 
> > 
> > -       tst_record_childstatus(NULL, child2);
> > > -       tst_record_childstatus(NULL, child1);
> > > +       SAFE_WAITPID(child1, &status, 0);
> > > +       SAFE_WAITPID(child2, &status, 0);
> > >
> > 
> > Maybe we could set &wstatus as a NULL? we don't inspect the status
> > information after its children terminates so why we store it into &status?
> 
> Good point, the status is not needed, since results from children
> are propagated automatically.
> 
> > Beside that two questions, patch set looks good to me.
> 
> Thanks for review,
> Jan

Pushed with changes from Li's comments.

Regards,
Jan

