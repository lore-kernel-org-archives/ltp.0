Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF5C79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:18:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C183E2CB4
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:18:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CF633E2B25
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:18:37 +0200 (CEST)
Received: from mta1.migadu.com (out-233.mta1.migadu.com
 [IPv6:2001:41d0:203:375::e9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3F7746002CE
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:18:32 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788848311; v=1; x=1789453111;
 b=Xwd2BEr3wr9PoKa1unXzS3Lg3ZzUWH/iT4JNSLoByHLJVyvYUWQIFWH8OQjgsrsLI4by6omx
 rpXB8cnkoLhR+dmeyijqGG5BXhJ6Ue7Gq5sKsIj9DJxnHoTllI1slvHhXuX8qSvgebuPy+avpui
 HMsVvKvakdmKYohppAZmadpQ=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 69149723492fd8f2;
 Tue, 08 Sep 2026 06:18:31 +0000
X-Mizu-Trace-ID: 69149723492fd8f2
X-Migadu-Flow: FLOW_OUT
Date: Tue, 8 Sep 2026 14:18:21 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ap-oraSyaWStBiWR@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260904-coredump-v7-0-a32b7ca1acea@suse.com>
 <20260904-coredump-v7-1-a32b7ca1acea@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-coredump-v7-1-a32b7ca1acea@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] coredump01: New core_pattern specifiers
 test
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
