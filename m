Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001D606A31A
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hH3eE+mH
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A67D3EA3F1
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 22:30:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0138C3CB557
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 22:30:32 +0100 (CET)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9104060020C
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 22:30:32 +0100 (CET)
Received: by mail-qk2-x08.google.com with SMTP id
 af79cd13be357-9369a6afaf8so223403785a.0
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793050231; x=1793655031; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggN1Zs5Wxy4IZkOfx9wNyqR0IIu1kiAPe+KNYkDN87o=;
 b=hH3eE+mHarnI3SuzViTZbXw1xpoxP04AwzcJqktqejKG1GXiab1ls6mxIxQ9msUU8M
 78slifDknyZ4o3faiPnnnfW1e/pzdnPYVhuLE6C7wxZcgyDDV5i6c99/ith2PVwfHD21
 1kf+7h/TwNazjLkTmeFIg2tnbuxQaX5WoCrLXUHK6edaXhjSPSvqBMnAYGZf3oYPu4pG
 9OBLHFx3Z3ZMpDC6/gPkeCYDlmDVfw4ZsuZGGN5LsVHLaj170vtv/gHEK24vxnvt/Nhm
 wJb7v6M0EWhlNcDfpjGHNgnegmY3IwBud3bVdjc9H7o1n2gCZQTh7UsaiTOam3P8lr7K
 ntZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050231; x=1793655031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ggN1Zs5Wxy4IZkOfx9wNyqR0IIu1kiAPe+KNYkDN87o=;
 b=pYYcH4OH0ptoaz+PPnS0Cu2hTjeDtLi+32MZA8r9NdOD4Ifj3nHY1+JCPMURTqRsap
 LoXBg1thX/DXdogX6JxuUnFS6gnZbFITn4Md1ia2zwO/90NUIjhZ59XR4HOjZK14W9Qs
 B/spm5ITgCCbn+2K5OzqMfdcgzEU7Ov8XH8T8HEeOPArIx3YjDhjg8JckLlbG9RsjuPQ
 p6j60lZb8rVAsVl8w/N4soz4/fVXd0WfAWwIH4zDbY+4/1684WOzMsIA9KdxQE13fjDu
 LJFjFWV6/v2MWNGjI9bZbM9DVxJTxWawOoMxIcO7numDjNvxSfU4UOskHEGOsOVOxBMm
 40YQ==
X-Gm-Message-State: AFq9FYLdiE5dNmttUHGWFYNnSX5PDvH3tge8DROHflNHZqGG5Q2YuVjj
 Isf4X7t7zHUnz2y18QWmmhBnnhHfTt6fE1QFgC+TXeENnvEbZ1OrWnVb
X-Gm-Gg: AYBFou3zIFGZ9wzkpXvUdDjA/Iis8KEhzIitryuNk0sP6aMv0G12hR35cXdMthv0Sxj
 Ro8oIcIGM2sEgbpGAB52EV1zRZQxYj4Q3austkMn4LUwTCyjVWl22JcxOBqhNsKe93hk+GJjBSw
 71orKzsUmVx/Bueit6fPoCstsFMgHQuK76pHC/VpwxP5LSfuI8oswXO+PQ7fehivNtr+I26d6FW
 opXnbiCHwfz36lxXq41Ew1tKN0VEtHSWXSD473PqeKk109mWKBzssxS9AQkdXkr3Bq+R8ieGUAT
 V/b4hJYhC/P7011YYyhkm/DW7zkruCPCllEGnOX3wvzUsKkyX+v9j2WenfCVZHba6aM4w7qVY8Z
 UVPP8bplVNRu6hMEVmjVekYCcakHsDxb5jNjDJ2H0soA9siVQGAI8Rg5vyReVDkuBV9P6rAB5OB
 elvqeeKTgSiBRBA+O8tlyp4N8A4edcvPWljWHmVa4rTIiPlD0appqvED+qEobfCKMa/BGbON/WO
 eOGiMEtSevHsSBBwzgpj9Kz0fkiFEqEC654AvqDek2epBfT40UmzcWELee7tthI38e2aCTg8Pgu
 fLlbLUK9bBzYgs7V/MJh0WfYok8/aCH8Y6UcL8gm07t4N4FBKSgnIi7xxLY4UfSZUhRJNH/vEJg
 s3SG1QF/VzxmlggM=
X-Received: by 2002:a05:620a:468d:b0:93e:920c:c00e with SMTP id
 af79cd13be357-940ef8fd21bmr1412473485a.21.1793050231204; 
 Mon, 26 Oct 2026 14:30:31 -0700 (PDT)
Received: from
 runnervmtai0g.gpqnxt3ebx0ehps3kygovi2zzf.cx.internal.cloudapp.net
 ([145.132.100.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c6ed36451sm3949906d6.34.2026.10.26.14.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:30:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Mon, 26 Oct 2026 21:30:30 +0000
Message-ID: <20261026213030.4240-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-statx-atomic-write-v9-1-8df127a863b5@suse.com>
References: <20261026-statx-atomic-write-v9-1-8df127a863b5@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/statx13: Add test for STATX_WRITE_ATOMIC on
 regular file
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gaurav,

On Mon Oct 26 22:40:55 2026 +0530, Gaurav Pathak <gaurav.pathak@suse.com>
wrote:
> syscalls/statx13: Add test for STATX_WRITE_ATOMIC on regular file

> +#define PATH_EXT4_BS_GT_PS "/sys/fs/ext4/features/blocksize_gt_pagesize"
> +
> +static int has_thp(void)
> +{
> +	return access(PATH_MM_THP, F_OK) == 0;
> +}
> ...
> +static int fs_supports_large_block(const char *fs_type)
> +{
> +	if (!strcmp(fs_type, "ext4"))
> +		return access(PATH_EXT4_BS_GT_PS, F_OK) == 0;
> +
> +	return has_thp();
> +}
> ...
> +	if (!strcmp(tst_device->fs_type, "xfs")) {
> +		if (max >= 65536 && fs_supports_large_block(tst_device->fs_type))
> +			bsize = 16384;
> +		else if (fs_supports_large_block(tst_device->fs_type))
> +			bsize = max;
> +		else
> +			bsize = MIN(max, (unsigned int)getpagesize());
> +	} else {
> +		bsize = MIN(max, (unsigned int)getpagesize());
> +	}

fs_supports_large_block() is only called inside the "xfs" branch in setup(),
while the ext4 branch unconditionally caps bsize to getpagesize(). As a
result, PATH_EXT4_BS_GT_PS and the "ext4" check in fs_supports_large_block()
are dead code, and the commit message claim that ext4 block size uses
blocksize_gt_pagesize does not match setup(). Either drop PATH_EXT4_BS_GT_PS
and fs_supports_large_block() (calling has_thp() directly for "xfs") and
update the commit message, or use fs_supports_large_block() in the ext4
branch as well.

> +static void cleanup(void)
> +{
> +	if (file_fd != -1) {
> +		SAFE_CLOSE(file_fd);
> +		file_fd = -1;
> +	}
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}

SAFE_CLOSE() already resets file_fd to -1. Drop the manual file_fd = -1
assignment and the surrounding curly braces.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
