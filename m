Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B301D68BE4
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766065033; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/iEhlJ3OtYe3Q2FkRAdZSqJ3rZwYCaOr8CN6H4pPMXU=;
 b=Ju0KozV0JZf3rwB7Hw2Fic7aVmEBlSwzM+QKt38zV7/aF/nHn5Y+aldWFVKDpDMYcwVxb
 cqFW9+QoKuy0mBPATo7yhvHie+b3muF3/NW/5pN9zMNvrkwwNlJ002d1zgnJgNPSUjARgfo
 l1be98orwsUSGWTw9ws+JlRBZepa1OM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B117F3CFAF9
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 14:37:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9487A3CB780
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:36:49 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4D2831A00CBB
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:36:48 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso90224466b.1
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766065007; x=1766669807; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLmo8l2BCBpPiwjS/CCkN7a6JVDKw4nDqff42eqPfQU=;
 b=O+RO79UKnwtt1lEf9FEZw7MGvjD/gayh35fpJe+U4PQfgMbfyP/j7FNwMNt0q+lqlT
 IV1IkUvG+eGz0LXVB0mqlMG41tITIz9WEqgPMX4xVRODoFDLCe8FZIb2X9K9bvpap51L
 /fkv8nGFxYzErVuU3NacpOHCYeLml4UdQBCeBYjVIOKll3lhXasbuzFj/HGHNb+1fkIC
 EVLROQa+/c+VURKPC+tG27eRS/40CHBQVs6exHsckIqyiHUw+NExtznUC4MzeNqT7PuQ
 DLXNnYlNMB1WH7Gwf3sjZIm5NBzOeRP+fheqtB5sKYedY0PeXCBpBnsI7WvgXvd8uM1C
 7r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766065007; x=1766669807;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLmo8l2BCBpPiwjS/CCkN7a6JVDKw4nDqff42eqPfQU=;
 b=rmKfQAAGpqx71WX40fC99ZK7Qs2+8f1Qy5hTFrrL6N/qsRZwQ5K58S//y/svCHI6lS
 CnyXv8AXUeMI1urHUja139oClaY1ClpialBgJorB4uW5a+2FPjjOhw+oQ21D377XbKdB
 4Cq+eqlDM3Blw2fQAOAE1qQ9yadiF3wt2vE2ZQyfkUki8x4fhznHJkWAYoNT8OoDSahD
 uRO+effXz2n7Runk+KHTh2BL/QcpkeIWGAKkqw6k41dr83GyB7vIzz1XZDWYVT3+sezt
 GQwIM764tDkTSl3cT460YOQEoKBsogSlMETmMp0PquQ7Qz0R3ribMOMLBz9Fu9EQwTrM
 omcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa8zdVM3yzAVikdGVdfWrmA1w0mLkQN/70Z4aAY5wUS7uauEbHW6iKKHMGzv7bqmMsWF0=@lists.linux.it
X-Gm-Message-State: AOJu0Yxk1b58Qlt7x2CBiiV5Ct36MarPp/BKjoyTKKZjXbIolew1/RJD
 EocuBlaxi4UrRQGOV2wYzz2zGBfB2nMAguwurvjZsVC6w9JKU8MUjavtGYMAvmxezQaPJme7nFQ
 rEPCkrPI=
X-Gm-Gg: AY/fxX4yIJ/airfcUVDv1nUyfxH3/h4Nvz9CwG1etab+sN1EezMnuOjUTXbFkyEtIJi
 qLDWnO63FwLvqZ+M29diBk5a1bcVwZ0JSLnryQ7kyR4BjDFCnYQHSk/ltfxWGJfIIc+iNO9tCkC
 cvRBFyPZF3LP+CaplY/XmXt1xkBEBpeRwDDKrKFQIpsbbEFrQYWYLIXXXxxtvAtB8A+tb/4ocBT
 n9t/M4Ee2fSvyppG5Dq/YdSvKgZfAhONHI6df1kGnD5UeaFhd+UfUN5omwhqnEjGcHLwq1E6rYv
 os0s6lE9aO4yQVGjbdZ/ORrmBDF7nE4RwMJL+qeFdGSulmn7YXmXCkDBUJa6jGUbcakKlezs+D0
 Zo1PeKqUYmQ314IrVogfaU+dpEqZUbAUbOgXUnMU2KGxiKnZwzhuPzxVvk6ZpP3xFzm+SV8a5th
 QEHCBOtCYJb1ELFaw=
X-Google-Smtp-Source: AGHT+IFSrYb9kqLv/KV9VgSx3RTtYwnuJe6uUJAYeqXyOR5AgiybZhX44tb+KWUcFRzEf9CphsMgig==
X-Received: by 2002:a17:907:3d8d:b0:b7a:2ba7:198c with SMTP id
 a640c23a62f3a-b7d23aa4092mr2492488366b.59.1766065007518; 
 Thu, 18 Dec 2025 05:36:47 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8023466073sm227712866b.38.2025.12.18.05.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:36:47 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 14:36:46 +0100
Message-Id: <DF1DSNN2O3LK.2NIRU59O5LLY6@suse.com>
To: "Zorro Lang" <zlang@kernel.org>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251113162217.1077332-1-zlang@kernel.org>
In-Reply-To: <20251113162217.1077332-1-zlang@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/stat04&lstat03: remove fs block size
 related code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Sorry for the delay to this review.

On Thu Nov 13, 2025 at 5:22 PM CET, Zorro Lang via ltp wrote:
> The st_blksize isn't equivalent to the filesystem block size. The
> stat(3) manual describe st_blksize as:
>
>   "This field gives the "preferred" block size for efficient filesystem I/O."
>
> So the st_blksize is the "preferred" block size for "efficient" fs
> I/O, extN might think the "preferred" block size is fs block size.
> But not all filesystems think same with extN. For example, xfs thinks
> the "preferred" block size is:
>
>   max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize)
>
> So you might get st_blksize=4096, no matter on 1k blocksize xfs or 4k
> blocksize xfs. We shouldn't expect to use a different blocksize mkfs
> option to get a different st_blksize. This part of code is useless,
> except causing unexpected test failures on other filesystems (e.g.
> xfs, btrfs and so on).
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>
> Hi,
>
> I tried to fix the mkfs problem last year:
>   https://lists.linux.it/pipermail/ltp/2024-December/041038.html
>
> Now I got a chance to look back this test failure, I think it's not a mkfs
> option problem, but the test case misunderstood the st_blksize.
>
> Except we limit this test only run on extN, or we don't need to make
> fs with a different block size, especially shouldn't expect to get
> a different st_blksize from that.

If testing `st_blksize` is an issue only under certain filesystems, we
should probably test it only when the right ones are in use.
For instance, this can be done as following :

	if (!strcmp(tst_device->fs_type, "ext2")) {
		/* test `st_blocks` attribute */
	}

In this way we avoid to disable `st_blksize` testing for all existing
filesystems.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
