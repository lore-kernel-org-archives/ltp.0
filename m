From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2020 14:18:03 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201119130824.GC12628@yuki.lan>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <20201113202828.GA2229@pevik>
 <CAEemH2fXD-gFF_7PogAPB1txUrgQmmzeK8p=MaMSn1zam0YeVg@mail.gmail.com>
 <20201119130824.GC12628@yuki.lan>
Message-ID: <20201125131803.GB30149@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I agree to add an expected value check for TEST_PASS(), e.g
> > 
> > #define TEST_PASS(SCALL, EXPECTED, ...)
> 
> I would rather keep this simple case as it is, since many function
> return zero on success and added more specialized functions if needed as
> it was done with TEST_FD()

Is anyone against pushing this initial patchset as it is?

-- 
Cyril Hrubis
chrubis@suse.cz
