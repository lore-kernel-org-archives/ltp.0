From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 07 Jun 2021 14:49:33 +0100
Subject: [LTP] [RFC PATCH v2 0/2] Libclang based analyzer
In-Reply-To: <52c808d5-c5d7-3a79-122b-428fe2802957@jv-coder.de>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
 <87bl8i563x.fsf@suse.de>
 <52c808d5-c5d7-3a79-122b-428fe2802957@jv-coder.de>
Message-ID: <878s3l6az6.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi Richard,
>
> On 6/7/2021 12:20 PM, Richard Palethorpe wrote:
>> Hello Joerg,
>>
>> On ubuntu 20.04, this file is part of libclang-dev, but installing it
>> did not help either, because it is installed to an include path not
>> know to gcc (/usr/lib/llvm-10/include/clang-c).
>> Is part of this path the same that 'clang -print-resource-dir' prints?
>>
>> Either way I guess we can search for this during configuration. LLVM has
>> a CMake module (or w/e) which probably finds all this automatically.
> resource dir is /usr/lib/llvm-12/lib/clang/12.0.1.
>
> The llvm-config tool can be used to find the locations of the include
> and lib directory.
> On my ubuntu, I installed clang-12 from apt.llvm.org and clang-10 from
> ubuntu repos.
> In the path there is the llvm-config tool from ubuntu pointing to
> /usr/lib/llvm-10/bin/llvm-config and llvm-config-10 and llvm-config-12 
> pointing to the respective llvm-config tool.
>
> I guess using llvm-config from the path to detect the correct include
> and library path would be the best way to go.
> If someone wants to use a different version, he can still set prepend
> it to the path during configuration:
>
> $ llvm-config --includedir
> /usr/lib/llvm-10/include
>
> $ llvm-config --libdir
> /usr/lib/llvm-10/lib
>
> $ PATH="/usr/lib/llvm-12/bin:$PATH" llvm-config --includedir
> /usr/lib/llvm-12/include
>
>
> Both includedir and libdir are required, to correctly link
> libclang. In the default library search paths, there are only
> versioned versiones of libclang (eg. libclang-12.so).

OK.

>
>>> I added it to the include path and it was found, but the next problem
>>> is, that some used functions (like clang_Cursor_getVarDeclInitializer)
>>> are only available starting with libclang 12.
>>>
>> I guess that we could replace that function by recursing further into
>> the AST to find the initializer ourselves.
>>
>> Probably we can restrict ourselves to only use functions from before
>> libclang 11.
> Sounds good, but how to force this? I don't think there is a "allow
> only libclang 10 symbols"...

Make a list of the symbols exported by libclang 10. Then check that
anything which starts with clang_ or CX is in that list.

Or just compile it against libclang 10 in CI.

>>
>>> So in conclusion, I do not think we can assume libclang to be
>>> available for all developers and installing it is probably more work,
>>> at least when newer functions from libclang are used, than installing
>>> coccinelle.
>> IIRC Cyril said the Coccinelle package on Gentoo is not maintained
>> anymore. AFAICT it exists, but it is on an old version. I don't think
>> many people are interested in or want to maintain Ocaml
>> stuff. LLVM/Clang OTOH looks to be very active.
> Right, it actually is removed now from gentoo portage tree ([1]). But
> is it used by the kernel developers?

Some kernel developers use it. There are a number of checkers and some
maintainers care about them while others do not.

>
> J?rg
>
> [1]
> https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=58395d3a0c06e060a0a40182fff4bf39f1910529


-- 
Thank you,
Richard.
