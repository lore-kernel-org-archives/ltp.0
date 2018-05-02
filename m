From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 02 May 2018 13:29:18 +0200
Subject: [LTP] LTP master testing on arm64 hikey
In-Reply-To: <CA+G9fYtDbxYEjA6T=0cf5wL-9VentRkmKZPHP7dxGCwk-NBOXQ@mail.gmail.com>
References: <CA+G9fYtDbxYEjA6T=0cf5wL-9VentRkmKZPHP7dxGCwk-NBOXQ@mail.gmail.com>
Message-ID: <878t92l2i9.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Naresh Kamboju writes:

> LTP master branch tested on arm64 Hikey device and we have noticed
> following observations,
>
>
> LTP Syscalls,
> -------------------
> utimensat01 1 TBROK: can't read /etc/sudoers
> https://lkft.validation.linaro.org/scheduler/job/203110#L12218
>
> LTP fs,
>
> The newly added test cases failed.
>
> read_all_dev: fail
> read_all_proc: fail
> read_all_sys: fail

Well the retrying messages are definitely not helpful, I think we should
remove them.

My guess is that one or more of the read_all tests read one or more
buggy sys files causing the stack traces (probably one which is exposed
by a driver). On the other hand it could just be that the board can not
handle having so many files read in parallel.

I would start by running "./read_all -d /dev -e '/dev/watchdog?(0)'"
manually. See ./read_all --help and the fs runtest file.

>
> kernel dump when running LTP fs tests,
>
> [ 1300.112030] raid6: int64x2  gen()   683 MB/s
> [ 1300.184024] raid6: int64x2  xor()   603 MB/s
> [ 1300.256046] raid6: int64x4  gen()  1056 MB/s
> [ 1300.328016] raid6: int64x4  xor()   745 MB/s
> [ 1300.400044] raid6: int64x8  gen()   986 MB/s
> [ 1300.472043] raid6: int64x8  xor()   745 MB/s
> [ 1300.544015] raid6: neonx1   gen()   742 MB/s
> [ 1300.616036] raid6: neonx1   xor()   851 MB/s
> [ 1300.688016] raid6: neonx2   gen()  1180 MB/s
> [ 1300.760019] raid6: neonx2   xor()  1198 MB/s
> [ 1300.832224] raid6: neonx4   gen()  1537 MB/s
> [ 1300.904031] raid6: neonx4   xor()  1435 MB/s
> [ 1300.976046] raid6: neonx8   gen()  1620 MB/s
> [ 1301.048024] raid6: neonx8   xor()  1511 MB/s
> [ 1301.052449] raid6: using algorithm neonx8 gen() 1620 MB/s
> [ 1301.058045] raid6: .... xor() 1511 MB/s, rmw enabled
> [ 1301.063203] raid6: using neon recovery algorithm
> [ 1301.092481] xor: measuring software checksum speed
> [ 1301.136024]    8regs     :  2280.000 MB/sec
> [ 1301.180019]    8regs_prefetch:  2034.000 MB/sec
> [ 1301.224018]    32regs    :  2797.000 MB/sec
> [ 1301.268018]    32regs_prefetch:  2359.000 MB/sec
> [ 1301.272805] xor: using function: 32regs (2797.000 MB/sec)
> [ 1301.383951] Btrfs loaded, crc32c=crc32c-arm64-ce
> [ 1301.426892] uart-pl011 f7112000.uart: no DMA platform data
> [ 1301.662370] Unable to handle kernel paging request at virtual
> address ffff7dfffee00000
> [ 1301.662379] Mem abort info:
> [ 1301.673872]   ESR = 0x96000006
> [ 1301.673880]   Exception class = DABT (current EL), IL = 32 bits
> [ 1301.673885]   SET = 0, FnV = 0
> [ 1301.673890]   EA = 0, S1PTW = 0
> [ 1301.673894] Data abort info:
> [ 1301.673899]   ISV = 0, ISS = 0x00000006
> [ 1301.673903]   CM = 0, WnR = 0
> [ 1301.673912] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 00000000be577448
> [ 1301.673917] [ffff7dfffee00000] pgd=0000000001658803,
> pud=0000000001659803, pmd=0000000000000000
> [ 1301.674399] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [ 1301.721431] Modules linked in: cuse btrfs xor zstd_decompress
> zstd_compress xxhash raid6_pq tun asix usbnet crc32_ce crct10dif_ce
> hci_uart adv7511 cec bluetooth ecdh_generic kirin_drm rfkill
> drm_kms_helper dw_drm_dsi drm drm_panel_orientation_quirks fuse
> [ 1301.721509] CPU: 1 PID: 7826 Comm: read_all Not tainted 4.16.0 #1
> [ 1301.721513] Hardware name: HiKey Development Board (DT)
> [ 1301.721519] pstate: 40000005 (nZcv daif -PAN -UAO)
> [ 1301.721540] pc : read_port+0xd4/0x170
> [ 1301.764723] lr : read_port+0x9c/0x170
> [ 1301.764726] sp : ffff000016603d20
>
> <>
>
> [ 1310.644163] dwc2 f72c0000.usb: Mode Mismatch Interrupt: currently
> in Host mode
> [ 1310.644176] dwc2 f72c0000.usb: Mode Mismatch Interrupt: currently
> in Host mode
> [ 1310.644189] dwc2 f72c0000.usb: Mode Mismatch Interrupt: currently
> in Host mode
> [ 1327.832272] INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1327.832287] 4-...0: (0 ticks this GP)
> idle=6a2/1/4611686018427387904 softirq=71103/71103 fqs=3228
> [ 1327.832291] (detected by 3, t=6502 jiffies, g=70806, c=70805, q=121109)
> [ 1327.832302] Task dump for CPU 4:
> [ 1327.832307] read_all        R  running task        0  7825      1 0x0000020a
> [ 1327.832319] Call trace:
> [ 1327.832335]  __switch_to+0x9c/0xe0
> [ 1327.832345]  page_wait_table+0x4280/0x4800
>
> Broadcast message fro[ 1344.329981] systemd-journald[1642]: /dev/kmsg
> buffer overrun, some messages lost.
> m systemd-journald@hikey (Mon 2018-03-26 14:44:28 UTC):
> [ 1344.341386] Unable to handle kernel paging request at virtual
> address ffff7dfffee00000
>
> kernel[2801]: [ 1301.674399[ 1344.352987] Mem abort info:
> ] Internal error: Oops: 96000006[ 1344.352992]   ESR = 0x96000006
>  [#1] PREEMPT SMP
> [ 1344.352998]   Exception class = DABT (current EL), IL = 32 bits
> [ 1344.353001]   SET = 0, FnV = 0
> [ 1344.353004]   EA = 0, S1PTW = 0
> [ 1344.353007] Data abort info:
> [ 1344.353011]   ISV = 0, ISS = 0x00000006
> [ 1344.353014]   CM = 0, WnR = 0
> [ 1344.353021] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 00000000be577448
> [ 1344.353025] [ffff7dfffee00000] pgd=0000000001658803,
> pud=0000000001659803, pmd=0000000000000000
> [ 1344.353041] Internal error: Oops: 96000006 [#2] PREEMPT SMP
> [ 1344.353049] Modules linked in: cuse btrfs xor zstd_decompress
> zstd_compress xxhash raid6_pq tun asix usbnet crc32_ce crct10dif_ce
> hci_uart adv7511 cec bluetooth ecdh_generic kirin_drm rfkill
> drm_kms_helper dw_drm_dsi drm drm_panel_orientation_quirks fuse
> [ 1344.426968] CPU: 7 PID: 7825 Comm: read_all Tainted: G      D
>    4.16.0 #1
> [ 1344.426971] Hardware name: HiKey Development Board (DT)
> [ 1344.426978] pstate: 40000005 (nZcv daif -PAN -UAO)
> [ 1344.426992] pc : read_port+0xd4/0x170
> [ 1344.426998] lr : read_port+0x9c/0x170
>
> Ref links:
> https://lkft.validation.linaro.org/scheduler/job/203101#L2159
> https://lkft.validation.linaro.org/scheduler/job/203101#L8030
> https://lkft.validation.linaro.org/scheduler/job/203110#L12218
>
> Best regards
> Naresh Kamboju


--
Thank you,
Richard.
