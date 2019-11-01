From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 1 Nov 2019 08:12:44 +0100
Subject: [LTP] [PATCH] pt_test: skip pt_disable_branch on Broadwell CPUs
In-Reply-To: <a5174e749dd7b6089fa861b5369baf9f80c51ef8.1572269566.git.jstancek@redhat.com>
References: <a5174e749dd7b6089fa861b5369baf9f80c51ef8.1572269566.git.jstancek@redhat.com>
Message-ID: <20191101071244.GA4930@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> commit d35869ba348d ("perf/x86/intel/pt: Allow the disabling of branch tracing")
> disallows not setting BRANCH_EN due to erratum BDM106 on Broadwell CPUs.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> @@ -145,6 +171,11 @@ static void setup(void)
>  	attr.size	= sizeof(struct perf_event_attr);
>  	attr.mmap			= 1;
>  	if (str_branch_flag) {
> +		if (is_affected_by_erratum_BDM106()) {
> +			tst_brk(TCONF, "erratum BDM106 disallows not "
> +				"setting BRANCH_EN on this CPU");
I'd join string (to be on single line), even it's longer than 80.
(better for grep)

Kind regards,
Petr
