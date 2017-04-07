From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Apr 2017 17:52:22 +0200
Subject: [LTP] [RFC] [PATCH] lib: Fix undefined reference to `mq_open'
 build failures
In-Reply-To: <20170406074544.GA18057@rei.lan>
References: <20170329165008.6396-1-chrubis@suse.cz>
 <20170406074544.GA18057@rei.lan>
Message-ID: <20170407155222.GA9310@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
And unfortunatelly this approach does not seem to work for static
linking :-(

Seems I misunderstand how weak symbols are handled, since if the weak
symbol is linked into the binary the linker does not even try to
resolve it hence the strong symbol in librt.so is ignored.

Basically what we wanted to have is the weak_import attribute that could
be used on apple OSX.

Anyway possible solutions I can come up with:


* Switch to dynamic linking for libltp

  - may be worth the saving some megabytes on file size

  - would require the dynamic library to be put in the correct path or
    messing with LD_LIBRARY_PATH though


* Getting pointer to the mq_open() function via
  dlysm(RTLD_DEFAULT, "mq_open") and TBROK if we get NULL

  - this requires the test linked with -ldl though
    so this is not helping much


* Splitting the libltp.a into libltp.a and libltprt.a

  - this is not elegant, but bullet-proof


* Hacking around build system and link the stub
  only when -lrt is not in CFLAGS

  - this is hackery, but would probably work fine


* Anything else?

-- 
Cyril Hrubis
chrubis@suse.cz
