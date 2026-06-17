Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CFECD98E4
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781699752; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=b+uodA7zmEBnTPTpANiMdi2gJDsyZbeC6keLXevglctKs5gfV3K3ggG1T9+EEfCatOos4
 HDI8h+HSX4kagEzwXJ4Q6XJolTekzJHyRmjjyVUdjwVdPe3ow5xU7igy/JQ3APNz0Sv9Dcr
 FAh+KrsMxPwXmNrPA7B9jjGuZP4VQBQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4AC3E5932
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 14:35:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8FF83C036C
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:35:32 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0E6BE1400BF8
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:35:31 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4629324e170so665355f8f.0
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781699731; x=1782304531; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=GcENggjD+1z9zbE71SwtiqLjQBmQeEYT9eidHDvVMU4mR3KMOMpyECp3BTkgD7kCnw
 gN6+pc4sT4pU+AnwMB/YIhpvZKZrVe8MY8KgUX2/dRJwNF8TOWZabULm5uNF4aeiH2po
 MeyyipXyKARjcJKNflRTHavsZJ4GkBZoNOcna3S7IxrMyukXdgVwg9pcWFaVpcXpipyJ
 VAvWquna/wNVMt1z3UGv3CElB61ApS3AOP+gtDSiccjA2EsgzlKI2iMm+Kt5fNhtuWsB
 61d3CBKZnlAgHigX0pbz7p8aAUHe9R5qiMw4RaUzZeD6Sb7q962RcikOFL0wjUUQrPrh
 Gvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781699731; x=1782304531;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=qmMXMVQO/hkFIH5uWPRFqBXPCvH+zJRXJh4+XTgIcKh0997985pPL6umQsWb0pPAlH
 cKS5pkplY5fZbuV8A561hD64U7gEAqRfQseMr4//qiYEI3o3wmg0nvxVUKWi+fzfSWKE
 5vO+SALSyjbzkyIGpQgr/lEzGhdtDE9DR+w0Ibg2+LvICHbhhy0RI04DU7qno1CCbz1J
 zlFOzk+nCFLvbiFZmpD7FKACdJtTP0adjxpYsFtg3oLfzcygB5ZSAjgDnFxluHmWA6aD
 hQ83QNgLoXtx28erHkGkgP+2fuNWagcAVAgRIFf0rr0b1Nkp0LVO59Q6OKB+oCAGXdm7
 LZyg==
X-Gm-Message-State: AOJu0YyilBN2GTaYgTQ7DdbAIpUSYeFP//2t4oPLeC3jsJ6da8Emiglo
 pqwYWz+b8HS0cTlih0HdNhG271Mc4laIz1I85OqEWx5M/V6kMEeWE2OOAPiMYWxBSfMaOYOEO8J
 pNPS5tDQ=
X-Gm-Gg: Acq92OHJbXDqW6Dd/f5GEQwMt8j2cfaZNnu6/wzM3/57mMmr/y1PpBheCWB7IdAfAz4
 rp+jqvuj5ZPMLrKSF7h5+hcXpw5WCFVCrsPkcvQFzhSXigkBFhJJiCmZmZwK5RHNOKYeTh+4e0Y
 ms3WgNb2l2070ZlEVRZK2+7YhsSzjUOqV0Ep0itkCKLxJWTq4jj529znW2tqq6mkjS2qdXPVQGg
 rBehsuTNwy4wxy9izrmQ5WEAZqIwOJYKxakLQHf8RzJt22Rhn9wMtdQA31HNGTOmvba52YdN2Kr
 pT4g0tV05cj+J0ea0F3hNhsS4s3Gz4VQUEYIDN7rhaeN6IgYh7rdWaeaVOT+128jfhy44CMApQd
 YjHj1AUJN/jMU+lz9PIEDHVFjAVJunzfslkRI8XhqgMsqwRD21JFF+TEI6SWelrBX0A3llHfBqg
 06LzlBMBiY7zvYHiE9vowuV4STIxIijsyzn3nHMfrq2XE4ZBMTfv8V7iLPiSdL0Q==
X-Received: by 2002:a05:600c:19d3:b0:490:b99c:9337 with SMTP id
 5b1f17b1804b1-492333a987dmr65790195e9.10.1781699731154; 
 Wed, 17 Jun 2026 05:35:31 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm53139386f8f.21.2026.06.17.05.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 05:35:30 -0700 (PDT)
Message-ID: <6a329492.829f5021.eb1ce.39c7@mx.google.com>
To: "Wenbo Ma" <wenbo1.ma@intel.com>
In-Reply-To: <20260615012911.36607-1-wenbo1.ma@intel.com>
Date: Wed, 17 Jun 2026 12:35:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix/pthread_sigmask/18-1: Fix race
 condition in signal thread join
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
Cc: Wenbo Ma <wenbo1.ma@intel.com>, ltp@lists.linux.it
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
