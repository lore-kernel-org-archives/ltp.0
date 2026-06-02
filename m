Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A75CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780416739; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=nT+tLe0JAouv73M4afqWlk/ouS8ATG5QMWaIWais7Rex07xXO6s+VP0KdbKVOsVyknMQn
 hQz3tJJLu5i6pi/XhvQHG2iBZB78ZKznN1ovTTWtEKlayYW7+JvGzNbRy/zn5CHwXxEFi3s
 k18aqd5RG+yErREkFs9PAuF0C0XVje8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AEFC3E7228
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 18:12:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2B543E4B69
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:11:58 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 55F3B20009D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 18:11:58 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b43e2b95so3470565e9.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780416718; x=1781021518; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=UTbVZDGk4gBVPCBEijcAXq/SUgF440trc8/wqUAab/mIBIICnZXX/D/j7j45DL2ykG
 UlE3LsvXH2XMErU0SVGt3NNNpvg7VF6uhe2xlso2cd1e9ihU5wLm98aaDaWnkmgc0jBH
 mkm6fmHNvXIKk1EQdzy0aNkBKA0rkFbWO3NZFZTNNXQAFs9TtQHyEMRKa4OeQXc359CG
 gCZPpZeAOXfX2cPD+hAhKAbuL+/mVzYqLD6cJp8UrWQ87JVYrIuGcUu3xEhL5IRlUimg
 6iuIX728mNMQ0M/ayZcvIFi2jEinJTIGq7RjGTQ4DqYqP+OivRiqqO/OyF0LsMsEZkDS
 v0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780416718; x=1781021518;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=iIOqy8PmDwav51a7Y5diIhms7yeD5fgTcYWF23xu1nSTp3uDLPEU0dDN438tsO3Y2J
 CLBIazbwu2wluWOPv262kliVSgtxBVWGkHoJHiKi7sxiwmOCk8JevtHaJ/Y/WiHakhVq
 t795w6LQsT46dT4QxHAx4xlxudH2NcMP3y56NdzEJBeAnRV8N1hzJnMSgbczeNfcHDwg
 aEMlBfglQmUfdKp7i0XPQlh7AXZ1yqKieuLg5ulPPDqTR8dmIJu6xZ6pwkUs6gZKLTuE
 iX+AfB/C+ZC3Q/jyrknTJMs+J4BxfZ3SfXy1Qj79gL8f3hQbsCDz9rvWuVmN7UiG1FFV
 qhcg==
X-Gm-Message-State: AOJu0Yz5BevltHT2lOov+NMElkQZ6x/b+ghW9sRAewh1XwNF0x7zu6n4
 HUDn3+7t/kpkdQeqghmnn5QUtMV2s35ns+gMnVWlSESAZvRoICGXivmcHt92cgCQGV06vQHPKAm
 7nGSY++8=
X-Gm-Gg: Acq92OGO9Tw/2GQgbDVJgbdQysekjDFvA0+C5F8mhHA1lSjfS2VPW2N/i6pj7itqsiI
 wvdHZQmzSaKFetb1ISMja1n6lu7zf5sGNY2jN0PhuCWtz9m4L0NqD+JkggE9RJPsmbADeHYvmEb
 NeaEhYaO11O2D/So4W4Zep+36c71C9HWCIjvTkWlPGt8tfelkFnlrzNFqPZ7uIhyYOxpq6d7PE5
 OipGle9KuHhhfj1B+ZzZDQzV3o0IQ0MZzOEJP4VeFJk5fig73xon+9CgppP0RY9HYjAwe34hRf/
 wcPT6FlPXs/p63rjPfqHlwEu3F3P/kX6zgvCImQrgl5PGyGEHsE2ozx1XHSJfTRshljYM78Se21
 yYlGpMKnwLy30nWgLMLVuelyeHIDTQ/e+W5QpovQnJA9SaWEwNmRsA+6bdQzzTrfI+GbpmTqduX
 iMzFez/hAhFQvhRYQUc9d1Qu6bxvZzsYAGZYabNYfRnxv6YRFDnMGsNFdgkH/LSP3sAU262DsIp
 8vztLTtqTo=
X-Received: by 2002:a05:600c:1384:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-490b50c2008mr5803675e9.30.1780416717685; 
 Tue, 02 Jun 2026 09:11:57 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f5612sm334833f8f.15.2026.06.02.09.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:11:57 -0700 (PDT)
Message-ID: <6a1f00cd.a55e49ed.2e7ce8.08bf@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260524161706.3510-1-always.starving0@gmail.com>
Date: Tue, 02 Jun 2026 16:11:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] getpid: Link manpage in docparse comments
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
