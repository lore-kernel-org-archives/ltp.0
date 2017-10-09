From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Oct 2017 19:05:36 +0200
Subject: [LTP] [RFC PATCH v2 7/7] m4,
 kernel/lib: Detect libnuma presence in kernel libs
In-Reply-To: <20171009155919.GH25633@rei.lan>
References: <20171009110101.3329-1-pvorel@suse.cz>
 <20171009110101.3329-8-pvorel@suse.cz>
 <20171009155919.GH25633@rei.lan>
Message-ID: <20171009170536.eyjyh2szpi3hxbfs@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > +#if HAVE_LIBNUMA && HAVE_NUMA_H

> I guess that the HAVE_LIBNUMA and HAVE_NUMA_H could be combined to
> HAVE_LIBNUMA as well, if we find a reasonable solution.

Right, should be possible, the same way as combining HAVE_LIBCRYPTO and HAVE_OPENSSL_SHA_H
you suggested in previous patch.


Kind regards,
Petr
