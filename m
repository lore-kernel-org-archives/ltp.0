From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Jul 2021 10:36:51 +0200
Subject: [LTP] [PATCH] ltp_tpci.c: Add release operation before
 allocation
In-Reply-To: <ca6ecb17-c1b4-0d8a-a3c4-dc5e8e2bd275@canonical.com>
References: <20210401125127.45600-1-wangxin410@huawei.com>
 <YNoxKg+Hm0qa3Z70@pevik>
 <fd26cf45-7dd8-004f-3d41-422ce4d9bbdb@canonical.com>
 <34bbe196-515c-f4f3-6d1c-5c9f1221e52a@canonical.com>
 <ca6ecb17-c1b4-0d8a-a3c4-dc5e8e2bd275@canonical.com>
Message-ID: <YP50I9N3dfASNrvz@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> On 07/07/2021 09:04, Krzysztof Kozlowski wrote:
> > On 29/06/2021 11:38, Krzysztof Kozlowski wrote:
> >> On 28/06/2021 22:29, Petr Vorel wrote:
> >>> Hi Xin,

> >>>> When we run the test case, the following results will be obtained:
> >>>> test_pci  283  TPASS  :  PCI bus 7d slot 00 : Test-case '11'
> >>>> test_pci  284  TFAIL  :  tpci.c:74: PCI bus 7d slot 00 : Test-case '12'
> >>>> ...
> >>>> test_pci  300  TFAIL  :  tpci.c:74: PCI bus 7d slot 01 : Test-case '12'
> >>>> test_pci  301  TPASS  :  PCI bus 7d slot 01 : Test-case '13'

> >>>> The analysis is that the space allocated by the bios is insufficient.
> >>>> The solution to this problem can be in add pci_release_resource(dev, i)
> >>>> before system resources are reallocated.Because the resources have been
> >>>> allocated when the system is initialized.If it is redistributed, it
> >>>> should be released and then allocated.

> >>> I wonder if this is the same issue as the one described by Krzysztof in his
> >>> patch:
> >>> https://patchwork.ozlabs.org/project/ltp/patch/20210401125127.45600-1-wangxin410@huawei.com/

> >>> Could you please share what HW and kernel you use and post dmesg?

> >> This solves my problem. It seems that could be the root cause - early
> >> configuration allocated too small resource? It might be also some
> >> specific BIOS issue (wrong resource allocated?) because in case of
> >> resource assignment failure, the kernel should try to get the original
> >> FW address from BIOS (pcibios_retrieve_fw_addr()) and this apparently
> >> returns NULL translated to -ENOMEM.

> >> I am fine with going with this patch instead of mine.


> > Is there anything stopping Xin's patch from being applied? LGTM:
Lack of time :)

> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Oh, I see what's wrong with the patch - it's corrupted, not possible to
> apply.

Trivial fix, I'll merge it shortly.

Kind regards,
Petr

> Best regards,
> Krzysztof
