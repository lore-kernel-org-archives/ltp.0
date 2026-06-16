Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38232CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781574493; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0rrUDqJP/lUdMk+or1205gcAi1blV24P6gHLIOI7Bvw=;
 b=orGUcnN18lH2dBC+sduguYUphRJ8KIg+VsxKhiNIfiTV//gERtJjXtWD7jvoTfqmDSpxT
 camnStnOtP5860x2Hie0UPjnJHIF/Oi+fVNFDnXPuK3MlllhXKpYiFMB9hR2DK13IXbEAJD
 3BCovUFiZ5L8HKYbkLLj5O4R6BfIkuw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7143E6CE8
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 03:48:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74DEC3E4E3E
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:47:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 97DF31400DB6
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:47:51 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so39797525e9.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781574471; x=1782179271; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W5TVi7wC2/KDvxjfA5qCS2gOOGfEgEbjmR2fay2yXY=;
 b=YZOVpJ+NGSN7dEi5flY2Hmzd7/yfRepVZrwT3vdXkn0n+PsQkoNvBquNAF0MfXq06J
 gjCtRfTOsodjj4O9150IV5NXdI6kHG97828URBBAG96FOB3aZZ5EbisNZx1NN3LD/Tye
 /+vKD2mpeV3kMcAGB/2gqS5OEgpP0xfHwqG7lD67S2to/B8K6i8WLGGd8/EDKx/f2+8g
 wcbijXN/HNagPzQerr71x0Bs0XZznfLSJPJcQbvv/Kfhpile3oMpDh6ahmxeYAmOEPxb
 rP0af5I5Ah6HpY3TkFRKKX1c7+AYkLWhRCxBRODVvuBtGeJEhhFFaHOiF1/+R18K3AgM
 iPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781574471; x=1782179271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6W5TVi7wC2/KDvxjfA5qCS2gOOGfEgEbjmR2fay2yXY=;
 b=MkCn5aAyYW7MLEOM/yGLoCk5WrJIpOlAUpINKdeyxT+/kXWa26S2NZxF2n2Kwz8d4L
 b1MA3eVUdA3bcKXPYktE5k7H2VAKlBbI0gq70YF0Ow8owX0sFIKY0VawE01MhEpLWBfF
 9RO5h3DIeA/TKeo6eR922dblFnVL0K1fHqfit1B8hfOqdPesoiEcWQDuAodyIzzbeyJV
 ZUarXlNTKwOMAShr9RzIj4mafuKIA7B6FEF4kYH7TOUOIJyWICJPKhTf6X3SOz6fHYJw
 ohkQ1Z9ykTV+MvEbOXySoEB6m1V3RZ1nmLL7WmHL+p1YBxz+hEtVHN5JAgYmlQXIFT8u
 i93w==
X-Gm-Message-State: AOJu0YxypGrjKUQvsCg6a2PiLzkzO/eEJqSMhe5F1CW9SxmkqLPEiTmH
 lFLOduBfjnNcQ/sALo0A+O5CUo3lCuAR7Zn4qe/86SGtZAlbpDSZzpnyTUHdXt08iMhLE1Uqqnz
 6YO0=
X-Gm-Gg: Acq92OEydHWbHkc9pwpLAgDVgBsMGGY9HF8HdEh+/LmRqq7LYbju22J1uaDm/lcCAkb
 eqKuMVA4UX5eVbcvwg2Yfew7cKv5rYBnf/o6WXwnIgkFBBVZjqY41VIne4MFJlGFWXtE/oinpmw
 wJz88tPm/PQ8tyAisRRm0K62PTRLWN+uBHB6VmjaY2AkNl7GvknOHrK1D6on4eVCvIU+hwluGqp
 QGKc4TNKtpjf0S3JvBL7ZsVRvENnK+e/PyIkBWVwDvH+2U9QedtqdSalVuCFtXrjx4eujhHt9iF
 geqyhxu3DUeF657Lq9KPsmHz/UV/uzOanL5cLidlH/JTSmGVyWw3+wLptxYAzgeF4HD0HTX6n68
 BL+Sy0tNGKcfcYm1d6/4dVkughsDaI5LxbCnkxhzbLrSh3JO2psS6VqKZj0pbFESIQ98Jse7xcK
 RUkg/9YuzwvaA=
X-Received: by 2002:a05:600c:310f:b0:490:a646:9d77 with SMTP id
 5b1f17b1804b1-4922ff8eebamr21570505e9.6.1781574470997; 
 Mon, 15 Jun 2026 18:47:50 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4606f26434dsm39863160f8f.1.2026.06.15.18.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 18:47:50 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 01:47:32 +0000
Message-ID: <20260616014747.8220-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604045008.29021-2-wegao@suse.com>
References: <20260604045008.29021-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] connect01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v4->v5:
- Reformat commit message body
- Initialize all socket file descriptors to -1.
- Use != -1  guards check fd
- Add tst_reap_children() after the SAFE_FORK()

Wei Gao (2):
  connect01: Convert to new API
  connect01: Add negative tests

 testcases/kernel/syscalls/connect/connect01.c | 401 ++++++------------
 1 file changed, 139 insertions(+), 262 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
