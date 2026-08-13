Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29388C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786618025; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0y4ZnBrLl0CUI7VEwlQyJ9PXZHTQBsD2R+dDHjowGUw=;
 b=nVaVOjXe5OT+6tq1tLKul2kFE3ORKSF0281cvxKMIQ7GzG823OzAft11crYykE1fqqTwJ
 sjKMILx42ei/6DfQxyd9VWainh1NtttCRKxYHvb9dKMxODxegdgTfaaQJqCehLgPUZW3soK
 OFWfjBb9diqiI1wrhL/aoncUMHBqbGk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A803F3E6BF6
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 12:47:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 915B83E249C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:46:46 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1F931A0081C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:46:45 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-480001972b8so748785f8f.2
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786618005; x=1787222805; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZiZDEy6vRG33mYlqsSwmYLKsm8zOfTiN1Y7PcH3Zois=;
 b=ZA393GdC8P8vXH86uW2pdaunI1JDiYF+CuL6e5qOXZ9X1nmxSTVmBpkd2pUGbFKmxe
 I2F/gL7GZ+5dpo5YLx2oI+faplYUHwpdJ57bXjYKuJ62tgzMQg3klvNij7zuDtevj2FO
 KeoITAVv+FwkomiC2NBa9uMncQXQO/ElHC5cFqG0sfphjdGbIqoi/ZEzZVbcl9CGR9+p
 0hNP8soeqxA+86FySSk4DCknM/NWydZ4ip/0dFErD3Tj006xx9HFMb4ntxa+UunVO/Lo
 5ywNGuwqXnzpSoMcI5HK5hweSbAjQghTbcqjDeFvf//jOIfmfHgy8SdCn2Z9s9QHdTHF
 n9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786618005; x=1787222805;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZiZDEy6vRG33mYlqsSwmYLKsm8zOfTiN1Y7PcH3Zois=;
 b=DSFuLCn/oycXcoQRow3AOt1gtJh79PPKajX1jl81ZNfUAxNhngd2zO+LUkf79weiHr
 yw9fVSn0Na2ILe9/V1bt15eeMotkGBD1AZsbyv8PHjIhpfZjoeFKzYPNsoknLQjifyDc
 DD4973aazDXQN3camsuFGk6Sa695Dmtkt1hSUMfwrLdgSMW7LI+xKxwh/BpdHXwxoNpj
 /DwyfBboDCY0wCg6DspnAO5Jxe12Z/SiBiR+tUkfSrvAIIN0RZ5VUy2hapjEQzWFxblw
 Q5TNriLljGIPp66SPkNdroVSzG6gO/f6O8HLN+XB37pvkEAFA01+su6Zhz+XSUSsh9ts
 x58w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rol8yk4S6CmhLkzcmLVWdCUl/dbgKIDNznIXBK29Q6M6ucjgD1JgomvXp0zK+0mZpHcJVg=@lists.linux.it
X-Gm-Message-State: AOJu0Yw6dYPdThuFSNbnjqsgpwTbyUMh3LPEQSGRGaEpPovqU2N2XhKC
 us1NOBxrglUvjbi0V/yeqJMur1k+f2k2RV53hiKQdZ+sb8iz+tHnj1WeUbCZkMioQBrTsatgBJp
 Mhrz5CIw=
X-Gm-Gg: AR+sD132ZhHVigvO7W5HnZmh7fY383Q7s0eVh6so7GduoJrH2nM0DeybimBxtgNjeeq
 z+9TotpL7zYTstWXeoP6R1IJRLlflFYpR3Shp57hUytlDF+NO+pTrx8izoV0Y7DFVOgqO5/Fzb+
 d5RA2nBaMISizy7QRPX0djNXe9MeNSc6ZzRTFpKX+erAsLAvqpBZg2eDA5yqTdblAY96bWK1K9V
 LyzkKRYC1FFTUfMMHpvnCtElJG368q70vctZ+KoaaiwJevfvcw3gnXyX5tEtY6sjqnb7yIyVMnv
 KjBqkNaUuCLQdIMxUvmfAIDi2XcCGgh7X1HDsWqbAYUtOXL1p4wFeMUfj7CCdHVDfhwLg3u1L9b
 zBtl7PBoNe5jQ6Fjh7+A4d2qMC9LmPwNsxtlMGEFaYwBhjFbD9TRXlHlKbgRq80tRpkoO5cViY5
 kLnsLeS56Q8TyvBSiuz7rKnPMWBkeLSqz69DekxfTEQoYiNPuEHYw2uiHPDQSPGinftDylYW0=
X-Received: by 2002:a05:6000:2209:b0:47f:9d0e:f8f with SMTP id
 ffacd0b85a97d-4815a007c23mr6366012f8f.26.1786618005180; 
 Thu, 13 Aug 2026 03:46:45 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a56133csm5407784f8f.7.2026.08.13.03.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:46:44 -0700 (PDT)
Message-ID: <6a7da094.a02854e2.9191a.a277@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <an2Gs6ztBU20B2Ik@yuki.lan>
Date: Thu, 13 Aug 2026 10:46:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] refluxfs: Check kernel reflink support before
 mount
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > > +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
> > > > +		tst_brk(TCONF, "Kernel does not support XFS reflinks");
> > > 
> > > Wouldn't it make more sense to add the check for EOPNOTSUPP into the
> > > tst_test.c library?
> > 
> > I don't know if we really need to add something in the LTP library,
> > since we have this check only in file_attr02
> 
> I mean that we should rather than hacking around it in the tests handle
> EOPNOTSUPP properly in the test libray when mounting filesystems. We do
> enough magick in safe_mount() to support FUSE and handle other corner
> cases, checking for EOPNOTSUPP (possibly with non-standard mount flags)
> does sound like a reasonable extension.
> 
> The main point of handling the filesystems in the test library is that
> cleanup (umounting) is handled properly even if the test crashes. If we
> move the code back to the tests like this we lose that.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Something like this?

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index f95c5fdc5..34430d018 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -993,9 +993,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 			"mount.%s failed with %i", filesystemtype, rval);
 		return -1;
 	} else if (rval == -1) {
-		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
-			"mount(%s, %s, %s, %lu, %p) failed", source, target,
-			filesystemtype, mountflags, data);
+		if (errno == EOPNOTSUPP) {
+			tst_brkm_(file, lineno, TCONF | TERRNO, cleanup_fn,
+				"mount(%s, %s, %s, %lu, %p) failed with EOPNOTSUPP", source, target,
+				filesystemtype, mountflags, data);
+		} else {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"mount(%s, %s, %s, %lu, %p) failed", source, target,
+				filesystemtype, mountflags, data);
+		}
 	} else {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid mount(%s, %s, %s, %lu, %p) return value %d",
diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
index f6625985a..28c1c7ca6 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr02.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
@@ -45,13 +45,7 @@ static void setup(void)
 	struct stat statbuf;
 
 	SAFE_MKDIR(MNTPOINT, 0755);
-	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
-
-	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF, "Kernel does not support XFS reflinks");
-
-	if (TST_RET)
-		tst_brk(TBROK | TTERRNO, "Mount failed");
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 
 	SAFE_STAT(MNTPOINT, &statbuf);
 

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
