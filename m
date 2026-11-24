Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18153606A321
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pO5lSKXu
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6250C3E9F41
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 03:27:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7307D3C8540
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 03:26:50 +0100 (CET)
Received: from mta0.migadu.com (out-52.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 014251A0034A
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 03:26:46 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=+zyjHonZOZSYgggzeCph9Y0Y8DeCs9FVdWk2UCbfhHY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795487205; v=1; x=1796092005;
 b=pO5lSKXugEumtPJx1NDtLr3RaLZCo8QjEAQ9HKRmMUn2xQLV/HGSTmm+wZsitEa6ItXn3mOl
 L6kx/7qZosL5h4qT/2frwAKRKCqPvmw43UtLDa/uPEn7SZqhwyS/x91KAvEFBMAnrFNUp9h7ete
 1n2jlTElO/tfVQ0/2NmTbnyg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 10dda487cc217b1a;
 Tue, 24 Nov 2026 02:26:45 +0000
X-Mizu-Trace-ID: 10dda487cc217b1a
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 10:26:37 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <awT1lOLz7gwaSGQc@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
 <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
 <augF5SbHd8Kk2KOG@linux.dev> <awRekXqoFx8kCouk@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <awRekXqoFx8kCouk@yuki.lan>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] build: Build shared libs once on subtree
 make
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Li do you want to take over the patchset and send v4 or should I do so?

Sure, I can take it over for Andrea.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
