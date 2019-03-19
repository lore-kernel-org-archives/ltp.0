From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 Mar 2019 09:25:58 -0700
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190319145233.rcfa6bvx6xyv64l3@kshutemo-mobl1>
References: <20190315160142.GA8921@rei>
 <CAHbLzkqvQ2SW4soYHOOhWG0ShkdUhaiNK0_y+ULaYYHo62O0fQ@mail.gmail.com>
 <20190319132729.s42t3evt6d65sz6f@d104.suse.de>
 <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
 <20190319144130.lidqtrkfl75n2haj@d104.suse.de>
 <20190319145233.rcfa6bvx6xyv64l3@kshutemo-mobl1>
Message-ID: <CAHbLzkpo4KHBN8YCCGGfrDnoX4FnEx6odgEUwweGTC5fGz4FQw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 19, 2019 at 7:52 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Tue, Mar 19, 2019 at 03:41:33PM +0100, Oscar Salvador wrote:
> > On Tue, Mar 19, 2019 at 05:26:39PM +0300, Kirill A. Shutemov wrote:
> > > That's all sounds reasonable.
> > >
> > > We only need to make sure the bug fixed by 77bf45e78050 will not be
> > > re-introduced.
> >
> > I gave it a spin with the below patch.
> > Your testcase works (so the bug is not re-introduced), and we get -EIO
> > when running the ltp test [1].
> > So unless I am missing something, it should be enough.

Thanks for adding the missing part.

>
> Don't we need to bypass !vma_migratable(vma) check in
> queue_pages_test_walk() for MPOL_MF_STRICT? I mean user still might want
> to check if all pages are on the right not even the vma is not migratable.

I think we need. As long as there is "existing page was already on a
node that does not follow the policy" with MPOL_MF_STRICT, it should
return -EIO. So, even though the vma is not migratable it should check
if the above condition is true or not.

I will wrap all the stuff into a formal patch.

Thanks,
Yang

>
> --
>  Kirill A. Shutemov
