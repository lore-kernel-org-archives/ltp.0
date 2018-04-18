From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Apr 2018 08:11:52 +0200
Subject: [LTP] Errored: linux-test-project/ltp#758 (master - 06ee2b0)
In-Reply-To: <5ad64480951dd_43f9e19419460435637@6c41ee02-ea54-406b-b1d2-cd774a36365b.mail>
References: <linux-test-project/ltp+367800244+errored@travis-ci.org>
 <5ad64480951dd_43f9e19419460435637@6c41ee02-ea54-406b-b1d2-cd774a36365b.mail>
Message-ID: <20180418061152.i44g47utzldyw7lc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Build Update for linux-test-project/ltp
> -------------------------------------

> Build: #758
> Status: Errored

> Duration: 14 mins and 34 secs
> Commit: 06ee2b0 (master)
> Author: Petr Vorel
> Message: network/vxlan03: Fix getopts parameters passed to virt_lib.sh

> vxlan03.sh pass getopts parameter to virt_lib.sh (other than -6 which is
> handled by tst_net.sh), so they must be processed before loading
> tst_net.sh. Therefore vxlan03.sh must load virt_lib.sh before loading
> tst_net.sh and virt_lib.sh must shift parameters.

> Also load tst_net.sh in vxlan03.sh, as it uses functions from network
> API (old error).

> Other users of vxlan03.sh not fixed as they pass just -6 parameter.

> Fixes: ba53eb04e tst_net.sh: Support both new and legacy APIs + rename

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reported-by: Alexey Kodanev <alexey.kodanev@oracle.com>

> View the changeset: https://github.com/linux-test-project/ltp/compare/48b24bc626fa...06ee2b0273bd

> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/367800244?utm_source=email&utm_medium=notification

False positive, again. This time it's due failing to install Java
(oracle-java8-installer and oracle-java9-installer).
I delete these repositories.


Kind regards,
Petr
