From: pvorel <pvorel@suse.de>
Date: Thu, 09 Sep 2021 17:53:17 +0200
Subject: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
In-Reply-To: <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
Message-ID: <0acf816462d49d8a6004c87e36b05d1b@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Su, Alexey,

On 2021-08-30 11:26, suy.fnst@fujitsu.com wrote:
> Hi,
>   I found that it's indeed related to ipv6 DAD as you said.
> Calling
> `ip netns exec ltp_ns sysctl -n 
> net.ipv6.conf.ltp_ns_veth1.accept_dad=0`
> or tst_wait_ipv6_dad() at end of the setup both solves the problem.
> However there is one super strange part that the tentative address is
> the local link adress of the ltp_ns_veth1:
> 
> 5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> state UP group default qlen 1000
>     link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>     inet 10.0.0.1/24 scope global ltp_ns_veth1
>        valid_lft forever preferred_lft forever
>     inet6 fd00:1:1:1::1/64 scope global nodad
>        valid_lft forever preferred_lft forever
>     inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative
> <-------------------
>        valid_lft forever preferred_lft forever
> 
> However, there is no place using the address in mpls02 test.
> It makes me wonder how could it be possible to trigger the issue..

I wonder if test still needs be fixed to work on all setups.

Petr

> 
> Thanks!
> --
> Su
