From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Mar 2021 05:52:54 -0400 (EDT)
Subject: [LTP] [RFC PATCH 1/1] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <20210317083347.9791-1-pvorel@suse.cz>
References: <20210317083347.9791-1-pvorel@suse.cz>
Message-ID: <1233742536.40765616.1615974774212.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/maintainer-patch-review-checklist.txt | 32 +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 doc/maintainer-patch-review-checklist.txt
> 
> diff --git a/doc/maintainer-patch-review-checklist.txt
> b/doc/maintainer-patch-review-checklist.txt
> new file mode 100644
> index 000000000..cfe3918c1
> --- /dev/null
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -0,0 +1,32 @@
> +# Maintainer Patch Review Checklist
> +
> +Patchset should be tested locally and ideally also in maintainer's fork in
> +https://travis-ci.org/[Travis CI].
> +
> +Commit messages should have
> +
> +* author's `Signed-off-by` tag
> +* committer's `Reviewed-by` or `Signed-off-by` tag
> +* check also mailing lists for other reviewers / testers

Maybe "Fixes #" if it fixes github issue, so it's automatically closed?

> +
> +## New tests
> +New test should have
> +
> +* record in runtest file
> +* test run with more iteration (`-i 100`)
> +
> +### C tests
> +* use new
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C
> API]
> +* record in `.gitignore`
> +* check coding style with `checkpatch.pl`
> +(more in
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style[C
> coding style])
> +* docparse documentation
> +
> +### Shell tests
> +* use new
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell
> API]
> +* check coding style with `checkbashism.pl`
> +(more in
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style[Shell
> coding style])
> +
> +## LTP library
> +For patchset touching library please check also
> +https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP
> Library API Writing Guidelines].

One more things that comes to mind:

After patch is accepted or rejected, set correct state and archive
in LTP patchwork instance: http://patchwork.ozlabs.org/project/ltp/list/

