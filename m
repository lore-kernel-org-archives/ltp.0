From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Apr 2017 03:41:44 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] lib: Fix undefined reference to `mq_open'
 build failures
In-Reply-To: <20170407155222.GA9310@rei>
References: <20170329165008.6396-1-chrubis@suse.cz>
 <20170406074544.GA18057@rei.lan> <20170407155222.GA9310@rei>
Message-ID: <871439500.24205435.1491810104946.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> And unfortunatelly this approach does not seem to work for static
> linking :-(
> 
> Seems I misunderstand how weak symbols are handled, since if the weak
> symbol is linked into the binary the linker does not even try to
> resolve it hence the strong symbol in librt.so is ignored.
> 
> Basically what we wanted to have is the weak_import attribute that could
> be used on apple OSX.
> 
> Anyway possible solutions I can come up with:
> 
> 
> * Switch to dynamic linking for libltp
> 
>   - may be worth the saving some megabytes on file size
> 
>   - would require the dynamic library to be put in the correct path or
>     messing with LD_LIBRARY_PATH though

I'd avoid this, as it makes it more difficult to run tests in-tree.

> 
> 
> * Getting pointer to the mq_open() function via
>   dlysm(RTLD_DEFAULT, "mq_open") and TBROK if we get NULL
> 
>   - this requires the test linked with -ldl though
>     so this is not helping much
> 
> 
> * Splitting the libltp.a into libltp.a and libltprt.a
> 
>   - this is not elegant, but bullet-proof
> 
> 
> * Hacking around build system and link the stub
>   only when -lrt is not in CFLAGS
> 
>   - this is hackery, but would probably work fine
> 
> 
> * Anything else?

Move safe_mq_open to header?

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
