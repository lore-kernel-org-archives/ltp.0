From: suy.fnst@fujitsu.com <suy.fnst@fujitsu.com>
Date: Mon, 30 Aug 2021 06:46:00 +0000
Subject: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
In-Reply-To: <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
Message-ID: <TY2PR01MB2124907012E8CCEADD65682A89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Alexey
  Sorry for late reply and the bad email format. 
  And thanks a lot for your suggestion! It inspire me to find the cause.
  I'll explain it in V2.

--
Su 

________________________________________
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Sent: Thursday, August 26, 2021 17:36
To: Su, Yue/? ?; ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02

On 26.08.2021 08:26, suy.fnst@fujitsu.com wrote:
> While running mpls02.sh -6 in our slow test box with kernel
> version > v5.11, we found the test hangs at ping6 occasionally:
>
>   + grep -q 'invalid option'
>   + for size in ${msg_sizes:-"56"}
>   + EXPECT_PASS ping6 -I fd00:23::2 -c 500 -s 10 -f fd00:23::1
>   '>/dev/null'
>   + _tst_expect_pass tst_res ping6 -I fd00:23::2 -c 500 -s 10 -f
>   fd00:23::1 '>/dev/null'
>   + local fnc=tst_res
>   + shift
>   + tst_rod ping6 -I fd00:23::2 -c 500 -s 10 -f fd00:23::1 '>/dev/null'
>
> The weird part is that manual ping6 works in the meantime.
>
> Then we found that adding `sleep 1` at end of mpls02.sh/setup() make
> the test pass in 100%. Dig depper in the problem, ftrace catched during
> the 1 second shows (The test started at [ 3979.485488]):
>
>  3981.210701 |   2) kworker-24742  |               |  addrconf_dad_work() {
>  3981.210712 |   2) kworker-24742  |               |    addrconf_dad_completed() {
>  3981.210712 |   2) kworker-24742  |   0.417 us    |      addrconf_del_dad_work();
>  3981.210713 |   2) kworker-24742  |               |      __ipv6_ifa_notify() {
>  3981.210716 |   2) kworker-24742  |   1.097 us    |        inet6_fill_ifaddr();
>  3981.210730 |   2) kworker-24742  |               |        ip6_ins_rt() {
>  3981.210731 |   2) kworker-24742  |               |          fib6_add() {
>
> In kernel, addrconf_dad_work() is delegated by inet6_addr_add() to do
> route related jobs in a delayed workqueue . Hence, there is tiny period
> we need to wait for it. Adding the `sleep 1` seems suffcient for now.

What is happening in the ping6, it is OK for it to hang on this?

Adding nodad to loopback might only change the flags (remove tentative
if ifa_flags==IFA_F_NODAD), the delayed dad work should be completed in
addrconf_dad_begin() for it anyway... but will it make any difference
for ping6 to change the test as below?

ip addr add $ip_loc/$mask dev lo nodad
tst_rhost_run -s -c "ip addr add $ip_rmt/$mask dev lo nodad"

> Signed-off-by: Su Yue <suy.fnst@fujitsu.com>
> ---
>  testcases/network/mpls/mpls02.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/testcases/network/mpls/mpls02.sh b/testcases/network/mpls/mpls02.sh
> index 2fd3ec5bf4ba..75f5fca32f9a 100755
> --- a/testcases/network/mpls/mpls02.sh
> +++ b/testcases/network/mpls/mpls02.sh
> @@ -35,6 +35,8 @@ setup()
>       tst_rhost_run -s -c "ip addr add $ip_rmt/$mask dev lo"
>       tst_rhost_run -s -c "ip route add $ip_loc/$mask encap mpls 60 via inet$TST_IPV6 $(tst_ipaddr)"
>       tst_rhost_run -s -c "ip -f mpls route add 50 dev lo"
> +
> +     sleep 1
>  }
>
>  do_test()
>

