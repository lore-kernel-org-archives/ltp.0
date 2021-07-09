From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 9 Jul 2021 13:05:34 +0300
Subject: [LTP] [PATCH v2] network/tc01.sh: Add a regression test for tc
 qdisc command
In-Reply-To: <1625733759-30715-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <50bca7a2-41f5-3eba-d1da-e8e12c883d22@bell-sw.com>
 <1625733759-30715-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <7d822a0c-451c-4653-23f1-9bbc81bd0842@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08.07.2021 11:42, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
...
> +do_test()
> +{
> +	tst_res TINFO "Use tc qdisc command to trigger a null-pointer dereference"
> +
> +	EXPECT_FAIL tc qdisc add dev teql0 root teql0
> +
> +	dmesg | grep RIP | grep teql_destroy | grep sch_teql > /dev/null

It can be simplified to:

if dmesg | grep -q 'RIP:.*sch_teql'; then

> +	if [ $? -eq 0 ]; then
> +		tst_res TFAIL "This bug is reproduced."
> +	else
> +		tst_res TPASS "This bug is not reproduced."
> +	fi
> +}
> +
> +tst_run
> 

