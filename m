From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Mar 2019 17:44:24 -0400 (EDT)
Subject: [LTP] [PATCH v4] mm: rewrite mtest01 with new API
In-Reply-To: <CAEemH2fROC2pVwKreLfkHiBD6nZatrCFnVHh5e25Cv3smRzrdw@mail.gmail.com>
References: <CAEemH2cKD7Pxa9asmRiLO6N8ZJG6R=-q1YArhJ2JQFgGBBCESg@mail.gmail.com>
 <c3f11669ed0fd7a5cf14c2d5e4b977913be0e119.1552477010.git.jstancek@redhat.com>
 <CAEemH2fROC2pVwKreLfkHiBD6nZatrCFnVHh5e25Cv3smRzrdw@mail.gmail.com>
Message-ID: <238926294.9466692.1552686264198.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> On Wed, Mar 13, 2019 at 7:48 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > From: Li Wang <liwang@redhat.com>
> >
> >  Test issue:
> >    mtest01 start many children to alloc chunck of memory and do write
> >    page(with -w option), but occasionally some children were killed by
> >    oom-killer and exit with SIGCHLD signal sending. After the parent
> >    reciving this SIGCHLD signal it will report FAIL as a test result.
> >
> >    It seems not a real kernel bug if something just like that, it's
> >    trying to use 80% of memory and swap. Once it uses most of memory,
> >    system starts swapping, but the test is likely consuming memory at
> >    greater rate than kswapd can provide, which eventually triggers OOM.
> >
> >    ---- FAIL LOG ----
> >    mtest01     0  TINFO  :  Total memory already used on system = 1027392
> > kbytes
> >    mtest01     0  TINFO  :  Total memory used needed to reach maximum =
> > 12715520 kbytes
> >    mtest01     0  TINFO  :  Filling up 80% of ram which is 11688128 kbytes
> >    mtest01     1  TFAIL  :  mtest01.c:314: child process exited
> > unexpectedly
> >    -------------------
> >
> >  Rewrite changes:
> >    To make mtest01 more easier to understand, I just rewrite it into
> >    LTP new API and make a little changes in children behavior.
> >
> >    * decrease the pressure to 80% of free memory for testing
> >    * drop the signal SIGCHLD action becasue new API help to
> > check_child_status
> >    * make child pause itself after finishing their memory
> > allocating/writing
> >    * parent sends SIGCONT to make children continue and exit
> >    * use TST_PROCESS_STATE_WAIT to wait child changes to 'T' state
> >    * involve ALLOC_THRESHOLD to rework same code in defines
> >    * to make mtest01 support running with -i N > 1
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> > Li,
> >
> > I'm posting v4 because I'm proposing also couple other small changes.
> > Changes in v4:
> > - fix -b parameter, it was ignored, because maxpercent is always non-zero
> >   Now, if -b is set, then maxpercent is ignored.
> > - remove casts to unsigned long long, use literal with ULL suffix
> > - pid_count renamed to children_done, because pid_count vs. pid_cntr was
> > confusing
> > - original_maxbytes dropped, instead alloc_maxbytes remains unchanged in
> > mem_test()
> > - do_write_page renamed to do_write_mem, since we write more than single
> > page
> > - do_write_mem loop now increases offset by page size to make it slightly
> > faster
> > - bytecount initialized to 0 in child_loop_alloc()
> > - info messages expanded to show some timestamp (remaining time)
> > - PASS/FAIL messages for do_write=0 and do_write=1 consolidated to single
> > one
> > - child creation loop in mem_test() tweaked:
> >   - child_loop_alloc() called directly from loop
> >   - pid_cntr incremented and used as index to pid_list array, 'i' variable
> > not used
> >   - while condition "((pid != 0)" removed, it's always true
> > - sleep reduced to 100ms
> > - "while (pid_list[i] > 0)" replaced with for loop, since we know exactly
> > how many
> >   children we spawned. memset in setup dropped.
> >
> 
> I'm OK with these improvements, patch v4 looks quite good to me:).

I tested it on s390 too and pushed.

Thanks,
Jan
