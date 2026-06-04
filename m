Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63469CD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 09:52:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDB383E54DB
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:52:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2235A3E1CF6
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:52:11 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A5BDB1A00807
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:52:06 +0200 (CEST)
Date: Thu, 4 Jun 2026 17:52:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780566726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oddT4ZnCsHkwgN9JNI91d3Z30EOVoUsiAFDXB3t9EgU=;
 b=N6g5/pFwerlkRR2fL1jnrEzfU22BE9uH48TIXhGHlq/teJzG5slsFiYTz2uaPv+izidZDC
 kIcfTDT6Wx1dwJDlNPYCJ/pKDXVUD+/jXl084DX9niGYC5dycMIeOK8GF0hEx3Usuey/jy
 juT4KjAhjaQSno7t58dSd/DxPtCaxe4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Message-ID: <aiFKwQ163zjrPA2t@linux.dev>
Mail-Followup-To: ltp@lists.linux.it
References: <20260604094200.21643-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260604094200.21643-1-li.wang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] lib: Introduce tst_path_defs.h to
 consolidate system paths
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

Li Wang wrote:

> We have a lot of hardcoded strings and duplicated macros for /proc
> and /sys paths scattered throughout the testcases.
> 
> This patch introduces a new common header, tst_path_defs.h, to centralize
> and standardize these path definitions. By unifying these macros, we
> reduce code duplication, improve maintainability, and ensure consistent
> path usage across the entire LTP codebase.
> 
> Signed-off-by: Li Wang <li.wang@linux.dev>
> Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Forgot to paste the notes:

  v5:
      * add PATH_{KERN|USER} strings
      * change MM_KSM_FP()/NET_IPV4_FP() to explicit paths
      * rebase to the main branch

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
