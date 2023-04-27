Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC7C77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:20:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FBB23CE4CB
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:20:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800AB3CBA98
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:20:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0F4CF60083C
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:20:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ECC11FE0E;
 Thu, 27 Apr 2023 12:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682598019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIPK1LEmqlsoXh/azdYhtwQYSX+F7xePM1F7pPWg0R4=;
 b=knigDepy+fsaiYvHrnilH0zGBE5+Wl9ib/by7omfRgTX5WRUtM9p6ULs9vxiTsfTgdZunN
 79KKby1F8l3g6cAO7308vty7+rbT+ymoLHKi8er+/LgeNonfRXv4xyOJGKLHYQlXCsHmv3
 z1SeOUyiF9mR0RVtYfAX9wvV4xjda+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682598019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIPK1LEmqlsoXh/azdYhtwQYSX+F7xePM1F7pPWg0R4=;
 b=q4+H9UhWcFSEqzrDaRM47dp5wChlx9WE6zPsD3x0/zUyn0Lu4JEKgYxDY+nrXYxkathUYU
 N/1vH/so6O4gW9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DAAA13910;
 Thu, 27 Apr 2023 12:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Syl0HYNoSmQFUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 27 Apr 2023 12:20:19 +0000
Date: Thu, 27 Apr 2023 14:18:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Shivani Samala <samalashivani123@gmail.com>
Message-ID: <ZEpoGL9ypGzbdGfU@rei>
References: <20230421012642.16625-1-wegao@suse.com>
 <20230422135337.12087-1-wegao@suse.com>
 <20230422135337.12087-2-wegao@suse.com> <ZEki8+W/YpkWd9vc@yuki>
 <CANHBesXJz5hm8Tbi+Gk6Yi4NjTp7ezhtAeQa++XHEBPn2O29dA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANHBesXJz5hm8Tbi+Gk6Yi4NjTp7ezhtAeQa++XHEBPn2O29dA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] kill01: New case cgroup kill
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gUGxlYXNlIHJlbW92ZSBtZSBmcm9tIHlvdXIgbWFpbGluZyBsaXN0LiBJ4oCZbSBub3Qg
ZnJvbSB5b3VyIHRlYW0uIFdoeSBhcmUKPiB5b3Ugc2VuZGluZyBhbGwgdGhpcyB0byBtZS4gSnVz
dCByZW1vdmUgbWUgZnJvbSB5b3VyIGxpc3QuCgpJJ20gYSBiaXQgY29uZnVzZWQgaGVyZSwgeW91
IGFwcGFyZW5sdHkgc3Vic2NyaWJlZCB5b3Vyc2VsZiB0byB0aGlzCm1haWxpbmcgbGlzdCBhbmQg
dGhlbiB5b3UgYXJlIGNvbXBsYWluaW5nIHRoYXQgeW91IGFyZSBnZXR0aW5nIGVtYWlscz8KCk1v
cmVvdmVyIGlmIHlvdSBoYXZlIHN1YnNjcmliZWQgeW91cnNlbGYgeW91IHNob3VsZCBiZSBhYmxl
IHRvCnVuc3Vic2NyaWJlIGFzIHdlbGwuIE5vIG5lZWQgdG8gc3BhbSB0aGUgbWFpbGluZyBsaXN0
IHdpdGggc3VjaApyZXF1ZXN0cy4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6Cgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
