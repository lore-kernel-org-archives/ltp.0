From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Sep 2018 15:02:22 +0200
Subject: [LTP] [PATCH v2 4/4] network/ipsec: replace ipsec_try() with
 TST_RTNL_CHK()
In-Reply-To: <1534764229-26993-4-git-send-email-alexey.kodanev@oracle.com>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
 <1534764229-26993-4-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180913130222.GB30936@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v2: fixed missing ip before TST_RTNL_CHK

Merged your patch to have it for the release.
Thanks a lot!

NOTE: I'm going to leave the 1st and 2nd patch, as there is currently no test
using it. I guess we'd like to use it in tst_net.sh for netns.


Kind regards,
Petr
