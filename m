Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67DDC982EA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 09:02:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C2483E6B9B
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:02:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C18C33E6B83
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:02:37 +0200 (CEST)
Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8141010001BB
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 11:02:33 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=+8zrxdNT33IITA45s3/3Myb/mHm+ALI/5AQD0eVKMR0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154152; v=1; x=1790758952;
 b=ZqZB95+3cg2Z3L6yfPbvIBYlL10WhYEU3mvKWHPVc16JhS/473yRNNCmTwJ1jzFcRmLzk2qo
 Gc6ByokwnZuD9Jr3gIb2gI1RvAMkv4YE25lo6wNuXYHJxzCGkcxM/XzGSKrfeqVN9hqHwvMBH04
 WO2a0a+WkvVhx0cPCS71uez8=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id f37994110f82a83b;
 Wed, 23 Sep 2026 09:02:32 +0000
X-Mizu-Trace-ID: f37994110f82a83b
X-Migadu-Flow: FLOW_OUT
Date: Wed, 23 Sep 2026 17:02:28 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arOVpNvSwS6E_oQl@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20260923054114.105891-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260923054114.105891-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Stop using libkeyutils
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

Hi Petr,

> Using directly <linux/keyctl.h> is enough. Move the rest of struct
> checks in to configure.ac (together with other struct checks).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> This is probably too much as a pre-release fix, it should probably wait
> after the release.
> 
> Changes v1->v2:
> * Remove printing "keyutils: ${have_keyutils:-yes}" in configure.ac (agent)
> * Remove <keyutils.h> in configure.ac (agent)
> * Remove Follow-up: of first commit (I'll add it before merge when we
>   have correct hash) (agent)
> * Reword commit subject

This patch looks good, but it doesn't apply cleanly with git-am on the
latest branch. I think you need to rebase it.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
