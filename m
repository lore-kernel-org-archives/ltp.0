From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 07 Jun 2021 11:20:02 +0100
Subject: [LTP] [RFC PATCH v2 0/2] Libclang based analyzer
In-Reply-To: <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
Message-ID: <87bl8i563x.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
> just one quick remark. I guess the whole reason for using clang over
> coccinelle was availability of clang on developer systems.
> I just wanted to quickly check your work, but had no clang
> installed. Build fail, even with cyril's patch for CHECK_TARGETS,
> because clang-c/Index.h is not found.

Thanks for testing it.

>
> On ubuntu 20.04, this file is part of libclang-dev, but installing it
> did not help either, because it is installed to an include path not
> know to gcc (/usr/lib/llvm-10/include/clang-c).

Is part of this path the same that 'clang -print-resource-dir' prints?

Either way I guess we can search for this during configuration. LLVM has
a CMake module (or w/e) which probably finds all this automatically.

> I added it to the include path and it was found, but the next problem
> is, that some used functions (like clang_Cursor_getVarDeclInitializer) 
> are only available starting with libclang 12.
>

I guess that we could replace that function by recursing further into
the AST to find the initializer ourselves.

Probably we can restrict ourselves to only use functions from before
libclang 11.

>
> So in conclusion, I do not think we can assume libclang to be
> available for all developers and installing it is probably more work,
> at least when newer functions from libclang are used, than installing
> coccinelle.

IIRC Cyril said the Coccinelle package on Gentoo is not maintained
anymore. AFAICT it exists, but it is on an old version. I don't think
many people are interested in or want to maintain Ocaml
stuff. LLVM/Clang OTOH looks to be very active.

> And very important for final setup: It must be possible to
> successfully compile ltp, without libclang/coccinelle available. There
> is no reason to force this libraries/tools for pure "users" of ltp.
>
> J?rg

100% agree. These checks only make sense during development. Even then I
want to ensure that everyone can run the checks with very little
effort.

-- 
Thank you,
Richard.
