From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Aug 2019 17:59:09 +0800
Subject: [LTP] 
	=?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
	=?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2Zm?=
	=?utf-8?q?lined_hugepage_in_background?=
In-Reply-To: <27a48931-aff6-d001-de78-4f7bef584c32@oracle.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
 <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
 <a65e748b-7297-8547-c18d-9fb07202d5a0@oracle.com>
 <27a48931-aff6-d001-de78-4f7bef584c32@oracle.com>
Message-ID: <CAEemH2drL4LKRi52SQMOgVXQJSpztSKp54jRdNTkfWvPCxe34g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mike,

Thanks for working on this.

On Fri, Aug 2, 2019 at 8:20 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 7/30/19 5:44 PM, Mike Kravetz wrote:
> > A SIGBUS is the normal behavior for a hugetlb page fault failure due to
> > lack of huge pages.  Ugly, but that is the design.  I do not believe this
> > test should not be experiencing this due to reservations taken at mmap
> > time.  However, the test is combining faults, soft offline and page
> > migrations, so the there are lots of moving parts.
> >
> > I'll continue to investigate.
>
> There appears to be a race with hugetlb_fault and try_to_unmap_one of
> the migration path.
>
> Can you try this patch in your environment?  I am not sure if it will
> be the final fix, but just wanted to see if it addresses issue for you.

It works for me. After rebuilding the kernel with your patch, SIGBUS
does not appear anymore.

And I'm also thinking that why the huge_pte is not none here when race
with page migration (try_to_unmap_one).

--
Regards,
Li Wang
