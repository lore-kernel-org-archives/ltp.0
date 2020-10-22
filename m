From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Oct 2020 12:13:36 +0200
Subject: [LTP] [PATCH V4 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <20201022045406.4m6pgqfmwvyx7mh2@vireshk-i7>
References: <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
 <63646c1ba9e1a3061b44be4f1f9a29d9d6d03f2e.1603254560.git.viresh.kumar@linaro.org>
 <20201021120434.GB10861@yuki.lan>
 <20201022045406.4m6pgqfmwvyx7mh2@vireshk-i7>
Message-ID: <20201022101336.GC2427@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we still need a test where select would clear the bits from
> > fd->set though, I supposes that the easiest solution would be to add
> > select04.c for that...
> 
> I am not sure how to do that and why would that matter ? :)

So the tests we do have now are checking that the bits in the fdset are
not cleared when there are data ready to be read/written from/to the
filke descriptor, right?

What we need is a test where we ask for a data to be read from an empty
pipe, ask for data to be written to a pipe filled with data (write there
till we get EAGAIN in setup), etc. We can do this with a very short
timeout or even with a timeout set to zero (polling) and check that the
bits were cleared once we have returned from the call.

-- 
Cyril Hrubis
chrubis@suse.cz
