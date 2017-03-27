From: Andi Kleen <andi@firstfloor.org>
Date: Mon, 27 Mar 2017 16:54:42 -0700
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
	pages?
In-Reply-To: <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp> (Naoya
 Horiguchi's message of "Thu, 23 Feb 2017 03:23:49 +0000")
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
 <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
 <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
Message-ID: <87zig6uvgd.fsf@firstfloor.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> writes:
>
> I think that what the testcase effectively does is to test whether memory
> handling on zero pages works or not.
> And the testcase's failure seems acceptable, because it's simply not-implemented yet.
> Maybe recovering from error on zero page is possible (because there's no data
> loss for memory error,) but I'm not sure that code might be simple enough and/or
> it's worth doing ...

I doubt it's worth doing, it's just too unlikely that a specific page
is hit. Memory error handling is all about probabilities.

The test is just broken and should be fixed.

mce-test had similar problems at some point, but they were all fixed.

-Andi
