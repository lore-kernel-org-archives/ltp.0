From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Jan 2018 06:26:13 -0500 (EST)
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2ep93OYxwXbj_fwdQDiFhCBaKd3Aj2nrt1k4uim+RBRDQ@mail.gmail.com>
References: <20171220113323.GD6688@rei> <20180109181745.GA11221@rei.lan>
 <1073451511.4987996.1515523657228.JavaMail.zimbra@redhat.com>
 <CAEemH2ep93OYxwXbj_fwdQDiFhCBaKd3Aj2nrt1k4uim+RBRDQ@mail.gmail.com>
Message-ID: <977653471.5142457.1515583573139.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, Jan 10, 2018 at 2:47 AM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> >
> > ----- Original Message -----
> > > Hi!
> > > This is just a reminder that we should start working on the January
> > > stable release.
> > >
> > > I see that we included the meltdown test which I guess was one of the
> > > important enough patches to be included.
> > >
> > > Anything else that should be taken in before we freeze the git?
> > >
> > > I've did some preliminary testing (compiling and runnign LTP on a few
> > > selected distros) and haven't found any big issues so far, so it looks
> > > like this may as well be smoothest release ever (fingers crossed).
> >
> > I ran a test couple days ago with snapshot from 20180103 on RHEL6.2/6.9
> > and RHEL7.5(beta) across i386/x86_64/ppc64(le)/s390x. I'm planning
> > to try also some recent upstream kernel, but as you said so far
> > it looks good.
> >
> 
> ​I ran LTP on the upstream kernel-4.15-rc6 across x86_64/ppc64(le)/s390x​,
> and catch some failures as below, ​but currently I haven't get a chance to
> look into the detail, just post here.​
> 
> 
> migrate_pages02   FAIL  x86_64
> ------------------------------
> migrate_pages02    0  TINFO  :  pid(15539) migrate pid 0 to node -> 0
> migrate_pages02    9  TPASS  :  pid(15539) addr 0x194f840 is on expected
> node: 0
> migrate_pages02   10  TFAIL  :  migrate_pages02.c:165: pid(15539) addr
> 0x194f840 not on expected node: 0 , expected 1
> migrate_pages02    0  TINFO  :  mem_stats pid: 15539, node: 1
> migrate_pages02    0  TINFO  :  Node id: 1, size: 2044157952, free:
> 1439322112
> migrate_pages02    0  TINFO  :  pid(15535) migrate pid 15539 to node -> 1
> migrate_pages02    9  TFAIL  :  migrate_pages02.c:129: migrate_pages
> failed ret: -1, : errno=EPERM(1): Operation not permitted
> migrate_pages02    0  TINFO  :  mem_stats pid: 15539, node: 1
> migrate_pages02    0  TINFO  :  Node id: 1, size: 2044157952, free:
> 1439358976
> migrate_pages02   10  TFAIL  :  migrate_pages02.c:301: child returns 256

numactl -H output could be helpful here.

> 
> 
> 
> msgctl11  FAIL  s390x
> ----------------------
> msgctl11    0  TINFO  :  Found 32000 available message queues
> msgctl11    0  TINFO  :  Using upto 32698 pids
> Fork failure in the second child of child group 682
> Fork failure in the first child of child group 9
> Fork failure in the first child of child group 191
> ...
> Fork failure in the first child of child group 1490
> Fork failure in the first child of child group 1432
> Fork failure in the second child of child group 1326
> Fork failure in the first child of child group 1327
> Fork failure in the first child of child group 638
> msgctl11    1  TFAIL  :  msgctl11.c:205: Fork failed (may be OK if under
> stress)

I have very old note this test spawns large number of children, so
I'm assuming this is not a regression.

> 
> 
> 
> shmt02/03/04/05/06/07/08/09/10   FAIL ppc64
> -------------------------------------------
> shmt02      1  TFAIL  :  shmt02.c:71: shmget Failed: shmid = -1, errno = 22
> shmt03      1  TFAIL  :  shmt03.c:72: shmget Failed: shmid = -1, errno = 22
> ...
> shmt10      2  TFAIL  :  shmt10.c:98: Error: shmid = -1
> 
> 
> 
> switch01  FAIL  ppc64(le)
> ------------------------
> endian_switch01    1  TFAIL  :  endian_switch01.c:127: Got SIGILL - test
> failed

This is new failure since 4.15-rc1:
  commit 727f13616c45caa72e4325c5027c1a8f41e745a9
  Author: Michael Ellerman <mpe@ellerman.id.au>
  Date:   Mon Oct 9 21:54:05 2017 +1100
    powerpc: Disable the fast-endian switch syscall by default

One way would be to check if "/boot/config-$(uname -r)" exists
and contains "CONFIG_PPC_FAST_ENDIAN_SWITCH=y".

Or perhaps we can try to make switch only (0x1ebe), check if that
returns ENOSYS. If not we run current do_le_switch(). I'll try
this latter approach.

Regards,
Jan
