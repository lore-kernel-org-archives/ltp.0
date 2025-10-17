Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EC3CCD199
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 15:31:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC2B43CEED6
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 17:31:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02AF63CEB19
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 17:30:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B2C3601930
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 17:30:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DA1321A93;
 Fri, 17 Oct 2025 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760715047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOmcRLLE4sZ0PVZ6wGY56Kbgtp09RD6Z6TVfnYobXKI=;
 b=hbnrHk8l1HI6ACx5Yn9zU2GCb6QLBmWf+5cb4hN6qE7PYAd/jYmbqAy4bcD+/DILNmqBED
 BDuyKjs8UEEqsNK+Cf970SwSDxTvj+cV7pO2SR9G+Kqyt5W4Qzb0WC6bNjUXrp1qfXnK9a
 X0Ri8sIba+RWO9mTf0MzZX8/71JY8SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760715047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOmcRLLE4sZ0PVZ6wGY56Kbgtp09RD6Z6TVfnYobXKI=;
 b=Ejp+eCnWuqBHLVRsddjHYK3kLdViRT3G4Posam4TAAbvKUw1TGVtjHeYWsmTujFBmb8UOm
 lhOS2WK/N9NEBZDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hbnrHk8l;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ejp+eCnW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760715047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOmcRLLE4sZ0PVZ6wGY56Kbgtp09RD6Z6TVfnYobXKI=;
 b=hbnrHk8l1HI6ACx5Yn9zU2GCb6QLBmWf+5cb4hN6qE7PYAd/jYmbqAy4bcD+/DILNmqBED
 BDuyKjs8UEEqsNK+Cf970SwSDxTvj+cV7pO2SR9G+Kqyt5W4Qzb0WC6bNjUXrp1qfXnK9a
 X0Ri8sIba+RWO9mTf0MzZX8/71JY8SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760715047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YOmcRLLE4sZ0PVZ6wGY56Kbgtp09RD6Z6TVfnYobXKI=;
 b=Ejp+eCnWuqBHLVRsddjHYK3kLdViRT3G4Posam4TAAbvKUw1TGVtjHeYWsmTujFBmb8UOm
 lhOS2WK/N9NEBZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73481136C6;
 Fri, 17 Oct 2025 15:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hi6bGidh8mjOFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Oct 2025 15:30:47 +0000
Date: Fri, 17 Oct 2025 17:30:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251017153046.GB339521@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-4-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017101011.3811-4-wegao@suse.com>
X-Rspamd-Queue-Id: 9DA1321A93
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] tst_run_shell.c: Add new function handle
 new needs_cmds
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKPiArCVVKU09OX0FSUl9GT1JFQUNIKHJlYWRlciwgdmFsKSB7Cj4gKwkJVUpTT05f
T0JKX0ZPUkVBQ0hfRklMVEVSKHJlYWRlciwgdmFsLCAmY21kX29iaiwgdWpzb25fZW1wdHlfb2Jq
KSB7Cj4gKwkJCXN3aXRjaCAoKGVudW0gY21kX2lkcyl2YWwtPmlkeCkgewo+ICsJCQljYXNlIENN
RDoKPiArCQkJCXJldFtpXS5jbWQgPSBzdHJkdXAodmFsLT52YWxfc3RyKTsKPiArCQkJYnJlYWs7
Cj4gKwkJCWNhc2UgT1BUSU9OQUw6Cj4gKwkJCQlyZXRbaV0ub3B0aW9uYWwgPSB2YWwtPnZhbF9p
bnQ7Cj4gKwkJCWJyZWFrOwo+ICsJCQljYXNlIE1LRlNfVkVSOgo+ICsJCQkJcmV0W2ldLnByZXNl
bnQgPSB2YWwtPnZhbF9pbnQ7CgpNeSBjb21waWxlciBzaG93cyAyIHdhcm5pbmdzOgoKdHN0X3J1
bl9zaGVsbC5jOjMwMjoyNTogd2FybmluZzogY2FzZSB2YWx1ZSDigJgz4oCZIG5vdCBpbiBlbnVt
ZXJhdGVkIHR5cGUg4oCYZW51bSBjbWRfaWRz4oCZIFstV3N3aXRjaF0KICAzMDIgfCAgICAgICAg
ICAgICAgICAgICAgICAgICBjYXNlIE1LRlNfVkVSOgogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn4KCj0+IEluZGVlZCwgTUtGU19WRVIgaXMgcGFydCBvZiBlbnVtIGZzX2lkcywg
aXQgc2hvdWxkIG5vdCBiZSBoZXJlLgoKQW5vdGhlciB3YXJuaW5nOgoKdHN0X3J1bl9zaGVsbC5j
OiBJbiBmdW5jdGlvbiDigJhwYXJzZV9jbWRz4oCZOgp0c3RfcnVuX3NoZWxsLmM6Mjk1OjI1OiB3
YXJuaW5nOiBlbnVtZXJhdGlvbiB2YWx1ZSDigJhQUkVTRU5U4oCZIG5vdCBoYW5kbGVkIGluIHN3
aXRjaCBbLVdzd2l0Y2hdCiAgMjk1IHwgICAgICAgICAgICAgICAgICAgICAgICAgc3dpdGNoICgo
ZW51bSBjbWRfaWRzKXZhbC0+aWR4KSB7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+Cgo9PiBFaXRoZXIgaXQgTUtGU19WRVIgc2hvdWxkIGhhdmUgUFJFU0VOVCwgb3IsIGJl
Y2F1c2Ugc3RydWN0IHRzdF9jbWQtPnByZXNlbnQKc2hvdWxkIG5vdCBiZSBzZXQgaW4gdGhlIHRl
c3QsIGJ1dCBieSBDIEFQSSwgd2UgbWlnaHQgd2FudCB0byBjYWxsIHVqc29uX2VycigpPwoKS2lu
ZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
