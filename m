Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF52C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789044088; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=P6q+6QQNFZmkEhULwW59FCLXV4Q3yCyrBOQUd3L/G3k=;
 b=Q6c1ZPRMU181C0B77ePamoPldxXyrqK/pvSeom/FRPOO5by+WrHcJI7gxUO6mV8JGVUfv
 LqT6HmP+LHsrkEpHVr3oEsKG4bY/micZK43yIMzdwQXhIRWuyohFgF0y/PNHsw8FvUFghAI
 7L4aVaNtFrqI7N4Yvyb4i5n1xGg+0jI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75D2C3E72E0
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 14:41:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8FD3D03B0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 14:41:08 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E99DD20074A
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 14:41:07 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so69118025e9.2
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789044067; x=1789648867; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+pRkg3PyXrZSjV8UhEFCQeRtv5ejpfhI19k2rum1+HE=;
 b=AnKsn5c8Tci6cZ7ettAptF8Um+WY3bI+WengsVYeZow8bb6aeVfLsUCKnL4DvWIUvo
 afSMDk0vv6S+lOH7Lb6OTszK/lduRS6gj74PVwfoCHA9ZfjCsPREkznbS3arN5r1aMKH
 HVDr7UVXWqrf/TtH8U375f1Hof76vvmSYnOwuQIFca7Moj5WTFvlv/GzTJuq117z3rpz
 lD4pqXiahmOOasm/XVTubiQ/HR33bb5KXivcoTZZA92nffTFDX8276XgqJOUIzmDmx0r
 imvfHJxdOX0qnkAklTEnUr+incJ55z+Gt/ITgaRX9h3iWlxGafYysUCsKxpXzgOPk8gy
 Aa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044067; x=1789648867;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+pRkg3PyXrZSjV8UhEFCQeRtv5ejpfhI19k2rum1+HE=;
 b=tCbS5TyvCttkr61pTkgWbXcQk8yiPIueChxFcTxx99HmUJdNFSZYsgSVbGrRhbvdnP
 hNEXHLJQzwEBO0vvfuu54jXCgXvcJUQ1wrFmIEB1fCFFe0bOoVdw0j/BRCz6ZYAC7Zbb
 gIG7BU0Wl0sgVUhm+m9YXgp54OGL4wwBLtn5PAnVQ1C4VVyOLMMwNb0BqdwFbDQ1xHqP
 agapiwp5xHUN6TRsV2jCMCd7lnyvuwiJjGHch6S8ASUfHPSQH8yKeG2DiQ68PWJ04Wey
 s+o67oRRLMbnoDpDJr4fz/XTuYvD0kI+P18xoySrOsUHpWvRt2JTust9OqQmyqm7jSpw
 wy+g==
X-Gm-Message-State: AFuF++mYOmQ/pXE/MXbf0cddBeG+uN9xh9BWgfNfClmC1/OVWIB4XcT3
 TBnlYkyDQsP5xxTxTUYjQCEvi4aJEW+42qzaiz9Au+BANZn8V64OtXIzUnIh8Cq4Oa2beDU5MKV
 DJAOAuWxEqg==
X-Gm-Gg: AYBFou2FIQbM26drieinR4hV1gTHsTlUulQY4CcLAgOIHPB1HsqvQdmCEdJ9T2i2tjq
 U/gKmLy8dzgGriFg3sHSgq8eqH4Zj0B/F/VaAv5KUDWDfHyGoOVZQuA71BjDoELLc6hCibN4dkb
 qY4MhUECFrLX9DXXcsE002WCqG8e9QohviQUJOevOg1mBJCKD+jGFinDbDp8B4V2q6ZKXpvGnDl
 kel1gv7DNyHftB6mioq4xeMeQ0LA+mAg6jhQKumharwnvsfRnO8k/Y18cNMKlb+KJoJbDgNutxA
 zNvfLYgrcv75oFRU25f+B/ifubeOrVBNNzQ9mfyW9UcHGJvlAgSZfgrAT942mCFmt7KpUW1SAYs
 PHtScg3fdSSW09tOM2Tb+D7c2WswgWU40Jzmm0wkx50HaJWKXQZuNyZ6o3Tkp4HtMIMmaFL9H8u
 ThOgf8NzQigc/sJ65n5/mwDfw002m8oajs7Zv5T2rszWRky+vhOLa+3K/dC6ZzbaWzBnQMJhXn6
 T1yN8hgfRvYXei7aISw6er2SINA4O7nkHxq5f3Qu2Xdse4=
X-Received: by 2002:a05:600c:8b26:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-49d25364042mr73687735e9.30.1789044067195; 
 Thu, 10 Sep 2026 05:41:07 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm77311595e9.9.2026.09.10.05.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:41:06 -0700 (PDT)
Message-ID: <6aa2a562.2769c8e3.390461.bb6b@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260910-cve-ghostlock-v9-0-ff3c31791cd6@suse.com>
Date: Thu, 10 Sep 2026 12:41:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 0/5] Reproducer for ghostlock
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

Hi Cyril,

sign...now there's a build error. I'm gonna send the next version..
https://github.com/linux-test-project/ltp/actions/runs/34474819570/job/102862960039

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
