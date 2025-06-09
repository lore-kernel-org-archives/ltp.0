Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28DC5AD49
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 02:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749437617; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cO3EaQMbIkFr0N7pWG/mP0sMM8Hy/3KhYdZBmpwHp1Y=;
 b=cWixNUs19QCVDJbzBvSV5eyNNBBW/vbqCEIG/M0sELDzzPSiP3T13NSGLbn7oegORj4ca
 Nz2tVz7QBn3UHC3rQ+7Pcmo9+nJ6e/TOndJdkxatIO77v12ZJacfVJ3IDKY0Rych9f49K6A
 m9+fmY5fDDtfhTFVb1SNyiDvBFfRPZk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3C3E3CABA3
	for <ltp@archiver.kernel.org>; Mon,  9 Jun 2025 04:53:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4793C26CE
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 04:53:16 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A1FE8600541
 for <ltp@lists.linux.it>; Mon,  9 Jun 2025 04:53:13 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so3317011f8f.1
 for <ltp@lists.linux.it>; Sun, 08 Jun 2025 19:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749437593; x=1750042393; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CmKWYOJMcZmXEoOSmf+ZJYcIAJALxgPd5c/3AZ6WqO4=;
 b=cbWPSDFqXydiUegh4PrTfqFfotAbyGI2x9EbvMoNngphU9jNGF4FGyBngnZ35Rc6ON
 iM8GNnf9fvZJBu18Hp50VzYeCi7rejWTSKtCrI5yCVDAsw/jIHBn2fQ0QwvYaDeLvP64
 L8l9hi4dHL6BkhkVaRp5gxYbpyGMS8FjKIKfH8Zrw/Tuw6xyRrMuEO62TlQ/LLA2x+xj
 I1pb454rHuAK6OZfmbv6TvYDSCKsPkAg63NYM8h85iTyGC15thfvq6Py1bUC8aOxmPfd
 qly7AExJhaDxUjEpKZddCQVh9EtIELWZjC3P+Ct9IQuKP1HwCpEVEou77XKglrOoQ/hi
 q7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749437593; x=1750042393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmKWYOJMcZmXEoOSmf+ZJYcIAJALxgPd5c/3AZ6WqO4=;
 b=s+offh+w2/vtDi7+CakEx3H7fcvlUEph069R1Nxz0fKWSnqUT8Zoo2epXkogY/838G
 MThEl1K0V/DmYEuIoTjMZlQjN5SRINtApPjxfuwn/DtAwU9cjU8TPAK6e4EsZLFo2WlY
 ugl84lu7EO5otsgjP2HEjash1+6K7Q+iUy3DjdAfs2IQJuvjZMNf8RLCwZs7ktt6upMG
 AkDh2PqdWcsm8OpNVrxC3lhSaLLPsz+zuA2n+YHcn/5FPbKtdwtSTY8294egk5HQSNoO
 hkyqC59TQOHI1thewxpHJtxPGeQTh5IR6xpS/pZmb5mC91f0mdvZe4cfNrYzGNyTjReM
 BnRw==
X-Gm-Message-State: AOJu0YwLOf3mAq5mv7SgPflVPGKTHRHhlgipBmz0IIeWQfiXEJ+m8yb8
 bBPrdZ2796Va268RtdnRs+w/VmI+JK0Le0QW9I+TWqmv1MwfPdL9V2I4YEwMTMHTnQ==
X-Gm-Gg: ASbGncu2jnRgTBJKPRUnNsAj/xF3O2PImTw7eY1K/KMA4mBwEec6mM3wxYiZIRdv4n0
 ZfyR6c3rnqyC4YoZu+ISeFF80K33i97coSpsYDTaWfX+bu38rHTLG77dn52b61c/MFzK60NGlrN
 T98xnso8aqjOSsXX1LuFHq4Bswr2KXabweUJ7B1ZrJPc3AGJOJpN55TSRRTY8Hhnwvr9pO739E+
 mK11R6R151G+1Ds1FM/aNRMMVjWxynpnicskL7X2HDiDb654bZW23Pv2ywBo6Vo1jCw4Jw9TPGr
 hBanFetwSC7YpOkPtfWWCDiR5AtfEs6sIrsW4c4SvC6Obs8jcpuKudAxq7GmZw==
X-Google-Smtp-Source: AGHT+IGDSvb4QhIT1PeFMraAGY8jOmlDQ47QP/vo9ls0RbDk1f14nlx9VrMsPhcz0eCa2SNNSXYfBw==
X-Received: by 2002:a05:6000:2c13:b0:3a4:ed9a:7016 with SMTP id
 ffacd0b85a97d-3a526e1d833mr14708207f8f.26.1749437593252; 
 Sun, 08 Jun 2025 19:53:13 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236032fce7esm45566795ad.114.2025.06.08.19.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 19:53:12 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:52:54 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aEb1RmlZ_mlUA3NC@MiWiFi-CR6608-srv>
References: <20250606132100.20145-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250606132100.20145-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] doc: Add testers guide
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

This is great, just a few minor typos need fix.
Reviewed-by: : Wei Gao <wegao@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
