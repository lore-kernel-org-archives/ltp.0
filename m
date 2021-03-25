From: Liam Howlett <liam.howlett@oracle.com>
Date: Thu, 25 Mar 2021 13:15:51 +0000
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one
 VMA
In-Reply-To: <CAEemH2fnyB_dGzQWUb7SBi9S01vYGXaZBczj2ZwaYF-Rqv9UsA@mail.gmail.com>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
 <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
 <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
 <20210323162714.t5dm5vbo35vl4t2l@revolver>
 <CAEemH2fnyB_dGzQWUb7SBi9S01vYGXaZBczj2ZwaYF-Rqv9UsA@mail.gmail.com>
Message-ID: <20210325131545.jwrzhdy474utqjpa@revolver>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Li Wang <liwang@redhat.com> [210325 04:37]:
> Hi Liam,
> 
> On Wed, Mar 24, 2021 at 12:27 AM Liam Howlett <liam.howlett@oracle.com>
> wrote:
> 
> > Hello Li,
> >
> > Thank you for looking at this testcase.
> >
> > * Li Wang <liwang@redhat.com> [210317 07:08]:
> > > Hi Liam, Petr,
> > >
> > > Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > >
> > > > ...
> > > > +       if (mprotect(addr - page_size, page_size,
> > > > +                    PROT_READ|PROT_WRITE|PROT_EXEC)) {
> > > > +               tst_res(TFAIL, "Cannot mprotect new VMA.");
> > > > +               return;
> > > > +       }
> > > >
> > >
> > > We got permission denied here while performing the brk02 on
> > > x86_64/s390x(kernel-4.18~). After looking at the manual page of
> > > mprotect(), seems the access issue caused by PROT_EXEC.
> > >
> > > "
> > > POSIX says that the behavior of mprotect() is unspecified if it is
> > applied
> > > to a region of memory that was not obtained via mmap(2).
> > > ...
> > > Whether  PROT_EXEC has any effect different from PROT_READ
> > > depends on processor architecture, kernel version, and process state.
> > > If READ_IMPLIES_EXEC is set in the process's personality flags
> > > (see personality(2)), specifying PROT_READ will implicitly add PROT_EXEC.
> > > "
> >
> >
> > Unforntunately, dropping the PROT_EXEC causes the VMA behaviour to
> > change and does not test what this testcase is intended to test.
> >
> 
> Yes, I agree with this. But am not sure if Linux take some action on
> security
> side to prevent setting PROT_EXEC permission arbitrary.
> 
> 
> >
> > Removing the PROT_EXEC and the PROT_WRITE does test what is supposed to
> > be tested.  Can you verify that this works on the s390x?
> >
> 
> Actually just removing the PROT_EXEC then the brk02 can be passed on all my
> platforms.

Just removing the PROT_EXEC invalidates the test.  However, if both
PROT_EXEC and PROT_WRITE are removed, then the test still does what is
intended.

> 
> 
> >
> > Are you using real hardware to test this or can I use some sort of
> > emulation to test on my side?
> >
> 
> It looks like easily to reproduce.
> 
> I get failed with both virtual system and bare metal, e.g. the first one
> is on my Fedora33-workstation. But the worth to say, brk02 passed
> with raspberry pi3 and pi4.
> 
> x86_64
> -------------
> # virt-what
> # echo $?
> 0
> # uname -r
> 5.10.22-200.fc33.x86_64
> # ./brk02
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> brk02.c:41: TFAIL: Cannot mprotect new VMA


This was my test platform.  I also sent it to the Travis CI which passed
for x86_64.  I will re-examine the accepted code to ensure the cosmetic
changes didn't invalidate my testing.


> 
> x86_64
> -------------
> # virt-what
> kvm
> # ./brk02
> tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
> brk02.c:41: TFAIL: Cannot mprotect new VMA
> 
> s390x
> -------------
> # uname -r
> 5.12.0-rc4.vdso+
> # virt-what
> ibm_systemz
> ibm_systemz-zvm
> # ./brk02
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> brk02.c:41: TFAIL: Cannot mprotect new VMA
> 
> 
> armv7l -- raspberry-pi3
> -----------------------------
> # uname  -r
> 5.4.96-v7.1.el7
> # ./brk02
> tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
> brk02.c:56: TPASS: munmap at least two VMAs of brk() passed
> armv7l -- raspberry-pi4
> -----------------------------
> # uname  -rm
> 5.10.17-v7l+ armv7l
> # ./brk02
> tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
> brk02.c:56: TPASS: munmap at least two VMAs of brk() passed
> 

Would you be willing to re-run the tests without both PROT_EXEC and
PROT_WRITE?


Thank you,
Liam
