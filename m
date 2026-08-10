Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA52C5AD5A
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786330724; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Zodk7ny9ghRSwnTAJMIl4f47yBjhSygaWoYmo0rMjVw=;
 b=ccieVPBYFlpprezulXoIoFmEOkwE5SSWdvi9FxjpDcMumT4iIb285pnP6KNJIRy3MF+nH
 jW9e7PTPPgLoYshqBrVzL1yPAJroMjPZ1n717iILLMV84JyL+enjMjK+HiqrviPc2LSfp3S
 0SQ39eTs9oTLJbqwtRAvD/LEjkCTirw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17A813CB468
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 04:58:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AA453CAE4B
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:58:22 +0200 (CEST)
Received: from mail-pg1-x547.google.com (mail-pg1-x547.google.com
 [IPv6:2607:f8b0:4864:20::547])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C1B201000485
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:58:21 +0200 (CEST)
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so2271889a12.2
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 19:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786330700; x=1786935500; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H0zAb1l7g63OYmZ16U5ARsa6nTAuGj83UNgLyZ977tQ=;
 b=O7jr53RXnO4yPrpEEqXPdY+Uj9yYLJs+l899PlCggoOlOmh/KJPg06NGroCXelcV2w
 K89nyKG0PP92ReZnJmoXEU21N9i3TikdqSmNYAymf4r3EvMf1MJFWpjvx0wqWPBQiHU/
 PsubTFqjPAK4oe9IdBp8zYK2bhCIVe0c5SG6CklUK8a/eS+q+9XBZxQ28Pux7o451UM8
 s9JHdgOXMWHlyRoKx4TJcLY/+ZBnRq0L9XDhCoeI4evjyUosmZfYGaWcwD0G5bC7ZuHN
 gbNz6uFUWfrJikmzzwxbcu/riA9R2XISZJyKrYW9G448sKsqWzpW327c5st0eO0JRQGp
 SkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330700; x=1786935500;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H0zAb1l7g63OYmZ16U5ARsa6nTAuGj83UNgLyZ977tQ=;
 b=qB/whhFVPlFL86Qi49VHdEq+EQyH/51Cwd4lkuIGoR1UDc13itGIQcdNM3m0CmcfNP
 hN9P/g9RDfbmpNJPuznMn9ig7PxRk2y4VF9h7r3fNBbgW7yTSYMVVKwsOb3E6b6MjCG4
 +RoyqbiSRdNNo3NgSMv7C/hIpx1018Z2ak1tKdsZrK5r9wIWCXQkIKh/94px4Pq2VzDK
 rQPFoYp+QGPssA7SZAd9GP3aYjAdifPLLdC2NJD6dlUgvofUPiEE1UnvBg2YPI5cn2A/
 9Z2b+eKjC8i5rEBZaKTZGp6jX3Lg3AKelXDDbHZ8+KCjuu3defeBTg8qURnxf8jaYKxu
 xzzA==
X-Gm-Message-State: AOJu0YxbSZJZCJuFm7PWKs/SMnIJehBpSma4sMVmiQH5EVbqRiZhwJsi
 06+g62W5+xHyuq6mjh4FXdp8x3MrB4FdKeGVI3znETman491GG4acfHVen6lOULGlLdO6HbM2MM
 YvriJRcNuPgDyuquEVZ7V+fbbsLctiYzVFweoJ0mKw0m8JASFS+/O2xkkbB3kr+PByOWWjZ8Nj9
 OJRZRqGzq8p5enapWeY687Baqd/Q==
X-Received: from pfux38.prod.google.com ([2002:a05:6a00:be6:b0:847:878f:44f0])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2da5:b0:84e:2f2e:8def
 with SMTP id d2e1a72fcca58-84f2dff6ce2mr39616301b3a.6.1786330699613; Sun, 09
 Aug 2026 19:58:19 -0700 (PDT)
Date: Mon, 10 Aug 2026 02:58:15 +0000
In-Reply-To: <20260807234935.3248935-1-wakel@google.com>
Mime-Version: 1.0
References: <20260807234935.3248935-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810025817.1665141-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] Fix overflow and use backoff polling for loop
 devices
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: wakel@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is v7 of the patch series to use backoff polling to wait for loop device nodes.

Since v6, we have split the changes into two patches and optimized the overflow fix:
1. Fix potential overflow in TST_RETRY_FN_EXP_BACKOFF() and tst_multiply_timeout()
   by using 'unsigned long long' for delay tracking variables.
2. Use backoff polling for loop device nodes (original patch logic).

This addresses the feedback from the LTP AI Reviewer regarding overflow
when LTP_TIMEOUT_MUL is large.

Wake Liu (2):
  lib: Fix overflow in backoff polling and timeout multiplication
  lib: Use backoff polling to wait for loop device nodes

 include/tst_common.h |  4 +++-
 lib/tst_device.c     | 13 +++++++++----
 lib/tst_test.c       | 11 +++++++++--
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.55.0.654.g21b8a5bc05-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
