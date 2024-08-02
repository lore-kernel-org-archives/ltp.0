Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E8EC52D71
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 05:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03B513D1F1B
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 07:49:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B519E3D1F1E
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 07:48:51 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7FF4614002B5
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 07:48:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D064C1FB7A;
 Fri,  2 Aug 2024 05:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722577728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8TDmlZzq+0rcsMnSMg+x6tsQGJQrobg7jqnjv33ngo=;
 b=IqxzodlDCovSgY68RRb7j99MKsRmSf9bEhVT1uk5TQF48E3pwrE6rBxH9nNtTSjhAR+B8K
 XkiAJFID9/l3dv7i7x+5u0yipw3T1SJoXvO8IY9u9Py/C/q9BDiPIQrK7G7gx5Zgho9fkC
 U/SMtxQOYCMF7f9oCgaW1Pn01uDdyS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722577728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8TDmlZzq+0rcsMnSMg+x6tsQGJQrobg7jqnjv33ngo=;
 b=iOWehlPRPX1Py+7zJ8IfyKhM0ls45qpUHnhV9RusRYm+skYOalT9rb3Cf1co5hyr2x4O+T
 5ZeuIOOqpB0WWOAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OzRmJyiP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bmymf9HU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722577727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8TDmlZzq+0rcsMnSMg+x6tsQGJQrobg7jqnjv33ngo=;
 b=OzRmJyiP2l4Ik03g3eFLhSszvv5UNvFvxB/FQHEjd0EyMTPCAAKuq+ru7jCeyfMMcaDe8r
 fIDtq6OOefHuI90dYl51jfuqALvtwAYa2R3v1dVig7YhRls/31tvswQJ4TVBuHvVKHwk/Z
 dQcLfkGY9WQwHGFqqABSzEayPWkSq9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722577727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8TDmlZzq+0rcsMnSMg+x6tsQGJQrobg7jqnjv33ngo=;
 b=bmymf9HUV+ZADU99+wtNkJIgBGlPXiD9gCi5URpIV4MuMrtvgL/vXHMN7BFb6eq3oFHCxp
 u+6rst6lTYJyl1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E7AD13B06;
 Fri,  2 Aug 2024 05:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gNQJJD9zrGaYawAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 05:48:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 07:48:39 +0200
MIME-Version: 1.0
Message-Id: <20240802-mseal-v4-2-bc1b97cb5a39@suse.com>
References: <20240802-mseal-v4-0-bc1b97cb5a39@suse.com>
In-Reply-To: <20240802-mseal-v4-0-bc1b97cb5a39@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6246;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=97Vcbbct/ievey9BnD1O2dqI2R9q/+hXoYvdyGogc3k=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrHM9SiPu3KZdvBw0INPkNrdqaMQnsYYAqFG4Z
 m0qGeGxRMiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqxzPQAKCRDLzBqyILPm
 RkxEDACDH9dc8SYlU7lvQ9pAePUNFGUe99dEeOXzlKvbCMEzUes3oNCcfnwOP63WwXw6A9StvSp
 MPU/4MAIHzi+HP+eBSfzsxEzlJEMnQv9+a6CMneGN7m4Hfi/6u/EjarZmRffUqNW9iYOWUaCPLO
 eypWBvdKW3Dy7OLFhaQejIoqhf5J11NLKV7MmaoNWPiOMVUNs408Zech+GgsnNOSvxBtUujo75z
 sDDq/ReID2h73UhFAbJsYH1qrvJOvMp/NfIsSHrsfbqPWE0qD4Im8C4Xt3fbvOw0u+55JwHq2Pf
 8WgVwwGS68kIiuW3Nj3s/X8Zyg8qeyZn6kYqWdHd3Lk8ZA616fmXjuKVc4SI2UcbPVnR0uWCmbf
 aEFMnb4G/Og5FIwKEpYmiXUeS7GvzHpx1wVHnjmS5yUvx4xOSw+BIeIdXFFx/QP3JQlAgqbGmGy
 QaUTPM+Nrf+WMe5KLjH6MJghA/th4wAscehRKTOV73oddoU4fjBURB8hvsVnmcD4deovA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D064C1FB7A
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] Add mseal01 test
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
Y3JpYmVkIGFjdGlvbnMgaXMgcmVjb2duaXplZCB2aWEgRVBFUk0gZXJybm8uCgpSZXZpZXdlZC1i
eTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+ClNpZ25lZC1vZmYtYnk6IEFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Ci0tLQogcnVudGVzdC9zeXNjYWxs
cyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbXNlYWwvLmdpdGlnbm9yZSB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21zZWFsL01ha2VmaWxlICAgfCAgIDcgKysKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNl
YWwvbXNlYWwwMS5jICB8IDE1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxl
cyBjaGFuZ2VkLCAxNjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2Fs
bHMgYi9ydW50ZXN0L3N5c2NhbGxzCmluZGV4IDliM2NiYTY2Ny4uNjNhYmUxZjc3IDEwMDY0NAot
LS0gYS9ydW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTg3OCw2ICs4
NzgsOCBAQCBtcmVtYXAwNCBtcmVtYXAwNAogbXJlbWFwMDUgbXJlbWFwMDUKIG1yZW1hcDA2IG1y
ZW1hcDA2CiAKK21zZWFsMDEgbXNlYWwwMQorCiBtc2djdGwwMSBtc2djdGwwMQogbXNnY3RsMDIg
bXNnY3RsMDIKIG1zZ2N0bDAzIG1zZ2N0bDAzCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21zZWFsLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21z
ZWFsLy5naXRpZ25vcmUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi5lMTMw
OTA5OTQKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFs
Ly5naXRpZ25vcmUKQEAgLTAsMCArMSBAQAorbXNlYWwwMQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tc2VhbC9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbXNlYWwvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi4z
NTMxN2Y0NDYKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21z
ZWFsL01ha2VmaWxlCkBAIC0wLDAgKzEsNyBAQAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcgorIyBDb3B5cmlnaHQgKEMpIDIwMjMgU1VTRSBMTEMgQW5kcmVhIENl
cnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KKwordG9wX3NyY2RpcgkJPz0gLi4v
Li4vLi4vLi4KKworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNhc2VzLm1r
CitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFyZ2V0Lm1r
CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uZWIyZjRkNTg4Ci0tLSAvZGV2L251bGwKKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2VhbDAxLmMKQEAgLTAsMCArMSwxNTYgQEAK
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKKy8qCisgKiBDb3B5cmln
aHQgKEMpIDIwMjQgU1VTRSBMTEMgQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0Bz
dXNlLmNvbT4KKyAqLworCisvKlwKKyAqIFtEZXNjcmlwdGlvbl0KKyAqCisgKiBUaGlzIGlzIGEg
c21va2UgdGVzdCB0aGF0IHZlcmlmaWVzIGlmIG1zZWFsKCkgcHJvdGVjdHMgc3BlY2lmaWMgVk1B
IHBvcnRpb25zCisgKiBvZiBhIHByb2Nlc3MuIEFjY29yZGluZyB0byBkb2N1bWVudGF0aW9uLCB0
aGUgc3lzY2FsbCBzaG91bGQgcHJvdGVjdCBtZW1vcnkKKyAqIGZyb20gdGhlIGZvbGxvd2luZyBh
Y3Rpb25zOgorICoKKyAqIC0gdW5tYXBwaW5nLCBtb3ZpbmcgdG8gYW5vdGhlciBsb2NhdGlvbiwg
YW5kIHNocmlua2luZyB0aGUgc2l6ZSwgdmlhIG11bm1hcCgpCisgKiAgIGFuZCBtcmVtYXAoKQor
ICogLSBtb3Zpbmcgb3IgZXhwYW5kaW5nIGEgZGlmZmVyZW50IFZNQSBpbnRvIHRoZSBjdXJyZW50
IGxvY2F0aW9uLCB2aWEgbXJlbWFwKCkKKyAqIC0gbW9kaWZ5aW5nIGEgVk1BIHZpYSBtbWFwKE1B
UF9GSVhFRCkKKyAqIC0gbXByb3RlY3QoKSBhbmQgcGtleV9tcHJvdGVjdCgpCisgKiAtIGRlc3Ry
dWN0aXZlIG1hZHZpY2UoKSBiZWhhdmlvcnMgKGUuZy4gTUFEVl9ET05UTkVFRCkgZm9yIGFub255
bW91cyBtZW1vcnksCisgKiAgIHdoZW4gdXNlcnMgZG9u4oCZdCBoYXZlIHdyaXRlIHBlcm1pc3Np
b24gdG8gdGhlIG1lbW9yeQorICoKKyAqIEFueSBvZiB0aGUgZGVzY3JpYmVkIGFjdGlvbnMgaXMg
cmVjb2duaXplZCB2aWEgRVBFUk0gZXJybm8uCisgKi8KKworI2RlZmluZSBfR05VX1NPVVJDRQor
CisjaW5jbHVkZSAidHN0X3Rlc3QuaCIKKyNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCisKKyNk
ZWZpbmUgTUVNUEFHRVMgOAorI2RlZmluZSBNRU1TRUFMIDIKKworc3RhdGljIHZvaWQgKm1lbV9h
ZGRyOworc3RhdGljIGludCBtZW1fc2l6ZTsKK3N0YXRpYyBpbnQgbWVtX29mZnNldDsKK3N0YXRp
YyBpbnQgbWVtX2FsaWdubWVudDsKKworc3RhdGljIGlubGluZSBpbnQgc3lzX21zZWFsKHZvaWQg
KnN0YXJ0LCBzaXplX3QgbGVuKQoreworCXJldHVybiB0c3Rfc3lzY2FsbChfX05SX21zZWFsLCBz
dGFydCwgbGVuLCAwKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9tcHJvdGVjdCh2b2lkKQorewor
CVRTVF9FWFBfRkFJTChtcHJvdGVjdChtZW1fYWRkciwgbWVtX3NpemUsIFBST1RfTk9ORSksIEVQ
RVJNKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9wa2V5X21wcm90ZWN0KHZvaWQpCit7CisJaW50
IHJldDsKKwlpbnQgcGtleTsKKworCXBrZXkgPSB0c3Rfc3lzY2FsbChfX05SX3BrZXlfYWxsb2Ms
IDAsIDApOworCWlmIChwa2V5ID09IC0xKSB7CisJCWlmIChlcnJubyA9PSBFSU5WQUwpCisJCQl0
c3RfYnJrKFRDT05GLCAicGt1IGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyBDUFUiKTsKKworCQl0
c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAicGtleV9hbGxvYygpIGVycm9yIik7CisJfQorCisJVFNU
X0VYUF9GQUlMKHRzdF9zeXNjYWxsKF9fTlJfcGtleV9tcHJvdGVjdCwKKwkJbWVtX2FkZHIsIG1l
bV9zaXplLAorCQlQUk9UX05PTkUsCisJCXBrZXkpLAorCQlFUEVSTSk7CisKKwlyZXQgPSB0c3Rf
c3lzY2FsbChfX05SX3BrZXlfZnJlZSwgcGtleSk7CisJaWYgKHJldCA9PSAtMSkKKwkJdHN0X2Jy
ayhUQlJPSyB8IFRFUlJOTywgInBrZXlfZnJlZSgpIGVycm9yIik7Cit9CisKK3N0YXRpYyB2b2lk
IHRlc3RfbWFkdmlzZSh2b2lkKQoreworCVRTVF9FWFBfRkFJTChtYWR2aXNlKG1lbV9hZGRyLCBt
ZW1fc2l6ZSwgTUFEVl9ET05UTkVFRCksIEVQRVJNKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9t
dW5tYXAodm9pZCkKK3sKKwlUU1RfRVhQX0ZBSUwobXVubWFwKG1lbV9hZGRyLCBtZW1fc2l6ZSks
IEVQRVJNKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9tcmVtYXBfcmVzaXplKHZvaWQpCit7CisJ
dm9pZCAqbmV3X2FkZHI7CisJc2l6ZV90IG5ld19zaXplID0gMiAqIG1lbV9hbGlnbm1lbnQ7CisK
KwluZXdfYWRkciA9IFNBRkVfTU1BUChOVUxMLCBtZW1fc2l6ZSwKKwkJUFJPVF9SRUFELAorCQlN
QVBfQU5PTllNT1VTIHwgTUFQX1BSSVZBVEUsCisJCS0xLCAwKTsKKworCVRTVF9FWFBfRkFJTF9Q
VFJfVk9JRChtcmVtYXAobWVtX2FkZHIsIG1lbV9zaXplLCBuZXdfc2l6ZSwKKwkJTVJFTUFQX01B
WU1PVkUgfCBNUkVNQVBfRklYRUQsCisJCW5ld19hZGRyKSwKKwkJRVBFUk0pOworCisJU0FGRV9N
VU5NQVAobmV3X2FkZHIsIG5ld19zaXplKTsKK30KKworc3RhdGljIHZvaWQgdGVzdF9tbWFwX2No
YW5nZV9wcm90KHZvaWQpCit7CisJVFNUX0VYUF9GQUlMX1BUUl9WT0lEKG1tYXAobWVtX2FkZHIs
IG1lbV9zaXplLAorCQlQUk9UX1JFQUQsCisJCU1BUF9BTk9OWU1PVVMgfCBNQVBfUFJJVkFURSB8
IE1BUF9GSVhFRCwKKwkJLTEsIDApLCBFUEVSTSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdGNhc2Ug
eworCXZvaWQgKCpmdW5jX3Rlc3QpKHZvaWQpOworCWludCBwcm90OworCWNoYXIgKm1lc3NhZ2U7
Cit9IHRjYXNlc1tdID0geworCXt0ZXN0X21wcm90ZWN0LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRF
LCAibXByb3RlY3QoKSBhdmFpbGFiaWxpdHkifSwKKwl7dGVzdF9wa2V5X21wcm90ZWN0LCBQUk9U
X1JFQUQgfCBQUk9UX1dSSVRFLCAicGtleV9tcHJvdGVjdCgpIGF2YWlsYWJpbGl0eSJ9LAorCXt0
ZXN0X21hZHZpc2UsIFBST1RfUkVBRCwgIm1hZHZpc2UoKSBhdmFpbGFiaWxpdHkifSwKKwl7dGVz
dF9tdW5tYXAsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsICJtdW5tYXAoKSBhdmFpbGFiaWxpdHkg
ZnJvbSBjaGlsZCJ9LAorCXt0ZXN0X21yZW1hcF9yZXNpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJ
VEUsICJtcmVtYXAoKSBhZGRyZXNzIG1vdmUvcmVzaXplIn0sCisJe3Rlc3RfbW1hcF9jaGFuZ2Vf
cHJvdCwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgIm1tYXAoKSBwcm90ZWN0aW9uIGNoYW5nZSJ9
LAorfTsKKworc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBuKQoreworCS8qIHRoZSByZWFz
b24gd2h5IHdlIHNwYXduIGEgY2hpbGQgaXMgdGhhdCBtc2VhbCgpIHdpbGwKKwkgKiBwcm90ZWN0
IFZNQSB1bnRpbCBwcm9jZXNzIHdpbGwgY2FsbCBfZXhpdCgpCisJICovCisJaWYgKCFTQUZFX0ZP
UksoKSkgeworCQlzdHJ1Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1tuXTsKKworCQltZW1fYWRkciA9
IFNBRkVfTU1BUChOVUxMLCBtZW1fc2l6ZSwKKwkJCXRjLT5wcm90LAorCQkJTUFQX0FOT05ZTU9V
UyB8IE1BUF9QUklWQVRFLAorCQkJLTEsIDApOworCisJCXRzdF9yZXMoVElORk8sICJUZXN0aW5n
ICVzIiwgdGMtPm1lc3NhZ2UpOworCisJCVRTVF9FWFBfUEFTUyhzeXNfbXNlYWwobWVtX2FkZHIg
KyBtZW1fb2Zmc2V0LCBtZW1fYWxpZ25tZW50KSk7CisKKwkJdGMtPmZ1bmNfdGVzdCgpOworCQlf
ZXhpdCgwKTsKKwl9Cit9CisKK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCit7CisJbWVtX2FsaWdu
bWVudCA9IGdldHBhZ2VzaXplKCk7CisJbWVtX3NpemUgPSBtZW1fYWxpZ25tZW50ICogTUVNUEFH
RVM7CisJbWVtX29mZnNldCA9IG1lbV9hbGlnbm1lbnQgKiBNRU1TRUFMOworfQorCitzdGF0aWMg
c3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CisJLnRlc3QgPSBydW4sCisJLnRjbnQgPSBBUlJBWV9T
SVpFKHRjYXNlcyksCisJLnNldHVwID0gc2V0dXAsCisJLm1pbl9rdmVyID0gIjYuMTAiLAorCS5m
b3Jrc19jaGlsZCA9IDEsCit9OworCgotLSAKMi40My4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
