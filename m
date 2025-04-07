Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11722C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 10:25:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5591E3CAEB0
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:25:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 793EB3C264A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:24:55 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.218.24;
 helo=buffalo.tulip.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from buffalo.tulip.relay.mailchannels.net
 (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 221311000972
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:24:53 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9A5EF249B9
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 10:24:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com
 (trex-6.trex.outbound.svc.cluster.local [100.102.53.226])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 3FDDF24C41
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 10:24:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744021491; a=rsa-sha256;
 cv=none;
 b=i78jDOd3XQyyLWAYY87n9JsggV8D0mgZEcL2utrNN96uFTvSYBIgDh+JjvlIOfycgJtSdV
 vKXzQVhZnStZQKW9IKbsSKO1OOib9KN/Tg/941ztvtQ88fCGtIWDIlbwV17xdzrnZGNwc5
 qEz5nuGSNT8aGCuJQHBlPRg9qiKURq0vVP9atn1h1ZrCgctC4E4tMlJkmGRO5266Tow/KY
 6ZRy2QzllCG2fl+2KtxDDsSkkgM26+Y2GtFEODsZCYejcFiHlbMkTe+5+Ofbi3yRwut6rq
 6OcFnftQpI6/BfkI0B8s6PuurMUISVVEUvhj++3edi7R7MJP7kOUU7rYhvvQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1744021491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=3LJBOGjB0BuNIutIXc2kSx9Z9sbGW+09VAefKgh81s0=;
 b=Tr2e/FY5ABRxPK3S1Xw3yvARQxyxN1eF0yXQc7tdfnevjmfjf3PvIYu+tW81NkuTvAZmRQ
 0Z4NbQ8rP1+44yFTVzh4pKEpgP1/5bb787s8JljU/M97qiaJ7kp6cFO1ZJ7HpY/VEeEuA5
 x9XAyroJpKaT3DkpTmSG2UswkmbyEUhCRtQw9tO71czpRqX/TVAymr0Hkr2zv6xqfaEfB/
 Dwr4YBMIFhNcNiY1v7jft+W0QocICo13Bqzs/oK+xXbzoItlxvqGHJ1OUMB8ULZwcdfOWV
 OzdqRjLabo/hhdFgA2YMWgQY1fuhZ2ruwRNRHbMWQ1YGnvwWqnpT2JK/gFYBsg==
ARC-Authentication-Results: i=1; rspamd-7dd6dcd7db-jqbtg;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Chief-Troubled: 40603d7b08f1c918_1744021491468_691001016
X-MC-Loop-Signature: 1744021491468:4133831783
X-MC-Ingress-Time: 1744021491467
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.53.226 (trex/7.0.3); Mon, 07 Apr 2025 10:24:51 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4ZWQLp5XY2zQr
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1744021491;
 bh=3LJBOGjB0BuNIutIXc2kSx9Z9sbGW+09VAefKgh81s0=;
 h=From:To:Subject:Date:Content-Transfer-Encoding;
 b=dxaIaGcZ4LdgseC+DmXOmGzogwQd83vGyFiiffRjVvGvUE+FTrM22auSehiW0yUEr
 kXFFI5kEnjrhE2MNivvmGsI9A3tYkyBmOXUMksEcm5tScf+ZGMNeD44yP8wGsMZ/ZQ
 ZUYvAWlmVyqKFnQ6n/o+pkOdSDRWd02nFLsl8OdxgBX3qf2XyNWKFy6MI8CxiR3pqZ
 qOlEToCdQGMoh0PMrY+3JPEOO5klglE8AQP14nY5QUh6/sPe94EMdLDBCqel2nJ+wL
 YZ37ZcQzJsNHKy1dhuycSPaG75H3QB1YjDHUKuR3t6w37ZwBKT6hl26XLxcq6GyzDZ
 SbeMmMQSCSrZA==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 06:24:46 -0400
Message-ID: <20250407102448.2605506-1-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402170718.1710388-1-siddhesh@gotplt.org>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] cve-2015-3290: Disable AVX
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

Here's v3 of the patch with test results here:

https://github.com/siddhesh/ltp/actions/runs/14306572501

Thanks,
Sid

Siddhesh Poyarekar (2):
  cve-2015-3290: Disable AVX for x86_64
  Add centos10 to test matrix

 .github/workflows/ci-docker-build.yml | 5 +++++
 testcases/cve/Makefile                | 6 ++++++
 2 files changed, 11 insertions(+)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
