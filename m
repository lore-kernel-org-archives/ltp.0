From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 31 Jul 2017 14:09:54 -0700
Subject: [LTP] [PATCH] syscalls/keyctl05: new test for key_update() crash
In-Reply-To: <87lgn5gezv.fsf@our.domain.is.not.set>
References: <20170729010718.42236-1-ebiggers3@gmail.com>
 <87lgn5gezv.fsf@our.domain.is.not.set>
Message-ID: <20170731210954.GB41369@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 31, 2017 at 10:57:56AM +0200, Richard Palethorpe wrote:
> > +	for (i = 0; i < 10000; i++) {
> > +		TEST(tst_syscall(__NR_keyctl, KEYCTL_UPDATE, keyid,
> > +				 payload, sizeof(payload)));
> > +		if (TEST_RETURN < 0 && TEST_ERRNO != EACCES) {
> > +			tst_res(TFAIL | TTERRNO, "failed to update 'user' key");
> > +			return;
> > +		}
> > +	}
> 
> There is a library for causing race conditions (tst_fuzzy_sync.h), but
> it only works with threads at the moment. I'm not entirely sure whether
> to ask you to use it or not at this stage. How reliable is the test at
> crashing a vulnerable system currently?
> 

It happens either very reliably or not at all, depending on how the kernel stack
is laid out which the test has no control over.  And if it *can* happen, it
doesn't need any fancy synchronization to trigger the crash.

(Also this test could use threads; it just seemed that forking was simpler.)

Eric
