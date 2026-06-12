Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E892CD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD1D3E1CF6
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:09:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86EC33E1CF6
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:09:16 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 196E91000A2A
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:09:15 +0200 (CEST)
Date: Fri, 12 Jun 2026 20:09:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781266154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYEBxujDknH+G3XBFNxwehVnHk+U/DQCBkMs9a+Ysd8=;
 b=E6Yt44k+OM5ATXzR/bgBL99On+2hlqXOwcQwrFinF3hFVPDFMYRCld5BSgsd5hdVLMFXXV
 K7lvqiXmHz0jiWnxjP38R3yyeX4hScflnUQ003Xz61SBoqFAUXICXRNWzFah/v9dXv05nz
 aUBij30U6bqH4S1wqdVZsPstQvUhK0w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wei Gao <wegao@suse.com>
Message-ID: <aiv24EYGADj5ZoR1@linux.dev>
Mail-Followup-To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Petr Vorel <pvorel@suse.cz>
References: <20260611030858.4109-1-wegao@suse.com>
 <20260612051605.5385-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260612051605.5385-1-wegao@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] mmapstress06: Convert to new API
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
