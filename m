From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Aug 2019 14:59:55 +0200
Subject: [LTP] [PATCH v3 3/5] network/route: Rewrite route-change-dst
 into new API
In-Reply-To: <20190725111027.18716-4-pvorel@suse.cz>
References: <20190725111027.18716-1-pvorel@suse.cz>
 <20190725111027.18716-4-pvorel@suse.cz>
Message-ID: <20190802125955.GA707@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> * Drop route command (use just ip command), support both IPv4 and IPv6
> * Add route-lib.sh (will be used in other route-change-*)
> * Use unused network range to avoid clash with real network
> * Add verification with ping (previous version sent UDP datagram with
> ns-udpsender, but didn't verify receiving it on rhost and didn't setup
> rhost ip at all)

> Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net_stress.route                      |   4 +-
>  .../network/stress/route/00_Descriptions.txt  |  18 +-
>  .../network/stress/route/route-change-dst     |  33 +++
>  testcases/network/stress/route/route-lib.sh   |  17 ++
>  .../network/stress/route/route4-change-dst    | 276 ------------------
>  .../network/stress/route/route6-change-dst    | 272 -----------------
>  6 files changed, 55 insertions(+), 565 deletions(-)
>  create mode 100755 testcases/network/stress/route/route-change-dst
Just a small change, not worth of sending v2: use .sh extension
for all 3 tests (route-change-{dst,gw,if}.sh).

Kind regards,
Petr
