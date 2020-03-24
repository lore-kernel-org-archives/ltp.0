From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Mar 2020 07:53:43 +0100
Subject: [LTP] [PATCH 1/3] accept4: Use tst_variant
In-Reply-To: <20200323230305.GA2696136@x230>
References: <20200323224933.2613658-1-petr.vorel@gmail.com>
 <20200323230305.GA2696136@x230>
Message-ID: <20200324065343.GA24724@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I guess __NR_socketcall is for x86 and other old architectures,
> > but we still want to use it, right?

> Maybe I should have kept just 2 variants (libc implementation and only one
> syscall implementation) and chose the correct syscall implementation with
> #ifdef SYS_ACCEPT4

> Or is there arch which supports both syscall variants?
OK, I can answer myself: ppc64le is example of arch which support both
__NR_accept4 and __NR_socketcall SYS_ACCEPT4.

Kind regards,
Petr
