From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Jul 2021 10:40:24 +0200
Subject: [LTP] [PATCH] ltp_tpci.c: Add release operation before
 allocation
In-Reply-To: <ca6ecb17-c1b4-0d8a-a3c4-dc5e8e2bd275@canonical.com>
References: <20210401125127.45600-1-wangxin410@huawei.com>
 <YNoxKg+Hm0qa3Z70@pevik>
 <fd26cf45-7dd8-004f-3d41-422ce4d9bbdb@canonical.com>
 <34bbe196-515c-f4f3-6d1c-5c9f1221e52a@canonical.com>
 <ca6ecb17-c1b4-0d8a-a3c4-dc5e8e2bd275@canonical.com>
Message-ID: <YP50+GkBceVIr4It@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof

...
> > Is there anything stopping Xin's patch from being applied? LGTM:

BTW does it solve your issue "tpci: accept ENOMEM resource failure with
virtio-pci" [1] ?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210618130536.54806-2-krzysztof.kozlowski@canonical.com/
