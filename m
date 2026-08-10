Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61255C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786354904; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=58NAOoMUDg3aKNjgT7ejoi6xrmjNytuufWlpHw1ktTU=;
 b=TSNYj93Ks8GNghhh51IgQk+fOnWTEDzqgAM3AP4oQ84M6F10nh+8lzlypFo2e3NyW1A0n
 b6uhBsNhSwV4HHHXdqV9fy5MAg9gScr3KLFUW6O4SB5gRd8tKZ5699/6LFMhdXsDcPwKGWt
 4XQbOSe5p9RqytOd+xtK5r9f6+noYvs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A4963CEEAF
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:41:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA54A3CE141
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:41:24 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3C71E100060C
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:41:24 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so11896705e9.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786354884; x=1786959684; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CUzRdSvoyLUrHZNnz/XxlRgRymWsZx0M4IGGT57Nd/g=;
 b=IwwgT8Ba7xp6c3Uv6trgq0PyO6FhMee0348jlt3nL5WgXpaH2+lPfswTHoNshSxKdX
 rCfEwAS5QJFoU1kfJdliSjdJ4IBzJMj/1sVVK+JOLzHc0YPqZ3DNrBix2xmGjvBk7qyy
 9msxnInb514aFvBbxThsdN+sAi5uj0jzUI5Q1vrZkLAiuUIjFwGIynQdSlvgSo95C3kW
 OBg9Gn1D3pqqhgs1/nBSSXKYAuYNW1WdwMv8XIFMC3CslR5nN9fJ/hFJ8OQdscJHU6FD
 BLopkb0cyTbmZHyXJxIMvMEc/Ii/NLR1y8PmNBjM8AlxVS2/Zhz7+xgcxTu5GEikUyS2
 GFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786354884; x=1786959684;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CUzRdSvoyLUrHZNnz/XxlRgRymWsZx0M4IGGT57Nd/g=;
 b=o305inLUMEsfCeXD+LrNiJwmY5Os8G1+kIzqaU4fAXoHln7QuKD3BJr64TryUjkgk6
 EmQNeE5BCNJfakNCGS4EKo7N7ZV2WGIJAURK6hgrmLT2flNZnn1l3vbvhaeCXWEWyeeS
 3r/JaG+cfvmoy0PK/U1ScWtvftPiErd+0WOUY2j1qKY5AoXibreeplAiPWA5Izz7E9Mp
 rUD1ZKA9StpCaRcImHC2TVAcsnwFURrI4Zb1Z0fSMzhWX7IGVxxWp1wPM30AOkWUdBJg
 ARcYaSkoAiI/eOqGqgHglkGDRMVrWOFBjkTQlBwRI4rvQEs8wERbssPJq366PoCB1s1L
 X8yA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqT+GCY9YoX+AXWu1Js8gvL9H1ryEckzKlNUndHrB9wg/pzTKxMCNHDMEYMMWtIANGwH7Y=@lists.linux.it
X-Gm-Message-State: AOJu0YytgyWicsibnTFaFZMeFI4AlFr0BkBghGsSTHSC9iuwwkDsbuj5
 vDtL9tGa9Lc/yJhSFAR/STzv9tXK3GVdi16vxzi53BnNBen+ehbqTQy8hsaJ26TyTlyLYNPv54j
 O28SL
X-Gm-Gg: AR+sD13RZQeSEqVCQxBLvVdfMvrgixK7F/oPF8CaiPDfrS4O6TKfWQm+9Z5pDr7zeBD
 vRQClFuwQ3E8jxt2kP9wLtVc/TrXT5zrwraC8yguRFpT1BGiqfiDXrlALuH7W62FO5uYEZPqnE+
 1O/JjAF/qk5iR6Xp2FK+lSDeGIedkElE1tPuDKTw2SQFRhPMzfVSm/RnfZLv9P05EgtR7Fo2pD5
 VPybnTiiB9kH4RhyLIfUpjxc8mbIyXtuTiDqdGRwbJ/cZOMQuZrZQI44UIvmmJ8BeZDA8rXOZs8
 BS/Pl5P2rBCsasg9B2AX03dP93UVvDq6gEOZCqJlifQXMMQe3lhVhHEC4C7zX6/Vy3VEPX3O8V/
 Bsm7xzkdNHG/dD/vfCzuJPYMPe/qTEaafjIGsYkkD6MLHF/DOlVsOP5gSiU82ye8eXQBiLwBnl/
 IZfbOquMxoSls3UKvBHcA90d51PbrFX8NbwIbgelN4iHgSHxKT9s4rdc+Z4VDVK5KHtEu7sA==
X-Received: by 2002:a05:600c:35d1:b0:499:5e9e:1f50 with SMTP id
 5b1f17b1804b1-4995e9e207dmr304286885e9.4.1786354883627; 
 Mon, 10 Aug 2026 02:41:23 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2d84csm243944165e9.12.2026.08.10.02.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:41:23 -0700 (PDT)
Message-ID: <6a799cc3.3b530373.1ff701.4966@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260807141849.4616-1-linuxtestproject.agent@gmail.com>
Date: Mon, 10 Aug 2026 09:41:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol02: fix fd leak in cleanup path
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
Cc: Disha Goel <disgoel@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Disha,

> > fd is initialized to 0 (a valid file descriptor) so the cleanup()
> > guard 'if (fd > -1)' would never trigger.
> 
> Could this explanation be corrected? Zero is greater than -1, and the
> cleanup guard is added by this patch rather than being an existing guard.
> The relevant problem is that -1 is needed to distinguish an unopened
> descriptor before cleanup tries to close it.
> 
> > +	if (fd > -1)
> > +		SAFE_CLOSE(fd);
> 
> Could this use `fd != -1` instead? LTP file descriptors use -1 as the
> invalid sentinel, and the LTP convention requires this form for cleanup
> guards.

this is correct.

> 
> --- [PATCH 2/2] ---
> 
> > #include <inttypes.h>
> >
> > -		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
> > +		tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",
> 
> Could the now-unused `<inttypes.h>` include be removed from both
> memcontrol03.c and memcontrol04.c? This patch replaces every `PRIdPTR`
> use in both files.

And also this is correct. We should split the patch in two: one for
memcontrol03 and one for memcontrol04

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
