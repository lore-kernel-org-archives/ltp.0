Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9561AC61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787678354; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0v0d1e5Zbjw9TyDr8JeISolnib9jwVWHXkkiPweV6Po=;
 b=YTx044jFPXJZYInkPwobEcSsF9mScqOkmTOWnFzJJ9tF58vlB4grx/aXD3yy+WPAS7siL
 S/U40GkOWLKk0MJud1ujiEzVtngUHk4yWgAbpPWx/TUZlHPdahwN8Ub/3o5PRaCqZApGHNi
 qfclIBG7eQhzynBVgdmqIAMOd6znRZw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A859D3C7176
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 19:19:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C783E3C210D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:18:54 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F75D600428
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:18:54 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so766204066b.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787678333; x=1788283133; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TUZkn/wnyR94HkIYN23yOjqWKYyJPpAMsveo3EBjSgM=;
 b=LKEVD6kqn3/tBZ9qb2GtouSLbbYpnoKoLG390w7VR7+jQoioh101NU/9yKkaI1TqWs
 HpPdMrD4UpJEwRkXIQXfoznbkFvFWjCZgj4g7z3tbPrzbjPjEmvn+cZ1QW0+aVaE7aqf
 uTEDeyfhgI4+qW9RgLxy7xN8ffKnzngNcSdg9L15dZxxWIn2zcHCRj+TGqOdJziQmDkh
 +ImzSfhIuL7G098iS5Z7G0cj94jauyXTn02BTGebNAjevZ8xMYAs4dNKa7OmWqlNgaYQ
 FxhGtH8ALTdDbZQzEsHNYV1oPY0EPohTyGiFbzAkh8l932oa/zl5fQkhx2qWYKkpwf3K
 ZPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787678333; x=1788283133;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TUZkn/wnyR94HkIYN23yOjqWKYyJPpAMsveo3EBjSgM=;
 b=qZMVeOKQSlNI/7tE2NRVLkzVRWHOrANDX5mt7u+jduVIzlhZV0bVKVk3jgCwiK84Yf
 w/fWYZu7UIC5TUNTqHa2voIhJn/d+/G5FDWQL8seswU3mW7dJwisMOwYjssO3vKoAi+L
 YBiy7Te8pGHJcMtuzk0DWA121LR0T1bES7EkRskhOVSyef5+Je1XGoHyGCSZw10oPfLk
 BsTB00oYG2lBSR7PzxYxQny2dsYNueiERkmdRSfEsZUExC/TJWOKVKDrRryrqjuplvnO
 RPAussmL9TeImoNMF0TxKGvB1vd9Y/7D14qMVle0ExPsmnIa4rdCGxKz574mSU9c+iBC
 v5FA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0roS8hDgjp0oGlJ0NrpKAuwES5rIP4EViD305LlUauuGzrYN+Ahlzx1HSZFxD43LgOjo=@lists.linux.it
X-Gm-Message-State: AFuF++lc3CXusLMrAdPdk9tlw4QtZHusyywjVjlKRrtOKbasPMC3DrI5
 W0ClM3CWrBdHOP9aENDKUducFwhjSzwPB0bBwyVqt5EnhxC2d78yBgqzaMxkrX5LQME=
X-Gm-Gg: AR+sD13dQu8lfA7BuiaQY5gK9JVwCwAN3Qb3ACNWst6ErNb3TjziVpp6x9c5aFHpnOD
 Y/tjscVVR2l2rwVHoWoA2nj8V56H+gzaKXJD0BXQpL/4XJ9PyVI/RWQcNOidIx0eqBk+Uu+q+Hf
 DO6QOQIyFcGdUK1r2QtRKQHeNrCBZfxZKGyN+U6bjVxWmAc+r79zIStWlLaH8rQ+aAP3k+jS9Iz
 91Zl59ckL51foTKKYZnwwqy39yb8U341N2bxoWwiaRogrbtNclwLM3AdlwRWQgfjHWwe8cDb0Td
 gjHfju/dPTJScYxHcAOR6eaMQ2k5Rg3XUNoNsXxQuxfJpaW7vj+FNILIbhWaNTdVhnKijvWOWix
 XZsNPsWKllB7tkNZ93OUTyqSGRkCC10L3Zmh1xgn+KqgJ0GTa14GmHk37xGdp+i7PU6hJzID2+R
 TBUX0vLfgB8Qo5ASO3e/HZ+j87eKBCwE+Yq1FNA9P5a3ZdthiITvust9byGav+vKpd6H9nsm66O
 zHPSQpgw5xvIbOV+1X+6hvwr+gV6lidTojcMGjTtJNYLV7GdtDjWj/+2gHf96fWpN3FtUQ=
X-Received: by 2002:a17:907:1c9b:b0:c24:469d:5653 with SMTP id
 a640c23a62f3a-c250c36b074mr15183766b.21.1787678333606; 
 Tue, 25 Aug 2026 10:18:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b22ffsm40860466b.42.2026.08.25.10.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:18:53 -0700 (PDT)
Message-ID: <6a8dce7d.6e4ae5d3.4b2cf.4697@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260825150749.GA86472@pevik>
Date: Tue, 25 Aug 2026 17:18:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve/sctphantom: fix EINVAL on pre-v4.19 kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> nit: I suppose you copy paste the older struct, which used a different
> whitespace. But how about (before merge) just remove spp_ipv6_flowlabel and
> spp_dscp? Without touching whitespace of the other members is change more
> visible even without using --ignore-space-change.

yes indeed, i will fix it before merge. Thanks

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
