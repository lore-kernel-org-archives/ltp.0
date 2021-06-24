From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 24 Jun 2021 21:32:42 +0200
Subject: [LTP] [PATCH 1/2] tpci: fix NULL pointer dereference on wrong
 test invocation
In-Reply-To: <20210618130536.54806-1-krzysztof.kozlowski@canonical.com>
References: <20210618130536.54806-1-krzysztof.kozlowski@canonical.com>
Message-ID: <8753cbfb-01ac-34f9-57d6-afa33629ac78@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18/06/2021 15:05, Krzysztof Kozlowski wrote:
> Fix NULL pointer dereference when a ltp_tpci test case is started before
> choosing the device:
> 
>     ltp_tpci: test-case 12
>     ltp_tpci: assign resources
>     ltp_tpci: assign resource #0
>     BUG: kernel NULL pointer dereference, address: 00000000000003b8
>     ...
>      Call Trace:
>       dev_attr_store+0x17/0x30
>       sysfs_kf_write+0x3e/0x50
>       kernfs_fop_write_iter+0x13c/0x1d0
>       new_sync_write+0x113/0x1a0
>       vfs_write+0x1c5/0x200
>       ksys_write+0x67/0xe0
>       __x64_sys_write+0x1a/0x20
>       do_syscall_64+0x49/0xc0
>       entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Hi everyone,

Any comments on these two tpci patches? Do they look reasonable?

Best regards,
Krzysztof
