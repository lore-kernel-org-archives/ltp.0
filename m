From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Sep 2017 10:19:19 +0300
Subject: [LTP] [RFC PATCH v9 3/7] network/stress: Simplify
 make_background_tcp_traffic usage
In-Reply-To: <20170824234436.18145-4-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-4-pvorel@suse.cz>
Message-ID: <e90bac44-ceda-a991-dc1b-78b2a713416f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/25/2017 02:44 AM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/stress/interface/if-addr-adddel    | 6 +-----
>  testcases/network/stress/interface/if-addr-addlarge  | 6 +-----
>  testcases/network/stress/interface/if-mtu-change     | 7 ++-----
>  testcases/network/stress/interface/if-route-adddel   | 7 ++-----
>  testcases/network/stress/interface/if-route-addlarge | 6 +-----
>  testcases/network/stress/ns-tools/test_net_stress.sh | 2 ++
>  6 files changed, 9 insertions(+), 25 deletions(-)

Applied.

Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170908/584fa215/attachment.html>
