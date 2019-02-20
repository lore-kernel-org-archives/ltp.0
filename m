From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 09:15:24 +0100
Subject: [LTP] [PATCH 2/4] lib/tst_net.sh: add new TST_NET_MAX_PKT env
 variable
In-Reply-To: <1550587673-7995-3-git-send-email-alexey.kodanev@oracle.com>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
 <1550587673-7995-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190220081524.GB15392@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> This is critical for performance tests, which compare virtual
> devices with the real ones. Trigger the fragmentation but keep
> the number of fragments at the minimum for those cases.

> Also improve the test timing if MTU is not large.

> The previous numbers can be restored with TST_NET_MAX_PKT
> environment variable.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
