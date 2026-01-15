Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF6AD44C46
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 13:51:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC98D3C9FBA
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 14:51:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAA2E3C7628
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 14:51:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49B3B600B48
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 14:51:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EC015BCDE;
 Thu, 15 Jan 2026 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768485066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH3WgH2QMto/OfdBLNlsR+VPDHe7469nHrcAucE5Zqo=;
 b=yuu7sGSHj8boCzo1huYftQv/+pcVdRMntvy6a7wlCszFExmPBVMVmRv9EF7ODsNHuz0xjf
 k2d17F+yXuloJZdXvO31ztEf+IM5W9/gg+80SSCygQMzT1aKXXGGeQtrMV59bG8qUFDoBc
 qUK3jcu5vGO7viaxaRxCkNV6QqzuuOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768485066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH3WgH2QMto/OfdBLNlsR+VPDHe7469nHrcAucE5Zqo=;
 b=CxUnmmtqLgi7ZXPM+yYLhp8KmzmbFl8OAbO777r2flSqqidVslzDj55CwijlmrPstxnlVn
 gZBRygQ8aV28M1Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yuu7sGSH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CxUnmmtq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768485066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH3WgH2QMto/OfdBLNlsR+VPDHe7469nHrcAucE5Zqo=;
 b=yuu7sGSHj8boCzo1huYftQv/+pcVdRMntvy6a7wlCszFExmPBVMVmRv9EF7ODsNHuz0xjf
 k2d17F+yXuloJZdXvO31ztEf+IM5W9/gg+80SSCygQMzT1aKXXGGeQtrMV59bG8qUFDoBc
 qUK3jcu5vGO7viaxaRxCkNV6QqzuuOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768485066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH3WgH2QMto/OfdBLNlsR+VPDHe7469nHrcAucE5Zqo=;
 b=CxUnmmtqLgi7ZXPM+yYLhp8KmzmbFl8OAbO777r2flSqqidVslzDj55CwijlmrPstxnlVn
 gZBRygQ8aV28M1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 837723EA63;
 Thu, 15 Jan 2026 13:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LmFfH8rwaGkUQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 15 Jan 2026 13:51:06 +0000
Date: Thu, 15 Jan 2026 14:52:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aWjxFQOl3M1xV5Ep@yuki.lan>
References: <aWjZX0fsrTJMqq49@yuki.lan>
 <CAEemH2f_56EZUi74x-K5a5Pe231qjU14NTsZjWt+=aTdAJcLkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f_56EZUi74x-K5a5Pe231qjU14NTsZjWt+=aTdAJcLkA@mail.gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 9EC015BCDE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

SGkhCj4gICB0c3RfOiBjb3JlIExUUCBBUEkgKGxpYi8pCj4gICBldHN0Xzogbm9u4oCRY29yZSBl
eHRlbmRlZCBsaWJyYXJ5IGluIChsaWJzLykKPiAgIG90c3RfOiBsZWdhY3kvY29tcGF0IGxpYnJh
cnkgKG5vIG5ldyBmZWF0dXJlcykKPiAKPiBCdXQgbm93LCBJJ20gYWxzbyBjb25zaWRlcmluZyB1
c2luZyB0c3RfKiwgZXN0XyosIGFuZCBvc3RfKiBkaXJlY3RseS4KCk1heWJlIHRzZV8gKHRlc3Qg
ZXh0ZW5kZWQpIGFuZCB0c29fICh0ZXN0IG9sZCkuCgo+IFRoYXQgd291bGQgZ3JlYXQgaWYgd2Ug
Y2FuIGZpbmFsaXplIHRoaXMgYmVmb3JlIHRoaXMgcmVsZWFzZS4KCkkgZG8gbm90IGhhdmUgYSBz
dHJvbmcgb3BpbmlvbiBoZXJlLCB3aGF0ZXZlciBpcyBzaG9ydCBlbm91Z2ggd291bGQgZG8uCgot
LSAKQ3lyaWwgSHJ1YmlzCmNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
