Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C50FC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788173442; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=PfmjWXt7O15xQoLRBVMlR/U7FY7z68Jw92iicgXIh6sKfvKvdBxHS348pWeJZxB8v55ey
 tCcjAFHXvzNW8NpxSlJkm+JHZPZGJDnvlLxx2xuKSrf7Ti2diVXongPZSJtVpMD/Et++d3a
 yZWzbXDu+ies6Qjb9xLcuzWHiO0LWbA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEBEE3E96C0
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 12:50:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4DD3C0E10
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 12:50:22 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0EDE01A0092F
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 12:50:22 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so274167f8f.2
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788173421; x=1788778221; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=C0U95bS9848z0kZYThVDcQ+WXT1EPBmrauBw9Tpfd6buMMCku+dfxx/HpCFiJc1g4F
 JyQuiVrf4w5MV+VXm5p3WTp3vjc2hnc6u3ONsZwpsFL6aBswph6k19O7a8AvwWpArweE
 bM8N0LxsITVxDaRNU/wikj/A+UaWKr/P9Bq1TNxZn0ZSIHAJymFdzFDy5V73u+BMQg+o
 g+sqJP0GmN5sNkIsugamrbVoNdVPL3wQP+1NUtUdQyVpVRrXuUBfXGkote2iS29woM30
 WoutMFWOu4SknvdJTTEXLU4dOkmwJVbrJ9Z/EPmgXs4p8Xsc/U1++y8PpTfq42LQedEN
 /eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788173421; x=1788778221;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=eKjzg9WkpFE1zXpRn4MY0C7KnnfbrSvq8zkavAYUMSZYf/9Ls1kAPyDSwRQYG9h9w1
 DiLNbNL2w1TfyWfnQR6Is8BK0Nvt/280RfJ5nIeZsXKhEoaX4AbmO5XIEIw7MoWKoE3W
 0Cvr4uOL//8APJalpYcb9w2/BY1ZbPzkvVU6K83WK3rKILIIo84VB/q4YC2B3pShn2r9
 nQQweQwb1PwsRyMi7bsLQ0w6Vzw7/NuS4KgzmkMgbVj/3Wg1ZvlSIUNMkATzrH1OWn7d
 JLGz8ON/zEEW9JZd1x9ZRrPoyOFk3qQiyH4us8LaG3p9BCvwJ4UOyEAlPwy9NVRlcx4T
 Szcw==
X-Gm-Message-State: AFuF++kou0iueQV07y6JX9KgRgYi3CChHYArW1HLUnan40PWqh5GTnHR
 MpKxYLe7cxOeyC4OXjmXUfJ1QYd4WMdZQQUAa9+5wk5iBSYXCyR/aAmur87c14K+8Js=
X-Gm-Gg: AYBFou0Q67GZM9o6NIVDBfAL7vG0LmrQiQpUsvaZQrleHSFrzhDgTjRn09af13vovUv
 KuUlr8rdGbg0NYOQmlYBpUN3IKk8655IQ4f+wy+5kO/bYr6mVtKfa39T3HNqub3MAUbNpbHkJf+
 Agdq9savQHRRxcNgZNYaKpFZWX0NtnA4oSxlmydTMTpXd/E1BZwEs/aQZY+b2F19HsiU9w6HT/p
 KxO8FxCDFeN1QlK7gCMcTcw+mPNQ33IXWy1y2M7WK/FsO/wV2mX/0/wF39XsRiHRgGXLa+gJQuq
 CPkJUDji8vC0z8NryvcCXJZRPO+jvP0T/JbKTL2F7G4T0WugZw+iKUrMtBudwn6ob9iOSRMohAB
 6zgu7f4SoTB/gkyHLr3LsVp5uLR67VR3nXOfg3sgR2PC1da0zEV8tZeKpqTVumpIjkd6pWzMRWQ
 QjRYt1RUZIHJJ8jdN+H4qmIbBI2z4bQ/fbIKRpVcJiSoavaKPl+v01imfDOr6jcf09ZSpMBrgC5
 2z3tQcS9aO7ZVmQBWqZczLEbXwlcAQM30rs
X-Received: by 2002:a05:6000:471a:b0:484:3785:210e with SMTP id
 ffacd0b85a97d-4843fd0fabemr1645131f8f.25.1788173421432; 
 Mon, 31 Aug 2026 03:50:21 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22641778f8f.36.2026.08.31.03.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:50:21 -0700 (PDT)
Message-ID: <6a955c6d.b1f9e4c6.274437.cb69@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260828230924.2635548-1-wakel@google.com>
Date: Mon, 31 Aug 2026 10:50:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpufreq_intel: Check for per-CPU online file
 presence before reading
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
Cc: Grzegorz Jaszczyk <jaszczyk@google.com>, ltp@lists.linux.it
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
