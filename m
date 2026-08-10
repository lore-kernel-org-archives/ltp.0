Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2B2C5AD4E
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786355335; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=d3BIth8Jqz2mBvqqI4Id46gwTSllsQOPj3c2drK27v590fDKVzjQ+HS9JFpXqg0XQ957L
 GESyJeHhhtgWeFWspOrppLOmSfC9Z+UE5BBj0K9318a32HNLkHqXeLtFQ5QxaMfSImlhqs0
 EQ0TazBKIg3Df9v0COe0yv48S3ApIO4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 278803CE356
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:48:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D262D3CD5AD
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:48:34 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 526B96005F6
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:48:34 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4956869750eso10724845e9.2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786355314; x=1786960114; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=fZVpAqayGaaZvMrghl3r+Y9sRv4OQasRvwUzC0iVbpkPfeP4DwZlLYu+MwBEGhnsl8
 YnNMb/rAUg5kLOoFirMfE3+ve92qvUhBmq7HMcjdeMhpojLWqIsxKTIPZoRNfYTxWlHQ
 d5oyBoXrRdvj6EjUi7UWLKaaiE5yHWd3MLIeadztZwDtcCc7gUzW9ip4+PlqnOPOExi9
 C5c2W/P/31p/TcxhVeKHx5PCpbF9do+Bj2LbVEcGZRBFtou3aZVao9jrUJ797eSewocZ
 vjH9CLoZRM3A4y00/FsmbMdWvQJe8rGtiFzh+qKkUsOPDycujaGHKbGEX4gyIZuBBgOj
 gGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355314; x=1786960114;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=CscqJGrOpFVtoLQpo4y43NZtUdsnQX6oFM9Ifc3s3tP7GnYkhVDc1W+0jR5Fa/Qj/m
 6/283R2ZJU3auBlIpEUUBaz8lsolybvP2PSoE+ujnL5rztxSNj6H11INVvDBBDxKk32X
 XxpHGA9qB40UvD2YkD3vD/dz+z7Sd1fkzQdmOfKdzT5U5y6ja7b8kHptks5tdR2gWpM7
 xpW81CYhYIIoINDcuroiOc9dYtHQb9uV6fAcS0v/h/bggEu4wzb6+ohZmuAlEQGJ6v7K
 2AtSGewA4QdQxUwcsXu/mbHH6857dw47hXUMWyZoR4hB5FRo3WOl+AIvmUULhfHr0Web
 XUIg==
X-Gm-Message-State: AOJu0Yw/T8ZGqtT+Syk5jBTCZBDjSTV/UUCvjXZmIwtIO4SVHnhR4W0q
 Kt4OxfCfaLuJEdh0i302ihJn1bFP9e7+5fW4aVPZlaTk+CeGHuscaf2qgz98vQFN6/7t5o/G7Pw
 6YL8d
X-Gm-Gg: AR+sD10kH9Zyw+SKLhUUqoplRfRu6KEzkRVBh9OFpXfkIah0RGQzIMOiCaIsu+O9C9z
 16O/WrJ4H75fWiixhTbai9jAyDBn2p1OcUDnGd02cxotpxH6yacR9yFasxlmV9qMtpxOiXpKd3G
 y1cNXXWQf9XAmPfrP3vLsUqdIe/SnTiglAcvS1uvRShQXmpgfFnA2f7yir0ZnN8/BOLZwZhx3fw
 hskyQkjdKxQmnyAu1qnKPDlE6SBlHxuL6YKfHM37YxFqZwTUZNdLJXuppIEtr59HyYzd6ZnCw7s
 scx537vlkMGE//69O+wSJxlO9RiVP5k+g4j7l20u8zR7H+7IoNT+/roLl3X3J0Fb951lP+7M9q+
 BeGsDLq4NkmNXkxysfp2cXu87ABk285SIRUlNDonI/UODpHy/0uP58Rhzt5Aw8vN4o/D/AGSaKh
 AsULPMt0KvJU7UCOCGa1aSstSkSm0DEbeaBoz6UyTktsxSCtsViy0kA1Y+aU94UL7ZQFLQNg==
X-Received: by 2002:a05:600c:6305:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-499728b4f9bmr3252905e9.15.1786355313586; 
 Mon, 10 Aug 2026 02:48:33 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea27ef0sm323065695e9.9.2026.08.10.02.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:48:33 -0700 (PDT)
Message-ID: <6a799e71.8af9f03d.31a0ac.aac1@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260807231752.3218267-1-wakel@google.com>
Date: Mon, 10 Aug 2026 09:48:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] inode01: Use uint64_t to prevent inode
 truncation on 32-bit
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
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
