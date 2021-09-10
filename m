From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 10 Sep 2021 16:26:14 +0530
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
In-Reply-To: <YTngKohBcpQK7l5r@pevik>
References: <20210906083444.82394-1-naresh.kamboju@linaro.org>
 <YTngKohBcpQK7l5r@pevik>
Message-ID: <CA+G9fYsiHOBCDb8gub7FVfETydGy0JwDNUDkazTqPo=qhhcvwA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, 9 Sept 2021 at 15:51, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Naresh,
>
> > The test case route4-change-dst fails intermittently creating
> > the problem for smoketest results verdict. route4-change-dst
> > is a stress test should not be a part of smoketest. because of
> > these issues removing route4-change-dst from the smoketest.
> Could you please be more specific about the failure?

Test log,

route-change-dst 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
route-change-dst 1 TINFO: add local addr 10.0.0.2/24
route-change-dst 1 TINFO: add local addr fd00:1:1:1::2/64
route-change-dst 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
[   54.413187] IPv6: ADDRCONF(NETDEV_CHANGE): ltp_ns_veth2: link becomes ready
route-change-dst 1 TINFO: add remote addr 10.0.0.1/24
route-change-dst 1 TINFO: add remote addr fd00:1:1:1::1/64
route-change-dst 1 TINFO: Network config (local -- remote):
route-change-dst 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
route-change-dst 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
route-change-dst 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
route-change-dst 1 TINFO: timeout per run is 0h 15m 0s
route-change-dst 1 TINFO: change IPv4 route destination 100 times
route-change-dst 1 TINFO: testing route '10.23.1.0/24'
bind: Cannot assign requested address
route-change-dst 1 TFAIL: ping -c1 -I 10.0.0.2 10.23.1.1 >/dev/null
failed unexpectedly
route-change-dst 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
route-change-dst 1 TINFO: add local addr 10.0.0.2/24
route-change-dst 1 TINFO: add local addr fd00:1:1:1::2/64
route-change-dst 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
route-change-dst 1 TINFO: add remote addr 10.0.0.1/24
route-change-dst 1 TINFO: add remote addr fd00:1:1:1::1/64

Summary:
passed   0
failed   1


>
> I'm not against adding ping tests into smoketest runtest file,
> although just on might be enough. ping02.sh is the fastest from all 3 tests,
> maybe add it. Also -6 for IPv6 would be good (to detect problems with IPv6 setup).

I will add
ping602 ping02.sh -6

>
> But route-change-dst.sh is quick (actually 2 times faster than ping01) that it's
> not really a stress test in the default configuration, thus I'd prefer to keep it.

The actual problem with route-change-dst.sh is an intermittent failure
test case.

Here is the link showing intermittent failure.  (click on the loadmore button)
https://qa-reports.linaro.org/_/comparetest/?project=136&suite=ltp-smoketest-tests&test=route4-change-dst


- Naresh
