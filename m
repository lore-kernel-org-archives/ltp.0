From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Sep 2019 15:56:16 +0300
Subject: [LTP] [PATCH v4 0/7] net/route: rewrite route-change-{dst, gw,
 if} into new API
In-Reply-To: <20190903141610.28887-1-pvorel@suse.cz>
References: <20190903141610.28887-1-pvorel@suse.cz>
Message-ID: <df197557-8f95-52d5-813e-a5abc73a1af6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 9/3/19 5:16 PM, Petr Vorel wrote:
> Hi Alexey,
> 
> this version address functionality problems you pointed out.
> But yet there might need to be another version as I'm not sure about
> tst_ipaddr_un() API changes.
> 
> Changes v3-v4:
> * enhanced tst_ipaddr_un() with -b, -h -l, -m, -n and -p options (-p was
> previous -m)
> * use tst_ipaddr_un() options to fix address clash on host_id, net_id clash fix
> by adjusting $1 in test (this is really inconsistent, see note at 3/7).
> * added tests for tst_ipaddr_un()
> * quiet EXPECT_PASS ping$TST_IPV6
> 

The patch-set looks good, the only concerns are:

* complicated tst_ipaddr_un(), may be add another high-level function
  to use raw tst_ipadd_un(), if -b, -f, -n options are really needed?

* if NS_TIMES is large, there are a lot of messages in a test output
  (it seems NS_TIMES * 4), could we minimize the number of them?
