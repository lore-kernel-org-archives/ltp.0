From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Thu, 23 Feb 2017 03:23:49 +0000
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
	pages?
In-Reply-To: <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
 <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
Message-ID: <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Mon, Feb 20, 2017 at 05:00:17AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> On Tue, Feb 14, 2017 at 04:41:29PM +0100, Jan Stancek wrote:
> > Hi,
> >
> > code below (and LTP madvise07 [1]) doesn't produce SIGBUS,
> > unless I touch/prefault page before call to madvise().
> >
> > Is this expected behavior?
> 
> Thank you for reporting.
> 
> madvise(MADV_HWPOISON) triggers page fault when called on the address
> over which no page is faulted-in, so I think that SIGBUS should be
> called in such case.
> 
> But it seems that memory error handler considers such a page as "reserved
> kernel page" and recovery action fails (see below.)
> 
>   [  383.371372] Injecting memory failure for page 0x1f10 at 0x7efcdc569000
>   [  383.375678] Memory failure: 0x1f10: reserved kernel page still referenced by 1 users
>   [  383.377570] Memory failure: 0x1f10: recovery action for reserved kernel page: Failed
> 
> I'm not sure how/when this behavior was introduced, so I try to understand.

I found that this is a zero page, which is not recoverable for memory
error now.

> IMO, the test code below looks valid to me, so no need to change.

I think that what the testcase effectively does is to test whether memory
handling on zero pages works or not.
And the testcase's failure seems acceptable, because it's simply not-implemented yet.
Maybe recovering from error on zero page is possible (because there's no data
loss for memory error,) but I'm not sure that code might be simple enough and/or
it's worth doing ...

Thanks,
Naoya Horiguchi
