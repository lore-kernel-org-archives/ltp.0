Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AECBCCFA1E
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 06:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762930316; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0uHnAsJJ8IVV8fUhMYvq/Vl8lHs4pPC+sphcj/Zbxpo=;
 b=Pmqpx+hl3BfNjXGxCgoTfBIKNBtUB/IeM47678aBqV57dXBW/kt2iqZw+mUGSWAoKLTsb
 9u2RLRuaGx8EFS7sbNLppo0Jw6W0kc+Mvm5tvOIqQgNrqgvRv6VzI9varmmb5mFRMJHjEoU
 cz16HR5x3bZzgROmWxhxvyE5gfz686g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B640E3CF70D
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 07:51:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06943CF59E
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 07:51:34 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDA081A00996
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 07:51:33 +0100 (CET)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b71397df721so82689866b.1
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762930293; x=1763535093; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5K4s5dQN3+fpfYejPC6oYzuVsWhscKz/jgARlTL3UcI=;
 b=DgNMtr72OuZe1h59h4YDc1UU9ka2xqY1M//4BfE3P4+M0OnoBezL0xMKQmTy9jkupj
 SeCJGDGI6d+1H1AU+lVIqe/YEnZH97HwUTvq7PIVhv/MmPWm0kGACU5t1b74+J0chLN+
 ryYTgupkOn+w/wHOxlCnL6yD69uO8Lv97PtN27phkuCv7z9ndV2famp1DBeyaKYevily
 yxsu7oRW27lmvNdSzF4SxtQbVLwFZCek2lwD5Vy107DZccQLo6Qur7OSMexzr1iBGzQJ
 yGT/r0sOlqTWPCKMg85968cm0X1Lq6lfhLBoQadi57mPHvm2lse3Q9yiHR8vWS2vehA9
 6uKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762930293; x=1763535093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5K4s5dQN3+fpfYejPC6oYzuVsWhscKz/jgARlTL3UcI=;
 b=B9XCflThXvCIBAN28dWUVuaVAw7VClpmeBwU6jVA6tTqK2VhDw90434BWWAHg9AifL
 mOKAw5G1OXkVHfhCxUpeDRyYojKoGJnIpNoRM1QrAXDAdN4G/FqETyh+3mcwPARAEOEi
 qiMyKBBqkyMx6wcFzcLSaGEEu5CFt2+jctjv0FMGykAIsEwPCdyKFqBSeVfcaDyvtCfd
 vSFk6VLc/wt0Q0/Bwg1fEVog6i0gL5GFkrHT5XVXG+Oj8ATQStgICVmosxYDwlLzF71z
 3vkb1iALGdPB2g1veYrT9wRMdDP4jCzZlzvVz37yKC7nlxjGnI2i27jN2/xY8oRYjT1+
 2TWg==
X-Gm-Message-State: AOJu0YyT08dfBYWB8o65B5XRKPuI02/4xvqHjYg7asFA1GsODV28capR
 RJlcaVddIsx90XO/4FxW38u9UKBgcsXud7MarZ7JvatzpQ/H2hvqTkzAmgaMah5KWQ==
X-Gm-Gg: ASbGncu4dgnOJUWYhqdzhN1TrhmdP2u6DQ1Q8fC5FntdWqCszNIkvEn5hFxjSVaZMmt
 k8FiYLyGbNhnMfemeGg0LbjSR0iT57OmBkB+O6TZw/3JbLwUQsP/Ol+KmCYxgAlgytBrnExBq/Q
 ISxC4bi5ouvWO6+8DAsvIT4SiYnhd4/0yCoM3Om07gj3q8oOppqk2bKUzef1ykugulJRtLE+m3W
 lYQbs70tB+E68WGOUPfdVSnxmf/XaUBZG2F4kUk89yX7QTTZwTYjtr1ISSIlpWNBrOJOIP9eiXe
 WjclSm23nL6cLOggKhMoB9yMRimuAxYk7ji0udjl0EF5J/LIsfGioDbSv+xIYvszMxENvEIBYb8
 AwDdi6bg9Y63rjSBlrS+mF0mGVf4E/+L4I+klmBZIfs00GRd0MmkJ3CVtlwUALVYvOCFhKv5HOJ
 b+YkTP0e1DdTYxs3vd4dFD0YVdHT7A
X-Google-Smtp-Source: AGHT+IGl3pzoM3aAnnhQUCuNxSvWZutoTCAl/qdQmwyN0QYA+eNjceyU0rXs7hVUT1g8PnmCrLCDUA==
X-Received: by 2002:a17:907:3f09:b0:b72:ddc4:2a7b with SMTP id
 a640c23a62f3a-b7331af1dedmr193329166b.63.1762930293110; 
 Tue, 11 Nov 2025 22:51:33 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa25454sm1506918666b.75.2025.11.11.22.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 22:51:32 -0800 (PST)
Date: Wed, 12 Nov 2025 06:51:31 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251111120600.GA50277@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for
 .filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 11, 2025 at 01:06:00PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +static void do_test(void)
> > +{
> > +	long fs_type;
> > +
> > +	fs_type = tst_fs_type(MOUNT_POINT);
> > +
> > +	if (fs_type == TST_EXT234_MAGIC) {
> > +		TST_EXP_PASS((check_inode_size(128)));
> > +		TST_EXP_PASS((check_mkfs_size_opt(10240)));
> 
> very nit: I would personally add #define for 128 and 10240, but sure it's ok to
> keep it hardcoded on 2 places.
I thought also use #define but i found and can not replace it in
"mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL}",
so i keep hardcoded number here.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> > +	}
> > +
> > +	if (fs_type == TST_XFS_MAGIC)
> > +		TST_EXP_PASS((check_mnt_data("usrquota")));
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = do_test,
> > +	.needs_root = 1,
> > +	.mntpoint = MOUNT_POINT,
> > +	.mount_device = 1,
> > +	.needs_cmds = (const char *[]) {
> > +		"tune2fs",
> > +		"dumpe2fs",
> > +		NULL
> > +	},
> > +	.filesystems = (struct tst_fs []) {
> > +		{
> > +			.type = "ext3",
> > +			.mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL},
> > +			.mkfs_size_opt = "10240",
> > +		},
> > +		{
> > +			.type = "xfs",
> > +			.mnt_data = "usrquota",
> > +		},
> > +		{}
> > +	},
> > +
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
