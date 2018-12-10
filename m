From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Dec 2018 13:24:55 +0100
Subject: [LTP] [PATCH 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <87pnudmnpj.fsf@rpws.prws.suse.cz>
References: <20181206181814.85583-1-ebiggers@kernel.org>
 <20181206181814.85583-4-ebiggers@kernel.org>
 <87pnudmnpj.fsf@rpws.prws.suse.cz>
Message-ID: <20181210122455.GA9930@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void __check_for_leaks(const char *name, const char *value,
> > size_t vlen)
> 
> IIRC we don't allow functions beginning with underscores because they
> are reserved by the compiler or C library.

We do append underscores at the end of the identifiers in order not to
redefine symbols from compiler/libc.

-- 
Cyril Hrubis
chrubis@suse.cz
