From: Desnes Augusto Nunes do Rosario <desnesn@linux.ibm.com>
Date: Thu, 2 Apr 2020 17:50:32 -0300
Subject: [LTP] [PATCH] ltp_tpci.c: fix a null pointer
In-Reply-To: <1584507302-23515-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1584507302-23515-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <bd1dc27b-5680-5a7e-941e-bbd085880ffa@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Greetings Yang,thanks for the patch.

On 3/18/20 1:55 AM, Yang Xu wrote:
> Since commit 3dd286bdbee ("ltp_tpci.c: Update legacy code"),
> it introduced a warning as below:
> ../ltp_tpci.c: In function ?probe_pci_dev?:
> ../ltp_tpci.c:107:8: warning: ?dev? is used uninitialized in this function [-Wuninitialized]
>    struct pci_dev *dev;
>    dev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), bus, slot)
>
> This will lead to system crash when we run this case because it triggers a null pointer.
> Use 0 domain intead of pci_domain_nr.
>
> ps: I want to use a dymaic domain to fix it but failed. If someone know,
> please tell me. Also, this case failed when merging this patch because
> test 13 (test_assign_resources) report no space error as below:
> [754930.757585] ltp_tpci: test-case 13
> [754930.757585] ltp_tpci: assign resources
> [754930.757585] ltp_tpci: assign resource #0
> [754930.757586] ltp_tpci: name = 0000:00:08.0, flags = 262401, start 0xc140, end 0xc17f
> [754930.757586] ltp_tpci: assign resource #1
> [754930.757587] ltp_tpci: name = 0000:00:08.0, flags = 262656, start 0xfebd7000, end 0xfebd7fff
> [754930.757587] ltp_tpci: assign resource #2
> [754930.757587] ltp_tpci: name = 0000:00:08.0, flags = 0, start 0x0, end 0x0
> [754930.757588] ltp_tpci: assign resource #3
> [754930.757588] ltp_tpci: name = 0000:00:08.0, flags = 0, start 0x0, end 0x0
> [754930.757588] ltp_tpci: assign resource #4
> [754930.757589] ltp_tpci: name = 0000:00:08.0, flags = 538190348, start 0xfe80c000, end 0xfe80ffff
> [754930.757593] virtio-pci 0000:00:08.0: BAR 4: no space for [mem size 0x00004000 64bit pref]
> [754930.757594] virtio-pci 0000:00:08.0: BAR 4: failed to assign [mem size 0x00004000 64bit pref
>
> Fixes: 3dd286b ("ltp_tpci.c: Update legacy code")
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
> index 7cbabfaa5..a57953db6 100644
> --- a/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
> +++ b/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c
> @@ -104,7 +104,7 @@ static int probe_pci_dev(unsigned int bus, unsigned int slot)
>   		ltp_pci.dev = NULL;
>   	}
>   
> -	dev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), bus, slot);
> +	dev = pci_get_domain_bus_and_slot(0, bus, slot);
>   	if (!dev || !dev->driver)
>   		return -ENODEV;

I was about to post the same fix on the mailing list - just tested in 
powerpc arch and it looks good to me.

It is safe to use 0 since function pci_get_bus_and_slot(unsigned int 
bus, unsigned int devfn) removed on kernel commit <5cf0c37a71da0f3> 
("PCI: Remove pci_get_bus_and_slot() function") used to be a wrapper for 
pci_get_domain_bus_and_slot(0, bus, devfn).

Hence, this patch avoids the following Oops:

=====
[69614.978596] Unable to handle kernel paging request for data at 
address 0x00000010
[69614.978602] Faulting instruction address: 0xd000000003c200a4
[69614.978606] Oops: Kernel access of bad area, sig: 11 [#1]
[69614.978609] LE SMP NR_CPUS=2048 NUMA PowerNV
[69614.978613] Modules linked in: ltp_tpci(OE) vmac chacha20_generic 
poly1305_generic chacha20poly1305 snd_timer snd soundcore authenc pcrypt 
crypto_user sha3_generic salsa20_generic uinput can_raw can dummy veth 
n_gsm pps_ldisc ppp_synctty n_hdlc ppp_async ppp_generic slhc kvm_hv 
kvm_pr kvm binfmt_misc nfsv3 nfs_acl nfs lockd grace fscache tun brd 
vfat fat fuse overlay ext4 mbcache jbd2 loop sunrpc uio_pdrv_genirq ses 
xts ipmi_powernv enclosure ipmi_devintf uio scsi_transport_sas 
ibmpowernv ipmi_msghandler leds_powernv vmx_crypto powernv_rng 
powernv_op_panel ip_tables xfs libcrc32c sr_mod cdrom sd_mod sg ipr 
libata tg3 dm_mirror dm_region_hash dm_log dm_mod [last unloaded: 
ltp_block_dev]
[69614.978653] Features: eBPF/sock
[69614.978657] CPU: 1 PID: 2292176 Comm: tpci Kdump: loaded Tainted: 
G??????? W? OE??? --------- -? - 4.18.0-187.el8.ppc64le #1
[69614.978662] NIP:? d000000003c200a4 LR: d000000003c2006c CTR: 
c000000000dc8c00
[69614.978666] REGS: c0000004be437a20 TRAP: 0300?? Tainted: G??????? W? 
OE??? --------- -? -? (4.18.0-187.el8.ppc64le)
[69614.978670] MSR:? 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>? CR: 
28002272? XER: 20000000
[69614.978676] CFAR: c000000000008934 DAR: 0000000000000010 DSISR: 
40000000 IRQMASK: 0
GPR00: d000000003c2006c c0000004be437ca0 d000000003c2a300 0000000000000000
GPR04: d000000003c214ba 0000000000000000 c0000007846448c9 0000000000000000
GPR08: c0000004be437d04 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000002200 c0000007ffffee00 0000000000000000 0000000000000000
GPR16: 0000000000000000 000000001001cf98 000000001001cf78 000000001001cff0
GPR20: 000000001001d010 000000001001cf58 00007fff92643190 0000000010040530
GPR24: 000000001001d108 000000001001cf48 c0000004be437df0 0000000000000001
GPR28: fffffffffffffff2 0000000000000000 d000000003c22f80 0000000000000000
[69614.978711] NIP [d000000003c200a4] sys_bus_slot+0x8c/0x170 [ltp_tpci]
[69614.978715] LR [d000000003c2006c] sys_bus_slot+0x54/0x170 [ltp_tpci]
[69614.978718] Call Trace:
[69614.978721] [c0000004be437ca0] [d000000003c2006c] 
sys_bus_slot+0x54/0x170 [ltp_tpci] (unreliable)
[69614.978727] [c0000004be437d40] [c0000000008da5bc] 
dev_attr_store+0x3c/0x60
[69614.978732] [c0000004be437d60] [c0000000005fb908] 
sysfs_kf_write+0x68/0x80
[69614.978736] [c0000004be437d80] [c0000000005f9fb4] 
kernfs_fop_write+0x104/0x270
[69614.978741] [c0000004be437dd0] [c0000000004ff624] sys_write+0x134/0x3a0
[69614.978745] [c0000004be437e30] [c00000000000b388] system_call+0x5c/0x70
[69614.978748] Instruction dump:
[69614.978751] ebde8010 80a10064 e87e0000 78bdc622 54bf063e 2fa30000 
419e0014 48000e89
[69614.978757] e8410018 39200000 f93e0000 39200000 <e8690010> 48000dd1 
e8410018 7fe5fb78
[69614.978764] ---[ end trace 414b1270f579351f ]---
=====

Reviewed-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>

>
-- 
Desnes A. Nunes do Rosario
--------------------------------
Advisory Software Engineer - IBM
Virtual Onsite Engineer - Red Hat

