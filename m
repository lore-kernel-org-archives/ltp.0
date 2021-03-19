From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Mar 2021 10:30:07 +0100
Subject: [LTP] [PATCH v2 1/2] doc: Document test tags
In-Reply-To: <20210318181641.2062-2-pvorel@suse.cz>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-2-pvorel@suse.cz>
Message-ID: <YFRvH6y+vwosiWfh@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + add URL for checkpatch.pl script and slightly reword related text.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/test-writing-guidelines.txt | 62 +++++++++++++++++++++++++++++----
>  1 file changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 50696e14a..16715b841 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -47,10 +47,12 @@ LTP adopted Linux kernel coding style. If you aren't familiar with its rules
>  locate 'linux/Documentation/CodingStyle' in the kernel sources and read it,
>  it's a well written introduction.
>  
> -There is also a checkpatch (see 'linux/scripts/checkpatch.pl') script that can
> -be used to check your patches before the submission.
> +There is also
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
> +script from kernel git tree which can be used to check your patches before the
> +submission.  Please use reasonably recent one.
>  
> -NOTE: If checkpatch does not report any problems, the code still may be wrong
> +NOTE: If checkpatch.pl does not report any problems, the code still may be wrong
>        as the tool only looks for common mistakes.
>  
>  1.3.2 Shell coding style
> @@ -2213,6 +2215,53 @@ struct tst_test test = {
>  Some tests require more than specific number of CPU. It can be defined with
>  `.min_cpus = N`.
>  
> +2.2.38 Test tags
> +^^^^^^^^^^^^^^^^
> +
> +Test tags are name-value pairs that can hold any test metadata.
> +
> +We have additional support for CVE entries, or git commit in mainline kernel,
                                               ^        ^
					       |      commits?
					       |
					       This or should probably
					       be removed since we have
					       another one later in the
					       sentence.

> +stable kernel or glibc git repository.  If a test is a regression test it
> +should include these tags.  They are printed when test fails and added in
> +docparse documentation.
   ^
   Not sure if we should name it docparse, maybe just "... and exported
   into documentation."

> +CVE, mainline and stable kernel git commits in a regression test for a kernel bug:
> +[source,c]
> +-------------------------------------------------------------------------------
> +struct tst_test test = {
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "9392a27d88b9"},
> +		{"linux-git", "ff002b30181d"},
> +		{"linux-stable-git", "c4a23c852e80"},
> +		{"CVE", "2020-29373"},
> +		{}
> +	}
> +};
> +-------------------------------------------------------------------------------
> +
> +Glibc git commit in a regression test for a glibc bug:
> +[source,c]
> +-------------------------------------------------------------------------------
> +struct tst_test test = {
> +	...
> +	.tags = (const struct tst_tag[]) {
> +		{"glibc-git", "574500a108be"},
> +		{}
> +	}
> +};
> +-------------------------------------------------------------------------------
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +struct tst_test test = {
> +	...
> +	.tags = (const struct tst_tag[]) {
> +		{"glibc-git", "574500a108be"},
> +		{}
> +	}
> +};
> +-------------------------------------------------------------------------------
> +
>  2.3 Writing a testcase in shell
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> @@ -3005,10 +3054,11 @@ skips 'atexit(3)' callbacks.
>  4. Test Contribution Checklist
>  ------------------------------
>  
> -1. Test compiles and runs fine (check with -i 10 too)
> -2. Checkpatch does not report any errors
> +1. Test compiles and runs fine (check with `-i 10` too)
> +2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
> +   does not report any errors
>  3. The runtest entires are in place
> -4. Test files are added into corresponding .gitignore files
> +4. Test files are added into corresponding '.gitignore' files
           ^
	   Can we fix this to say binaries since we are fixing things?

>  5. Patches apply over the latest git

Here as well, looks great minus the few minor things.

-- 
Cyril Hrubis
chrubis@suse.cz
