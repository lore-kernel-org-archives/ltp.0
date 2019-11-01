From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 1 Nov 2019 09:49:34 +0100
Subject: [LTP] [PATCH v2] syscalls/prctl02: add more error tests
In-Reply-To: <1572512347-30116-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1572007183-13661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572512347-30116-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20191101084933.GA14639@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

>  static struct tst_test test = {
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.test = verify_prctl,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
> +		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
This fails on some old distros (Debian stable [1], CentOS 6 [2]),
but also on new (Fedora latest [3]):

undeclared identifier 'CAP_SETPCAP'

Could you please setup travis for your LTP fork and validate builds before
posting to ML?

BTW it'd be nice to have this feature in our patchwork [4], but not sure if this
is available and configurable on our patchwork instance (we don't host it).

Kind regards,
Petr

[1] https://travis-ci.org/pevik/ltp/jobs/605881703
[2] https://travis-ci.org/pevik/ltp/jobs/605881705
[3] https://travis-ci.org/pevik/ltp/jobs/605881704
[4] https://github.com/linux-test-project/ltp/issues/599
