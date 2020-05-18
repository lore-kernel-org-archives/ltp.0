From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 18 May 2020 11:26:57 +0800
Subject: [LTP] [PATCH v1 1/2] tpci: remove useless ENABLE_BRIDGES
In-Reply-To: <1589353614-24423-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1589353614-24423-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5EC20081.1000508@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks for your work, pushed.

Best Regards,
Xiao Yang
On 2020/5/13 15:06, Yang Xu wrote:
> Since the previous commit, we have removed test_enable_bridges() because
> pci_enable_bridges() was removed in 3.12 (928bea964827). But it forgot
> to delete it in tpci.h. So remove it.
>
> Fixes: 3dd286b ("ltp_tpci.c: Update legacy code")
> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
> index f65c6fc22..f7defb29f 100644
> --- a/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
> +++ b/testcases/kernel/device-drivers/pci/tpci_kernel/tpci.h
> @@ -30,7 +30,6 @@ enum PCI_TCASES {
>   	FIND_SUBSYS,
>   	BUS_SCAN,
>   	SLOT_SCAN,
> -	ENABLE_BRIDGES,
>   	BUS_ADD_DEVICES,
>   	MATCH_DEVICE,
>   	REG_DRIVER,



