Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48387C87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 07:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98C3A3CA33B
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 09:47:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C83493C06B4
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 09:47:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D4584100040D
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 09:47:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3C4433DF6;
 Fri,  8 Aug 2025 07:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754639235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hldLSQrwpumAdSfeTz9e8SWbxAo02mXHYz74iGnQqZo=;
 b=wOfnx9g9pEO73e6lWU32utcjuj6SPNwD3IZSc8F9BeYoZb735StondHC6dqZFh6Q4ndtUq
 omtlMn66LICztV0Zn7cih62Hg8WKvzh5dNIj8jUpTXRYTTqOD4IxnoFFXsAOzR+czmvyX/
 NlCmrCYwbSHdwimtU7aVaftOUReRu7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754639235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hldLSQrwpumAdSfeTz9e8SWbxAo02mXHYz74iGnQqZo=;
 b=PREOvNb+3ISYKr/+hSsJZUG7gpQ0PlgqWxziBrSnqdb6jhIn03VmFIlR5mPIl3VhGPwTQE
 t+y9doWv50LD7QCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754639235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hldLSQrwpumAdSfeTz9e8SWbxAo02mXHYz74iGnQqZo=;
 b=wOfnx9g9pEO73e6lWU32utcjuj6SPNwD3IZSc8F9BeYoZb735StondHC6dqZFh6Q4ndtUq
 omtlMn66LICztV0Zn7cih62Hg8WKvzh5dNIj8jUpTXRYTTqOD4IxnoFFXsAOzR+czmvyX/
 NlCmrCYwbSHdwimtU7aVaftOUReRu7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754639235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hldLSQrwpumAdSfeTz9e8SWbxAo02mXHYz74iGnQqZo=;
 b=PREOvNb+3ISYKr/+hSsJZUG7gpQ0PlgqWxziBrSnqdb6jhIn03VmFIlR5mPIl3VhGPwTQE
 t+y9doWv50LD7QCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 975AD1392A;
 Fri,  8 Aug 2025 07:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eJjmI4OrlWgNNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 07:47:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 09:47:02 +0200
Message-ID: <20250808074702.414456-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] rpc_test.sh: Check for rpcbind remote calls
 support
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Y2xpZW50IGJpbmFyaWVzIHJwY19wbWFwX3JtdGNhbGwgYW5kIHRpcnBjX3JwY2Jfcm10Y2FsbCBy
ZXF1aXJlIHJwY2JpbmQKY29tcGlsZWQgd2l0aCByZW1vdGUgY2FsbHMuICBycGNiaW5kIGhhcyBk
aXNhYmxlZCByZW1vdGUgY2FsbHMgYnkKZGVmYXVsdCBpbiAxLjIuNS4gQnV0IHRoaXMgd2FzIG5v
dCBkZXRlY3RhYmxlIHVudGlsIDEuMi44LCB3aGljaCBicm91Z2h0CnRoaXMgaW5mbyBpbiAtdiBm
bGFnLgoKRGV0ZWN0IHRoZSBzdXBwb3J0IGFuZCBza2lwIG9uIHRoZXNlIDIgZnVuY3Rpb25zIHdo
ZW4gZGlzYWJsZWQuCk5PVEU6IE5vIG5lZWQgdG8gYWN0dWFsbHkgY2hlY2sgZm9yIGEgdmVyc2lv
biBiZWNhdXNlIHJwY2JpbmQgPCAxLjIuOApwcmludHMgb24gJy12JyBqdXN0IGVycm9yIG1lc3Nh
Z2Ugd2hpY2ggZG9lcyBub3QgbWF0Y2ggZ3JlcDoKCiAgICBycGNiaW5kOiBpbnZhbGlkIG9wdGlv
biAtLSAndicKICAgIHVzYWdlOiBycGNiaW5kIFstYWRoaWxzd2ZdCgpSZXZpZXdlZC1ieTogUmlj
YXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Ci0tLQpDaGFuZ2VzIHYxLT52MjoKKiBTaW1wbGlmeSBjaGVjawoK
TGluayB0byB2MToKaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRj
aC8yMDI1MDgwNDE4NDg1MC4zMTMxMDEtMS1wdm9yZWxAc3VzZS5jei8KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbHRwLzIwMjUwODA0MTg0ODUwLjMxMzEwMS0xLXB2b3JlbEBzdXNlLmN6LwoKIHRl
c3RjYXNlcy9uZXR3b3JrL3JwYy9ycGMtdGlycGMvcnBjX3Rlc3Quc2ggfCA1ICsrKysrCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL25ldHdv
cmsvcnBjL3JwYy10aXJwYy9ycGNfdGVzdC5zaCBiL3Rlc3RjYXNlcy9uZXR3b3JrL3JwYy9ycGMt
dGlycGMvcnBjX3Rlc3Quc2gKaW5kZXggY2FkYWU1NTIwMy4uYTAzOGI1YmQ1NiAxMDA3NTUKLS0t
IGEvdGVzdGNhc2VzL25ldHdvcmsvcnBjL3JwYy10aXJwYy9ycGNfdGVzdC5zaAorKysgYi90ZXN0
Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3JwY190ZXN0LnNoCkBAIC01Myw2ICs1MywxMSBA
QCBzZXR1cCgpCiAJCWZpCiAJZmkKIAorCWlmIFsgIiRDTElFTlQiID0gJ3JwY19wbWFwX3JtdGNh
bGwnIC1vICIkQ0xJRU5UIiA9ICd0aXJwY19ycGNiX3JtdGNhbGwnIF0gJiYgXAorCQlycGNiaW5k
IC12IDI+JjEgfCBncmVwIC1xICdyZW1vdGUgY2FsbHM6IG5vJzsgdGhlbgorCQl0c3RfYnJrIFRD
T05GICJza2lwIGR1ZSBycGNiaW5kIGNvbXBpbGVkIHdpdGhvdXQgcmVtb3RlIGNhbGxzIgorCWZp
CisKIAlbIC1uICIkQ0xJRU5UIiBdIHx8IHRzdF9icmsgVEJST0sgImNsaWVudCBwcm9ncmFtIG5v
dCBzZXQiCiAJdHN0X2NoZWNrX2NtZHMgJENMSUVOVCAkU0VSVkVSIHx8IHRzdF9icmsgVENPTkYg
IkxUUCBjb21waWxlZCB3aXRob3V0IFRJLVJQQyBzdXBwb3J0PyIKIAotLSAKMi41MC4xCgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
