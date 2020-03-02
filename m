From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Mar 2020 11:16:28 +0100
Subject: [LTP] [PATCH] syscalls/openat2: New tests
In-Reply-To: <20200302100244.6syqeskptbsnyf6t@vireshk-i7>
References: <b927e5f2cd36ec2dd57202b492563922b1a94e77.1582886993.git.viresh.kumar@linaro.org>
 <20200228132210.GC8324@rei>
 <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
 <20200302084651.GA4736@rei.lan>
 <20200302090718.hmyxgbmrwltxiz56@vireshk-i7>
 <20200302093622.GA5288@rei.lan>
 <20200302100244.6syqeskptbsnyf6t@vireshk-i7>
Message-ID: <20200302101628.GB5288@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The code you had there in the first place was passing by accident
> > because the were non-zero bytes on the stack after the structure, which
> > is pretty bad, because if it started to fail randomly nobody would know
> > why.
> 
> I know :)
> 
> What about this? This doesn't test the success case with pad = 0 though, as it
> is a success case. Don't want to add a separate file for it. :)

This has still one small drawback, the whole purpose of the test buffers
is that there is a PROT_NONE page allocated right behind the end of the
buffer. This is implemented so that we can make sure that kernel does
not touch any data outside of it. So the buffer has to be sized exactly
as the tc->size otherwise there is no point in using it. So I guess we
still need two buffers.

Also I guess that we can add the success case to the openat201.c test
but that would mean that we need two buffers there as well.

-- 
Cyril Hrubis
chrubis@suse.cz
