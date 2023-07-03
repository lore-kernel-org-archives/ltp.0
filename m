Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4770FC001DD
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 19:56:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8A4A3CC151
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 21:55:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C4B43C8949
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 21:55:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C01041A006BC
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 21:55:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D10DF1FE9D;
 Mon,  3 Jul 2023 19:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688414146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ndItis4gnHkdT2fMUxvlQFiU5jxsVaXaueSCDn7yzQ=;
 b=APJHcWBq/pXlnV71DaSYzNKA5eCzeGzi2XkHcxxGLp7LcEMHW1R2gARawvfrC4tQchuhWL
 KByXvh9Na5c/f0F3oVJh38ZVGTECJKV4NmoKmUC+BF8aectS59QliJ88hhOr6mmYW3cGuX
 uMfUOBu/Hfma/yJSjJ4z3pCMPVzsIN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688414146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ndItis4gnHkdT2fMUxvlQFiU5jxsVaXaueSCDn7yzQ=;
 b=7q+oNEpAmt44SV4VxVbRJ0Hfgo4qBBGspB2Z0J9zvpPNHefPWhufa7/+N/amY///6XFhjS
 tgi0Gd8kYBggXSCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2C631358E;
 Mon,  3 Jul 2023 19:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y8blJcIno2QXXgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 19:55:46 +0000
Date: Mon, 3 Jul 2023 21:55:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230703195545.GA446620@pevik>
References: <20230703194904.445661-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230703194904.445661-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Fabian Vogt <fvogt@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I forget to add link to the original bug report
https://bugzilla.suse.com/show_bug.cgi?id=1210903
(I'll add it to the commit message)

and the original reproducer (I'll add it to the sources).

Kind regards,
Petr

+++ testcases/kernel/syscalls/mremap/mremap06.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 SUSE LLC
  * Author: Vlastimil Babka <vbabka@suse.cz>
+ * https://bugzilla.suse.com/attachment.cgi?id=867254
  * LTP port: Petr Vorel <pvorel@suse.cz>
  */
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
