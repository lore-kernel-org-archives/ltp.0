From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 14:08:24 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <CAEemH2fXD-gFF_7PogAPB1txUrgQmmzeK8p=MaMSn1zam0YeVg@mail.gmail.com>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <20201113202828.GA2229@pevik>
 <CAEemH2fXD-gFF_7PogAPB1txUrgQmmzeK8p=MaMSn1zam0YeVg@mail.gmail.com>
Message-ID: <20201119130824.GC12628@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I agree to add an expected value check for TEST_PASS(), e.g
> 
> #define TEST_PASS(SCALL, EXPECTED, ...)

I would rather keep this simple case as it is, since many function
return zero on success and added more specialized functions if needed as
it was done with TEST_FD()

-- 
Cyril Hrubis
chrubis@suse.cz
