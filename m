From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Jul 2021 13:43:13 +0200
Subject: [LTP] [PATCH 2/2] tpci: accept ENOMEM resource failure with
 virtio-pci
In-Reply-To: <YNov+zuL+C4JFlsJ@pevik>
References: <20210618130536.54806-1-krzysztof.kozlowski@canonical.com>
 <20210618130536.54806-2-krzysztof.kozlowski@canonical.com>
 <YNov+zuL+C4JFlsJ@pevik>
Message-ID: <YP6f0WWfbybimXG7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

just for a record: Krzysztof confirmed [1] that d631e9cae ("ltp_tpci.c: Add release
operation before allocation") fixed issue with virtio-pci reported here,
suggested to refuse this patch.

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2021-July/024053.html
