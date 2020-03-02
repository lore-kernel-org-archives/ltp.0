From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Mar 2020 10:36:22 +0100
Subject: [LTP] [PATCH] syscalls/openat2: New tests
In-Reply-To: <20200302090718.hmyxgbmrwltxiz56@vireshk-i7>
References: <b927e5f2cd36ec2dd57202b492563922b1a94e77.1582886993.git.viresh.kumar@linaro.org>
 <20200228132210.GC8324@rei>
 <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
 <20200302084651.GA4736@rei.lan>
 <20200302090718.hmyxgbmrwltxiz56@vireshk-i7>
Message-ID: <20200302093622.GA5288@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, I guess that it makes sense to add the pointer to how to the tcase
> > structure and allocate exact size for the E2BIG case. That should work
> > fine, right?
> 
> We need to hack it a bit more to initialize rest of the memory as
> well. This is what I did before I dropped the idea.

Looking at the kernel the code that we are trying to trigger is
copy_struct_from_user() in include/linux/uacess.h. And indeed the area
after the kernel how structure has to be non-zero in order for the
structure to be deemed incompatible.

I guess that the easier way how to test this would be:

* Create an extended how structure
* Set bytes at the end of the extended structure to non-zero

The code you had there in the first place was passing by accident
because the were non-zero bytes on the stack after the structure, which
is pretty bad, because if it started to fail randomly nobody would know
why.

I guess that it would make sense to put this in a separate test and test
that everthing works fine as long as padd is zero and that we got a
failure with padd != 0.

So something as:

struct how_ext {
	uint64_t flags;
	uint64_t mode;
	uint64_t resolve;
	char padd[20];
};

Then setup the flags, mode and resolve and do two calls to openat2() one
with padd 0 => should work and one with pad != 0 should fail.

Does that sound reasonable?

-- 
Cyril Hrubis
chrubis@suse.cz
