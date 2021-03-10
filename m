From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 11:32:27 +0100
Subject: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
In-Reply-To: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
References: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
Message-ID: <YEigO2gryF1Kp6Gq@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -static const char *const resource_files[] = {
> -	TEST_APP,
> -	NULL,
> -};
> -
>  static struct tst_test test = {
>  	.test_all = verify_creat,
>  	.needs_checkpoints = 1,
>  	.forks_child = 1,
> -	.resource_files = resource_files,
> +	.resource_files = (const char *const []) {
> +		TEST_APP,
Don't we want to drop TEST_APP definition and use file directly?
Having TEST_APP does not say much.
Not sure how far we should go with moving everything into inline anonymous
definitions (it'd be nice if docparse was able to just expand macros, but that
would be way too slow).

Kind regards,
Petr
