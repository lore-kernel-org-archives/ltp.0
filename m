Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7883C5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786602014; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IxZY3Q6f6Xtzf5NYgrqN8Bztf9SGgu3dpBOPon5e65o=;
 b=PvgQ6NeBI+LWatqs3g5oyO4sJu/0Q7K+NdnNEUnk2y9rVMi2wTFvXNWsJxrDfS5FdhTuv
 QVDeutL8GVzeP8ajlWbuLIe5NH2Nw8rsZ1ARCpAlx4QiqcZR8Wj/5lYRdc5f/DQ/qiXKioR
 lXWUJ19CNAjhd6JSKVibkm5s4mF4HpQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10EC03E5295
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:20:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D22ED3CB298
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:19:54 +0200 (CEST)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E1732005CC
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:19:54 +0200 (CEST)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2cacf17c7e0so26241695ad.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786601992; x=1787206792; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eR5wqUmjmaWcS4bueXkpRt7SGBKCfMF6eJC4RYrIrL4=;
 b=CqVm3mo9uYwCd3oDCyOeOY6Utg0Xmhp5/7ECKXBlB/oOZoJgzVumAkA/5owrsPXaG/
 PGmT/MRoyNb8ZEagEH865C+ZtGZu5TruCa2TfALE4WIiaWGdiVw/zwdlUE6rIMb1r124
 u43lHL1idPfVR8m13utWft8LpVWkrxeoxeMHkyZMEMcqnvOFl/YIEbZWdsfB4W0a5TGC
 cl6yvheatSfWAk+IvZ2kmXm+kWx+0lgDgcuAO+1Ydftckv7fFLqJQQta063Ikueigkph
 CS62Hs4Tu148noI5R63eNwNYp+4eiSKRz4yERMMEXGGz7duZ8ECTpqpzXan0zQDJVYA+
 b8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786601992; x=1787206792;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eR5wqUmjmaWcS4bueXkpRt7SGBKCfMF6eJC4RYrIrL4=;
 b=iikDDTgqZ+wHRmvyZwgUa3Q2WZZ1qLb5jxEQIC/olvBWCxkJx/q9zr7EuPA65FhJon
 hR3ITjaKb01Bawmt0BIa6GVYnat1B6sg2WbqVatUWb2SYJA2p6/Tc+5VjjX1yuCxK3ko
 6U6MAoPB0pmdDhwmSOi59HHgHQBbizLivpyFGcaUzd3xDt9B6Rn1eDlkbPzYLpkLhMuC
 SKBrd0MI/97kSOm9dMvFtKoBqgpQVWhcodA4q3ymYaVKyVS7Z4HDFPzpjQmXoXlxPhxX
 mgfSm2BR38SKHPtwllz/G5u8SxgzHqgjx763fP+eAbzEJmh+LU90rsywhI35t8EOpUvu
 vGeA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5Ohi7hprN9iW6SxMe9edoCa7EicENVY9RaZsIXrFOc976TYfbAdIFaYWvuA5R8zN8wHM=@lists.linux.it
X-Gm-Message-State: AOJu0YyLRLR/B4R6g+YcPuxyXUTtFIVBIGohubkXZscx/tvrzRfTY4n/
 1tzlP0fs29ZLTU3okGdZK7g20F6+RyV+OFDRmqjcTRqQSo9J4TM2RiRvZRol7nxXPxLFWcOzQ+t
 q1w==
X-Received: from plpm10.prod.google.com ([2002:a17:903:3dea:b0:2c8:7ed:acf4])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4588:b0:2c9:e2c1:4fb5
 with SMTP id d9443c01a7336-2d37ebcf007mr35717155ad.22.1786601992447; Wed, 12
 Aug 2026 23:19:52 -0700 (PDT)
Date: Thu, 13 Aug 2026 06:19:50 +0000
In-Reply-To: <20260813023216.79848-1-li.wang@linux.dev>
Mime-Version: 1.0
References: <20260813023216.79848-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813061950.4015582-1-wakel@google.com>
To: Li Wang <li.wang@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Petr, Avinesh,

Thanks Li for the quick analysis and for proposing this patch.
I agree that this approach is much better than reverting d90d2004657b.

Reviewed-by: Wake Liu <wakel@google.com>

Best regards,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
