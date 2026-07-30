Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003AAC55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785415958; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=U1Ah9mkZY9uPRWpx5bp5BdiJHdF/QaDx7NJmeRpX1A1Tm44rI7jSPq45+Vkx0wyGaWp6M
 O2Cem1eVGaCEELLfPw4vc2piX67miswKJSyAh5CQTtl5R6DKDrdwJcDhG3ZL36zyo6hEKRS
 sO7cohPu8b5hlS+K3VCfS545nyQQ/ho=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CA9F3E7226
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:52:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 462583E2D30
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:52:17 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 79EF21A0049E
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:52:16 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso18711975e9.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785415936; x=1786020736; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Xel/3KNCO0IoYpZupj2qUksRL/L1nvpmTNkjnMJVUfJ9m7XyLurHGkCu423wRXiDjI
 CRaycnTqWZ+6Aw/1w/h4C+CxpLxSCDzsBRG3bAaG25gsqHeYdSWlYOUVKvSbehJvDAvq
 EmVx14FMcBOrZdtxFpUVL2hk5BrhfnIVMc9przNRDPPkEDwnaN5m9g+j8nXnBxUIFNm4
 0EmBK/alxkH3p/6S9KCdzkxnG+iPNe3MhwPzth/P46XCeEjtvusszgW+bceaA7d/OsBM
 16vmJUo8hHhMFH6XVxJ/JwPYmYap7QirpxIP/14VmLEdWTNiW2E91OWlira/wE8ho/BA
 NhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415936; x=1786020736;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=ppjGHbw3FYgQANUm15vgsDJy7TU54Qyq+9Z/HRNaJqUO0LSOGUu/3abN9JE02cWJIM
 182QZSPdEWml1EdDW8XICs52677//LUMV4QXZw9HBorl+R8dWwXKF2adeLok4CSzHo/s
 1xqFNvffG9wkbDVzUy3fqz6fwYOCXa9qjs4JpJnrJ0+hGsCS6D1jbIu5r+t224e6TJDj
 aYD8xh+s6iaS9b2E/mu6mj1boAd0meeZcG7927XDDzRGvPqUFMHXk2/rffJCgnEcJfRc
 JM29Hh/+5wtV5jhATsq0VSMgdU+k6hP6NIk9RsWvMRDCA76Neq2feM0f/8ohGfjdVf1H
 AfbQ==
X-Gm-Message-State: AOJu0YzJHJjPVpHOoW97TlO0OI5PNdzmNfnsji188w34OtlZ4XpXSH62
 aA1K6RvYBNcfTxHlfB6YZmarlgYPGB3KPTMO4Hxczwn9nJUpgD47cYMTBZU0ATtoJkSuvdqS7RY
 MvpfGckxn4Q==
X-Gm-Gg: AR+sD11EXJZ9a+W24u8Br6p62O7/aRsiscF/E2v2nN0rk285UX2Ui7naUXFJTdcMdF/
 ud0sAa6SWAJnV5v5xlDk3A0VC/NycRzWKmP5os9v7lb7vWIJZfiSs/pcY622KcdlRHRBp7yKIx0
 o11m+fCWS9lwBc7pjumRe3gJb2bw+wlw8acXHteHZM2166H808iSj47HahGaFNZhS2f3SPsJ8K9
 51QpKRRpOS9tm9G8juV4pEE3zPQ53gn3Hwt5VpKfv0W5GNqQXaDtrQf/hmxPefVpcEjZZFMPs6e
 cDjBH0zqJLJ0N/d34ygzzpzB5ALEas7RNi4vZiQ+v1EDDZcGiunJBg3HTwQyOrzOSK8e08QEorM
 TDkgpKR2LsfsoWIYOUGXtQ1NEOwD9fez7Jt2pjW5S/O3BYPUhPifrYP46YoaaMd4y14WLebZHdT
 hAE8JoSitu1KUKHftJvsL1naOGlNAqvt2cLFxQYrm8uhoA0DEOj1pIE0cpVMJTN9dWcs869jbq2
 sEvF59EyUQcPd/IvTAptzkqFJg9V7ellt+JgA==
X-Received: by 2002:a05:600c:a0d:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-49800ecf287mr32937315e9.37.1785415935661; 
 Thu, 30 Jul 2026 05:52:15 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cc54sm6015079f8f.21.2026.07.30.05.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:52:15 -0700 (PDT)
Message-ID: <6a6b48ff.e862d496.11a6db.7a16@mx.google.com>
To: "Stephen Bertram via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260713170129.1177772-1-sbertram@redhat.com>
Date: Thu, 30 Jul 2026 12:52:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] pipe13: Scale child reap window with
 LTP_TIMEOUT_MUL
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
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
