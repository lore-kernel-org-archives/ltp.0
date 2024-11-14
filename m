Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273D5D68B2B
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 837813D6F49
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:40:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1C973D6F13
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 261FE10122AE
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68E2621125;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+7W36VxwaatLjet/1B+iIV0JC+nqVoXGLqXpeMy9ro=;
 b=NiDeqRItMKtJUy5rWAEanunkxZ4qCN8cnWWX/qpDx/iHwlQnfdT8fpIeLd2glr0o5DkYR0
 TDVLSihrtHHSZvHXNAcPQGsl9tbskmMmXKBqLVf2v4fRaLQsDcuXuERKbYEGA0eDxvpe+Y
 V+Kh+J05aHNRmJWjnLKCyKHbhijmheI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+7W36VxwaatLjet/1B+iIV0JC+nqVoXGLqXpeMy9ro=;
 b=1pjxYQtJu7Zi0HxJ5WWqVi9WAJlfvIiE3hqTWB/EYgwu0moOXBHBweTkwxdQvN2fjDV5hi
 3zpFAcHhP9Q0RpBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+7W36VxwaatLjet/1B+iIV0JC+nqVoXGLqXpeMy9ro=;
 b=NiDeqRItMKtJUy5rWAEanunkxZ4qCN8cnWWX/qpDx/iHwlQnfdT8fpIeLd2glr0o5DkYR0
 TDVLSihrtHHSZvHXNAcPQGsl9tbskmMmXKBqLVf2v4fRaLQsDcuXuERKbYEGA0eDxvpe+Y
 V+Kh+J05aHNRmJWjnLKCyKHbhijmheI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+7W36VxwaatLjet/1B+iIV0JC+nqVoXGLqXpeMy9ro=;
 b=1pjxYQtJu7Zi0HxJ5WWqVi9WAJlfvIiE3hqTWB/EYgwu0moOXBHBweTkwxdQvN2fjDV5hi
 3zpFAcHhP9Q0RpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F88A13ACF;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oG7PCOMLNmeSdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:40:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 15:40:25 +0100
Message-ID: <20241114144029.349559-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114144029.349559-1-pvorel@suse.cz>
References: <20241114144029.349559-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] mq_timedsend01: Fix different signedness error on
 32bit
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

bXFfdGltZWRzZW5kMDEuYzoyMjM6MjE6IHdhcm5pbmc6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBl
eHByZXNzaW9ucyBvZgpkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYdW5zaWduZWQgaW504oCZIGFu
ZCDigJhsb25nIGludOKAmSBbLVdzaWduLWNvbXBhcmVdCgpTaWduZWQtb2ZmLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21xX3Rp
bWVkc2VuZC9tcV90aW1lZHNlbmQwMS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tcV90aW1lZHNlbmQvbXFfdGltZWRzZW5kMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbXFfdGltZWRzZW5kL21xX3RpbWVkc2VuZDAxLmMKaW5kZXggMzM0MTMxNDAyYy4uMjYz
NjA2Njg2MSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tcV90aW1lZHNl
bmQvbXFfdGltZWRzZW5kMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21xX3Rp
bWVkc2VuZC9tcV90aW1lZHNlbmQwMS5jCkBAIC0yMzUsNyArMjM1LDcgQEAgc3RhdGljIHZvaWQg
ZG9fdGVzdCh1bnNpZ25lZCBpbnQgaSkKIAkJfQogCX0KIAotCWlmICh0Yy0+bGVuICE9IFRTVF9S
RVQpIHsKKwlpZiAoKGxvbmcpdGMtPmxlbiAhPSBUU1RfUkVUKSB7CiAJCXRzdF9yZXMoVEZBSUws
ICJtcV90aW1lZHJlY2VpdmUoKSB3cm9uZyBsZW5ndGggJWxkLCBleHBlY3RlZCAldSIsCiAJCQlU
U1RfUkVULCB0Yy0+bGVuKTsKIAkJcmV0dXJuOwotLSAKMi40NS4yCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
