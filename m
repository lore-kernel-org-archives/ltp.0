Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738F2CC6B27
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791966287; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=RlihyTRkkW3UvJC5jaRz5zC2JTv8aUC5JVr/VGOCsBkDUrDLlkv429rPtelPWGweOYvy4
 NkJSYrBajTGjP4Vg/yx5s0rEpBRPGOWOgoshg99aytu4WFJgt5u/Mc2yhqaU7uvuTiqaMlE
 4+RymNSz2tz0mDhZrhreKSS8kO+Kb2M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD4923E2AFC
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:24:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EAA23CD546
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:24:28 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9825B60081D
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:24:27 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so31380975e9.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791966267; x=1792571067; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=XJrfQn5QpFRWlhJLxE3s8nws0ptbgtqpS2sEE7H/19O5f86j8SbqAxNKSJrlhZSWW/
 59erNJwT7uyAhOYXJApPpvgMTAN9xoVo/GK9USD46wn2bLcaSqKHZnEkUcQCdHqOlGVM
 rW05Z53v28Fq2J6pIczlOodvQ0GE6UCaE5Tb2xOQ/mLJjcx956eJVxZaC57/QtBw/Kv8
 TKBqvTEiz1XhDvrV3gX0vHaa2/Htiho+re0a5SrycCdlOHoTcsKijxziYf9vPTwBCFxo
 ZxnvsdxsW8w0IfsccMShhoRzcUNJSaMpwsuIDN4HWxLozm5+VkJ4wcWgHZ6Z5ICT9MB+
 HQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791966267; x=1792571067;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=hI87+fWS/MdlICkv9bzhQQpKl8xgKkUKX4fZCBtaXPRdNQh5+GZ6YshLQy9Q/eicx/
 EVb08MjJsUTWfrVdfh5adaDfCfGtRjS8Oavkbjfs90JQJKYffp9I/a1eshVYcAeGwJoO
 R5gYTewJZ1lPq8sy4uuWLlBqVKb4eAA3PdDBV8pHEQt+IqIyhFFEWuJoFXaZ/ahfONmU
 vAsEtS8R+ACy2BRL6DfpGPOtW2jomcRhO667dqSKLQ0XCP+8JB9o8Qk9F+HPwL3dEXUp
 KVv474JwSx5GmjuX4BO+ILN9hwMSvQ/jFPHxoJ6gprWkGoYwEgKUJGHB8GuuyDdpazmx
 JKTQ==
X-Gm-Message-State: AFq9FYK7rKah5OCcXMffEUbQ9qq2q6uGDvC5q3c/YXPfcmsuM3BQhuyp
 VncgN9Uh2Gn16O3JVhvbdiScOQMj/AVjURT8meZ8kDZpRp2SwUE4xBI0EZs6z35V1wM8uCdEVZi
 TMcz92F9BlQ==
X-Gm-Gg: AYBFou04p5gbptxUu8qWX0dCFeC4GooLi56ii+j2HblMRulH+1jD2I4j87ZfFjFxzkK
 LBvQI/EQh/kUojr5EGA/H6v3AETcKxRixdznGxUTQf7Bo7r29YIdxPXne4iX+xuLujZ+H0luSZM
 GRlQMicw9D5z3WJqBGkiUgfUxjdPD/BfCYCaGsfnd9M4Oc3Z3zcshMZKQzPjOz4Fg8T5KHS1uUk
 D3MgJ+g7HcaVV/5qpCuh4EWxHyjBDX1sbjKqASfgEtU7xPGc7ypKJ3TXxe5K8tOgmmaGZcLml7D
 hqIiVckYAEgmwU7w31zdUthcFFawk1DVqaSzB297/FaSzSMVq9wytRuYomGZ7zVFgkJqtv7TDP/
 8Rc7kWtPbELdeh3H9u0s2beyBxko6i144NSvzYgSAAegq555CSYW+3rfxHmX8rCPFcMkgGN6Di+
 RcYfMmnRqLRO8xXhqpH5+ge5blwpY/Xq8x3h7i3zpmwk1jXQ8XsXhu7xsrx/i4W0ocu32ExcccS
 amiIr/0HJChQK5RZKWlO0WhG4s1XcZRGptDmz3+BTrfNYyz5RWxk27Pyc9nwdPToCUgpo9et9i1
 aA==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id
 5b1f17b1804b1-4a18e4cd667mr295501575e9.26.1791966266964; 
 Wed, 14 Oct 2026 01:24:26 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf214a1sm486264365e9.7.2026.10.14.01.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 01:24:26 -0700 (PDT)
Message-ID: <DkqcS9z6QNhWOfxK5lLMYGCle8AY14iEBf11@localhost.localdomain>
To: "Florian Schmaus" <florian.schmaus@codasip.com>
In-Reply-To: <20261014071734.450957-1-florian.schmaus@codasip.com>
Date: Wed, 14 Oct 2026 08:24:25 +0000
Subject: Re: [LTP] [PATCH] keyctl05: Use DNS_LOOKUP_GOOD to avoid
 false-negatives due to EKEYEXPIRED
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
