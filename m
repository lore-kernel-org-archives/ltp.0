From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 Oct 2018 15:06:11 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20180802141251.1571-2-mylene.josserand@bootlin.com>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
Message-ID: <20181004130611.GB32169@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mylène,

> If there is no support for "dummy" or "veth", the tests will fail
> with errors:
>    RTNETLINK answers: Operation not supported
>    netns_sysfs 1 TBROK: failed to add a new (host) dummy device
> and
>    RTNETLINK answers: Operation not supported
>    netns_comm_ip_ipv6_ioctl 1 TBROK: unable to create veth pair devices
>    Cannot find device "veth0"

> This commit is storing the output of the commands and verifies
> if there is any reference to "Operation not supported".
> This code is based on what it is already done in "ipsec_lib.sh"
> stress test.

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>

..
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
...
> +			tst_brkm TCONF "Command not supported (maybe missing 'veth' support)"

..
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
..
> +		tst_brkm TCONF "Command not supported (maybe missing 'dummy' support)"

Can you implement this patch with TST_NEEDS_DRIVERS (recently contributed by
Alexey Kodanev)? Thanks a lot!


Kind regards,
Petr
