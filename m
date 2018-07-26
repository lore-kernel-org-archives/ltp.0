From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Jul 2018 09:37:39 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add default trap to INT
In-Reply-To: <20180614100436.28558-1-pvorel@suse.cz>
References: <20180614100436.28558-1-pvorel@suse.cz>
Message-ID: <20180726073738.GA17185@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> + remove it's definition from network stress tests already
> converted to the new API.

> Trap function can be overwritten in tests, if needed.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh                           | 3 +++
>  testcases/network/stress/interface/if4-addr-change  | 2 --
>  testcases/network/stress/ns-tools/tst_net_stress.sh | 1 -
>  3 files changed, 3 insertions(+), 3 deletions(-)

Pushed.


Kind regards,
Petr
