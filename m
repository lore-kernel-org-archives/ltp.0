From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 27 Mar 2017 14:08:37 +0200
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
 pages?
In-Reply-To: <20170227063308.GA14387@hori1.linux.bs1.fc.nec.co.jp>
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
 <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
 <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
 <1ba376aa-5e7c-915f-35d1-2d4eef0cad88@huawei.com>
 <20170227012029.GA28934@hori1.linux.bs1.fc.nec.co.jp>
 <22763879-C335-41E6-8102-2022EED75DAE@cs.rutgers.edu>
 <20170227063308.GA14387@hori1.linux.bs1.fc.nec.co.jp>
Message-ID: <20170327140837.502b1296@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Naoya,

On Mon, 27 Feb 2017 06:33:09 +0000
"Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com> wrote:

> 
> > I expected either madvise should fail because HWPOISON does not work on
> > non-existing physical pages or madvise_hwpoison() should populate
> > some physical pages for that virtual address range and poison them.  
> 
> The latter is the current behavior. It just comes from get_user_pages_fast()
> which not only finds the page and takes refcount, but also touch the page.

To clarify, the current behaviour seems to be the following:

1st madvise_hwpoison() -> EBUSY,
2nd madvise_hwpoison() -> SUCCESS, but no SIGBUS when the memory is accessed.

So it touches the zero page and madvise succeeds on the second attempt because
it is now mapped, but still the memory is not poisoned.

This means that when I modify the LTP test to accept EBUSY, it still fails if
a user runs it twice. This is OK, but I will need to document it in the test.

Thank you,
Richard.
