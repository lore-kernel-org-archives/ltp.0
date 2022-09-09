Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16949ECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:39:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B7673CAA54
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:39:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114C33CA9C9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:39:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 16E901000A72
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:39:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D77121F43;
 Fri,  9 Sep 2022 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662734349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKrZCKCLIUnNxhahdtooWZNoyvSrIsnOofflLvfwLYA=;
 b=0b11+k7XhmtxOPi1rvHeBdGzmtxvhOJciuWsajWKJL7dWwnrF7/UAMUPrrq1oFFe82CUFo
 zshhsrQ11QzngJ3LeG9cppGNmpw8P3txlX0jqr7kPkqnGZGdDqD1YyUlX+uUtHdnZS+U3U
 KmzMX+awT5lcKrj5RZWQYhm6pI2r5zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662734349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKrZCKCLIUnNxhahdtooWZNoyvSrIsnOofflLvfwLYA=;
 b=zggz5GPQS3NxzOBgDMS7e0ztLBJG9lrCarwH3bF0hziMA225L5nh4etW3wDgmBtCQ/pJoF
 hVTubO53/SjtWCDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BBDB13A93;
 Fri,  9 Sep 2022 14:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SJa0DQ1QG2PaXwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 09 Sep 2022 14:39:09 +0000
Message-ID: <5e01e854-7cc6-7b08-d1f8-7f0709fbc07d@suse.cz>
Date: Fri, 9 Sep 2022 16:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
 <Yxsbtrcv+FEMvBfH@pevik> <Yxsgg8f7vOFdXV3q@yuki> <YxskoojodIaNuI6G@pevik>
 <70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz> <YxtMFw25BfJaEsji@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YxtMFw25BfJaEsji@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] tst_supported_fs: Support skip list when
 query single fs
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 09. 09. 22 16:22, Petr Vorel wrote:
> OK, this is not in v5. I don't mind to send v6 on Monday, if we agree this
> is wanted. Implementation detail: should I use for -2 and -1 for these two values?
> (code < 0 would be error, code > 0 would be OK, 0 itself skipped)

One more thing, the skiplist check should be done before availability 
check. It's faster and it'll save you work when you're trying to fix 
tests that shouldn't be skipped.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
