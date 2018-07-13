From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 13 Jul 2018 08:27:08 +0100
Subject: [LTP] [PATCH] mfd: hi655x: Fix regmap area declared size for
	hi655x
In-Reply-To: <20180706172833.533-1-rafael.tinoco@linaro.org>
References: <20180706172833.533-1-rafael.tinoco@linaro.org>
Message-ID: <20180713072708.GL4641@dell>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, 06 Jul 2018, Rafael David Tinoco wrote:

> Fixes: https://bugs.linaro.org/show_bug.cgi?id=3903
> 
> LTP Functional tests have caused a bad paging request when triggering
> the regmap_read_debugfs() logic of the device PMIC Hi6553 (reading
> regmap/f8000000.pmic/registers file during read_all test):
> 
> Unable to handle kernel paging request at virtual address ffff0
> [ffff00000984e000] pgd=0000000077ffe803, pud=0000000077ffd803,0
> Internal error: Oops: 96000007 [#1] SMP
> ...
> Hardware name: HiKey Development Board (DT)
> ...
> Call trace:
>  regmap_mmio_read8+0x24/0x40
>  regmap_mmio_read+0x48/0x70
>  _regmap_bus_reg_read+0x38/0x48
>  _regmap_read+0x68/0x170
>  regmap_read+0x50/0x78
>  regmap_read_debugfs+0x1a0/0x308
>  regmap_map_read_file+0x48/0x58
>  full_proxy_read+0x68/0x98
>  __vfs_read+0x48/0x80
>  vfs_read+0x94/0x150
>  SyS_read+0x6c/0xd8
>  el0_svc_naked+0x30/0x34
> Code: aa1e03e0 d503201f f9400280 8b334000 (39400000)
> 
> Investigations have showed that, when triggered by debugfs read()
> handler, the mmio regmap logic was reading a bigger (16k) register area
> than the one mapped by devm_ioremap_resource() during hi655x-pmic probe
> time (4k).
> 
> This commit changes hi655x's max register, according to HW specs, to be
> the same as the one declared in the pmic device in hi6220's dts, fixing
> the issue.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Cc: <stable@vger.kernel.org> #v4.9 #v4.14 #v4.16 #v4.17
> ---
>  drivers/mfd/hi655x-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
