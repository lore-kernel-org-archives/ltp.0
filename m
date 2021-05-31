From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 May 2021 05:37:37 +0200
Subject: [LTP] [PATCH 1/1] doc: Drop uClinux support
In-Reply-To: <20210531032910.6739-1-pvorel@suse.cz>
References: <20210531032910.6739-1-pvorel@suse.cz>
Message-ID: <YLRaAWP7A0RdleuX@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

[Cc: Mike ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,

> some shorter form could be added to 3. Test Contribution Checklist [1] as well.

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#3-test-contribution-checklist

>  doc/maintainer-patch-review-checklist.txt | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
> index 5420fa933..81ed61ddf 100644
> --- a/doc/maintainer-patch-review-checklist.txt
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -44,6 +44,9 @@ New test should
>  * Docparse documentation
>  * If a test is a regression test it should include tags
>    (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2238-test-tags[Test tags])
> +* When rewritting old tests, https://en.wikipedia.org/wiki/%CE%9CClinux[uClinux
> +  (?Clinux)] support should be removed (project has been discontinued).
> +  E.g. `FORK_OR_VFORK()` should be replaced with simple `fork()` or `SAFE_FORK()`.

>  ### Shell tests
>  * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]

FYI: https://github.com/uclinux-dev

But that's just archiving the project, it's safe to remove uclinux support from
LTP.

Kind regards,
Petr
