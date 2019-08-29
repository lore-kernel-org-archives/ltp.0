From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 21:25:18 +0200
Subject: [LTP] [PATCH 1/2] tst_net.sh: Move variable and link setup to
 separate function
In-Reply-To: <20190829190709.30834-1-pvorel@suse.cz>
References: <20190829190709.30834-1-pvorel@suse.cz>
Message-ID: <20190829192518.GA1197@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> When using LTP with netns ("Single Host Configuration"),
> init_ltp_netspace before running test which performs checking for
> TST_NEEDS_ROOT=1, therefore adding it is not enough.
> It fails on adding netns:

> RTNETLINK answers: Operation not permitted
> sctp01 1 TBROK: ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2 failed

> NOTE: tst_restore_ipaddr is called before running tests only on netns,
> in init_ltp_netspace, therefore tst_require_root_ as a check is enough.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Rejecting it myself, as it's not an improvement.

Kind regards,
Petr
