From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 10:16:20 +0100
Subject: [LTP] [RFC PATCH 1/1] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <20210317083347.9791-1-pvorel@suse.cz>
References: <20210317083347.9791-1-pvorel@suse.cz>
Message-ID: <YFHI5KEAI7HpgPzm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
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

Also add:
Please update patchset status in https://patchwork.ozlabs.org/project/ltp/list/[LTP patchwork].

> +
> +## New tests
> +New test should have
> +
> +* record in runtest file
> +* test run with more iteration (`-i 100`)
...

Kind regards,
Petr
