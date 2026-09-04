Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D408C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:34:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A96E03E9767
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:34:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B98E3E2DB1
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:34:14 +0200 (CEST)
Received: from mta1.migadu.com (out-136.mta1.migadu.com [95.215.58.136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32A5B200CFF
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:34:13 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=BD8sL8wN/myi2IZxHzFCDovTFvmXp2lQ263fqlJJk2w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788514453; v=1; x=1789119253;
 b=naLW21+QosddZy5PdfkNzTYv+M1LhIZyNsjEzmPgOp4e2DASTsSOfDXYr1oem3eSHoxkNENH
 UI2PZtwMYfq456X6otgbBtO0GMh2C9vZ9sLxrbBuatU5YVfzR+6I9R7wIYsGA58Z8K7MrUy53PP
 NFY+PM5BdTJnfj3sTe2rfSRE=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id b223b2d2837cfaa1;
 Fri, 04 Sep 2026 09:34:13 +0000
X-Mizu-Trace-ID: b223b2d2837cfaa1
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 17:34:09 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <apqQkdx0XS_gKlNj@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>,
 Avinesh Kumar <avinesh.kumar@suse.com>,
 automated-testing@lists.yoctoproject.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Tim Bird <tim.bird@sony.com>,
 Ben Copeland <ben.copeland@linaro.org>
References: <20260904085555.1202288-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904085555.1202288-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] testscripts: Remove outdated scripts
 (ltp-pan)
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Petr Vorel (4):
>   Remove testscripts/network.sh
>   Remove testscripts/tpm_tools.sh
>   Remove testscripts/ltp-aiodio.sh
>   controllers: Remove obsolete references to ltp-pan

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
