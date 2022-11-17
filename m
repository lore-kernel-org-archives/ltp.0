Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374FDC41535
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 15:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4947E3CCFBD
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 16:59:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9922B3C62D3
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 16:59:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34B9862C0F9
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 16:59:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BC5722702;
 Thu, 17 Nov 2022 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668700739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRRPR7PpLILrEVMv6MzTUdqC902dthmy5TZ1L8d9mmA=;
 b=A7RwNKjG8AgCNSMk3TK39RfrDSd1Rg8ZvShjtCVOD7bikt4IlOq0vITAc/0XK0qhs4jB5s
 mIzxkpJioPxCYP6+eMIYcrYlyxFTfIvlsoKMGnX8Jj2oQrIboNKEMtY2yWou06yhH0EdDa
 b2LAFj8PwQrMk4aMJXNahz4VhvUekpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668700739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRRPR7PpLILrEVMv6MzTUdqC902dthmy5TZ1L8d9mmA=;
 b=YJzlFsn79QWcDuHwmKCT5fuvZsT8LgwO5GM851YQmie/3K9NhfYIfVoa4GQlOF2bfOSriz
 FHtq3h07pQz2kMBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF64913A12;
 Thu, 17 Nov 2022 15:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fgVlKUJadmPRMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Nov 2022 15:58:58 +0000
Date: Thu, 17 Nov 2022 16:58:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <Y3ZaOqpTvvBgUTTi@pevik>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221115124741.14400-2-jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLCBhbGwsCgo+ICsjZGVmaW5lIGZvcmVhY2hfcGF0aCh0YywgYnVmLCBwbmFtZSkgXAo+
ICsJZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygoYnVmKSwgKHRjKS0+cG5h
bWUjI19mbXQsCVwKVW5mb3J0dW5hdGVseSB3ZSBzdGlsbCBzdXBwb3J0IEM5OSBkdWUgb2xkIGNv
bXBpbGVyIG9uIENlbnRPUyA3LAp0aGVyZWZvcmUgaW50IHBpdGVyIG5lZWRzIHRvIGJlIGRlZmlu
ZWQgb3V0c2lkZSBvZiBmb3IgbG9vcC4KCmZhbm90aWZ5MTAuYzo0NzA6MjogZXJyb3I6IOKAmGZv
cuKAmSBsb29wIGluaXRpYWwgZGVjbGFyYXRpb25zIGFyZSBvbmx5IGFsbG93ZWQgaW4gQzk5IG1v
ZGUKICBmb3IgKGludCBwaXRlciA9IDA7IGZvcm1hdF9wYXRoX2NoZWNrKChidWYpLCAodGMpLT5w
bmFtZSMjX2ZtdCwgXAogIF4KCmZhbm90aWZ5MTAuYzo0NzA6MTE6IGVycm9yOiByZWRlZmluaXRp
b24gb2Yg4oCYcGl0ZXLigJkKICBmb3IgKGludCBwaXRlciA9IDA7IGZvcm1hdF9wYXRoX2NoZWNr
KChidWYpLCAodGMpLT5wbmFtZSMjX2ZtdCwgXAogICAgICAgICAgIF4KS2luZCByZWdhcmRzLApQ
ZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
