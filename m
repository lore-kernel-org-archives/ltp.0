From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 7 Jul 2021 09:04:38 +0200
Subject: [LTP] [PATCH] ltp_tpci.c: Add release operation before
 allocation
In-Reply-To: <fd26cf45-7dd8-004f-3d41-422ce4d9bbdb@canonical.com>
References: <20210401125127.45600-1-wangxin410@huawei.com>
 <YNoxKg+Hm0qa3Z70@pevik> <fd26cf45-7dd8-004f-3d41-422ce4d9bbdb@canonical.com>
Message-ID: <34bbe196-515c-f4f3-6d1c-5c9f1221e52a@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29/06/2021 11:38, Krzysztof Kozlowski wrote:
> On 28/06/2021 22:29, Petr Vorel wrote:
>> Hi Xin,
>>
>>> When we run the test case, the following results will be obtained:
>>> test_pci  283  TPASS  :  PCI bus 7d slot 00 : Test-case '11'
>>> test_pci  284  TFAIL  :  tpci.c:74: PCI bus 7d slot 00 : Test-case '12'
>>> ...
>>> test_pci  300  TFAIL  :  tpci.c:74: PCI bus 7d slot 01 : Test-case '12'
>>> test_pci  301  TPASS  :  PCI bus 7d slot 01 : Test-case '13'
>>
>>> The analysis is that the space allocated by the bios is insufficient.
>>> The solution to this problem can be in add pci_release_resource(dev, i)
>>> before system resources are reallocated.Because the resources have been
>>> allocated when the system is initialized.If it is redistributed, it
>>> should be released and then allocated.
>>
>> I wonder if this is the same issue as the one described by Krzysztof in his
>> patch:
>> https://patchwork.ozlabs.org/project/ltp/patch/20210401125127.45600-1-wangxin410@huawei.com/
>>
>> Could you please share what HW and kernel you use and post dmesg?
> 
> This solves my problem. It seems that could be the root cause - early
> configuration allocated too small resource? It might be also some
> specific BIOS issue (wrong resource allocated?) because in case of
> resource assignment failure, the kernel should try to get the original
> FW address from BIOS (pcibios_retrieve_fw_addr()) and this apparently
> returns NULL translated to -ENOMEM.
> 
> I am fine with going with this patch instead of mine.
> 

Is there anything stopping Xin's patch from being applied? LGTM:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
