Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF95BC54754
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 07:02:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F8353CC481
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:02:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 117183CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 09:02:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BE7621400F93
 for <ltp@lists.linux.it>; Thu, 15 May 2025 09:02:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D41CF2121B;
 Thu, 15 May 2025 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747292544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WamuRM//NwS3SfixxeqgQJ/OkC5OfwjZbpd8ObvQBMk=;
 b=RGlkQV2amI2Uccw1IvLYXizxyrHNX1sYVEQq9WAhrgLPnMc4kPK0jV9ofjR+csskpcqO0n
 enpSQDXT7ZLCgDxB8QA2aq4z9Bshe12DfDaeF9LDlmcP00fFu1dMOyTGbpjnFiNJjfHTco
 Ja1JkfCTThcAoISoFJ+JJXhpm2ipSWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747292544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WamuRM//NwS3SfixxeqgQJ/OkC5OfwjZbpd8ObvQBMk=;
 b=LZUp+BrehxrAwwzcp5ka5LpDOsUWBy3Lpx+PS+nNxAsBJOu2L68g6goGetGv/yHovW189Y
 UET5UODdzbVUa1AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747292544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WamuRM//NwS3SfixxeqgQJ/OkC5OfwjZbpd8ObvQBMk=;
 b=RGlkQV2amI2Uccw1IvLYXizxyrHNX1sYVEQq9WAhrgLPnMc4kPK0jV9ofjR+csskpcqO0n
 enpSQDXT7ZLCgDxB8QA2aq4z9Bshe12DfDaeF9LDlmcP00fFu1dMOyTGbpjnFiNJjfHTco
 Ja1JkfCTThcAoISoFJ+JJXhpm2ipSWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747292544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WamuRM//NwS3SfixxeqgQJ/OkC5OfwjZbpd8ObvQBMk=;
 b=LZUp+BrehxrAwwzcp5ka5LpDOsUWBy3Lpx+PS+nNxAsBJOu2L68g6goGetGv/yHovW189Y
 UET5UODdzbVUa1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B465A137E8;
 Thu, 15 May 2025 07:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3Vm5KoCRJWhqHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 May 2025 07:02:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 May 2025 09:02:13 +0200
Message-ID: <20250515070217.453359-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: old: Update TST_SR_IGNORE_ERR description
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
Cc: Aaron Knobloch <aarondevelops@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VFNUX1NSX0lHTk9SRV9FUlIgaGFzIGEgYnJvYWRlciBtZWFuaW5nLCBpdCBpZ25vcmVzIGFsbCBl
cnJvcnMgKGUuZy4Kd2hlbiBmaWxlIGRvZXMgbm90IGV4aXN0cyBkdXJpbmcgcmVhZGluZykuCgpS
ZXBvcnRlZC1ieTogQWFyb24gS25vYmxvY2ggPGFhcm9uZGV2ZWxvcHNAZ21haWwuY29tPgpDbG9z
ZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMjM5
ClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgotLS0KSGkgYWxsLAoK
QExpIEkgcGxhbiB0byBhZGQgaW5jbHVkZS90c3Rfc3lzX2NvbmYuaCB0byBvdXIgZG9jIGFuZCB1
c2UgdGhlc2UKZGVzY3JpcHRpb24gaW4ga2VybmVsZG9jLCBidXQgYmV0dGVyIHRvIHVwZGF0ZSB0
aGUgb2xkIGRvYyBpbiBjYXNlIEkKZm9yZ2V0LgoKS2luZCByZWdhcmRzLApQZXRyCgogZG9jL29s
ZC9DLVRlc3QtQVBJLmFzY2lpZG9jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZG9jL29sZC9DLVRlc3QtQVBJLmFzY2lp
ZG9jIGIvZG9jL29sZC9DLVRlc3QtQVBJLmFzY2lpZG9jCmluZGV4IGZlMjZlMjYwNjcuLjcyZmQy
NzMxZDMgMTAwNjQ0Ci0tLSBhL2RvYy9vbGQvQy1UZXN0LUFQSS5hc2NpaWRvYworKysgYi9kb2Mv
b2xkL0MtVGVzdC1BUEkuYXNjaWlkb2MKQEAgLTE2NTEsNyArMTY1MSw3IEBAIHdpdGggJ1RCUk9L
Jy4gVGhpcyBiZWhhdmlvciBjYW4gYmUgY2hhbmdlZCB1c2luZyB0c3RfcGF0aF92YWwuZmxhZ3M6
CiAqICdUU1RfU1JfVEJST0tfUk8nIOKAkyBFbmQgdGVzdCB3aXRoICdUQlJPSycgaWYgdGhlIGZp
bGUgaXMgcmVhZC1vbmx5CiAqICdUU1RfU1JfVENPTkZfUk8nIOKAkyBFbmQgdGVzdCB3aXRoICdU
Q09ORicgaWYgdGhlIGZpbGUgaXMgcmVhZC1vbmx5CiAqICdUU1RfU1JfU0tJUF9STycg4oCTIENv
bnRpbnVlIHdpdGhvdXQgc2F2aW5nIHRoZSBmaWxlIGlmIGl0IGlzIHJlYWQtb25seQotKiAnVFNU
X1NSX0lHTk9SRV9FUlInIOKAkyBJZ25vcmUgZXJyb3JzIHdoZW4gd3JpdGluZyBuZXcgdmFsdWUg
aW50byB0aGUgZmlsZQorKiAnVFNUX1NSX0lHTk9SRV9FUlInIOKAkyBJZ25vcmUgYWxsIGVycm9y
cyBkdXJpbmcgcmVhZGluZyBhbmQgd3JpdGluZyB0aGUgZmlsZQogCiBDb21tb24gZmxhZyBjb21i
aW5hdGlvbnMgYWxzbyBoYXZlIHNob3J0Y3V0czoKIAotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
