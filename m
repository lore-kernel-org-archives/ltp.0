From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Oct 2017 07:17:11 -0400 (EDT)
Subject: [LTP] [PATCH v2 04/15] lib/tst_test: Add .all_filesystems flag
In-Reply-To: <20171011111101.GB3527@rei>
References: <20171010123205.20147-1-chrubis@suse.cz>
 <20171010123205.20147-4-chrubis@suse.cz>
 <1573092724.28358902.1507711367946.JavaMail.zimbra@redhat.com>
 <20171011095445.GA3527@rei>
 <533977237.28372622.1507718314194.JavaMail.zimbra@redhat.com>
 <20171011111101.GB3527@rei>
Message-ID: <1439328594.28383859.1507720631224.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > > 3) fs_fill test is still quite verbose
> > > > 
> > > > # ./fs_fill > log2 2>&1
> > > > # du -h log2
> > > > 688K	log2
> > > > 
> > > > # grep Got log2
> > > > fs_fill.c:96: PASS: Got 5713 ENOSPC
> > > > fs_fill.c:96: PASS: Got 9 ENOSPC
> > > > fs_fill.c:96: PASS: Got 1709 ENOSPC
> > > > 
> > > > I'm running this on single CPU KVM guest, which is (presumably due to
> > > > caching
> > > > and host SSD) able to trigger ENOSPC many times in those 2 seconds.
> > > > 
> > > > I expect baremetal systems with many CPUs producing lot of output as
> > > > well,
> > > > because we start tst_fill_fs() in NR_CPU+2 threads.
> > > 
> > > Okay. What about rewriting the main loop to sleep in short intervals and
> > > check the ENOSCP counter and exit if reasonably large number was found.
> > 
> > There might be systems, where I/O is very slow and waiting for 100
> > ENOSPC might take too long. So, I think it should be both enospc_cnt
> > and total time as well. Whatever comes first, we exit. That should
> > limit max test output to ~10kB.
> 
> Sure so what about exitting either at 100 ENOSPC or after 1s in a case
> that we got at least one ENOSPC?

Sounds good to me.

Regards,
Jan
