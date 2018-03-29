From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 19:00:49 +0200
Subject: [LTP] [RFC PATCH 1/3] test_net.sh: Support both old and new
	shell APIs
In-Reply-To: <20180329154537.32711-2-pvorel@suse.cz>
References: <20180329154537.32711-1-pvorel@suse.cz>
 <20180329154537.32711-2-pvorel@suse.cz>
Message-ID: <20180329170048.GA9981@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> This is temporary solution, after migrating all tests to new SHELL API
> the compatibility layer and old SHELL API support should be removed and
> file renamed to tst_net.sh.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 126 ++++++++++++++++++++++++++++------------------
...
> +if [ -z "$TST_LIB_LOADED" ]; then
> +	[ -n "$TST_USE_NEW_API" ] && . tst_test.sh || . test.sh
This makes legacy API default. Actually I'd like to change it in v2 to
make new API default, i.e. 

if [ -z "$TST_LIB_LOADED" ]; then
	[ -n "$TST_USE_LEGACY_API" ] && test.sh || . tst_test.sh
fi

[ -n "$TST_USE_LEGACY_API" ] && tst_read_opts $*
...

And add TST_USE_LEGACY_API=1 to all scripts.


Kind regards,
Petr
