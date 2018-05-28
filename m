From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 May 2018 06:21:39 +0200
Subject: [LTP] [PATCH 6/6] network/tcp_cc: add new test bbr02
In-Reply-To: <1526903310-2833-7-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
 <1526903310-2833-7-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180528042139.GF1717@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Difference, comparing to bbr01:

> * Uses different (not default) qdisc: pfifo_fast, codel, pfifo, fq, hfsc,
>   hhf, htb, pie, prio, sfb and sfq.
> * Emulates congestion not only with packet loss but with delay, corrupt
>   and reorder.

> The test expects that 'bbr' congestion-control algorithm not
> significantly worse than 'cubic'.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---

> +do_test()
> +{
> +	for q in $qdisc_list; do
> +		if tc qdisc add $q >/dev/null 2>&1; then
> +			tst_res TCONF "$q qdisc not supported"
> +			continue
> +		fi
Yes, this one would of using TST_TEST_DATA.


Kind regards,
Petr
