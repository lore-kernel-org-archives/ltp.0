Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1614AC982EA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 09:27:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65CBE3E6BFB
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:27:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABC713E0E13
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:26:55 +0200 (CEST)
Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EACC61A00114
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:26:54 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790155613; v=1; x=1790760413;
 b=Wpy80jTBQ4XsIQyR+16MsyOViOswh1d1YXlvAJ6dSZnbvePpF55hQNpGDsyxfKUyFs9gy8Mn
 Jq92Tzj/oXHqunLjfEpRTZPKPID/p25KMP/YW04uzV+z5R350RR0Obo/kddceywedO+ogT/NqST
 qJlfHJ9PqKXIvZmBw0ZxfWs4=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 0dbf22df334f3524;
 Wed, 23 Sep 2026 09:26:53 +0000
X-Mizu-Trace-ID: 0dbf22df334f3524
X-Migadu-Flow: FLOW_OUT
Date: Wed, 23 Sep 2026 17:26:48 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arObWLZVUno75vzA@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>,
 Avinesh Kumar <avinesh.kumar@suse.com>, Wei Gao <wegao@suse.com>,
 Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>
References: <20260922160911.2271754-1-pvorel@suse.cz>
 <20260922160911.2271754-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922160911.2271754-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] keyctl: Use struct keyctl_dh_params 'private'
 instead of 'priv'
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
