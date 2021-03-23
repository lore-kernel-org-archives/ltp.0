From: Liam Howlett <liam.howlett@oracle.com>
Date: Tue, 23 Mar 2021 16:27:20 +0000
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one
 VMA
In-Reply-To: <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
 <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
 <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
Message-ID: <20210323162714.t5dm5vbo35vl4t2l@revolver>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Thank you for looking at this testcase.

* Li Wang <liwang@redhat.com> [210317 07:08]:
> Hi Liam, Petr,
> 
> Liam Howlett <liam.howlett@oracle.com> wrote:
> 
> 
> > ...
> > +       if (mprotect(addr - page_size, page_size,
> > +                    PROT_READ|PROT_WRITE|PROT_EXEC)) {
> > +               tst_res(TFAIL, "Cannot mprotect new VMA.");
> > +               return;
> > +       }
> >
> 
> We got permission denied here while performing the brk02 on
> x86_64/s390x(kernel-4.18~). After looking at the manual page of
> mprotect(), seems the access issue caused by PROT_EXEC.
> 
> "
> POSIX says that the behavior of mprotect() is unspecified if it is applied
> to a region of memory that was not obtained via mmap(2).
> ...
> Whether  PROT_EXEC has any effect different from PROT_READ
> depends on processor architecture, kernel version, and process state.
> If READ_IMPLIES_EXEC is set in the process's personality flags
> (see personality(2)), specifying PROT_READ will implicitly add PROT_EXEC.
> "


Unforntunately, dropping the PROT_EXEC causes the VMA behaviour to
change and does not test what this testcase is intended to test.

Removing the PROT_EXEC and the PROT_WRITE does test what is supposed to
be tested.  Can you verify that this works on the s390x?

Are you using real hardware to test this or can I use some sort of
emulation to test on my side?

Thank you,
Liam
