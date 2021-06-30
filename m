From: wangxin (CQ) <wangxin410@huawei.com>
Date: Wed, 30 Jun 2021 02:14:28 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gbHRwX3RwY2kuYzogQWRkIHJl?=
 =?gb2312?b?bGVhc2Ugb3BlcmF0aW9uIGJlZm9yZSBhbGxvY2F0aW9u?=
In-Reply-To: <YNoxKg+Hm0qa3Z70@pevik>
References: <20210401125127.45600-1-wangxin410@huawei.com>
 <YNoxKg+Hm0qa3Z70@pevik>
Message-ID: <0af806e1a9da40ee8d5fb1745ed34bdc@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

The following is the kernel version information of the test case. The hardware information is in the attachment.

# uname -a
Linux hulk-168 4.19.195+ #1 SMP Tue Jun 29 09:42:18 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
# lscpu 
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              128
On-line CPU(s) list: 0-127
Thread(s) per core:  1
Core(s) per socket:  64
Socket(s):           2
NUMA node(s):        4
Vendor ID:           0x48
Model:               0
Stepping:            0x1
CPU max MHz:         2600.0000
CPU min MHz:         200.0000
BogoMIPS:            200.00
L1d cache:           64K
L1i cache:           64K
L2 cache:            512K
L3 cache:            65536K
NUMA node0 CPU(s):   0-31
NUMA node1 CPU(s):   32-63
NUMA node2 CPU(s):   64-95
NUMA node3 CPU(s):   96-127
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp asimdfhm

Kind regards,
Xin

-----????-----
???: Petr Vorel [mailto:pvorel@suse.cz] 
????: 2021?6?29? 4:30
???: wangxin (CQ) <wangxin410@huawei.com>
??: ltp@lists.linux.it; Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
??: Re: [LTP] [PATCH] ltp_tpci.c: Add release operation before allocation

Hi Xin,

> When we run the test case, the following results will be obtained:
> test_pci  283  TPASS  :  PCI bus 7d slot 00 : Test-case '11'
> test_pci  284  TFAIL  :  tpci.c:74: PCI bus 7d slot 00 : Test-case '12'
> ...
> test_pci  300  TFAIL  :  tpci.c:74: PCI bus 7d slot 01 : Test-case '12'
> test_pci  301  TPASS  :  PCI bus 7d slot 01 : Test-case '13'

> The analysis is that the space allocated by the bios is insufficient.
> The solution to this problem can be in add pci_release_resource(dev, 
> i) before system resources are reallocated.Because the resources have 
> been allocated when the system is initialized.If it is redistributed, 
> it should be released and then allocated.

I wonder if this is the same issue as the one described by Krzysztof in his
patch:
https://patchwork.ozlabs.org/project/ltp/patch/20210401125127.45600-1-wangxin410@huawei.com/

Could you please share what HW and kernel you use and post dmesg?

Kind regards,
Petr

> Signed-off-by: Wang Xin <wangxin410@huawei.com>
> ---
>  testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git 
> a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c 
> b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
> index e29821dda..5b0896093 100644
> --- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
> +++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
> @@ -439,6 +439,7 @@ static int test_assign_resources(void)
>  		if (r->flags & IORESOURCE_MEM &&
>  			r->flags & IORESOURCE_PREFETCH) {
> +			pci_release_resource(dev, i);
>  			ret = pci_assign_resource(dev, i);
>  			prk_info("assign resource to '%d', ret '%d'", i, ret);
>  			rc |= (ret < 0 && ret != -EBUSY) ? TFAIL : TPASS;
> 2.17.1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.log
Type: application/octet-stream
Size: 135634 bytes
Desc: dmesg.log
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210630/6e9839e7/attachment-0001.obj>
