From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 May 2017 09:01:52 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <20170510122130.GD29838@rei.suse.de>
References: <20170509140458.26343-1-chrubis@suse.cz>
 <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
 <20170510122130.GD29838@rei.suse.de>
Message-ID: <1451716543.9633353.1494421312196.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > I'm still getting sporadic failures with 4.11 kernel. It's freshly
> > booted system, so I would expect fragmentation to be low:
> > 
> > # numactl -H; ./move_pages12
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22
> > node 0 size: 31963 MB
> > node 0 free: 31600 MB
> > node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23
> > node 1 size: 32251 MB
> > node 1 free: 31915 MB
> > node distances:
> > node   0   1
> >   0:  10  20
> >   1:  20  10
> > 
> > tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
> > move_pages12.c:184: INFO: Free RAM 65040204 kB
> > move_pages12.c:139: INFO: Allocating and freeing 2 hugepages on node 0
> > move_pages12.c:139: INFO: Allocating and freeing 2 hugepages on node 1
> > nodes: 0 1
> > move_pages12.c:87: FAIL: move_pages failed: ENOMEM
> 
> Hmm, reproduced here as well. One of the 100 runs failed for me as well.
> 
> I've looked at the code in mm/migrate.c but so far I could not spot a
> place where it could fail with ENOMEM (apart from very unlikely single
> page allocation which is used to store the parameters passed to the
> syscall).
> 
> If I comment out the memset() in the test main loop the failure does not
> seem to happen. So my guess is that the failure happens when we try to
> isolate a page that is in the process of teardown and we get the ENOMEM
> somewhere from the memory management internals and that it's OK to
> ignore this failure. But that is just a wild guess.

Here's end of strace log from my system:
  https://paste.fedoraproject.org/paste/gg8Lbjg8LI-YM5S6dS8Aol5M1UNdIGYhyRLivL9gydE=/raw

It also suggests that failure happened sometime during memset() call.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
