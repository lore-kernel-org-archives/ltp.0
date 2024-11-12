Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AC7D42BB5
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 17:19:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21173C3010
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 18:19:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218573C3010
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 18:18:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 70F69142058D
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 18:18:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A282421266;
 Tue, 12 Nov 2024 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731431922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R0idmRzMmZjzhwF2aUlnGcX152oxF+Lq1TX+MHq1tZE=;
 b=Cj6xqdkXoFP/I92fkgT4+EVeubA6Sr0AsodA2oXWiNiRkJbcGnzfiIggfTml6yGjpfzO0a
 +f1aURtHDCR9JF41JL3csUcQi9DxmIja6DzhScGBCzSNFtPoQe6ImibF+5I5MI1HlTvnBm
 i6a22RxGZsj/qzu82R+lxpUbNoo9wTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731431922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R0idmRzMmZjzhwF2aUlnGcX152oxF+Lq1TX+MHq1tZE=;
 b=EWcU6sahKZvoGaHpH4TTDAnSZ833YCm2MktBtj6qRfAPd9Jmklm4oAugih7o6LQXF9XW6G
 iIO/DlFppEWhOvAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731431921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R0idmRzMmZjzhwF2aUlnGcX152oxF+Lq1TX+MHq1tZE=;
 b=C5c9kJrtQ2NGysDl7/huGlyXS2TR155b46rzWhgoGowkSZizGkKada8Q/Hzlj+3INKvf08
 p5higZ3gnBlaXDRybRkoGZOH9OldqyQhlIk7op6y4l33dDQpCSiTrzaItLE42kw3TRcU/g
 rzbWQIAcMF50eSaa7rtSiJUJ4wDnmSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731431921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R0idmRzMmZjzhwF2aUlnGcX152oxF+Lq1TX+MHq1tZE=;
 b=dhpCwVgjKeDRrJqIo/XEG7+N8Y/lCi4tcBNpenXEPGUU22S8u4rmHf0SfE9zh66YJZs917
 8+rREdWmAA6teKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5348113301;
 Tue, 12 Nov 2024 17:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h5W8EvGNM2dCLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 17:18:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 12 Nov 2024 18:18:30 +0100
Message-ID: <20241112171831.156440-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.0
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] mq_timedreceive01: Fix different signedness error
 on 32bit
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

d2FybmluZzogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBz
aWduZWRuZXNzOgrigJh1bnNpZ25lZCBpbnTigJkgYW5kIOKAmGxvbmcgaW504oCZIFstV3NpZ24t
Y29tcGFyZV0uCgpTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KLS0t
CiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21xX3RpbWVkcmVjZWl2ZS9tcV90aW1lZHJlY2Vp
dmUwMS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tcV90aW1lZHJlY2Vp
dmUvbXFfdGltZWRyZWNlaXZlMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXFfdGlt
ZWRyZWNlaXZlL21xX3RpbWVkcmVjZWl2ZTAxLmMKaW5kZXggMzg3MGI0MDg3YS4uZDRmNDQ3ZDA0
NyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tcV90aW1lZHJlY2VpdmUv
bXFfdGltZWRyZWNlaXZlMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21xX3Rp
bWVkcmVjZWl2ZS9tcV90aW1lZHJlY2VpdmUwMS5jCkBAIC0xODMsNyArMTgzLDcgQEAgc3RhdGlj
IHZvaWQgZG9fdGVzdCh1bnNpZ25lZCBpbnQgaSkKIAkJcmV0dXJuOwogCX0KIAotCWlmICh0Yy0+
bGVuICE9IFRTVF9SRVQpIHsKKwlpZiAoKGxvbmcpdGMtPmxlbiAhPSBUU1RfUkVUKSB7CiAJCXRz
dF9yZXMoVEZBSUwsICJtcV90aW1lZHJlY2VpdmUoKSB3cm9uZyBsZW5ndGggJWxkLCBleHBlY3Rl
ZCAldSIsCiAJCQlUU1RfUkVULCB0Yy0+bGVuKTsKIAkJcmV0dXJuOwotLSAKMi40Ny4wCgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
