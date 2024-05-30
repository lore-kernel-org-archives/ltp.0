Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66558C27C43
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 13:24:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DE813D073D
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 15:24:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B8AC3C02E7
 for <ltp@lists.linux.it>; Thu, 30 May 2024 15:24:19 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 866D261021A
 for <ltp@lists.linux.it>; Thu, 30 May 2024 15:24:18 +0200 (CEST)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4df550a4d4fso274622e0c.2
 for <ltp@lists.linux.it>; Thu, 30 May 2024 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075457; x=1717680257; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z1wf86rhc//hrXTmx06EkBUykqafTMVQ7bFCGB2R5oc=;
 b=m7OBO5uU2UEUMRcQBr0sHWEgMTSWsn4RRFelycWWsJVr7RlCfCoAoysHWY+27z8D8W
 HZZcqqE8py46uf5e3RHqnWe7/Wn0seQ1eLzIe+MPWz9EwhUNl9A01/JKzvMh/uy0Pk5T
 JQExCZDOhKCk9ttnRaqVSJxtxCILSEuJ9Li75yydKvnMO8gACtGnjRt9fPy287mDme3M
 kMpRBPvvU2SxgOi750dNsBvme9Jr5HDZZYD6ZHrbXWv/i9UFsQ3qm+VVXpyxuiNoURRP
 G6nt4JTwLBrUEbwm+uMxsiUoh7XVHXlmvyit06/hnzmlS3fvTdtNUJM97Yix2CotnApb
 2Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075457; x=1717680257;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z1wf86rhc//hrXTmx06EkBUykqafTMVQ7bFCGB2R5oc=;
 b=bDRrkUidlcBT+f12gNkGP3htWkMquLrhf2uX66OQIYCJ/jDhbykCOlwLecB7aJ5q6i
 uOf6+9ugHvEZ+Q/qzQg0tyXvIxRLrGnJfLk5kNR0e0aoKkhSjxgbDHAR1tPUpUbO0fD7
 IS5EZjdGczpx7+vj5ByqWahWTyJbR554qYTmlOtEA7pAGWaNucvPh55vvJbk0An2G/q9
 OkL3G+7bdQqITionu74/xBSxcr1IOZ1OK6kfQHqBcSvWUS64n2c1Yobt0vVRlDFX5XcP
 nOIF/5xLpTSBUabD3jvqUPGKzv2zbhGf4abHBFbtqdUk6vkwxizkc68Yqo4saUM+zhbE
 FrWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDxIKeCeSIK7KSQWAhYG2NOaH0EWROhGfcAkZGz4oXOCC/Wg1eVPRUr1aKnCjn9peY257K3Qa5H/gXIe6jaw+K3SI=
X-Gm-Message-State: AOJu0YxA/cyzQj7op1s88pkJuEKFX6vcM1KjklPn2U0tc4zx+BomLAv0
 tK5TO9CK4Tqt6vPHTf/VZcQZi3hGClpTkswiG2BVc6HIm++sq/+u8i0PED4hWNlxymq+yRk+IRr
 hpEucmN7Igse+w5v7kLhkp4Wx87RF/bgTSe/uTg==
X-Google-Smtp-Source: AGHT+IGkpezCmFIsSNHIXWWg711MfwaflaRlyGo0iVwc0c38BOJYKlEcuRFsht2/xa2Si8cst7kM/ZupsnWV43DFYAM=
X-Received: by 2002:a05:6122:d0d:b0:4da:a82e:95f5 with SMTP id
 71dfb90a1353d-4eaf21af5b3mr2676650e0c.5.1717075456991; Thu, 30 May 2024
 06:24:16 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 30 May 2024 18:54:05 +0530
Message-ID: <CA+G9fYuzd9Cz2Ndwc7HFOimJPRZL7w376N=2R2cV-d0mjzT+nw@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
 Linux Regressions <regressions@lists.linux.dev>, linux-nfs@vger.kernel.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] WARNING: at fs/nfs/nfs3xdr.c:188 encode_filename3 on rk3399
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: kasong@tencent.com, Arnd Bergmann <arnd@arndb.de>,
 NeilBrown <neilb@suse.de>, LTP List <ltp@lists.linux.it>,
 Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following kernel warning has been noticed while running LTP statvfs01
testcase on arm64 device rk3399-rock-pi-4b with NFS mounted test setup and
started from Linux next-20240522 tag and till next-20240529.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
-----
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /scratch/ltp-9gvw[
5211.161721] EXT4-fs (loop0): mounting ext2 file system using the ext4
subsystem
F2L8n6/LTP_stadLH0F7/mntpoint fstyp=ext2 flags=0
[ 5211.169391] EXT4-fs (loop0): mounted filesystem
af9dfac2-88f6-453d-9d02-c14cc888a51d r/w without journal. Quota mode:
none.
statvfs01.c:32: TPASS: statvfs(TEST_PATH, &buf) passed
[ 5211.175518] ------------[ cut here ]------------
statvfs01.c:44: TPASS: creat(valid_fname, 0444) returned fd 3
[ 5211.175938] WARNING: CPU: 5 PID: 786885 at fs/nfs/nfs3xdr.c:188
encode_filename3+0x4c/0x60
[ 5211.175962] Modules linked in: tun overlay btrfs blake2b_generic
libcrc32c xor xor_neon raid6_pq zstd_compress hantro_vpu
snd_soc_hdmi_codec brcmfmac panfrost v4l2_vp9 snd_soc_simple_card
dw_hdmi_i2s_audio dw_hdmi_cec crct10dif_ce snd_soc_audio_graph_card
snd_soc_spdif_tx brcmutil drm_shmem_helper v4l2_h264
snd_soc_simple_card_utils gpu_sched rockchipdrm hci_uart analogix_dp
btqca v4l2_mem2mem dw_mipi_dsi btbcm videobuf2_dma_contig dw_hdmi cec
phy_rockchip_pcie cfg80211 rtc_rk808 bluetooth videobuf2_memops
snd_soc_rockchip_i2s drm_display_helper drm_dma_helper videobuf2_v4l2
rfkill rockchip_saradc videobuf2_common drm_kms_helper snd_soc_es8316
industrialio_triggered_buffer rockchip_thermal kfifo_buf
coresight_cpu_debug pcie_rockchip_host fuse drm backlight dm_mod
ip_tables x_tables
[ 5211.176075] CPU: 5 PID: 786885 Comm: statvfs01 Not tainted
6.10.0-rc1-next-20240529 #1
[ 5211.176083] Hardware name: Radxa ROCK Pi 4B (DT)
[ 5211.176086] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 5211.176092] pc : encode_filename3+0x4c/0x60
[ 5211.176100] lr : nfs3_xdr_enc_create3args+0x4c/0x108
[ 5211.176109] sp : ffff80008b1ab7a0
[ 5211.176111] x29: ffff80008b1ab7a0 x28: ffff80008b1abc40 x27: 0000000000000001
[ 5211.176120] x26: 0000000000440040 x25: 0000000000000000 x24: ffff800081492c70
[ 5211.176128] x23: 0000000000000100 x22: ffff00000a274010 x21: ffff00002d1b9800
[ 5211.176136] x20: ffff00000a274010 x19: 0000000000000100 x18: 0000000000000000
[ 5211.176143] x17: 0000000000000000 x16: 0000000000000000 x15: 6262626262626262
[ 5211.176150] x14: 6262626262626262 x13: 90d1d5e100000000 x12: 40a645896bf3b486
[ 5211.176158] x11: a16c80bf234c2437 x10: 5702b6d600000000 x9 : ffff80008059040c
[ 5211.176165] x8 : a16c80bf234c2437 x7 : 5702b6d600000000 x6 : 600aa44181070001
[ 5211.176173] x5 : ffff00003109d080 x4 : ffff0000661a4232 x3 : ffff8000805903c0
[ 5211.176180] x2 : 0000000000000100 x1 : ffff00000a274010 x0 : ffff80008b1ab828
[ 5211.176187] Call trace:
[ 5211.176190]  encode_filename3+0x4c/0x60
[ 5211.176198]  nfs3_xdr_enc_create3args+0x4c/0x108
[ 5211.176206]  rpcauth_wrap_req_encode+0x24/0x40
[ 5211.176216]  rpcauth_wrap_req+0x28/0x40
[ 5211.176223]  call_encode+0x130/0x358
[ 5211.176231]  __rpc_execute+0xb4/0x638
[ 5211.176238]  rpc_execute+0x168/0x1e8
[ 5211.176244]  rpc_run_task+0x12c/0x1d8
[ 5211.176251]  rpc_call_sync+0x70/0xe0
[ 5211.176257]  nfs3_rpc_wrapper+0x48/0x98
[ 5211.176264]  nfs3_proc_create+0xb8/0x2d0
[ 5211.176272]  nfs_do_create+0x9c/0x1f0
[ 5211.176280]  nfs_atomic_open_v23+0x98/0xd8
[ 5211.176288]  path_openat+0x6d4/0xf50
[ 5211.176296]  do_filp_open+0xa4/0x160
[ 5211.176301]  do_sys_openat2+0xcc/0x108
[ 5211.176310]  __arm64_sys_openat+0x6c/0xc0
[ 5211.176317]  invoke_syscall+0x50/0x128
[ 5211.176327]  el0_svc_common.constprop.0+0x48/0xf0
[ 5211.176335]  do_el0_svc+0x24/0x38
[ 5211.176342]  el0_svc+0x3c/0x108
[ 5211.176351]  el0t_64_sync_handler+0x120/0x130
[ 5211.176355]  el0t_64_sync+0x190/0x198
[ 5211.176361] ---[ end trace 0000000000000000 ]---
statvfs01.c:48: TFAIL: creat(toolong_fname, 0444) expected ENAMETOOLONG: EIO (5)
[ 5211.432692] EXT4-fs (loop0): unmounting filesystem
af9dfac2-88f6-453d-9d02-c14cc888a51d.

metadata:
----
  git_describe: next-20240522 and next-20240529
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  arch: arm64
  test: LTP syscalls statvfs01

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131502/suite/log-parser-test/test/check-kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131502/suite/log-parser-test/test/check-kernel-warning-4a4050f2ba224c26acd76ee5aebc8fa78eb1cf8c315c763fd7b55e6a1d6e38b7/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240529/testrun/24131502/suite/log-parser-test/tests/


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
