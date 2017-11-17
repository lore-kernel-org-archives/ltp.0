From: Dan Rue <dan.rue@linaro.org>
Date: Fri, 17 Nov 2017 16:29:20 -0600
Subject: [LTP] [RFC] [PATCH] netns: Fix race in virtual interface bringup
In-Reply-To: <2c722239-8e24-9796-a022-03b0c423f3b8@oracle.com>
References: <20171109203841.28856-1-dan.rue@linaro.org>
 <CAEemH2eiHo8EfyMqVhS=iee8Hfxw7_ygeKtGHBo_AFGW1QEYGw@mail.gmail.com>
 <2c722239-8e24-9796-a022-03b0c423f3b8@oracle.com>
Message-ID: <20171117222920.yr46xvdgtspmq6jp@xps>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Alexey, Li, thank you for your suggestions.

On Fri, Nov 17, 2017 at 03:08:20PM +0300, Alexey Kodanev wrote:
> On 11/17/2017 09:09 AM, Li Wang wrote:
> > Hi Dan,
> >
> > On Fri, Nov 10, 2017 at 4:38 AM, Dan Rue <dan.rue@linaro.org> wrote:
> >> Symptoms (+ command, error):
> >>     netns_comm_ip_ipv6_ioctl:
> >>         + ip netns exec tst_net_ns1 ping6 -q -c2 -I veth1 fd00::2
> >>         connect: Cannot assign requested address
> >>
> >>     netns_comm_ip_ipv6_netlink:
> >>         + ip netns exec tst_net_ns0 ping6 -q -c2 -I veth0 fd00::3
> >>         connect: Cannot assign requested address
> >>
> >>     netns_comm_ns_exec_ipv6_ioctl:
> >>         + ns_exec 6689 net ping6 -q -c2 -I veth0 fd00::3
> >>         connect: Cannot assign requested address
> >>
> >>     netns_comm_ns_exec_ipv6_netlin:
> >>         + ns_exec 6891 net ping6 -q -c2 -I veth0 fd00::3
> >>         connect: Cannot assign requested address
> >>
> >> The error is coming from ping6, which is trying to get an IP address for
> >> veth0 (due to -I veth0), but cannot. Waiting for two seconds fixes the
> >> test in my testcases. 1 second is not long enough.
> >>
> >> dmesg shows the following during the test:
> >>
> >>     [Nov 7 15:39] LTP: starting netns_comm_ip_ipv6_ioctl (netns_comm.sh ip ipv6 ioctl)
> >>     [  +0.302401] IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> >>     [  +0.048059] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 
> It's quite strange that veth interface needs 2 seconds to become
> operational and it is up in less than 0.3s according to dmesg, but
> you said that it's not enough even 1 sec... Are you sure that IPv6
> address not in tentative state and dad process actually disabled?
> I'm asking because you don't have it disabled in the script:
> https://gist.github.com/danrue/7b76bbcbc23a6296030b7295650b69f3

Investigating further, the dmesg output is reporting on the status of
the link between veth0 and veth1, not the veth0 interface itself. That
is, the first dmesg message comes from "ip netns exec tst_net_ns0
ifconfig veth0 up" and the second comes from "ip netns exec tst_net_ns1
ifconfig veth1 up". This explains why we see .3s in dmesg but a 2 second
sleep being required. There is not actually anything in dmesg that is
helpful here.

Regarding dad (duplicate address detection), we have seen similar issues
on low power ARM64 boards and IPv4. Anyway, I tried disabling dad on the
interface and it did not make a difference.

> 
> >>
> >> Signed-off-by: Dan Rue <dan.rue@linaro.org>
> >> ---
> >>
> >> We've periodically hit this problem across many arm64 kernels and boards, and
> >> it seems to be caused by "ping6" running before the virtual interface is
> >> actually ready. "sleep 2" works around the issue and proves that it is a race
> >> condition, but I would prefer something faster and deterministic. Please
> >> suggest a better implementation.
> > Just FYI:
> >
> > I'm not good at network things, but one method I copied from ltp/numa
> > test is to split the '2s' into many smaller pieces of time.
> >
> > which something like:
> >
> > --- a/testcases/kernel/containers/netns/netns_helper.sh
> > +++ b/testcases/kernel/containers/netns/netns_helper.sh
> > @@ -240,6 +240,22 @@ netns_ip_setup()
> >                 tst_brkm TBROK "unable to add device veth1 to the
> > separate network namespace"
> >  }
> >
> > +wait_for_set_ip()
> > +{
> > +       local dev=$1
> > +       local retries=200
> > +
> > +       while [ $retries -gt 0 ]; do
> > +               dmesg -c | grep -q "IPv6: ADDRCONF(NETDEV_CHANGE):
> > $dev: link becomes ready"
> 
> 
> What about "grep -q up /sys/class/net/$dev/operstate && break"?

Since dmesg will not help, I explored /sys as proposed.

operstate shows "up", and ping6 still fails.
carrier shows "1" (up), and ping6 still fails.
dormant shows "0" (interface is not dormant), and ping6 still fails.
flags shows "0x1003" before and after a 2s sleep (they don't change)

So it seems there is nothing in dmesg, or /sys that can help here.

Dan

> 
> Thanks,
> Alexey
> 
> 
> > +               if [ $? -eq 0 ]; then
> > +                       break
> > +               fi
> > +
> > +               retries=$((retries-1))
> > +               tst_sleep 10ms
> > +       done
> > +}
> > +
> >  ##
> >  # Enables virtual ethernet devices and assigns IP addresses for both
> >  # of them (IPv4/IPv6 variant is decided by netns_setup() function).
> > @@ -285,6 +301,9 @@ netns_set_ip()
> >                         tst_brkm TBROK "enabling veth1 device failed"
> >                 ;;
> >         esac
> > +
> > +       wait_for_set_ip veth0
> > +       wait_for_set_ip veth1
> >  }
> >
> >  netns_ns_exec_cleanup()
> >
> >> Also, is it correct that "ifconfig veth0 up" returns before the interface is
> >> actually ready?
> >>
> >> See also this isolated test script:
> >> https://gist.github.com/danrue/7b76bbcbc23a6296030b7295650b69f3
> >>
> >>  testcases/kernel/containers/netns/netns_helper.sh | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> >> index a95cdf206..99172c0c0 100755
> >> --- a/testcases/kernel/containers/netns/netns_helper.sh
> >> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> >> @@ -285,6 +285,7 @@ netns_set_ip()
> >>                         tst_brkm TBROK "enabling veth1 device failed"
> >>                 ;;
> >>         esac
> >> +       sleep 2
> >>  }
> >>
> >>  netns_ns_exec_cleanup()
> >> --
> >> 2.13.6
> >>
> >>
> >> --
> >> Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> >
> 
