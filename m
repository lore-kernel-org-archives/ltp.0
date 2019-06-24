From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Jun 2019 05:57:14 -0400 (EDT)
Subject: [LTP] [PATCH v2 3/3] pkey: add pkey02 test
In-Reply-To: <CAEemH2fn9qhKBbYviKHbkDuV40kE=sK8b36-g=X31n5ihhCwtw@mail.gmail.com>
References: <20190621102628.4800-4-liwang@redhat.com>
 <1186374967.29667455.1561359397802.JavaMail.zimbra@redhat.com>
 <CAEemH2chU7KYJida_09RVWDMQRQLyv9igr5-j464SsKQj3svDA@mail.gmail.com>
 <CAEemH2fn9qhKBbYviKHbkDuV40kE=sK8b36-g=X31n5ihhCwtw@mail.gmail.com>
Message-ID: <1232452812.29707516.1561370234695.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Mon, Jun 24, 2019 at 3:27 PM Li Wang <liwang@redhat.com> wrote:
> 
> >
> >
> > On Mon, Jun 24, 2019 at 2:56 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> >>
> >>
> >> ----- Original Message -----
> >> > Signed-off-by: Li Wang <liwang@redhat.com>
> >> > +
> >> > +static void pkey_tests(int pkey, int prot, int flags, int fd)
> >> > +{
> >> > +     char *buffer;
> >> > +
> >> > +     if (fd == 0) {
> >> > +             fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
> >> > +     }
> >> > +
> >> > +     buffer = SAFE_MMAP(NULL, psize, prot, flags, fd, 0);
> >> > +
> >> > +     if (pkey_mprotect(buffer, psize, prot, pkey) == -1)
> >> > +             tst_brk(TBROK, "pkey_mprotect failed");
> >> > +
> >> > +     tst_res(TPASS, "apply pkey to the buffer area success");
> >> > +
> >> > +     if (fd > 0) {
> >> > +             SAFE_CLOSE(fd);
> >> > +     }
> >> > +
> >> > +     SAFE_MUNMAP(buffer, psize);
> >> > +}
> >> > +
> >>
> >> Hi,
> >>
> >> pkey02 doesn't try to read/write as pkey01, but otherwise two tests look
> >> very similar.
> >>
> >> Could we try to read/write here as well for all combinations of map flags?
> >> Then pkey01 could be dropped since pkey02 would cover more than just 1
> >> combination.
> >> Or is there a different reason behind separate tests, that I'm missing?
> >>
> >>
> > The pkey02 is a follow new test idea(test more types of memory) after I
> > completed pkey01.
> >
> > Yes, the diffenrence bettwen them is pkey02 cover more map flags but not
> > do R/W verification. That's because I'm hoping to add {0, 0x0} to the test
> > which does not trigger SIGSEGV in pkey02, it seems a bit tricky to
> > distinguish the SIGSEGV is come from 0x0(if bug there)
> > or PKEY_DISABLE_ACCESS progress.
> >
> >
> Well, a smple way I can find is to remove the {0, 0x0} from struct tcase,
> and test the access right 0x0 in lastly.

You could also keep {0, 0x0}, but extend struct with "int fault_expected",
and set it to 0/1 depending on flags.

> 
> So, what do you think about the new key02(merge key01 and old key02) in
> this attatchment?

That works too. Some comments below:

	if (fd > 0) {
		SAFE_CLOSE(fd);
	}
0 is valid fd, brackets are not needed.

All tst_* functions that report failures should also have TERRNO.

tst_res(TFAIL, "Child unexpectedly ended") could print also exit code.

Regards,
Jan
