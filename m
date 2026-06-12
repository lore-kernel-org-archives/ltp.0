Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A837CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781252941; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=EEp03OscAM+oKstebDzqmggRic4GY/mdQG4z47ATeBV/Rqqvy6WjUe4Cs4TigWoF5hEUR
 9nisxWrUQheJ+uUjYk1NQY4Dhyyh+/AitB0B7Ca7EhT+KZ73418jqClW00WKngF5w2/AP9E
 ApHIqWy/Qe1DYU6Hn5N7O8Bd1SbQ0M0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86D813E4E5B
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:29:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E649E3C2180
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:28:41 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54292200A08
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:28:41 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so505700f8f.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781252921; x=1781857721; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=EYw747rErECvFzxV9Bm4zY1MHkrOmsMMaBV2Eccq6mPOeRrGtoJ6rKIcC8Ac3JXECc
 1BFfzP4yFHiym6Yt+k7PM3S2Yo9AplZBSadXySJbheYn0xWd2kDsTGMn9dCklRuxvvFR
 GfOLFrcwwc3TqFXTBWx3Qm3zmTsP0290y6nmV3qBkpL5AbVXuLR2v1NB1gd9Eo7xO8Nw
 2BZFk2PSVhHR+cxR+O9sj5rWZ00iLGdSjqgnR3nwizgBPbAaFWzyo4mQlkgQgLr4VV9j
 cHGiXLcOp9X78zqNu1MHY3FgYf9TTGWRVxooBWJ9RywIVQT1DdS6ur0LpXG/XPw3QOYF
 Icag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781252921; x=1781857721;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=myP9QXwavSr+GQONezJkSr+9CRqkpTF11g7ZUAvxMEERaDwNopm9QtVICcLNXboR0K
 k8MmfnST0iDBzYMTHtePqaSc9RnEZR5SB/ZiDj3ebINNszpQzvfBn6CfNGNdeHSRyNVT
 mF3RstHul5u2ZSJYqLNWP9IeP9yu4W0Snya94s/F+496xdUdvSZpZXlhS81SiLPeUa3R
 YLMEdQURdRwNF82nRczS8GdCK8a1WopphDPy8FvfbUe1goLBLG+WjysB1XF4gPuQv4u5
 WDkkXRnBG9PkaLMBDq4SevAtk6+BPGQJEn7qQ8aL+Q8Y3t14EJjnRdI9kCmQqRtLLIfB
 Bikg==
X-Gm-Message-State: AOJu0YwbjOg3vua3T39jMu8a3dElg63dDMbtj1OEO6kLv4yLCivruCqr
 FwaNxek7Kpawsq70dn0VhVGtePvCO7hGoOO+nsMWCOpkXAEUpdN29qXAveBxqcH5RH5fKREd5X/
 nQVjZoVjnww==
X-Gm-Gg: Acq92OGtcmtpR9T46j7ZOxlbjYPKz6qKUxgRxcWPe2dUHf+/1kxhtx1iWYDcCpnaKry
 vt1SLYnZJCM93dLclk2m6nG7X10lGn+oFDVFJp/w+5WKTTzTwYjCBaqp3pcBjp5umkYWBwYrD3X
 t1nZin4IjXRKZssThsTs3W9eG6U+P2VRqDYK2DkgkQ+ZFIn0EVY8XLbHq+IDg52fJk9Jae3bFwN
 5l0Al45yjm5zarBYKj0FjsNV6UT+S7ASTDS0ZsU7hDUgMxLm+S1tRVh7irsgl+ORhIwnFPV70To
 x+Epr2hqFRDfP5I+Guadj1Wo3tboOYUEtYBnR9LCNTIUHFewts6NOVE+tdTIwIofHwQtwipxPe9
 CaDJBLI0XAfkU3GbHJ2JoK3EsLY1mSW3VXkQcQXOJA8MJcD06jla+dzb3C6url7S7RWo2/LKX1i
 SPJfM14XZgeeTZ4mgrA3D/SR/T1/t2ygJY7G6QMLBBJ8U/WhaOE4uSKtGok1qj/PVY9JeeR6CLN
 dS8wWy80lGOS4LHT6Roto1BnlWd3/pFuyY=
X-Received: by 2002:a05:6000:4013:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-4606da5e6eemr2473261f8f.8.1781252920573; 
 Fri, 12 Jun 2026 01:28:40 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm3722363f8f.19.2026.06.12.01.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:28:40 -0700 (PDT)
Message-ID: <6a2bc338.a1a40faf.2e0385.6f58@mx.google.com>
To: Samir <samir@linux.ibm.com>
In-Reply-To: <20260602100512.404810-1-samir@linux.ibm.com>
Date: Fri, 12 Jun 2026 08:28:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cfs-scheduler: Fixed "make check" warning in
 cfs_bandwidth01.c
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
Cc: Samir <samir@linux.ibm.com>, ltp@lists.linux.it
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
