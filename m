Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD2FC97E2
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774860988; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=PTE2qOanqbNVNx688/9tC7yGIqRP2IVwg/POYBw9auJcAVALuzPI57IBOJ9DywepE8WQM
 ipCWYUTXr/ieWRxLXEUjft3B9K+fuLOtiq2sICrBF1rWGU1B7wkQpwGZGdMKIMS6HbDDelf
 +COhoRuIYkJN0qaT2M2vLKk6vFBwCRw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE31E3E21D3
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:56:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD7D73CFE82
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:56:06 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 212D820005D
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:56:06 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso50376895e9.0
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774860965; x=1775465765; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=KjepYDLfzpc3Wo3WNfKHymNq6ZTf9ZVLfkHH0mhmak0lBl2WzTRYqo4MYlRoOYDxaW
 xonCf7agxBLNj6kXfdn4UDyjB8ifQ1qXi10NUq4iEqAl0wt5RT+q85s8zZh36StrqYio
 WVDzdbzjRloB9gs9fOHygmSPEoftFYypXqw6JLNNM+6g+XvW3oywhAeXrjWmr6vx6i+J
 NEbcuYgnje5hsvC/vqZSoiSIhSTA+J+NHf/F/TORJ1vKBO9jHe3GzpCBKgohWlHUN6Du
 7Mb3tbWO14PVryHF7NkxUn+7syoxmj61ixP5mBy2DULjNqo13iSqU5tsK+1j6hI+iVZ4
 Gb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774860965; x=1775465765;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=esEIZ//rkP5ZOwRsf5pD89TJMQUyWPR0c4rf+BVonfqUG+vGlBUkZS0Jq18fruWsI1
 W8sxPROTHQa0fKfuOJyg+h3DWMU8OzpLIkotx1mP3ZUlxrVh/3E9slJbv3tdkQVTS3W2
 mWlJAT2xY25d+e/DxPCFQMCEmtivH1jmX+awc2LBP+hsp4M1Fn77OHbxg+dvtCCK+DZL
 1PHUMqLSN6xT7pdQS7cNFwPIKUtjHW5/cr54ho+xhwvJ3EjQR4HgyCOGTVRuF26nw+Iq
 iw4LQRLHcVQDfyAjlKIJ6PPhtMjmD0nHbsAnVHzhGr1tx2i/1qjHR542wwwmd1IjjGfm
 6I8Q==
X-Gm-Message-State: AOJu0YzBYKeKwCYc2SaJ9PovBnBs6T1UuGih0rq3GJyq/jr+E6+L/ANP
 ZXITZxjDFGRw6N8R1r1yE2l9koPRb70VAMkqyF4pjlPEIG4pLLbptZ4K0Z+EdyHvbKA=
X-Gm-Gg: ATEYQzwE2K0igjK55MA1mpe79K1IKMkmECGa/gBfkC3sMLkzXSJ11JvpKu7brOPDyrG
 3UNn5DqeBxOiRKul/MVWH/YaHxK+gUZwDCmzJ/sFxMGXZ42lDvxp9Hm0H/PcRUTBR5qeGjFCoDE
 VlS/v41prcw7OswWKmocjnXBGBo9dLm89jdZ3o1tCEs/2flnbfq0h5JcL4RbWKlKPxkD6JQ/JNR
 YUrDoCYInmWk1uaKAwlbNcdUJLj2KL2L+dPvWV3uX7GTXtJwv1SQzKFDG+YW1d1zAPaCtRESRol
 mn7QYBdsdgh30595jo6dNd6/jpdc6gBRgKP2gdIfDcnTFdsJxWYBKPMFgBCngqBJ4hr98ZZMOYr
 MiU1ql1tum5GiVnqZYTP1m3HD8a2Rr9RudTMWe59YFRErE26XshFX34C/kADCkEwCKHWyTUanqo
 VnvPg5ISX1DSGQeLSVkTGxjGI18a6rbcpMZlraVO5i7ZhuWEA2lfGlNwspfkkt8ttlFg7Ija6v8
 49ksgqZuD/+arca0jpAo/hgDBzTK5UP35s=
X-Received: by 2002:a05:600c:6095:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-48727e9a09dmr196157805e9.12.1774860965420; 
 Mon, 30 Mar 2026 01:56:05 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c84988sm237957245e9.5.2026.03.30.01.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:56:05 -0700 (PDT)
Message-ID: <69ca3aa5.050a0220.3e39d.0ca9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260327173252.1112192-3-pvorel@suse.cz>
Date: Mon, 30 Mar 2026 08:56:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] lib: Rename variable LTP_ENABLE_DEBUG =>
 LTP_DEBUG
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
