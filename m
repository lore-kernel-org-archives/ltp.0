From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Jun 2018 18:41:48 +0800
Subject: [LTP] ltp/read_all_sys (read_all -d /sys -q -r 10) cause system
	panic with kernel-4.18.0-rc1
Message-ID: <CAEemH2egA1hoECjTSaao8n_YBZ3ypycMSUwZh+Ece28phL4F2Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm hitting this panic when running ltp/read_all_sys on kernel-v4.18-rc1.

Test env:
FUJITSU PRIMERGY RX200 S6 GS01
Intel(R) Xeon(R) CPU E5620 @ 2.40GHz
16384 MB memory, 598 GB disk space


[ 5915.705844] BUG: unable to handle kernel NULL pointer dereference
at 00000000000000b8
[ 5915.714587] PGD 800000042bcf7067 P4D 800000042bcf7067 PUD 423f4e067 PMD 0
[ 5915.722254] Oops: 0000 [#1] SMP PTI
[ 5915.726147] CPU: 6 PID: 18535 Comm: read_all Tainted: P
IOE     4.18.0-rc1 #1
[ 5915.734980] Hardware name: FUJITSU
PRIMERGY RX200 S6             /D3031, BIOS 6.00 Rev. 1.10.3031
     01/20/2012
[ 5915.749654] RIP: 0010:qla_dfs_tgt_counters_show+0x92/0x2a0 [qla2xxx]
[ 5915.756733] Code: b6 86 22 01 00 00 66 85 c0 74 63 83 e8 01 4c 8b
9e b8 00 00 00 31 f6 0f b7 c0 48 8d 3c c5 08 00 00 00 49 8b 04 33 48
83 c6 08 <48> 03 90 b8 00 00 00 48 03 88 c0 00 00 00 4c 03 80 c8 00 00
00 4c
[ 5915.777816] RSP: 0018:ffffaf04109e3d60 EFLAGS: 00010202
[ 5915.783645] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 5915.791606] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000040
[ 5915.799568] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 5915.807529] R10: ffff956823a74798 R11: ffff956824a29000 R12: 0000000000000000
[ 5915.815489] R13: 0000000000000000 R14: ffff9567badfc280 R15: 0000000000000000
[ 5915.823451] FS:  00007f27336a1740(0000) GS:ffff95683fd80000(0000)
knlGS:0000000000000000
[ 5915.832479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5915.838890] CR2: 00000000000000b8 CR3: 000000042960a003 CR4: 00000000000206e0
[ 5915.846850] Call Trace:
[ 5915.849583]  ? __kmalloc_node+0x195/0x280
[ 5915.854056]  ? seq_read+0x33e/0x3f0
[ 5915.857946]  seq_read+0x120/0x3f0
[ 5915.861643]  full_proxy_read+0x50/0x70
[ 5915.865827]  __vfs_read+0x36/0x190
[ 5915.869622]  vfs_read+0x87/0x130
[ 5915.873223]  ksys_read+0x52/0xc0
[ 5915.876823]  do_syscall_64+0x5b/0x180
[ 5915.880910]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 5915.886547] RIP: 0033:0x7f2733280790
[ 5915.890532] Code: 73 01 c3 48 8b 0d 18 88 20 00 f7 d8 64 89 01 48
83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 cc 20 00 00 75 10 b8 00 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e fc ff ff 48 89
04 24
[ 5915.911617] RSP: 002b:00007ffef181c738 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 5915.920064] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f2733280790
[ 5915.928025] RDX: 00000000000003ff RSI: 00007ffef181cbf0 RDI: 0000000000000006
[ 5915.935986] RBP: 0000000000000b7b R08: 0000000000000000 R09: 00007ffef181c690
[ 5915.943949] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2733688000
[ 5915.951909] R13: 00007ffef181cbf0 R14: 0000000000000028 R15: 0000000000000030
[ 5915.959871] Modules linked in: dummy veth binfmt_misc sctp overlay
tun fuse vfat fat btrfs xor zstd_decompress zstd_compress xxhash
raid6_pq ext4 mbcache jbd2 loop sunrpc intel_powerclamp coretemp
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel pcbc ipmi_ssif aesni_intel crypto_simd iTCO_wdt
ipmi_si cryptd iTCO_vendor_support glue_helper gpio_ich ipmi_devintf
sg acpi_power_meter ipmi_msghandler i2c_i801 pcspkr lpc_ich
i7core_edac acpi_cpufreq ip_tables xfs libcrc32c sd_mod sr_mod cdrom
mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
ttm ata_generic pata_acpi qla2xxx drm igb ata_piix nvme_fc mptsas
libata nvme_fabrics scsi_transport_sas dca crc32c_intel mptscsih
i2c_algo_bit nvme_core i2c_core mptbase scsi_transport_fc dm_mirror
dm_region_hash dm_log
[ 5916.038566]  dm_mod [last unloaded: ltp_insmod01]
[ 5916.043814] CR2: 00000000000000b8
[ 5916.047513] BUG: unable to handle kernel NULL pointer dereference
at 00000000000000b8
[ 5916.047537] ---[ end trace 1dddacfb06305174 ]---


-- 
Regards,
Li Wang
