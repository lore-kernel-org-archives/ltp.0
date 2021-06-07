From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 7 Jun 2021 10:37:45 +0200
Subject: [LTP] [RFC PATCH v2 0/2] Libclang based analyzer
In-Reply-To: <20210604111434.21422-1-rpalethorpe@suse.com>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
Message-ID: <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

just one quick remark. I guess the whole reason for using clang over 
coccinelle was availability of clang on developer systems.
I just wanted to quickly check your work, but had no clang installed. 
Build fail, even with cyril's patch for CHECK_TARGETS, because 
clang-c/Index.h is not found.

On ubuntu 20.04, this file is part of libclang-dev, but installing it 
did not help either, because it is installed to an include path not know 
to gcc (/usr/lib/llvm-10/include/clang-c).
I added it to the include path and it was found, but the next problem 
is, that some used functions (like clang_Cursor_getVarDeclInitializer) 
are only available starting with libclang 12.


So in conclusion, I do not think we can assume libclang to be available 
for all developers and installing it is probably more work, at least 
when newer functions from libclang are used, than installing coccinelle.
And very important for final setup: It must be possible to successfully 
compile ltp, without libclang/coccinelle available. There is no reason 
to force this libraries/tools for pure "users" of ltp.

J?rg
