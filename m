Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C57C3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 11:33:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42113CBDD0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 13:33:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940633C4C12
 for <ltp@lists.linux.it>; Wed,  7 May 2025 13:33:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB24B1A007EF
 for <ltp@lists.linux.it>; Wed,  7 May 2025 13:33:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 268771F393;
 Wed,  7 May 2025 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746617613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IjFroD58v5hGS20YRTRcRePxOm6Ak/0V6B7rYHK2WOg=;
 b=ZII+OGDUc49eJ4/Q3Wi1VpBRw+YZdSKG2UYzqO9bufx784f6LVow2IwXl0hmpc+boQDQo+
 htZd+yWa8JedYGWTSA8pnA5Rn37MGkU5+jvKWi8U+FQfyoH6hcRXeDTCmjGo9NAA70jPRh
 0F0pWKjo0CT37MHuYRwlT9ceZapQ9r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746617613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IjFroD58v5hGS20YRTRcRePxOm6Ak/0V6B7rYHK2WOg=;
 b=ekmWW88OsMSnD57kNa+lhpvyevF0W+sOeb+P91LYMXKp1SFalwIX6VwPVRKtyM3ZsXJAA8
 rNAfAOqR4zPoIBCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746617613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IjFroD58v5hGS20YRTRcRePxOm6Ak/0V6B7rYHK2WOg=;
 b=ZII+OGDUc49eJ4/Q3Wi1VpBRw+YZdSKG2UYzqO9bufx784f6LVow2IwXl0hmpc+boQDQo+
 htZd+yWa8JedYGWTSA8pnA5Rn37MGkU5+jvKWi8U+FQfyoH6hcRXeDTCmjGo9NAA70jPRh
 0F0pWKjo0CT37MHuYRwlT9ceZapQ9r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746617613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IjFroD58v5hGS20YRTRcRePxOm6Ak/0V6B7rYHK2WOg=;
 b=ekmWW88OsMSnD57kNa+lhpvyevF0W+sOeb+P91LYMXKp1SFalwIX6VwPVRKtyM3ZsXJAA8
 rNAfAOqR4zPoIBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07C7213882;
 Wed,  7 May 2025 11:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A2WJAA1FG2gwIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 May 2025 11:33:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 May 2025 13:33:14 +0200
Message-ID: <20250507113314.119628-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_net.sh: Avoid using tst_require_drivers in legacy
 API
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
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

dHN0X3JlcXVpcmVfZHJpdmVycyBpcyBvbmx5IGluIG5ldyBzaGVsbCBBUEkuIEF2b2lkIHVzaW5n
IGl0IGluIHRoZSBvbGQgQVBJLgoKUmVwb3J0ZWQtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+ClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgot
LS0KTk9URTogdGhlcmUgYXJlIHN0aWxsIDkgcmVtYWluaW5nIHRlc3RzIGluIHRoZSBvbGQgQVBJ
LCBlLmcuCmZ0cC11cGxvYWQtc3RyZXNzLnNoLiBCdXQgaW5zdGVhZCBvZiBjb252ZXJ0aW5nIHRo
ZW0gaXQnZCBiZSBiZXR0ZXIgdG8Kc3BlbmQgdGltZSB0byByZWltcGxlbWVudCB0aGUgdGVzdGNh
c2U6Cmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMjA3
CgpJJ20gbm90IHN1cmUgYWJvdXQgdXNhYmlsaXR5IG9mIG11bHRpY2FzdCB0ZXN0cyAoYnV0IGNv
bnZlcnRpbmcgdGhlbSB0bwpuZXcgc2hlbGwgQVBJIHNob3VsZCBiZSBlYXN5KS4KCiQgZ2l0IGdy
ZXAgLWwgVFNUX1VTRV9MRUdBQ1lfQVBJIHRlc3RjYXNlcy9uZXR3b3JrLwp0ZXN0Y2FzZXMvbmV0
d29yay9tdWx0aWNhc3QvbWNfY21kcy9tY19jbWRzLnNoCnRlc3RjYXNlcy9uZXR3b3JrL211bHRp
Y2FzdC9tY19jb21tby9tY19jb21tby5zaAp0ZXN0Y2FzZXMvbmV0d29yay9tdWx0aWNhc3QvbWNf
bWVtYmVyL21jX21lbWJlci5zaAp0ZXN0Y2FzZXMvbmV0d29yay9tdWx0aWNhc3QvbWNfb3B0cy9t
Y19vcHRzLnNoCnRlc3RjYXNlcy9uZXR3b3JrL3N0cmVzcy9kbnMvZG5zLXN0cmVzcy5zaAp0ZXN0
Y2FzZXMvbmV0d29yay9zdHJlc3MvZnRwL2Z0cC1kb3dubG9hZC1zdHJlc3Muc2gKdGVzdGNhc2Vz
L25ldHdvcmsvc3RyZXNzL2Z0cC9mdHAtdXBsb2FkLXN0cmVzcy5zaAp0ZXN0Y2FzZXMvbmV0d29y
ay9zdHJlc3MvaHR0cC9odHRwLXN0cmVzcy5zaAp0ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy90
Y3BkdW1wL3RjcGR1bXAwMS5zaAoKIHRlc3RjYXNlcy9saWIvdHN0X25ldC5zaCB8IDQgKysrLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9saWIvdHN0X25ldC5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X25ldC5zaApp
bmRleCA5YThiOGQ3MjE0Li42YzIyNzgzMTNjIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvbGliL3Rz
dF9uZXQuc2gKKysrIGIvdGVzdGNhc2VzL2xpYi90c3RfbmV0LnNoCkBAIC0xNzUsNyArMTc1LDkg
QEAgaW5pdF9sdHBfbmV0c3BhY2UoKQogCQl0c3RfcmVxdWlyZV9jbWRzIGlwIHRzdF9uc19jcmVh
dGUgdHN0X25zX2V4ZWMgdHN0X25zX2lmbW92ZQogCQl0c3RfcmVxdWlyZV9yb290CiAKLQkJdHN0
X3JlcXVpcmVfZHJpdmVycyB2ZXRoCisJCWlmIFsgLXogIiRUU1RfVVNFX0xFR0FDWV9BUEkiIF07
IHRoZW4KKwkJCXRzdF9yZXF1aXJlX2RyaXZlcnMgdmV0aAorCQlmaQogCQlST0QgaXAgbGluayBh
ZGQgbmFtZSBsdHBfbnNfdmV0aDEgdHlwZSB2ZXRoIHBlZXIgbmFtZSBsdHBfbnNfdmV0aDIKIAkJ
cGlkPSIkKFJPRCB0c3RfbnNfY3JlYXRlIG5ldCxtbnQpIgogCQlta2RpciAtcCAvdmFyL3J1bi9u
ZXRucwotLSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
