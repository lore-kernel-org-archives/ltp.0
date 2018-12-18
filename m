From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Dec 2018 02:07:04 +0100
Subject: [LTP] [PATCH v5 1/3] net: Add tst_net_run helper
In-Reply-To: <20181130203753.19765-1-pvorel@suse.cz>
References: <20181130203753.19765-1-pvorel@suse.cz>
Message-ID: <20181218010704.GA3845@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> and use it in tst_set_sysctl

> + improve doc of tst_rhost_run()

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> Changes v4->v5:
> * Add -q mode (default off) in tst_net_run()
> * Fix in tst_set_sysctl() for rhost (passed everything as single command
> to avoid processing -w in tst_net_run() as getopt.

FYI patchset merged.


Kind regards,
Petr
