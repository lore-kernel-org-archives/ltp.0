From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 28 May 2018 07:44:26 +0200
Subject: [LTP] [PATCH 4/6] network/tcp_cc/lib: add a function to set
 qdisc and txqueuelen
In-Reply-To: <1526903310-2833-5-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
 <1526903310-2833-5-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180528054425.GD21980@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/network/tcp_cc/tcp_cc_lib.sh |   34 ++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)

> diff --git a/testcases/network/tcp_cc/tcp_cc_lib.sh b/testcases/network/tcp_cc/tcp_cc_lib.sh
> index b96c8af..7e93e1d 100755
> --- a/testcases/network/tcp_cc/tcp_cc_lib.sh
> +++ b/testcases/network/tcp_cc/tcp_cc_lib.sh
> @@ -9,6 +9,8 @@ TST_NEEDS_CMDS="sysctl tc"
>  . tst_net.sh

>  def_alg="cubic"
> +prev_qlen=
> +prev_queue=
>  prev_alg=

>  set_cong_alg()
> @@ -21,8 +23,16 @@ set_cong_alg()

>  tcp_cc_cleanup()
>  {
> +	local rmt_dev="dev $(tst_iface rhost)"
> +
>  	[ "$prev_cong_ctl" ] && \
>  		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
> +
> +	[ "$prev_qlen" ] && \
> +		tst_rhost_run -c "ip li set txqueuelen $prev_qlen $rmt_dev"
> +
> +	[ "$prev_queue" ] && \
> +		tst_rhost_run -c "tc qdisc replace $rmt_dev root $prev_queue"
>  }

>  tcp_cc_setup()
> @@ -30,6 +40,30 @@ tcp_cc_setup()
>  	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
>  }

> +qdisc_list="pfifo_fast codel pfifo fq hfsc hhf htb pie prio sfb sfq"


Maybe just one thing: wouldn't be better to have this upper case as it's
library variable shared in tests? But it's only a minor nit.


Kind regards,
Petr
