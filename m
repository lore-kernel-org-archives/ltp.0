Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCE606A31C
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=soVk6eIO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE1C3E4A99
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 04:26:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B4873C2037
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 04:26:09 +0100 (CET)
Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 94A106005C1
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 04:26:08 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=GPbl6QRbivx6LirAHQO8LN/aGKGlAKVWZObuiQBu+wM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794194766; v=1; x=1794799566;
 b=soVk6eIOdOVTEaqZWcZ3E3h5/gEVrGLgWcil6D3CIVlLmS1w1gqDcYlprCrqrop/UnRaI30h
 w7wOjw63dsCTDVH8ikOhoCs7toHOSOVtyFQqcuZ4h2CtfDQ19fJ3nBUam1Lkrx1rKvcuJ6mXLqG
 BoyJu4V/PJ1I4cp4YAQGS0mo=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 3fb30c44e3641559;
 Mon, 09 Nov 2026 03:26:05 +0000
X-Mizu-Trace-ID: 3fb30c44e3641559
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 11:25:58 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <avE9RuU4bEklMGkX@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 wakel@google.com
References: <20261103075722.181317-1-li.wang@linux.dev>
 <20261103075722.181317-2-li.wang@linux.dev>
 <au3LKGR79fSjxMzq@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <au3LKGR79fSjxMzq@yuki.lan>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] lib: add module is loaded check
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > +		if (i == mod_len) {
> 
> Shouldn't we check that next character is a whitespace here?
> 
> I guess that module name that is prefix of unrelated module is going to
> be rare but it's not impossible.

The length check above already guarantees this: p is advanced to the
first whitespace, so (p - line) is the length of the whole module name
field. If mod_name were a prefix of an unrelated module, the lengths
would differ and we continue before the character comparison. By the
time i == mod_len, line[mod_len] is exactly the field boundary.

    if ((size_t)(p - line) != mod_len)
        continue;


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
