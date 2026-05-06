Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A993CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778070175; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lZNW0eJ11AvnbHNWQ8+2hnE4ybUSnIaDRDRsbvrws48YNWAA0M4jsU/L/NgaIP0EJVEFS
 iwoc5pvb0vPOKazi15mDScHpKpNm5cttLwTfRHPOQYet2Kqa74Lb/jPDtHhVhUvtxSsxQZP
 8BhJDaqcb5i9RGEDcP8Tq3pia6qg06U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E13E3E229C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:22:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7610C3E229C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:22:31 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E638D1400C42
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:22:30 +0200 (CEST)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a860667fabso5199869e87.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778070150; x=1778674950; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Mxhoau24uFtNhbbgpOy+tZ6O3+dA6MaxArv4BHWKNEzY2rZNTO+k83y32Iclakibm3
 koWstlnvYYI4yRvhTZRpoR08AaZZ2jrEX/SKuvxYgYt9w5NlGsZMeAruhd4Y0vhCCuRs
 Kx8yEwBCdIUSnHmnW0OBoWcGjqP7XiES0NOsZ05MaivqiHVtbGBiP+lDfm/pmpZoCZWi
 7uTafZ+e47jqvW6aDbmTt7cL/e8zix6OTaIsb8KNF6pGvGaC4o3aUvjoYdEB6io1lA5d
 kJCb2GxNWnWJpldbEJMl302TPhhmLPqE5G0ZOAaW1MOz39ZcvGCTacv9pXsmboK049et
 +4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778070150; x=1778674950;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=bZvurs7+0PyDCHH84ACK71hMME1301pF2H/HewrH/EsPCncNMThjKd3ztmRkaXvWlF
 Pxm2Mwz19f2qDQSTO8Dt03Mpc08+ziKVx/cn65L4I51hfzz/XiBLwdXEIJ9H1VIrxec2
 6VWgrBL7k5Sq+XuFggwYyNrdop4txDyO7j2DPe1y91g5DeQ9wfZ0Laj8IGjdB71kTvtI
 Ztpz5QdlLJHOkus9n7skhF8rwIHowsMhlkUjIukgcFcYy8CIl72h7fSBqlelHzOXfYSy
 5yXwy31rv4OKfNm5BrO/xChMktfXB/0Dn2aVEvpt1mOv39iBJXfji9aIM1xn3CdPBfvY
 sezQ==
X-Gm-Message-State: AOJu0YzVlo6gYQ7isJdDIaWKJ/qdBqszQ9DQAy0UIKqBmZowHiJbM05p
 oQeRkiHSx+NOLIDMXusrGMlroWCRPh9It8iKx+T+XouitC8Yb4J6QQ+L7BkdWKOJmE8=
X-Gm-Gg: AeBDieugzZmxDIOc2RUKrztIKvq+CMU/vqoFG0/k7lg6Od9v83ny1UJTXHITXZ6R0su
 9xJ0h1VjLiVacmJY1E4f1L76x0ZQ9ddcHn0qUXqr/GMZXQv1JUsH3EGMsJzZeqmool7TmN6QqTp
 vF8CroiNYacwNMjHtGPQdN0OlDtSFmUxBtK/aO5IyMsoonQVF2slEyqY+4aMWylH8dkh4yit2Ut
 6q+JoU/rnmbDcrLhUOvVyauMPyBvD12X6fTgEfZMN2BFI021H8ygXANd+uJX5kTstxgJDMJUB/t
 FKzWu1XhQvRc3C1nRTJA+Qg2YTYiaVbrkLrKgefc/WfuaJdq5hr6hWU6v5ZT6UOZcvUHlkEk5h/
 WYDivrWfRAh+Mv7hRrCeBV+ggbWtSbjGNn9NL3TUbUcW6/fDNRHX/jW4KQmqXLCYEOVsbLpP7Md
 NwitP6m4YpjOD9l0zuvYCy+P+yNf6MTXRn1NJC6TydQViAIeOR3d009HvMoXssNbaTvnrsjTk7R
 FWsKiMUhILUue4bP67sqxYKX3daxgz+o/Dt15maJP5e/4uFdsgr20nhVZEDhCZl0Jmi00sTV7Zp
 NAPq34Rx0J13
X-Received: by 2002:a05:6512:1191:b0:5a3:fd83:13f7 with SMTP id
 2adb3069b0e04-5a887ad8e1bmr1239225e87.6.1778070149803; 
 Wed, 06 May 2026 05:22:29 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a87791b4bdsm2208575e87.39.2026.05.06.05.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:22:29 -0700 (PDT)
Message-ID: <69fb3285.190a0220.26fc3e.2dab@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260429145314.79256-1-mdoucha@suse.cz>
Date: Wed, 06 May 2026 12:22:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] aio_cancel: Fix incorrect strerror() usage
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
