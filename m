From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Oct 2019 12:36:58 +0200
Subject: [LTP] [PATCH] pkeys: Fix uclibc build caused by conflicting
 signature
In-Reply-To: <1944770230.3074247.1570003394396.JavaMail.zimbra@redhat.com>
References: <20191001184750.20995-1-petr.vorel@gmail.com>
 <1944770230.3074247.1570003394396.JavaMail.zimbra@redhat.com>
Message-ID: <20191002103658.GA8087@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > Removing static fixes the problem.

> I'd prefer we rename test functions:

> #ifndef HAVE_PKEY_MPROTECT
> static inline int my_pkey_alloc()
> #else
> #define my_pkey_alloc pkey_alloc
> #endif

> my_pkey_alloc()

Good idea, thanks. I'd a detail, I'd prefer to use 'ltp_' prefix (ltp_pkey_alloc()).

Kind regards,
Petr
