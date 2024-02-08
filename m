Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3AAC4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:00:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8E493CF547
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 10:00:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7268C3CC4B5
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D961360673C
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D98A1FD89;
 Thu,  8 Feb 2024 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3uP134n2M902t2rF+yk9CBjBNyDi09XNDG4FcwW9VI=;
 b=y1zrylsXLXj46Yu/szawTkZbsw+idc8eZk50Lv9Cn6IasLwkqAjAk9HzcXCXlobjNnvA2C
 kNgAyDAr/N3X7pzbpg0f/dFuiJbG0YYltmXmHPg6Edat2eUWfgjwc6sGvmq1DCay3Smz/L
 oOSAC+avbLxb/o0XrYdOLrY3C8DL8kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3uP134n2M902t2rF+yk9CBjBNyDi09XNDG4FcwW9VI=;
 b=qafq0vUaJS5WX5sDiaTpIiJ/oyxkScttknfheQnsr+lMqKqRU72xV27wjF/HrIeqA638ap
 ryyc4ixLoObaTSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3uP134n2M902t2rF+yk9CBjBNyDi09XNDG4FcwW9VI=;
 b=y1zrylsXLXj46Yu/szawTkZbsw+idc8eZk50Lv9Cn6IasLwkqAjAk9HzcXCXlobjNnvA2C
 kNgAyDAr/N3X7pzbpg0f/dFuiJbG0YYltmXmHPg6Edat2eUWfgjwc6sGvmq1DCay3Smz/L
 oOSAC+avbLxb/o0XrYdOLrY3C8DL8kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3uP134n2M902t2rF+yk9CBjBNyDi09XNDG4FcwW9VI=;
 b=qafq0vUaJS5WX5sDiaTpIiJ/oyxkScttknfheQnsr+lMqKqRU72xV27wjF/HrIeqA638ap
 ryyc4ixLoObaTSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C5513985;
 Thu,  8 Feb 2024 08:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDM6NvmXxGUoDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Feb 2024 08:59:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 09:59:27 +0100
Message-ID: <20240208085932.182167-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208085932.182167-1-pvorel@suse.cz>
References: <20240208085932.182167-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y1zrylsX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qafq0vUa
X-Spamd-Result: default: False [0.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0D98A1FD89
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] network: Remove host01.sh
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGVzdGluZyBvbGQgaG9zdCBmdW5jdGlvbmFsaXR5IHJlcXVpcmVzIHByb3BlciBETlMgc2V0dXAu
ClRoYXQgd291bGQgYmUgcXVpdGUgY29tcGxpY2F0ZWQgc2V0dXAgYW5kIHJlc3VsdCB3b3VsZCBi
ZSB0byB0ZXN0CmJpbmQgcHJvamVjdCB1c2Vyc3BhY2UgdG9vbCBpbnN0ZWFkIG9mIGtlcm5lbCBp
bnRlcm5hbHMuCgpUZXN0aW5nIHJlbW90ZSBob3N0IGUuZy4gaG9zdCBleGFtcGxlLm9yZyB3b3Vs
ZCByZXF1aXJlIFNVVCBoYXZpbmcKaW50ZXJuZXQgY29ubmVjdGlvbi4KClRlc3RpbmcgaG9zdG5h
bWVjdGwgd291bGQgbWFrZSBtb3JlIHNlbnNlIG5vd2FkYXlzLCB0aGVyZWZvcmUgcmVtb3ZlCnRo
ZSB0ZXN0LgoKU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Ci0tLQog
cnVudGVzdC9uZXQudGNwX2NtZHMgICAgICAgICAgICAgICAgICAgICAgfCAgMSAtCiB0ZXN0Y2Fz
ZXMvbmV0d29yay90Y3BfY21kcy9ob3N0L01ha2VmaWxlICB8IDExIC0tLS0tLS0tCiB0ZXN0Y2Fz
ZXMvbmV0d29yay90Y3BfY21kcy9ob3N0L2hvc3QwMS5zaCB8IDM0IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDQ2IGRlbGV0aW9ucygtKQogZGVsZXRlIG1vZGUgMTAw
NjQ0IHRlc3RjYXNlcy9uZXR3b3JrL3RjcF9jbWRzL2hvc3QvTWFrZWZpbGUKIGRlbGV0ZSBtb2Rl
IDEwMDc1NSB0ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9ob3N0L2hvc3QwMS5zaAoKZGlmZiAt
LWdpdCBhL3J1bnRlc3QvbmV0LnRjcF9jbWRzIGIvcnVudGVzdC9uZXQudGNwX2NtZHMKaW5kZXgg
N2UxNDJkZTExLi5jNjMyMjM3NjMgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvbmV0LnRjcF9jbWRzCisr
KyBiL3J1bnRlc3QvbmV0LnRjcF9jbWRzCkBAIC03LDcgKzcsNiBAQCBpcG5laWdoMDFfaXAgaXBu
ZWlnaDAxLnNoIC1jIGlwCiBhcnBpbmcwMSBhcnBpbmcwMS5zaAogY2xvY2tkaWZmMDEgY2xvY2tk
aWZmMDEuc2gKIGZ0cCBmdHAwMS5zaAotaG9zdCBob3N0MDEuc2gKIG5ldHN0YXQgbmV0c3RhdDAx
LnNoCiBwaW5nMDEgcGluZzAxLnNoCiBwaW5nMDIgcGluZzAyLnNoCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMvbmV0d29yay90Y3BfY21kcy9ob3N0L01ha2VmaWxlIGIvdGVzdGNhc2VzL25ldHdvcmsv
dGNwX2NtZHMvaG9zdC9NYWtlZmlsZQpkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggNDUz
OTUxZTBkLi4wMDAwMDAwMDAKLS0tIGEvdGVzdGNhc2VzL25ldHdvcmsvdGNwX2NtZHMvaG9zdC9N
YWtlZmlsZQorKysgL2Rldi9udWxsCkBAIC0xLDExICswLDAgQEAKLSMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKLSMgQ29weXJpZ2h0IChDKSAyMDA5LCBDaXNjbyBT
eXN0ZW1zIEluYy4KLSMgTmdpZSBDb29wZXIsIEp1bHkgMjAwOQotCi10b3Bfc3JjZGlyCQk/PSAu
Li8uLi8uLi8uLgotCi1pbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1r
Ci0KLUlOU1RBTExfVEFSR0VUUwkJOj0gaG9zdDAxLnNoCi0KLWluY2x1ZGUgJCh0b3Bfc3JjZGly
KS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9uZXR3b3JrL3RjcF9jbWRzL2hvc3QvaG9zdDAxLnNoIGIvdGVzdGNhc2VzL25ldHdvcmsvdGNw
X2NtZHMvaG9zdC9ob3N0MDEuc2gKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDllZDQ0
YmFlMy4uMDAwMDAwMDAwCi0tLSBhL3Rlc3RjYXNlcy9uZXR3b3JrL3RjcF9jbWRzL2hvc3QvaG9z
dDAxLnNoCisrKyAvZGV2L251bGwKQEAgLTEsMzQgKzAsMCBAQAotIyEvYmluL3NoCi0jIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCi0jIENvcHlyaWdodCAoYykgMjAy
MCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KLSMgQ29weXJpZ2h0IChjKSBLw7ZyeSBNYWlu
Y2VudCA8a29yeS5tYWluY2VudEBib290bGluLmNvbT4gMjAyMAotIyBDb3B5cmlnaHQgKGMpIE1h
bm9qIEl5ZXIgPG1hbmpvQG1haWwudXRleGFzLmVkdT4gMjAwMwotIyBDb3B5cmlnaHQgKGMpIFJv
YmJpZSBXaWxsaWFtc29uIDxyb2JiaWV3QHVzLmlibS5jb20+IDIwMDEKLSMgQ29weXJpZ2h0IChj
KSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMAotCi1UU1RfVEVT
VEZVTkM9ImRvX3Rlc3QiCi1UU1RfTkVFRFNfQ01EUz0iYXdrIGdyZXAgaG9zdCBob3N0bmFtZSB0
YWlsIgotCi0KLWRvX3Rlc3QoKQotewotCWxvY2FsIGxob3N0PSIke0hPU1ROQU1FOi0kKGhvc3Ru
YW1lKX0iCi0JbG9jYWwgYWRkcgotCi0JdHN0X3JlcyBUSU5GTyAidGVzdCBiYXNpYyBmdW5jdGlv
bmFsaXR5IG9mIHRoZSBob3N0IGNvbW1hbmQiCi0JdHN0X3JlcyBUSU5GTyAibGhvc3Q6ICRsaG9z
dCIKLQotCWlmIGFkZHI9JChob3N0ICRsaG9zdCk7IHRoZW4KLQkJYWRkcj0kKGVjaG8gIiRhZGRy
IiB8IGdyZXAgYWRkcmVzcyB8IHRhaWwgLTEgfCBhd2sgJ3twcmludCAkTkZ9JykKLQkJaWYgWyAt
eiAiJGFkZHIiIF07IHRoZW4KLQkJCXRzdF9yZXMgVEZBSUwgImVtcHR5IGFkZHJlc3MiCi0JCQly
ZXR1cm4KLQkJZmkKLQkJRVhQRUNUX1BBU1MgaG9zdCAkYWRkciBcPi9kZXYvbnVsbAotCWVsc2UK
LQkJdHN0X3JlcyBURkFJTCAiaG9zdCAkbGhvc3Qgb24gbG9jYWwgbWFjaGluZSBmYWlsZWQiCi0J
ZmkKLX0KLQotLiB0c3RfbmV0LnNoCi10c3RfcnVuCi0tIAoyLjQzLjAKCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
