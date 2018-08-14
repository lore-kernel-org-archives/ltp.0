From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Aug 2018 20:39:55 +0200
Subject: [LTP] [PATCH RFC 3/4] lib/tst_test.sh: add TST_RTNL_CHK()
 helper function
In-Reply-To: <1533828226-24753-3-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <1533828226-24753-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180814183955.GC30905@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> It should parse iproute commands output and exit the test with TCONF
> if there are certain messages returned from iproute/RTNETLINK.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)


Kind regards,
Petr
