Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71650FF885A
	for <ltp@archiver.kernel.org>; Sat, 25 Apr 2026 06:12:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D5583E26B6
	for <ltp@archiver.kernel.org>; Sat, 25 Apr 2026 08:12:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E02333E2561
 for <ltp@lists.linux.it>; Sat, 25 Apr 2026 08:11:44 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3C1E1A00816
 for <ltp@lists.linux.it>; Sat, 25 Apr 2026 08:11:42 +0200 (CEST)
Date: Sat, 25 Apr 2026 14:11:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777097502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYEBxujDknH+G3XBFNxwehVnHk+U/DQCBkMs9a+Ysd8=;
 b=c6yCDLi6fROieYue/VfMWdK5cR+0O5IqBBKvBhmR94ILOZDoF8IEH09K9zKUYDWAehSE1L
 aqJIG/xNu7Ie1Plx5s8pkNnazqcchvkVaFEOpeL9TQ47gpAXe9CRDvn7meRY0tEl3t6Y8X
 Odu7Wk4VWZR2XPk3U9LJPAtb8NecfqY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aexbF4V_aFDGyg1A@linux.dev>
Mail-Followup-To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20260424132606.61550-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424132606.61550-1-mdoucha@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty03: Calculate test case count from test case
 array length
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
