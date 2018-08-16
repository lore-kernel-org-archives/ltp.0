From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Aug 2018 10:54:58 +0200
Subject: [LTP] [PATCH RFC 2/4] lib/tst_test.sh: add TST_NEEDS_DRIVERS
 parameter
In-Reply-To: <1533828226-24753-2-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <1533828226-24753-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180816085458.GA19422@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The drivers are checked with tst_check_drivers.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---

>  	tst_test_cmds $TST_NEEDS_CMDS
> +	tst_test_drivers $TST_NEEDS_DRIVERS

I'm sorry here must be some fix:
+	if [ -n "$TST_NEEDS_DRIVERS" ]; then
+		tst_test_drivers $TST_NEEDS_DRIVERS
+	fi

Otherwise tests without $TST_NEEDS_DRIVERS TCONF:
tcp_ipsec_vti 1 TCONF: 'Please provide kernel driver list' driver not found


Kind regards,
Petr
