From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 09:28:54 +0100
Subject: [LTP] [PATCH 4/4] network: add new test-cases with randomized
 message length
In-Reply-To: <1550587673-7995-5-git-send-email-alexey.kodanev@oracle.com>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
 <1550587673-7995-5-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190220082854.GD15392@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> * Change test-cases in dctcp01 (TCP). Default size changed to random size.

> * New test-cases added to tcp, sctp and udp IPsec tests

> * Updated bind_noport01

> * New tests: gre02, geneve02, macsec03, vxlan04
Commit is quite big. I know, that all is related to randomized message length.
But maybe these new tests can be added in separate commit.

> * Besides random payload changes:
>   - in macsec03, replay window increased from 300 to 1000
>   - vxlan04 and geneve02: new checksum testcases
>   - new tests use different protocol types

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net.features                            |    9 +
>  runtest/net_stress.ipsec_dccp                   |  208 +++++++++++-----------
>  runtest/net_stress.ipsec_sctp                   |  208 +++++++++++-----------
>  runtest/net_stress.ipsec_tcp                    |  208 +++++++++++-----------
>  runtest/net_stress.ipsec_udp                    |  212 +++++++++++-----------
>  testcases/network/sockets/bind_noport01.sh      |   15 ++-
>  testcases/network/stress/dccp/dccp_ipsec.sh     |    6 +-
>  testcases/network/stress/dccp/dccp_ipsec_vti.sh |    6 +-
>  testcases/network/stress/sctp/sctp_ipsec.sh     |    6 +-
>  testcases/network/stress/sctp/sctp_ipsec_vti.sh |    6 +-
>  testcases/network/stress/tcp/tcp_ipsec.sh       |    6 +-
>  testcases/network/stress/tcp/tcp_ipsec_vti.sh   |    6 +-
>  testcases/network/stress/udp/udp_ipsec.sh       |    7 +-
>  testcases/network/stress/udp/udp_ipsec_vti.sh   |    7 +-
>  testcases/network/virt/geneve02.sh              |   38 ++++
>  testcases/network/virt/gre02.sh                 |   11 ++
>  testcases/network/virt/macsec03.sh              |   13 ++
>  testcases/network/virt/virt_lib.sh              |   10 +
>  testcases/network/virt/vxlan04.sh               |   39 ++++
>  19 files changed, 592 insertions(+), 429 deletions(-)
>  create mode 100755 testcases/network/virt/geneve02.sh
>  create mode 100755 testcases/network/virt/gre02.sh
>  create mode 100755 testcases/network/virt/macsec03.sh
>  create mode 100755 testcases/network/virt/vxlan04.sh
...

> +++ b/testcases/network/virt/geneve02.sh
...
> +. virt_lib.sh
> +
> +VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
VIRT_PERF_THRESHOLD is read in virt_lib.sh. So this first line does not have
to be here. That applies also for vxlan04.sh (this commit) + other testcases
which already use this variable.
> +[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160


Kind regards,
Petr
