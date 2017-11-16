From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 16 Nov 2017 10:56:20 +0100
Subject: [LTP] [RFC] [PATCH] netns: Fix race in virtual interface bringup
In-Reply-To: <20171115190423.kcrzl2odqtdr6ghg@xps>
References: <20171109203841.28856-1-dan.rue@linaro.org>
 <20171115190423.kcrzl2odqtdr6ghg@xps>
Message-ID: <c9276a9b-16f4-338f-e51f-abebc4181fed@6wind.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Le 15/11/2017 à 20:04, Dan Rue a écrit :
> Adding CC netdev
> 
> Can someone comment on the expected behavior of this test case?
> 
> Here's the isolated test:
> 
>     ip netns del tst_net_ns0
>     ip netns del tst_net_ns1
>     ip netns add tst_net_ns0
>     ip netns add tst_net_ns1
>     ip netns exec tst_net_ns0 ip link add veth0 type veth peer name veth1
>     ip netns exec tst_net_ns0 ip link set veth1 netns tst_net_ns1
> 
>     ip netns exec tst_net_ns0 ifconfig veth0 inet6 add fd00::2/64
>     ip netns exec tst_net_ns1 ifconfig veth1 inet6 add fd00::3/64
ip netns exec tst_net_ns0 sysctl -w net.ipv6.conf.all.accept_dad=0
ip netns exec tst_net_ns0 sysctl -w net.ipv6.conf.veth0.accept_dad=0
ip netns exec tst_net_ns1 sysctl -w net.ipv6.conf.all.accept_dad=0
ip netns exec tst_net_ns1 sysctl -w net.ipv6.conf.veth1.accept_dad=0

>     ip netns exec tst_net_ns0 ifconfig veth0 up
>     ip netns exec tst_net_ns1 ifconfig veth1 up
> 
>     #sleep 2>
>     ip netns exec tst_net_ns0 ping6 -q -c2 -I veth0 fd00::3
> 
> This is essentially what LTP is running. Sometimes, on some systems,
> ping6 fails with "connect: Cannot assign requested address". Adding a
> "sleep 2" always fixes it (but we'd obviously like to avoid a hard coded
> sleep in the test).
Probably due to DAD. By disabling DAD, you should be able to use immediately the
ipv6 addrs.


Regards,
Nicolas
