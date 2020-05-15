From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 15 May 2020 14:55:14 +0100
Subject: [LTP] [PATCH] pty04: Avoid receiving packets from all interfaces
In-Reply-To: <20200515130024.GA26750@dell5510>
References: <20200515103910.8703-1-rpalethorpe@suse.com>
 <20200515114837.GB3395@yuki.lan>
 <914267680.12582166.1589545134812.JavaMail.zimbra@redhat.com>
 <20200515130024.GA26750@dell5510>
Message-ID: <87tv0hqp4t.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
>> > Sounds reasonable, also hope it's the last patch. :-)
>
>> > @Jan do you want to test this as well, or should I apply and proceed
>> > with the release?
>
>> I haven't spotted potential issue while looking at kernel code,
>> will test the patch just to be sure.
> +1 reproduced kernel oops on 5.7.0-rc5-1.g298ea3d from openSUSE Tumbleweed, but
> when running with -i100 (=> this fix greatly reduces the problem, but still
> possible to reproduce)
>
> Kind regards,
> Petr
>
> [27048.459612] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [kworker/u16:10:10487]
> [27048.459615] Modules linked in: slcan slip slhc uas usb_storage vhost_net vhost tap vhost_iotlb ccm rfcomm fuse xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter tun bridge stp llc af_packet cmac algif_hash algif_skcipher af_alg bnep dmi_sysfs msr xfs dm_crypt cdc_ether usbnet snd_usb_audio r8152 snd_usbmidi_lib snd_rawmidi snd_seq_device mii uvcvideo btusb videobuf2_vmalloc x86_pkg_temp_thermal intel_powerclamp videobuf2_memops btrtl videobuf2_v4l2 btbcm coretemp videobuf2_common btintel btrfs bluetooth videodev kvm_intel blake2b_generic xor snd_hda_codec_hdmi ecdh_generic ecc mc joydev kvm iwlmvm raid6_pq irqbypass iTCO_wdt libcrc32c iTCO_vendor_support snd_hda_codec_realtek hid_multitouch mac80211 mei_hdcp mei_wdt intel_rapl_msr dell_rbtn crct10dif_pclmul
> [27048.459667]  snd_hda_codec_generic crc32_pclmul dell_laptop ledtrig_audio intel_hid snd_hda_intel ghash_clmulni_intel dell_smm_hwmon libarc4 snd_intel_dspcfg aesni_intel snd_hda_codec crypto_simd cryptd glue_helper snd_hda_core iwlwifi snd_hwdep snd_pcm dell_wmi dell_smbios dcdbas snd_timer snd pcspkr sparse_keymap dell_wmi_descriptor wmi_bmof intel_wmi_thunderbolt cfg80211 i2c_i801 soundcore mei_me rfkill mei processor_thermal_device intel_lpss_pci intel_rapl_common intel_lpss idma64 intel_pch_thermal intel_soc_dts_iosf thermal fan int3403_thermal dell_smo8800 acpi_pad int3402_thermal int3400_thermal int340x_thermal_zone acpi_thermal_rel ac tiny_power_button nfsd auth_rpcgss nfs_acl lockd grace sunrpc hid_logitech_hidpp hid_logitech_dj hid_generic usbhid i915 nouveau rtsx_pci_sdmmc mmc_core ttm i2c_algo_bit drm_kms_helper xhci_pci xhci_hcd syscopyarea sysfillrect sysimgblt fb_sys_fops mxm_wmi cec rc_core crc32c_intel drm usbcore serio_raw rtsx_pci battery i2c_hid video wmi butt
 on
> [27048.459695]  dm_mirror dm_region_hash dm_log sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [27048.459700] CPU: 1 PID: 10487 Comm: kworker/u16:10 Kdump: loaded Tainted: G          I       5.7.0-rc5-1.g298ea3d-default #1 openSUSE Tumbleweed (unreleased)
> [27048.459701] Hardware name: Dell Inc. Precision 5510/0N8J4R, BIOS 1.2.13 08/08/2016
> [27048.459705] Workqueue: events_unbound flush_to_ldisc
> [27048.459709] RIP: 0010:slip_receive_buf+0xfc/0x2a0 [slip]
> [27048.459710] Code: 10 48 83 80 60 01 00 00 01 f0 80 8b 88 00 00 00 04 41 83 ec 01 41 83 fc ff 0f 85 5f ff ff ff 48 83 c4 08 5b 5d 41 5c 41 5e c3 <3c> dc 0f 84 44 01 00 00 77 24 3c c0 0f 84 f3 00 00 00 3c db 75 2e
> [27048.459711] RSP: 0018:ffffb7f022757de0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> [27048.459713] RAX: 000000000000005f RBX: ffff90a8d8e4d900 RCX: 0000000000000e00
> [27048.459713] RDX: 0000000000000004 RSI: ffff90a8d959a4b0 RDI: ffff90a902d76400
> [27048.459714] RBP: 0000000000000000 R08: ffffffffc1a9c000 R09: ffffffffb4871d01
> [27048.459715] R10: ffff90a8d959f000 R11: 0000000000000001 R12: 0000000000000970
> [27048.459716] R13: 0000000000000000 R14: 00000000ffffffc0 R15: ffff90a8d959a020
> [27048.459717] FS:  0000000000000000(0000) GS:ffff90affdc40000(0000) knlGS:0000000000000000
> [27048.459718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27048.459718] CR2: 000034ca2fb92400 CR3: 000000067380a001 CR4: 00000000003626e0
> [27048.459719] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [27048.459720] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [27048.459720] Call Trace:
> [27048.459725]  tty_ldisc_receive_buf+0x41/0x50
> [27048.459727]  tty_port_default_receive_buf+0x3d/0x60
> [27048.459729]  flush_to_ldisc+0x8a/0xd0
> [27048.459732]  process_one_work+0x1e3/0x3b0
> [27048.459735]  worker_thread+0x4d/0x3f0
> [27048.459739]  kthread+0xf9/0x130
> [27048.459741]  ? process_one_work+0x3b0/0x3b0
> [27048.459742]  ? kthread_park+0x90/0x90
> [27048.459744]  ret_from_fork+0x35/0x40

Is there more to this? Do you get allocation failures as well? (no
problem if not, I'm just curious, I don't think this is an issue unless
it happens with N=1).
-- 
Thank you,
Richard.
