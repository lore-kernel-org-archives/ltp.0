Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E75C87FD2
	for <ltp@archiver.kernel.org>; Mon, 11 Aug 2025 14:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BE243CB166
	for <ltp@archiver.kernel.org>; Mon, 11 Aug 2025 16:20:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CE8F3C06B5
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 16:19:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9EFCF600838
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 16:19:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9FF63412B;
 Mon, 11 Aug 2025 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754921990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4zOSB/SPQhc8h8lj8Fi0mkc5PWkWiMImO1vuGNYqjg=;
 b=W5LXribJ3LrYq5kz+hT84xpkbj83kpBbf7U8+Y3hIGEBKgC8kEvzG0cYOv96Q28sngYMeI
 OybzZvEokdPJRtPI1zHl16xtv5+Fr+jAjAlOO/nuRd3YwWybUAq9u4r59+eBSLRnHz1my/
 mXwbdMsnR8ECZHrxH8GJ9ZhImkmp6qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754921990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4zOSB/SPQhc8h8lj8Fi0mkc5PWkWiMImO1vuGNYqjg=;
 b=D1k5EkSX1gWUlI9/N3MlD+RyVCAONYO+Owai6b2uBBTRrBVqZp3nqFXwwCTMd1wMwCLrVD
 Jc7gWVgfxkxPczBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ue+HXHMb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+uMiadD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754921989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4zOSB/SPQhc8h8lj8Fi0mkc5PWkWiMImO1vuGNYqjg=;
 b=ue+HXHMbvi+iC873OVRl2guq2y2ykLS1ZQI6Np05twDr8i/lX9ghSkCp7sW7z4Oue3Tx1Z
 x9NIPGRT8cF817wgw7KTVzqEhb7SR5UWaChbOE5HSqI2pDD15WddEmAOZjgoRct37Prq9y
 enD+stDc+bsKPdD7mUVz6lh1CLxqHXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754921989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4zOSB/SPQhc8h8lj8Fi0mkc5PWkWiMImO1vuGNYqjg=;
 b=+uMiadD4CSNjRBEZMi6BIUIkvJIpydK1opx0kQKI0bIj8YJq2mJWCN8JQSxSs4QgVcBP1I
 lQMqBwRL4Pq4czBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2EA813AB9;
 Mon, 11 Aug 2025 14:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jy6xLgX8mWjKUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 11 Aug 2025 14:19:49 +0000
Date: Mon, 11 Aug 2025 16:20:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aJn8ObtEEaAf1H-a@yuki.lan>
References: <20190102131913.GA26215@rei.lan>
 <20250806074405.14890-1-liwang@redhat.com>
 <aJMf-6DEu-9NzLAJ@yuki.lan>
 <CAEemH2dFjv2Mn-CfM6HEZxT7BR45PAHuwQcMa6dckxemf0tvzg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dFjv2Mn-CfM6HEZxT7BR45PAHuwQcMa6dckxemf0tvzg@mail.gmail.com>
X-Rspamd-Queue-Id: D9FF63412B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_umount: Retry open() after umount to handle
 delayed device release
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
Cc: rafael.tinoco@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gRnJvbSB0aGUgYnBmc3RyYWNlIGxvZ3MsIHRoZXJlIHNlZW1zIHVkaXNrc2QgbGlzdGVu
aW5nIHRvIHRoZSBzYW1lCj4gdWRldmV2ZW50cyBhbmQgcHJvYmVzIHRoZSBkZXZpY2UgdmlhIGxp
YmJsb2NrZGV2L2Jsa2lkLCBwZXJmb3JtaW5nCj4gcmVhbCBPX1JET05MWSBvcGVucyAoZmxhZ3M9
MHgwKS4gVGhlc2UgT19SRE9OTFkgb3BlbnMgZnJvbQo+IHVkaXNrc2QgcmFjZSB3aXRoIG1rZnMu
ZXh0M+KAmXMgT19FWENMIG9wZW4sIGludGVybWl0dGVudGx5IGNhdXNpbmcKPiDigJxhcHBhcmVu
dGx5IGluIHVzZSBieSB0aGUgc3lzdGVt4oCdIChFQlVTWSkuCj4gCj4gRG9lcyB0aGlzIGFuYWx5
c2lzIHNvdW5kIHJlYXNvbmFibGUgdG8geW91PwoKWWVzLiBTbyB3ZSBoYXZlIGFub3RoZXIgZGFl
bW9uIHRoYXQgcHJvYmVzIGJsb2NrIGRldmljZXMgb24gZWFjaCBjaGFuZ2UuCgpJIHN1cHBvc2Ug
dGhhdCB0dXJuaW5nIG9mZiB1ZGlza3NkIGZpeGVzIHRoZSBwcm9ibGVtIHJpZ2h0PyBJZiB0aGF0
IGlzCnNvIEkgd291bGQgYmUgaW5jbGluZWQganVzdCB0byBwcmludCBhIG1lc3NhZ2UgdG8gdHVy
biBvZmYgdWRpc2tzZCBpZgpta2ZzIG9uIGEgbG9vcCBkZXZpY2UgZmFpbHMuLi4KCi0tIApDeXJp
bCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
