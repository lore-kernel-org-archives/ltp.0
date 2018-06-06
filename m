From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 6 Jun 2018 17:21:20 +0300
Subject: [LTP] [PATCH 0/7] TST_IPVER
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <2b765425-664a-d4f6-3547-c2a63cd9b96e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01.06.2018 14:49, Petr Vorel wrote:
> Hi,
> 
> this is a better implementation of part of
> "tst_net.sh: Simplify ipver settings code" part of patch-set posted in [1]
> 
> 
> Kind regards,
> Petr
> 
> [1] http://lists.linux.it/pipermail/ltp/2018-May/008240.html
> 
> Petr Vorel (7):
>   tst_net.sh: Simplify ipver settings code
>   tst_net.sh: Rename ipver to TST_IPVER
>   net/dns: Replace $ipver by $TST_IPVER from tst_net.sh
>   net/ftp: Replace $ipver by $TST_IPVER from tst_net.sh
>   net/http: Replace $ipver by $TST_IPVER from tst_net.sh
>   net/ssh: Replace $ipver by $TST_IPVER from tst_net.sh
>   net/virt: Replace $ipver by $TST_IPVER from tst_net.sh
> 

The patch-set look good, acked.

BTW, I would rather split such patches on these logical changes:
* introduce new TST_IPVER library variable
* remove $ipver setups and replace the usage with $TST_IPVER.

>  testcases/lib/tst_net.sh                                   |  5 ++---
>  testcases/lib/tst_test.sh                                  |  2 +-
>  testcases/network/stress/dns/dns-stress                    | 12 +++++-------
>  testcases/network/stress/ftp/ftp-download-stress           |  3 +--
>  testcases/network/stress/ftp/ftp-upload-stress             |  3 +--
>  testcases/network/stress/http/http-stress                  |  3 +--
>  testcases/network/stress/interface/if-addr-adddel          |  2 +-
>  testcases/network/stress/interface/if-addr-addlarge        |  2 +-
>  testcases/network/stress/interface/if-route-addlarge       |  2 +-
>  .../multicast/grp-operation/mcast-group-multiple-socket    |  2 +-
>  .../stress/multicast/grp-operation/mcast-group-same-group  |  2 +-
>  .../multicast/grp-operation/mcast-group-single-socket      |  2 +-
>  .../multicast/grp-operation/mcast-group-source-filter      |  2 +-
>  .../network/stress/multicast/grp-operation/mcast-lib.sh    |  2 +-
>  testcases/network/stress/ns-tools/tst_net_stress.sh        |  2 +-
>  testcases/network/stress/ssh/ssh-stress                    | 14 ++++++--------
>  testcases/network/virt/virt_lib.sh                         |  6 ++----
>  17 files changed, 28 insertions(+), 38 deletions(-)
> 

