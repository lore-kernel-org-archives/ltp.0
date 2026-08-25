Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5671EC61DB9
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787666448; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=k6AT7AFnBOYSdtC/UGYTNdpnd03M6zwzjeCLfVK3bjYPzMpPcrip61/9b7gewTp0yJgyx
 ZTN9hYY6lyn/rJARNKeboDAA+Xl5FfjKiKnU+BXqdGyUinVtLCMjmR5oxfr7sByWS+r0oHY
 dIPtNTOctq3CHsMKDh83uXSskwx2yCI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A97B73C719D
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:00:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41D6A3C7394
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:59:59 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A33D8100040B
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:59:58 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so681904266b.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787666398; x=1788271198; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=PzITKFKRm8W/mBF9mPf4+ck9JXAN6HSQMcPzOVp26oGpLVT3T3HnQshWLsVHVVf3ne
 1VWmVoqcxPC4udFIxJYK6hvt2ditEqz+mtu2rnJmGaXkF6hLenOA5wgaHOODbBY8LpVL
 HOKpjvazFV464QzgiyiF93pH5oQkSzxx+9cDPeUKnUB0yCutPxMSTPVCjhpPB4tSSp37
 yt2CZmRAodBGJQZWrqnoQj6vObNM8IhGm1ugVYFPE5ys7zmKENg62W6FojNaDFx8FYVA
 F1pvP/mF6Bv9rYaCLIxdRVINMffGq3Cgd5EeQkBXoLFRYHUedf4J9vDD5bvDBzaOAN9d
 /+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666398; x=1788271198;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ICU2BxUHonL2ZyL8MCFAXzMVNj+AqdBQANolPjMRPaw2NeBKMr5B7eCwH97MhlRIvW
 12JNvqDIS14phm+x5gD80tCtPL3nt7FENaWnvm5up/RkOcwbKvo6fmTQY1ydpCMSPk5l
 uQ6RkoKlYTw1GjgKndskRFliDmyel1hLI5lmiEUKUvg5Ef4XA9EQI/UAgflechjx2QFr
 lgSlkV0WF1He8j4vn0hxZplKyEzOk8qfVMCoMlmeMZvVnl+rYFAAwJNkE3OL/fERbYy3
 vHtVPApgIFkS7dsrAM4bdf4LmF/Wbu1JgJmvFi1JU78g14P4o975YqZx9Lq939ZX5ez8
 fF/A==
X-Gm-Message-State: AFuF++mkxbhsuaF+B53+zvdF8ABiJoo0IjoEd3jYHA6ZG5b+V2N59jM8
 ITh6Llv/jPSA5xqCQHg7J1tR97/hx8vFCaqYovBjc4DNk0CF2k2TdYexyaTDHabEOJLLSOkqN0F
 qZHvD3Kc=
X-Gm-Gg: AR+sD10+tttHqNk5pB4huUnmwEWrsG/5D8u4PuZg8tOOfqf43WZcgyAk8UkS4yf6t8X
 E317XyBYhZP0kB2wevNdLsS4hjg7IQOwkZA1zsvrb4GEWHNGyhrxprZrZl0IHu6/AP2+8YWip3Z
 D7n4Ctcn+r0WE5gS32dZyqUoNk4wUJgYo6jYyC8M5xC9JH9RMejelj3vgPPj+mw2F6WiVPsUXjC
 TDCZtmhnRYv6Q+rpreC1bi4tOpzjKg5HUD3PVq1hxSkNnpje5WptSTeCfmUsyXh7XJXJRI4o4UF
 IZkD8nyJkBWozuXCr/Dbvs1ho63wOcoh+krCfbyq7GHoGaHZxrJF9ZR6Fs6tibQ29vEoUW1W6I5
 n8QQZxjN4m3EzJ01A6oeK1rj9ruFZ1Jab9da6cDVDV6OisijH0WTXEv1y0IDWE2Y8H3b2Azthas
 Ax0GIYBI+Spx2F6emFafQSBXPJEAwMFWfURAaHh4SBDUwVGzgUZFclADQA0cg7ju6hFI+HQXeBq
 7HlI4e96JiNpq7MDplekSAHHp0UOMuSklJ/SDJVKWIgRUo=
X-Received: by 2002:a17:907:e1d3:20b0:c25:192:99ee with SMTP id
 a640c23a62f3a-c250192b1c9mr260922966b.19.1787666398046; 
 Tue, 25 Aug 2026 06:59:58 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f6b48sm1877371566b.33.2026.08.25.06.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:59:57 -0700 (PDT)
Message-ID: <6a8d9fdd.2b04accf.11303c.0096@mx.google.com>
To: "Disha Goel" <disgoel@linux.ibm.com>
In-Reply-To: <20260818121436.1397-2-disgoel@linux.ibm.com>
Date: Tue, 25 Aug 2026 13:59:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] memcg/memcontrol03: fix typos,
 redundant define and format specifiers
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
