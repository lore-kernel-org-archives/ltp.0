From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Thu, 7 Apr 2016 10:07:51 +0000
Subject: [LTP] [PATCH] Check available memory to support embedded devices
In-Reply-To: <1024370333.16915329.1459580215038.JavaMail.zimbra@redhat.com>
References: <1458097275-2769-1-git-send-email-jcsistemas2001@gmail.com>
 <1423281604.10539234.1458206400762.JavaMail.zimbra@redhat.com>
 <AF04265A3FC2B144B9892F621A394E13EA3F8762@tethys>
 <FF335120-237D-434A-AC4D-D88A0B2DD0E2@smartmatic.com>
 <1714664694.15587378.1459340331690.JavaMail.zimbra@redhat.com>
 <AF04265A3FC2B144B9892F621A394E13EA409B66@tethys>
 <1024370333.16915329.1459580215038.JavaMail.zimbra@redhat.com>
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA436BA7@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Jan,

The patch version 2 for the test case 'getrusage03' was send to the list.

Thanks for your suggestions in the previous emails.=20

In summary:

- The initial 'consume' was moved out the loop
- The variable 'avail_memory_mb' was remove and the function 'get_available=
_memory_mb' is used all the times
- As concluded, the kernel not allocate the memory (for every fork) but sti=
ll check if there is available. So, this is the reason to include the verif=
ication prior each test case (with fork)
- In error (TCONF) the function 'tst_brkm(TCONF, cleanup,...' is used=20
- The patch was build and tested on final boards
- The patch was check with 'checkpatch.pl'

Regards

Julio

> -----Original Message-----
> From: Jan Stancek [mailto:jstancek@redhat.com]
> Sent: Saturday, April 02, 2016 2:57 PM
> To: Julio Cruz Barroso
> Subject: Re: [PATCH] Check available memory to support embedded devices
>=20
>=20
>=20
>=20
>=20
> ----- Original Message -----
> > From: "Julio Cruz Barroso" <julio.cruz@smartmatic.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Sent: Saturday, 2 April, 2016 8:39:08 AM
> > Subject: RE: [PATCH] Check available memory to support embedded
> > devices
> >
> > Hi Jan,
> >
> > Thanks for your comments. My reply inline
> >
> > > -----Original Message-----
> > > From: Jan Stancek [mailto:jstancek@redhat.com]
> > > Sent: Wednesday, March 30, 2016 8:19 PM
> > > To: Julio Cruz Barroso
> > > Subject: Re: [PATCH] Check available memory to support embedded
> > > devices
> > >
> > >
> > >
> > >
> > >
> > > ----- Original Message -----
> > > > From: "Julio Cruz Barroso" <julio.cruz@smartmatic.com>
> > > > To: "Jan Stancek" <jstancek@redhat.com>
> > > > Sent: Friday, 25 March, 2016 2:23:11 AM
> > > > Subject: Re: [PATCH] Check available memory to support embedded
> > > > devices
> > > >
> > > > Hi Jan,
> > > >
> > > > Any comment feedback related with this test case?
> > >
> > > comments inline
> > >
> > > >
> > > > Let me know to send the new patch.
> > > >
> > > > Regards
> > > >
> > > > Julio
> > > >
> > > > On Mar 23, 2016, at 12:28 PM, Julio Cruz Barroso
> > > > <julio.cruz@smartmatic.com>
> > > > wrote:
> > > >
> > > > Hi Jan,
> > > >
> > > > >
> > > > > What I was suggesting was:
> > > > >  return (ps / 1024) * pn / 1024;
> > > >
> > > > Done.
> > > >
> > > > >> +
> > > > >> +    tst_resm(TINFO, "Available memory: %ldMB\n",
> avail_memory_mb);
> > > > >> +    if (avail_memory_mb < DEFAULT_ALLOCATION_MB) {
> > > > >> +        tst_resm(TCONF, "Not enough memory to run this
> > > > >> + case\n");
> > > > >
> > > > > We have tst_brkm(TCONF, cleanup, "...");, which will print
> > > > > message, run cleanup and exit testcase.
> > > > >
> > > >
> > > > Done. Applied also in other points.
> > > >
> > > > > DEFAULT_ALLOCATION_MB);
> > > > >> +            consume(DEFAULT_ALLOCATION_MB);
> > > > >
> > > > > This consume() is within loop, and it doesn't look like same
> > > > > loop frees any memory. I suggest you move it before loop.
> > > > > You can try running the testcase with "-i 20".
> > > >
> > > > Done.
> > > >
> > > > >> +    if (avail_memory_mb < DEFAULT_ALLOCATION_MB*2) {
> > > > >
> > > > > Is this needed? Child is not allocating anything, and fork
> > > > > should use
> > > > > copy-on-
> > > > > write.
> > > > >
> > > >
> > > > If before the call to fork() the available memory is not the
> > > > double as DEFAULT_ALLOCATION_MB, the test fail (ENOMEM: fork()
> > > > failed to allocate the necessary kernel structures because memory is
> tight).
> > > >
> > > > In summary (let me know if I'm wrong), the fork() 'means that all
> > > > that the state is copied, including open files, register state and
> > > > all memory allocations, which includes the memory used at consume()
> function'
> > > [ref].
> > > > However, with COW, 'rather than copy all the memory at once, it
> > > > pretends it was copied and only actually copies when the parent
> > > > and child need to hold different values at the same address' [ref].
> > > > According with those assumptions, the kernel need to reserve the
> > > > allocated memory anyway, and that explain why I place the condition.
> > >
> > > I don't think kernel is going to reserve any memory. But, there is
> > > still a possibility that it  will make an overcommit check
> > > (depending on vm.overcommit_memory).
> > > So to check for memory that's needed for fork is OK.
> >
> > I agree with you. I don=E2=80=99t think there is an reservation but som=
ehow
> > there is a checking. About your suggestion with overcommit_memory, my
> > current system has CommitLimit  254884 kB in /proc/meminfo.
> >
> > root@emad:~# cat /proc/meminfo
> > MemTotal:         509768 kB
> > MemFree:          323228 kB
> > MemAvailable:     346020 kB
> > Buffers:            6712 kB
> > Cached:            26384 kB
> > SwapCached:            0 kB
> > Active:            16224 kB
> > Inactive:          20420 kB
> > Active(anon):       3652 kB
> > Inactive(anon):     4340 kB
> > Active(file):      12572 kB
> > Inactive(file):    16080 kB
> > Unevictable:           0 kB
> > Mlocked:               0 kB
> > HighTotal:             0 kB
> > HighFree:              0 kB
> > LowTotal:         509768 kB
> > LowFree:          323228 kB
> > SwapTotal:             0 kB
> > SwapFree:              0 kB
> > Dirty:                 0 kB
> > Writeback:             0 kB
> > AnonPages:          3544 kB
> > Mapped:             7804 kB
> > Shmem:              4448 kB
> > Slab:               8624 kB
> > SReclaimable:       3028 kB
> > SUnreclaim:         5596 kB
> > KernelStack:         648 kB
> > PageTables:          344 kB
> > NFS_Unstable:          0 kB
> > Bounce:                0 kB
> > WritebackTmp:          0 kB
> > CommitLimit:      254884 kB
> > Committed_AS:      27428 kB
> > VmallocTotal:    1548288 kB
> > VmallocUsed:        5856 kB
> > VmallocChunk:    1365276 kB
> >
> > >
> > > >
> > > > >>    tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> > > > >> +    if (avail_memory_mb < DEFAULT_ALLOCATION_MB*2) {
> > >
> > > In which case there should be no "*2", because memory in parent is
> > > already allocated. You should need the same amount in child, right?
> > > This is now checking, that we have twice the available memory that
> > > parent allocated.
> >
> > I understand you point. But in this case, the variable
> > "avail_memory_mb" is set in the beginning.
>=20
> I missed that. You're right then it needs to be "DEFAULT_ALLOCATION_MB*2".
>=20
> Regards,
> Jan
>=20
> > Maybe, to avoid confusions, I could set this variable every time.
> >
> > If you thinks is OK, I could remake another patch version.
> >
> > >
> > > > >
> > > > > Same as above.
> > > > >
> > > >
> > > > Same condition.
> > > >
> > > > >>    tst_resm(TINFO, "Testcase #03: fork + malloc");
> > > > >> +    if (avail_memory_mb < (DEFAULT_ALLOCATION_MB*2+50)) {
> > >
> > > Same here.
> > >
> > > Regards,
> > > Jan
> > >
> > > > >
> > > > > Same as above, isn't "50" going to be enough?
> > > >
> > > > Same assumption. If there is not memory available, the test will fa=
il.
> > > > The idea is to avoid it with the condition.
> > > > >
> > > > > Regards,
> > > > > Jan
> > > >
> > > > Regards
> > > >
> > > > Julio
> > > >
> > > > [ref] some references about CoW:
> > > > https://www.reddit.com/r/compsci/comments/31szui/trying_to_underst
> > > > and_ fork_and_copyonwrite_cow/
> > > > https://en.wikipedia.org/wiki/Copy-on-write
> > > >
> >
