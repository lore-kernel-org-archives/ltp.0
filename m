Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E86AC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 09:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 043DD3D0B39
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:44:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CFD73D0729
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:44:40 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8065D1A02380
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:44:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5A79210E9;
 Mon, 10 Jun 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718012678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdy57M+K9+q1TB1JfOotPbdWbdjrd2RLH0gbZDVgnEY=;
 b=XnPnq0xIKUd0Lke5ItVKgVt5DKb/F86R+WRyJ8PPIdAb3cHT1nkzSPYwNFWgdtTASavCCi
 ya0kAdBUo2yykFiZDGWVzy4Pl0M4NWrLeDlQDXEM2yHxiBIuT8W8U3kSt+M1//QYScUaLK
 5gOXhPHNmGPSM45InXIVXZ0OAXZVBaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718012678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdy57M+K9+q1TB1JfOotPbdWbdjrd2RLH0gbZDVgnEY=;
 b=MsSsY8FGN7OoSysWwSN3t1ggXEug04jua5LyQ9HFW+hTOPELEbYpl0dWcBPM98xlrwnlmj
 GSmOmdjkjv7rfQDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718012678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdy57M+K9+q1TB1JfOotPbdWbdjrd2RLH0gbZDVgnEY=;
 b=XnPnq0xIKUd0Lke5ItVKgVt5DKb/F86R+WRyJ8PPIdAb3cHT1nkzSPYwNFWgdtTASavCCi
 ya0kAdBUo2yykFiZDGWVzy4Pl0M4NWrLeDlQDXEM2yHxiBIuT8W8U3kSt+M1//QYScUaLK
 5gOXhPHNmGPSM45InXIVXZ0OAXZVBaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718012678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdy57M+K9+q1TB1JfOotPbdWbdjrd2RLH0gbZDVgnEY=;
 b=MsSsY8FGN7OoSysWwSN3t1ggXEug04jua5LyQ9HFW+hTOPELEbYpl0dWcBPM98xlrwnlmj
 GSmOmdjkjv7rfQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA40013AA8;
 Mon, 10 Jun 2024 09:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IL02KAbLZmbpbgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Jun 2024 09:44:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Jun 2024 11:44:01 +0200
MIME-Version: 1.0
Message-Id: <20240610-mseal-v1-2-f659b9e97efa@suse.com>
References: <20240610-mseal-v1-0-f659b9e97efa@suse.com>
In-Reply-To: <20240610-mseal-v1-0-f659b9e97efa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6173;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=j47jbrLQcJLTGEE/85b1V0VTAbclHr+me6ZFPCeT4IQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmZssGUz6MXRbL+DotwqIycXr+gLWYdyrCdIBWR
 +8aL6MCuoeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmbLBgAKCRDLzBqyILPm
 RoT0C/9g0kreGlsqzSTxVAja/FPuAaHfynJb6H6VQBHV4PGLYMPGKGMbtop9KQjFAQxXZKU71FI
 T7Z2ibcvNItPqYDxl7Wvmk/yYzWsnE+wh4ot/lmL+u/sDlS+z/HnSfeh1v/yOxThBevePwZwh/Q
 c1lDgjwBagmT+R85HT/e9pN5YslptUXChhopa9raHgZlzUZFBhsy81AMid3FYkw6g6YUgl/c0AB
 vxF7SO12vz+VlGidixXK0zbLEea7r0dlvjnyqoziBh0UZ3lFu8uMp62IUmcY3C1yU4aK5jX/k7a
 0byIXu5L+K/PYE8+ZpPdoKynSUfnYLKbWyd+Z+dOSrZOdE5gfAx2Xmb+9m/WrooDe8K9TM0/lx3
 J0VdPz/GkdKVlASFYZs7riBHaN16QDQnPa+jfOEo+sHU9lYiAApeVwA2ffoK3o8O6JVw2OGmyvq
 y2sJ+T/xdSRqb0pLsoUFF3P3r2m1luZY7//jxX/jHqjBZx7ldHf/LG9PmqL3HLEBq/uDM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add mseal01 test
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

RnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KClRoaXMg
aXMgYSBzbW9rZSB0ZXN0IHRoYXQgdmVyaWZpZXMgaWYgbXNlYWwoKSBwcm90ZWN0cyBzcGVjaWZp
YyBWTUEKcG9ydGlvbnMgb2YgYSBwcm9jZXNzLiBBY2NvcmRpbmcgdG8gZG9jdW1lbnRhdGlvbiwg
dGhlIHN5c2NhbGwgc2hvdWxkCnByb3RlY3QgbWVtb3J5IGZyb20gdGhlIGZvbGxvd2luZyBhY3Rp
b25zOgoKLSB1bm1hcHBpbmcsIG1vdmluZyB0byBhbm90aGVyIGxvY2F0aW9uLCBhbmQgc2hyaW5r
aW5nIHRoZSBzaXplLCB2aWEKICBtdW5tYXAoKSBhbmQgbXJlbWFwKCkKLSBtb3Zpbmcgb3IgZXhw
YW5kaW5nIGEgZGlmZmVyZW50IFZNQSBpbnRvIHRoZSBjdXJyZW50IGxvY2F0aW9uLCB2aWEKICBt
cmVtYXAoKQotIG1vZGlmeWluZyBhIFZNQSB2aWEgbW1hcChNQVBfRklYRUQpCi0gbXByb3RlY3Qo
KSBhbmQgcGtleV9tcHJvdGVjdCgpCi0gZGVzdHJ1Y3RpdmUgbWFkdmljZSgpIGJlaGF2aW9ycyAo
ZS5nLiBNQURWX0RPTlRORUVEKSBmb3IgYW5vbnltb3VzCiAgbWVtb3J5LCB3aGVuIHVzZXJzIGRv
buKAmXQgaGF2ZSB3cml0ZSBwZXJtaXNzaW9uIHRvIHRoZSBtZW1vcnkKCkFueSBvZiB0aGUgZGVz
Y3JpYmVkIGFjdGlvbnMgaXMgcmVjb2duaXplZCB2aWEgRVBFUk0gZXJybm8uCgpTaWduZWQtb2Zm
LWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgotLS0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZSB8ICAgMSArCiB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL01ha2VmaWxlICAgfCAgIDcgKysKIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jICB8IDE3NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxODUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZSBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZQpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwMDAuLmUxMzA5MDk5NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXNlYWwvLmdpdGlnbm9yZQpAQCAtMCwwICsxIEBACittc2VhbDAxCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL01ha2VmaWxlIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEwMDY0
NAppbmRleCAwMDAwMDAwMDAuLjM1MzE3ZjQ0NgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvTWFrZWZpbGUKQEAgLTAsMCArMSw3IEBACisjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisjIENvcHlyaWdodCAoQykgMjAy
MyBTVVNFIExMQyBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgor
Cit0b3Bfc3JjZGlyCQk/PSAuLi8uLi8uLi8uLgorCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5j
bHVkZS9tay90ZXN0Y2FzZXMubWsKK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dl
bmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbXNlYWwvbXNlYWwwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2Vh
bDAxLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi5iZjVlNzE2MTIKLS0t
IC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEu
YwpAQCAtMCwwICsxLDE3NyBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQorLyoKKyAqIENvcHlyaWdodCAoQykgMjAyNCBTVVNFIExMQyBBbmRyZWEgQ2VydmVzYXRv
IDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgorICovCisKKy8qXAorICogW0Rlc2NyaXB0aW9u
XQorICoKKyAqIFRoaXMgaXMgYSBzbW9rZSB0ZXN0IHRoYXQgdmVyaWZpZXMgaWYgbXNlYWwoKSBw
cm90ZWN0cyBzcGVjaWZpYyBWTUEgcG9ydGlvbnMKKyAqIG9mIGEgcHJvY2Vzcy4gQWNjb3JkaW5n
IHRvIGRvY3VtZW50YXRpb24sIHRoZSBzeXNjYWxsIHNob3VsZCBwcm90ZWN0IG1lbW9yeQorICog
ZnJvbSB0aGUgZm9sbG93aW5nIGFjdGlvbnM6CisgKgorICogLSB1bm1hcHBpbmcsIG1vdmluZyB0
byBhbm90aGVyIGxvY2F0aW9uLCBhbmQgc2hyaW5raW5nIHRoZSBzaXplLCB2aWEgbXVubWFwKCkK
KyAqICAgYW5kIG1yZW1hcCgpCisgKiAtIG1vdmluZyBvciBleHBhbmRpbmcgYSBkaWZmZXJlbnQg
Vk1BIGludG8gdGhlIGN1cnJlbnQgbG9jYXRpb24sIHZpYSBtcmVtYXAoKQorICogLSBtb2RpZnlp
bmcgYSBWTUEgdmlhIG1tYXAoTUFQX0ZJWEVEKQorICogLSBtcHJvdGVjdCgpIGFuZCBwa2V5X21w
cm90ZWN0KCkKKyAqIC0gZGVzdHJ1Y3RpdmUgbWFkdmljZSgpIGJlaGF2aW9ycyAoZS5nLiBNQURW
X0RPTlRORUVEKSBmb3IgYW5vbnltb3VzIG1lbW9yeSwKKyAqICAgd2hlbiB1c2VycyBkb27igJl0
IGhhdmUgd3JpdGUgcGVybWlzc2lvbiB0byB0aGUgbWVtb3J5CisgKgorICogQW55IG9mIHRoZSBk
ZXNjcmliZWQgYWN0aW9ucyBpcyByZWNvZ25pemVkIHZpYSBFUEVSTSBlcnJuby4KKyAqLworCisj
ZGVmaW5lIF9HTlVfU09VUkNFCisKKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorCisjaWZuZGVmIFRT
VF9BQkkzMgorI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKKworI2RlZmluZSBNRU1QQUdFUyA4
CisjZGVmaW5lIE1FTVNFQUwgMgorCitzdGF0aWMgdm9pZCAqbWVtX2FkZHI7CitzdGF0aWMgaW50
IG1lbV9zaXplOworc3RhdGljIGludCBtZW1fb2Zmc2V0Oworc3RhdGljIGludCBtZW1fYWxpZ25t
ZW50OworCitzdGF0aWMgaW5saW5lIGludCBzeXNfbXNlYWwodm9pZCAqc3RhcnQsIHNpemVfdCBs
ZW4pCit7CisJcmV0dXJuIHRzdF9zeXNjYWxsKF9fTlJfbXNlYWwsIHN0YXJ0LCBsZW4sIDApOwor
fQorCitzdGF0aWMgdm9pZCB0ZXN0X21wcm90ZWN0KHZvaWQpCit7CisJVFNUX0VYUF9GQUlMKG1w
cm90ZWN0KG1lbV9hZGRyLCBtZW1fc2l6ZSwgUFJPVF9OT05FKSwgRVBFUk0pOworfQorCitzdGF0
aWMgdm9pZCB0ZXN0X3BrZXlfbXByb3RlY3Qodm9pZCkKK3sKKwlpbnQgcmV0OworCWludCBwa2V5
OworCisJcGtleSA9IHBrZXlfYWxsb2MoMCwgMCk7CisJaWYgKHBrZXkgPT0gLTEpIHsKKwkJaWYg
KGVycm5vID09IEVJTlZBTCkKKwkJCXRzdF9icmsoVENPTkYsICJwa3UgaXMgbm90IHN1cHBvcnRl
ZCBvbiB0aGlzIENQVSIpOworCisJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJwa2V5X2FsbG9j
KCkgZXJyb3IiKTsKKwl9CisKKwlUU1RfRVhQX0ZBSUwocGtleV9tcHJvdGVjdCgKKwkJbWVtX2Fk
ZHIsIG1lbV9zaXplLAorCQlQUk9UX05PTkUsCisJCXBrZXkpLAorCQlFUEVSTSk7CisKKwlyZXQg
PSBwa2V5X2ZyZWUocGtleSk7CisJaWYgKHJldCA9PSAtMSkKKwkJdHN0X2JyayhUQlJPSyB8IFRF
UlJOTywgInBrZXlfZnJlZSgpIGVycm9yIik7Cit9CisKK3N0YXRpYyB2b2lkIHRlc3RfbWFkdmlz
ZSh2b2lkKQoreworCVRTVF9FWFBfRkFJTChtYWR2aXNlKG1lbV9hZGRyLCBtZW1fc2l6ZSwgTUFE
Vl9ET05UTkVFRCksIEVQRVJNKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9tdW5tYXAodm9pZCkK
K3sKKwlUU1RfRVhQX0ZBSUwobXVubWFwKG1lbV9hZGRyLCBtZW1fc2l6ZSksIEVQRVJNKTsKK30K
Kworc3RhdGljIHZvaWQgdGVzdF9tcmVtYXBfcmVzaXplKHZvaWQpCit7CisJdm9pZCAqbmV3X2Fk
ZHI7CisJc2l6ZV90IG5ld19zaXplID0gMiAqIG1lbV9hbGlnbm1lbnQ7CisKKwluZXdfYWRkciA9
IFNBRkVfTU1BUChOVUxMLCBtZW1fc2l6ZSwKKwkJUFJPVF9SRUFELAorCQlNQVBfQU5PTllNT1VT
IHwgTUFQX1BSSVZBVEUsCisJCS0xLCAwKTsKKworCVRTVF9FWFBfRkFJTF9QVFJfVk9JRChtcmVt
YXAobWVtX2FkZHIsIG1lbV9zaXplLCBuZXdfc2l6ZSwKKwkJTVJFTUFQX01BWU1PVkUgfCBNUkVN
QVBfRklYRUQsCisJCW5ld19hZGRyKSwKKwkJRVBFUk0pOworCisJU0FGRV9NVU5NQVAobmV3X2Fk
ZHIsIG5ld19zaXplKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9tbWFwX2NoYW5nZV9wcm90KHZv
aWQpCit7CisJVFNUX0VYUF9GQUlMX1BUUl9WT0lEKG1tYXAobWVtX2FkZHIsIG1lbV9zaXplLAor
CQlQUk9UX1JFQUQsCisJCU1BUF9BTk9OWU1PVVMgfCBNQVBfUFJJVkFURSB8IE1BUF9GSVhFRCwK
KwkJLTEsIDApLCBFUEVSTSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdGNhc2UgeworCXZvaWQgKCpm
dW5jX3Rlc3QpKHZvaWQpOworCWludCBwcm90OworCWNoYXIgKm1lc3NhZ2U7Cit9IHRjYXNlc1td
ID0geworCXt0ZXN0X21wcm90ZWN0LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCAibXByb3RlY3Qo
KSBhdmFpbGFiaWxpdHkifSwKKwl7dGVzdF9wa2V5X21wcm90ZWN0LCBQUk9UX1JFQUQgfCBQUk9U
X1dSSVRFLCAicGtleV9tcHJvdGVjdCgpIGF2YWlsYWJpbGl0eSJ9LAorCXt0ZXN0X21hZHZpc2Us
IFBST1RfUkVBRCwgIm1hZHZpc2UoKSBhdmFpbGFiaWxpdHkifSwKKwl7dGVzdF9tdW5tYXAsIFBS
T1RfUkVBRCB8IFBST1RfV1JJVEUsICJtdW5tYXAoKSBhdmFpbGFiaWxpdHkgZnJvbSBjaGlsZCJ9
LAorCXt0ZXN0X21yZW1hcF9yZXNpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsICJtcmVtYXAo
KSBhZGRyZXNzIG1vdmUvcmVzaXplIn0sCisJe3Rlc3RfbW1hcF9jaGFuZ2VfcHJvdCwgUFJPVF9S
RUFEIHwgUFJPVF9XUklURSwgIm1tYXAoKSBwcm90ZWN0aW9uIGNoYW5nZSJ9LAorfTsKKworc3Rh
dGljIHZvaWQgY2hpbGQodW5zaWduZWQgaW50IG4pCit7CisJc3RydWN0IHRjYXNlICp0YyA9ICZ0
Y2FzZXNbbl07CisKKwltZW1fYWRkciA9IFNBRkVfTU1BUChOVUxMLCBtZW1fc2l6ZSwKKwkJdGMt
PnByb3QsCisJCU1BUF9BTk9OWU1PVVMgfCBNQVBfUFJJVkFURSwKKwkJLTEsIDApOworCisJdHN0
X3JlcyhUSU5GTywgIlRlc3RpbmcgJXMiLCB0Yy0+bWVzc2FnZSk7CisKKwlUU1RfRVhQX1BBU1Mo
c3lzX21zZWFsKG1lbV9hZGRyICsgbWVtX29mZnNldCwgbWVtX2FsaWdubWVudCkpOworCisJdGMt
PmZ1bmNfdGVzdCgpOworfQorCitzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IG4pCit7CisJ
LyogdGhlIHJlYXNvbiB3aHkgd2Ugc3Bhd24gYSBjaGlsZCBpcyB0aGF0IG1zZWFsKCkgd2lsbAor
CSAqIHByb3RlY3QgVk1BIHVudGlsIHByb2Nlc3Mgd2lsbCBjYWxsIF9leGl0KCkKKwkgKi8KKwlp
ZiAoIVNBRkVfRk9SSygpKSB7CisJCWNoaWxkKG4pOworCQlfZXhpdCgwKTsKKwl9CisKKwl0c3Rf
cmVhcF9jaGlsZHJlbigpOworCisJaWYgKG1lbV9hZGRyICE9IE1BUF9GQUlMRUQpCisJCVNBRkVf
TVVOTUFQKG1lbV9hZGRyLCBtZW1fc2l6ZSk7Cit9CisKK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Cit7CisJbWVtX2FsaWdubWVudCA9IGdldHBhZ2VzaXplKCk7CisJbWVtX3NpemUgPSBtZW1fYWxp
Z25tZW50ICogTUVNUEFHRVM7CisJbWVtX29mZnNldCA9IG1lbV9hbGlnbm1lbnQgKiBNRU1TRUFM
OworfQorCitzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCit7CisJaWYgKG1lbV9hZGRyICE9IE1B
UF9GQUlMRUQpCisJCVNBRkVfTVVOTUFQKG1lbV9hZGRyLCBtZW1fc2l6ZSk7Cit9CisKK3N0YXRp
YyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwkudGVzdCA9IHJ1biwKKwkudGNudCA9IEFSUkFZ
X1NJWkUodGNhc2VzKSwKKwkuc2V0dXAgPSBzZXR1cCwKKwkuY2xlYW51cCA9IGNsZWFudXAsCisJ
Lm1pbl9rdmVyID0gIjYuMTAiLAorCS5mb3Jrc19jaGlsZCA9IDEsCit9OworI2Vsc2UKK1RTVF9U
RVNUX1RDT05GKCJtc2VhbCgpIGRvZXNuJ3Qgc3VwcG9ydCAzMmJpdCBhcmNoIik7CisjZW5kaWYK
Ci0tIAoyLjM1LjMKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
