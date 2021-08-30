From: suy.fnst@fujitsu.com <suy.fnst@fujitsu.com>
Date: Mon, 30 Aug 2021 09:26:58 +0000
Subject: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
In-Reply-To: <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
Message-ID: <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
  I found that it's indeed related to ipv6 DAD as you said.
Calling
`ip netns exec ltp_ns sysctl -n net.ipv6.conf.ltp_ns_veth1.accept_dad=0`
or tst_wait_ipv6_dad() at end of the setup both solves the problem.
However there is one super strange part that the tentative address is
the local link adress of the ltp_ns_veth1:

5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.0.0.1/24 scope global ltp_ns_veth1
       valid_lft forever preferred_lft forever
    inet6 fd00:1:1:1::1/64 scope global nodad
       valid_lft forever preferred_lft forever
    inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative       <-------------------
       valid_lft forever preferred_lft forever

However, there is no place using the address in mpls02 test.
It makes me wonder how could it be possible to trigger the issue..

Thanks!
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

