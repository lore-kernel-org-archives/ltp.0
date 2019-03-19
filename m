From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 19 Mar 2019 16:10:50 +0100
Subject: [LTP] mbind() fails to fail with EIO
In-Reply-To: <20190319145233.rcfa6bvx6xyv64l3@kshutemo-mobl1>
References: <20190315160142.GA8921@rei>
 <CAHbLzkqvQ2SW4soYHOOhWG0ShkdUhaiNK0_y+ULaYYHo62O0fQ@mail.gmail.com>
 <20190319132729.s42t3evt6d65sz6f@d104.suse.de>
 <20190319142639.wbind5smqcji264l@kshutemo-mobl1>
 <20190319144130.lidqtrkfl75n2haj@d104.suse.de>
 <20190319145233.rcfa6bvx6xyv64l3@kshutemo-mobl1>
Message-ID: <20190319151050.7ym3kdmhec7bf2ky@d104.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 19, 2019 at 05:52:33PM +0300, Kirill A. Shutemov wrote:
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
> 
> Don't we need to bypass !vma_migratable(vma) check in
> queue_pages_test_walk() for MPOL_MF_STRICT? I mean user still might want
> to check if all pages are on the right not even the vma is not migratable.

Yeah, I missed that.
Then, I guess that we have to put the check into queue_pages_pte_range as well,
and place it right before migrate_page_add().
So, if it is not placed in the node and is not migreatable, we return -EIO.

-- 
Oscar Salvador
SUSE L3
