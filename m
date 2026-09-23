Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4FCC982FA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 09:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86C533E6C04
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:16:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38C3D3C6846
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:16:02 +0200 (CEST)
Received: from mta0.migadu.com (out-35.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::23])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B91701A01065
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:15:59 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154953; v=1; x=1790759753;
 b=kmd6tVohlF61XdGLNDBLqCaDXBDnCCf2hxK5xSZMP9w2QtlpUrfISf74RZD7cZbEClXZUbof
 HY6AAfqLQ0c8R8t6cTvKUGRj4UW41FUiKgaYBTt9FXoYkfXLdCsaZLZ7FX1R9XiMsQSheAESelp
 oya52DE9jRRhZvI7TiI/bJ+4=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 5d5d28c8aab05f6b;
 Wed, 23 Sep 2026 09:15:53 +0000
X-Mizu-Trace-ID: 5d5d28c8aab05f6b
X-Migadu-Flow: FLOW_OUT
Date: Wed, 23 Sep 2026 17:15:48 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arOYxB23ZmSbSb3Z@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>,
 Avinesh Kumar <avinesh.kumar@suse.com>, Wei Gao <wegao@suse.com>,
 Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>
References: <20260922160911.2271754-1-pvorel@suse.cz>
 <20260922160911.2271754-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922160911.2271754-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] lapi/keyctl.h: Remove <keyutils.h>
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

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
