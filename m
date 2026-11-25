Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AE606A323
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GyHCZRM7
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9FA33E92E3
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 10:08:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2DB3CD421
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 10:08:25 +0100 (CET)
Received: from mta0.migadu.com (out-45.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5761010009E9
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 10:08:23 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=eS5/6yJADqvQZ7iYmVnqk9MHsLuZ/65yN6RydCyYN9w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795597702; v=1; x=1796202502;
 b=GyHCZRM7DYAsIkzpsCmzuXs1ARXH4uDsjSCmo8avwlyPg/schrfmxVeWgN2iN3rQK+NDkgQ2
 bVO5HCGA0aDNqp6sTlHLkd7o94dz/Q8dMwOX0n7wd9FOA4n+94Tye8XWGLj6xJf1xbGjl4pCLxo
 1OJ8xz8kRIXv/oXZ0SmwuyqA=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id c82dfb4351cd3f05;
 Wed, 25 Nov 2026 09:08:22 +0000
X-Mizu-Trace-ID: c82dfb4351cd3f05
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 17:08:15 +0800
From: Li Wang <li.wang@linux.dev>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <awalf18W4N2l6srH@linux.dev>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>,
 ltp@lists.linux.it, chrubis@suse.cz, andrea.cervesato@linux.dev
References: <20261125084746.122593-1-avinesh.kumar@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261125084746.122593-1-avinesh.kumar@suse.com>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] build: Build libltp before 'make modules'
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
