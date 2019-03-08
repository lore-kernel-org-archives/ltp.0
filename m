From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Mar 2019 12:58:31 +0100
Subject: [LTP] [PATCH v2] sysctl01: fix fails on live-patched kernels
In-Reply-To: <20190307183728.7659-1-jbaier@suse.cz>
References: <20190307183728.7659-1-jbaier@suse.cz>
Message-ID: <20190308115831.GB1360@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

LGTM, with 2 minor changes (no need to repost if you agree).

> During live-patching, the uname syscall is overridden to reflect the
> fact that the kernel has been live-patched. The version string
> obtainable through /proc/sys/kernel/version is defined during
> compilation and it is not touched by the live-patch. In this case, the
> two interfaces can report different kernel versions.
I'd add a comment that we're removing "/kGraft-<git_new_hash>"
from "(<git_hash>/{lp,kGraft}-<git_new_hash>)"
But maybe that's known and obvious from the code.

> Adjust the string from uname in such cases and remove the tag added
> during live-patching.

> Signed-off-by: Jan Baier <jbaier@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +	klp_tag = strstr(buf.version, "/kGraft-");
> +	if (!klp_tag)
> +		klp_tag = strstr(buf.version, "/lp-");
> +	if (klp_tag) {
> +		right_brace = strchr(klp_tag, ')');
> +		if (right_brace)
> +			memmove(klp_tag, right_brace, sizeof(char) * (strlen(right_brace)+1));
sizeof(char) == 1 by definition :)
...


Kind regards,
Petr
