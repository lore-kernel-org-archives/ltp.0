Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DECCC6B27
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791964818; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=QbbG3bGkY9F+fZYok21BzmvlAt74jSUD52zfmv/LPuig4Wn/Mm+UPvrKwsuIaH53b3n7I
 db2U5IJH8niMnrLWRkdxXvWFpZlz99pz1id6L7soPnhr5jgniI6h+/vyKbc3L2rV20p2Opz
 /7sVToV/PtnUnC4H47BQuFhA5D6/aqE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360653E6A0C
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:00:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6028F3E2B3B
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:59:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E87E91000A30
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:53:24 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so22945915e9.2
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791964404; x=1792569204; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=U+DSPruQNpAs8ul7gBiuN9JjSEtGDY1rVzoTWNy0tYdr/GJGzlhd2M5eWSYvbjoMfb
 VbvcGL8QG9k3d+efYZzg2uLGx9s5LQmDuW/cUpD65dRopEYvqfbEMLqTMXKzfUWm/NDM
 UxfyX7zkFobReNxhJj0qCSVUsbBi3MDiQNTp9p5qLvrcz7xlG48PbgU6oibm7b38dHrM
 n74cWeJ6YC91EHMkPaIDDMtCNZxW4yPlSQ1y8GLd3RKe95uckW3KXFOKT/ay3zGXWCK/
 00PIue1aq9DyeJPcJkG1xfwO6T1dQVmUzxS+Ad9jj+zn4Fo8h8yDNaiohzz+bAkFqFvz
 omrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791964404; x=1792569204;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=JbjQOeMJ442QmItcjnCrk020CPVlEIArA6MvoBv61Bo0yMS3qU6Jck64n6Igoop2T3
 2DEQSLmmdRRYajTt3cUt3p9oKPWiy9sVMBrqnD/PLAdssnTVcmeQH39mzYlTOdPBBWxe
 axKwgJ0G4c6NXBDJULkBXp+ulYW2InM9SRMFnm5Wc0TydPT5dIbkmP9AH2lIlO3zeLj4
 D4JomMDx5+ItsRErDywplcYkij5fT3NyTQvCS863tqathHt2ectF6KeY5sJWFbXynsYI
 FxAAuydP2Ct7/3HVUYp9QBXlDyw8RDRubCFuS0Kpk7H1Tm808yANMaXDJo5tMata6e99
 DUzA==
X-Gm-Message-State: AFq9FYKi3+Bsf5lD/hoYOVknltU+gZSnxrmIQ7lwRWs6ePjdnkp7wM9f
 DgeCElwik4U7yQhWlRrnCp42GTdKQ2nXGiq3nrtv8QdQrIvw7paSJw/g0t7FXIdebHZJRtT1Eci
 9rMoXWgKBGA==
X-Gm-Gg: AYBFou2/Z7AxtZk1nkeI1JHBpS/NBKeKMtMpL4VTcIICOeNANJhiZDjHjZ04j4SO5vW
 IT5naw2bHGXgqQ0e+neiZUOklczQoLdYEsC/yO5X79doCLKRWAmXbFKRxxlZKKi4D7gcL3bZ8ef
 PgM+SVW2y8/qMlSsjDTik1RkgWRwXLFnIfDvDxTrSObO97yW7kJWHiMIc7aP5OMIpkw6JTNKn5M
 3zNEhx4yBoP4w52b3iIpQpkzPuUK1nbnQykX2qx7qGKoU2JwOTcuXtWynkp8BIQzqwnS01BImOc
 oAkF4m1M9AryUntpqysBUtqNjwaRx57qbsoCQo/3xEsoowOhe+3EFeo2e9ouxy3xNrUtCGeDXDg
 AuguuraKpXmfv9J+2WtRQP3CiavDmCSgds7DNgByf1/nFYP6rSqG2TP/neHr6EXdVx4YsNfJZii
 /Wu5cfnOaB3ekbCXSrY5wkbDHV6ALj9Akkwp+Q0Pc8RriBy+lt72xrDznqMPKMWMSFEcUr1WXWd
 nZyVCgC0yTZkO6k5OGCeISF7z10/WDKXO9dD6S19wRt7O5NAvmHzam3IB/pJsgA7o5dRt7qwEuB
 fA==
X-Received: by 2002:a05:600c:3554:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4a18e43a1cemr299777955e9.1.1791964404218; 
 Wed, 14 Oct 2026 00:53:24 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19471edd5sm564066795e9.11.2026.10.14.00.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:53:23 -0700 (PDT)
Message-ID: <ybQLfGBdMSwtlamvp5ZZ8ggOFTmNMKDRQSzK@localhost.localdomain>
To: "Darren Chang" <chihsheng@google.com>
In-Reply-To: <20261014060212.1081388-1-chihsheng@google.com>
Date: Wed, 14 Oct 2026 07:53:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] process_vm_writev02: Fix stack overflow with
 large buffer size
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
