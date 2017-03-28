From: Andi Kleen <andi@firstfloor.org>
Date: Tue, 28 Mar 2017 13:26:52 -0700
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
	pages?
In-Reply-To: <20170328082506.GA30388@rei>
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
 <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
 <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
 <87zig6uvgd.fsf@firstfloor.org> <20170328082506.GA30388@rei>
Message-ID: <20170328202652.GC8285@two.firstfloor.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Well I disagree, the reason why the test fails is that MADV_HWPOISON on
> not-faulted private mappings fails silently, which is a bug, albeit
> minor one. If something is not implemented, it should report a failure,
> the usual error return would be EINVAL in this case.
> 
> It appears that it fails with EBUSY on first try on newer kernels, but
> still fails silently when we try for a second time.
> 
> Why can't we simply check if the page is faulted or not and return error
> in the latter case?

It's a debug interface. You're supposed to know what you're doing.

-Andi
