Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABD5C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787915823; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=QZLZnHD/1fvBb7pCzgdbiZw3PcD/sLk2Gp7H61mmXtX0rt2MdwG34RCQ7jbAqAOMjzefF
 6gu8Qv1+mFRcBmMDyDdEmgjavyhm2eq+WLzZLWBTCxJT7gxoCw34iyHqCR6EvuuqlZqtidt
 MFh5L56AeZ+cVnFyxoAYAXxKL1jwHSA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FE983D75B9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:17:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DD503E5DC1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:22 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E2C06001E0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:22 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-482e067e908so503495f8f.2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787915782; x=1788520582; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=gf3MgHC5JPNxVyRYoouM5moMxxuORuH43T350qfxiM9JiuqJX+oTSzjpqlkJNjubtC
 Qx70kwDc1Sw53NqOxikdOdvAEWdBw/HjJ2rgW4vn0zB4ruHXDWeNFMDRmRo59yKQ9WAX
 PgE/JhtVPbx86h6C0mV3jyeRSi6kekHWQaudjWCq4S0rJFLj2iKRpS122L2XDZ6ve7B+
 TnCnT/mCgmin8S+Vu0D5zQV5dOan/EpHrdR6P5cCCHpwmld498n0mLVNWRu/Ajcs8sE5
 dgrBxPzA2i1pX59d6AOHl/w2OmgRWLZgJfKXGD3agG+OMcjPK6jw3xZMRiK+emZhPlpn
 /ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915782; x=1788520582;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MIbbCPIkmCboe4PjFzf4suLhki8Zf+a1PbDB+41kdTgKsF3TkuvQEQE7nYG8vH9f8B
 roAMVL7ONxRvD+aE9/hTakzbuI5kTxMYXOgfY7xO70c6QTYtO0+f4LrBtNqmQDML4uj/
 jsbOVKJO2+Kimx/2AUNK4t02EVbALSlOhE1YJFocpcJ2b7upqXGDkSoqIhRpBlmL8Ik8
 71pe6pCCsLrIdUY8tNhDbj9D1YcAcZHwIm3RpkrUlq228LDr2tX8bf1WBHfV5g/+BtQb
 7h5wKIAQs+h9L1ww4b1oDvOZmygTlWphMjAB06U3Kq+G0DBbkNjqKgaHf1awohzfv/si
 sTfg==
X-Gm-Message-State: AFuF++kd5U7J196MYfs/e32GQzUiAINYbIdMofPT8gvtrNIKXXpsJNz3
 tXfL6nXxMnYBX3IPz/HPlVuFjB0ojXdD+jrZ2I1s3NTj6w4Rmmk6dNiEASrTFDzNoFlwj9VKeWz
 ueyXOi/HQ/g==
X-Gm-Gg: AR+sD11y/K+lENJTAsICc8IBWwrUFxa90n0wkCWrVMHwH8f8cvgVG8g9SmHqfvVNaQY
 9ZxpSCAMDv5R6CONpmcJYqGkGwVav6NsjzodOVrWLJ1xw7zc5PbXtYVH9pWDbxsVWug2L2e0PHl
 RYayTphkxeej/6V49aNEJDEf0Z3z22zpO1CZxxY4FsbpNxNaqWHgQ1w0g5je5pKMYrHaKaiQo/m
 VKIRZNE5lAVgf89AfAU5x77hEWp1BkkhulPF4T9yMfy3pUMYUhbqFZCmQ1F+XiARJ56ZUG92WUJ
 9Vzm0b7W0z3Ubk+cVMTkg4zJkRSpYm455+F42oQMPBzLRESuOMmH+mzg1wu4Z5x0WAlQ4GaNCVR
 BD+fYBfCcCGTj15YbwKueNkYkxUnS17PuvK9sqBWUiCuUMoEqkGOY0qAMy9YQbQ9sQHBagfn8kS
 6Bxi0nirlNl09hh2DlBZm0mr7mt19nRuSAEf3LxWHAtkn/FmZYPGmz3+Dts4QK20xW6w9bSiys/
 LR9GL+6Oh9zIdLQacmypD7SmHJQXjPQPyyM
X-Received: by 2002:a5d:4702:0:b0:481:bb82:3f31 with SMTP id
 ffacd0b85a97d-482f79db522mr6988829f8f.10.1787915781864; 
 Fri, 28 Aug 2026 04:16:21 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20713sm3304922f8f.21.2026.08.28.04.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:16:21 -0700 (PDT)
Message-ID: <6a916e05.e862d496.1b0153.278a@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260828100105.195974-1-avinesh.kumar@suse.com>
Date: Fri, 28 Aug 2026 11:16:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setsockopt08: make check fixes
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
