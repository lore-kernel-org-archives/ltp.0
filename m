From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Nov 2017 14:09:13 +0800
Subject: [LTP] [RFC] [PATCH] netns: Fix race in virtual interface bringup
In-Reply-To: <20171109203841.28856-1-dan.rue@linaro.org>
References: <20171109203841.28856-1-dan.rue@linaro.org>
Message-ID: <CAEemH2eiHo8EfyMqVhS=iee8Hfxw7_ygeKtGHBo_AFGW1QEYGw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dan,

On Fri, Nov 10, 2017 at 4:38 AM, Dan Rue <dan.rue@linaro.org> wrote:
> Symptoms (+ command, error):
>     netns_comm_ip_ipv6_ioctl:
>         + ip netns exec tst_net_ns1 ping6 -q -c2 -I veth1 fd00::2
>         connect: Cannot assign requested address
>
>     netns_comm_ip_ipv6_netlink:
>         + ip netns exec tst_net_ns0 ping6 -q -c2 -I veth0 fd00::3
>         connect: Cannot assign requested address
>
>     netns_comm_ns_exec_ipv6_ioctl:
>         + ns_exec 6689 net ping6 -q -c2 -I veth0 fd00::3
>         connect: Cannot assign requested address
>
>     netns_comm_ns_exec_ipv6_netlin:
>         + ns_exec 6891 net ping6 -q -c2 -I veth0 fd00::3
>         connect: Cannot assign requested address
>
> The error is coming from ping6, which is trying to get an IP address for
> veth0 (due to -I veth0), but cannot. Waiting for two seconds fixes the
> test in my testcases. 1 second is not long enough.
>
> dmesg shows the following during the test:
>
>     [Nov 7 15:39] LTP: starting netns_comm_ip_ipv6_ioctl (netns_comm.sh ip ipv6 ioctl)
>     [  +0.302401] IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
>     [  +0.048059] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>
> Signed-off-by: Dan Rue <dan.rue@linaro.org>
> ---
>
> We've periodically hit this problem across many arm64 kernels and boards, and
> it seems to be caused by "ping6" running before the virtual interface is
> actually ready. "sleep 2" works around the issue and proves that it is a race
> condition, but I would prefer something faster and deterministic. Please
> suggest a better implementation.

Just FYI:

I'm not good at network things, but one method I copied from ltp/numa
test is to split the '2s' into many smaller pieces of time.

which something like:

--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -240,6 +240,22 @@ netns_ip_setup()
                tst_brkm TBROK "unable to add device veth1 to the
separate network namespace"
 }

+wait_for_set_ip()
+{
+       local dev=$1
+       local retries=200
+
+       while [ $retries -gt 0 ]; do
+               dmesg -c | grep -q "IPv6: ADDRCONF(NETDEV_CHANGE):
$dev: link becomes ready"
+               if [ $? -eq 0 ]; then
+                       break
+               fi
+
+               retries=$((retries-1))
+               tst_sleep 10ms
+       done
+}
+
 ##
 # Enables virtual ethernet devices and assigns IP addresses for both
 # of them (IPv4/IPv6 variant is decided by netns_setup() function).
@@ -285,6 +301,9 @@ netns_set_ip()
                        tst_brkm TBROK "enabling veth1 device failed"
                ;;
        esac
+
+       wait_for_set_ip veth0
+       wait_for_set_ip veth1
 }

 netns_ns_exec_cleanup()


>
> Also, is it correct that "ifconfig veth0 up" returns before the interface is
> actually ready?
>
> See also this isolated test script:
> https://gist.github.com/danrue/7b76bbcbc23a6296030b7295650b69f3
>
>  testcases/kernel/containers/netns/netns_helper.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> index a95cdf206..99172c0c0 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -285,6 +285,7 @@ netns_set_ip()
>                         tst_brkm TBROK "enabling veth1 device failed"
>                 ;;
>         esac
> +       sleep 2
>  }
>
>  netns_ns_exec_cleanup()
> --
> 2.13.6
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Li Wang
liwang@redhat.com
