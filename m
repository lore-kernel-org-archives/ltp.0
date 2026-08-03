Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78A3C55174
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 01:20:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC29C3E531C
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 03:20:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 658273C5DF6
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 03:20:33 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0694560013A
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 03:20:31 +0200 (CEST)
Date: Mon, 3 Aug 2026 09:20:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785720031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ax5TRV2PRnlI8NTuqT2YDAgWpOuaKEl6XDd1xl8a/N8=;
 b=amrFSca84YCTWTEDLQf/vaIkxrtynEv8UxxF5GxWnz1nRQl0uMfTCVonbWcJ7z9anG9sGR
 VHo5jNQEw7xgZFD2wUTuO9f6Ot8XEFoBctPa0PFrS86w7O4NDFGyGTqq5w0aKmmr9lQdjy
 QVVHBhI5xRI2FT1JSRRpaf8cQ4YNoyc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it, liwang@hygon.cn
Message-ID: <am_s1XgvsmKXVFib@linux.dev>
Mail-Followup-To: ltp@lists.linux.it, liwang@hygon.cn
References: <20260730100127.193103-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730100127.193103-1-li.wang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] madvise09: restore cgroup v1 memory limits
 with numeric values
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch set merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
