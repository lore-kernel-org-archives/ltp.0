From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 29 May 2021 21:10:45 +0200
Subject: [LTP] [PATCH] doc: Modernize test-writing-guidelines
In-Reply-To: <20210528182549.14347-1-chrubis@suse.cz>
References: <20210528182549.14347-1-chrubis@suse.cz>
Message-ID: <YLKRtWlnuRV2cLbM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

very nice improvements, thanks!
Few notes below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> -In case of LTP testcases it's customary to add a paragraph with highlevel test
> -description somewhere at the beginning of the file (usually right under the GPL
> -header). This helps other people to understand the overall goal of the test
> -before they dive into the technical details.
> +* First of all I will repeat *Keep things simple*
> +
> +* Keep function and variable names short but descriptive, choosing a good name
> +  for an API function is very difficuilt task; do not underestimate it
typo: difficuilt => difficult
> +
> +* Keep functions reasonably short and focused on a single task
BTW we are in the section "1.4 Commenting code", shouldn't be in some section
for general coding rules (for both C and shell)? Maybe under "1.3 Coding style"
> +
> +* Be consistent
> +
> +* Avoid deep nesting
> +
> +* DRY
maybe:
* https://en.wikipedia.org/wiki/Don%27t_repeat_yourself[DRY]

But DRY is the same as "1.2 Code duplication"

Also, I'd note for "Keep lines under 80 chars": for strings (log messages) we
prefer lines under 100 chars than splitting string.

> +
> +If there is a code that requires to be commented keep it short and to the
> +point. These comments should explain *why* and not *how* thigs are done.
typo: thigs => things
> +
> +Never ever comment the obvious.
> +
> +In case of LTP testcases it's customary to add a comment with an asciidoc
> +formatted paragraph with highlevel test description at the beginning of the
> +file right under the GPL SPDX header. This helps other people to understand
> +the overall goal of the test before they dive into the technical details. It's
> +also exported into generated documentation hence it should mostly explain what
> +is tested and why.

>  1.5 Backwards compatibility
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -124,20 +143,27 @@ toolchain supplied by the manufacturer.

>  Therefore LTP test for more current features should be able to cope with older
>  systems. It should at least compile fine and if it's not appropriate for the
> -configuration it should return 'TCONF' (see test interface description below).
> +configuration it should return 'TCONF'.

>  There are several types of checks we use:

>  The *configure script* is usually used to detect availability of a function
> -declarations in system headers. It's used to disable tests at compile time.
> -
> -We also have runtime kernel version detection that can be used to disable
> -tests at runtime.
> +declarations in system headers. It's used to disable tests at compile time or
> +to enable fallback definitions.
>  Checking the *errno* value is another type of runtime check. Most of the
>  syscalls returns either 'EINVAL' or 'ENOSYS' when syscall was not implemented
>  or was disabled upon kernel compilation.

> +LTP has kernel version detection that can be used to disable tests at runtime,
> +unfortunatelly kernel version does not always corresponds to a well defined
typo: unfortunatelly => unfortunately
> +feature set as distributions tend to backport hundreds of patches while the
> +kernel version stays the same. Use with caution.
> +
> +Lately we added kernel '.config' parser, a test can define a boolean
> +expression of kernel config variables that has to be satisfied in order for a
> +test to run. This is mostly used for kernel namespaces at the moment.
...

>  Tests are generally placed under the 'testcases/' directory. Everything that
>  is a syscall or (slightly confusingly) libc syscall wrapper goes under
> -'testcases/kernel/syscalls/'. Then there is 'testcases/open_posix_testsuite'
> -which is a well maintained fork of the upstream project that has been dead
> -since 2005 and also a number of directories with tests for more specific
> -features.
> +'testcases/kernel/syscalls/'.

Maybe also mention testcases/cve/ and why tests are duplicated?
Not sure if it's worth to mention testcases/network/; also there are other
directories. But I suppose you don't want to be too verbose here atm.
Maybe one day (after we have done a cleanup of old unsupported things)
we should describe here or in testcases/README.md all subdirectories.

> +
> +Then there is 'testcases/open_posix_testsuite' which is a well maintained fork
nit: 'testcases/open_posix_testsuite/' ('/' at the end to be consistent.
> +of the upstream project that has been dead since 2005 and also a number of
> +directories with tests for more specific features.

Kind regards,
Petr
