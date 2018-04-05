From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 5 Apr 2018 15:40:31 +0200
Subject: [LTP] [PATCH 1/2] lib/test_net.sh: lower default test parameters
In-Reply-To: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
References: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180405134031.mabcwgdiihs4bd5z@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Default scenario should not take hours to complete.
Great, agree.

> Also export TST_NETLOAD_CLN_REQUESTS which is used by all
> tst_netload tests and can control the test execution time.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/lib/test_net.sh |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)

> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 203464f..2f7668f 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -651,20 +651,21 @@ if [ -z "$TST_PARSE_VARIABLES" ]; then
>  	export TST_PARSE_VARIABLES="yes"
>  fi

> +export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
This variable is also in testcases/network/sockets/bind_noport01.sh, shouldn't you remove
it from there (it uses test_net.sh).

Also, why not to handle the same way TST_NETLOAD_CLN_NUMBER ?
(also used in tst_netload).

And I'd put it into separate commit.


Kind regards,
Petr
