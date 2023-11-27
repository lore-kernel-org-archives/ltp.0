Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2D2C4167B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 22:07:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E5593CDC8C
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 23:07:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 226183C0B8E
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 23:07:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 409321000ED8
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 23:07:19 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2831C1F385;
 Mon, 27 Nov 2023 22:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701122835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESEGjhlsbKRcUy3FeXyubdC44c/amai9VDLakIB3xoE=;
 b=AECnopmT3hnb7vauw6WvU5h0bKICRlSJHueYZLkZwTB7nKl9Pv65lsWgai4649eRirYg9o
 Wk1kgypclKvaHpqAiEzSGp6jh67n6871n4BDhCMEaqvJKUGIg1XMVwNFZjCAVCR8rnMO2d
 l1mpe8C903ZUh4laEhsU83Jz4V5xRBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701122835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESEGjhlsbKRcUy3FeXyubdC44c/amai9VDLakIB3xoE=;
 b=EHxnNzYDJxWf7rLHySH1LLZAge2BF8Uty8/AUt/K+o7hbcqBllypFP1zhpCldIXnZpM9VG
 rugQFsVKiy+RjzAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0548413440;
 Mon, 27 Nov 2023 22:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id MeQcABMTZWWVNAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 27 Nov 2023 22:07:15 +0000
Date: Mon, 27 Nov 2023 23:07:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20231127220713.GA292630@pevik>
References: <20231127154013.2625-1-jack@suse.cz>
 <CAOQ4uxhtz2rCn70roeof0Bt8CbAi0vK4CMNiuoFq9M85FUpgGQ@mail.gmail.com>
 <20231127182602.p5tx5hvinsobw3xb@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231127182602.p5tx5hvinsobw3xb@quack3>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.30 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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

SGkgSmFuLCBBbWlyLAoKPiBPbiBNb24gMjctMTEtMjMgMTk6NDA6MTQsIEFtaXIgR29sZHN0ZWlu
IHdyb3RlOgo+ID4gT24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgNTo0MOKAr1BNIEphbiBLYXJhIDxq
YWNrQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gV2hlbiBMVFAgdGVzdCBpcyBydW4gd2l0aCBDV0Qg
aW4gYnRyZnMgc3Vidm9sdW1lLCB0ZXN0cyBsaWtlIGZhbm90aWZ5MTYKPiA+ID4gZmFpbCB3aXRo
OgoKPiA+ID4gZmFub3RpZnkuaDoxNjk6IFRCUk9LOiBmYW5vdGlmeV9tYXJrICgzLCBGQU5fTUFS
S19BREQsIC4uLiwgQVRfRkRDV0QsICIuIikgZmFpbGVkOiBFWERFViAoMTgpCgo+ID4gPiBUaGlz
IGlzIGJlY2F1c2UgZmFub3RpZnlfZXZlbnRzX3N1cHBvcnRlZF9ieV9rZXJuZWwoKSB0cnkgdG8g
cGxhY2UgYQo+ID4gPiBtYXJrIG9udG8gQ1dEIGFuZCB0aGF0IGlzIGZvcmJpZGRlbiBmb3IgYnRy
ZnMgc3Vidm9sdW1lcy4gQ2hhbmdlCj4gPiA+IGZhbm90aWZ5X2V2ZW50c19zdXBwb3J0ZWRfYnlf
a2VybmVsKCkgdG8gdXNlICIvIiBpbnN0ZWFkIG9mICIuIiB3aGljaAo+ID4gPiBoYXMgaGlnaGVy
IGNoYW5jZXMgb2Ygd29ya2luZyBmb3IgYnRyZnMuCgoKPiA+IEZXSVcsICIuIiBpbiBzZXR1cCgp
IGlzIHVzdWFsbHkgYSB0ZW1wZGlyICh1bmRlciBMVFAgdGVtcCByb290KQo+ID4gU28gSSdtIG5v
dCBzdXJlIHRoYXQgIi8iIGlzIGEgYmV0dGVyIGNob2ljZSB0aGFuICIuIi4KPiA+IEF0IGxlYXN0
IHRoZSBMVFAgdGVtcCBkaXIgaXMgY29uZmlndXJhYmxlLgo+ID4gYW5kIG5vIHJlYXNvbiB0aGF0
ICIvIiBpcyBub3QgYSBidHJmcyBzdWJ2b2wgaW5zaWRlIGEgY29udGFpbmVyLi4uCgo+IFllYWgs
IHRoYXQncyBhIGdvb2QgcG9pbnQuIEkgd2FzIHRoaW5raW5nIGl0IG5lZWQgbm90IGJlIHNvIHNp
bXBsZSBidXQKPiB3YW50ZWQgc29tZXRoaW5nIHRvIHN0YXJ0IGEgZGlzY3Vzc2lvbiA6KQoKVGhl
IHZhcmlhYmxlIGlzIFRNUERJUiAoYWxsIHZhcmlhYmxlcyBhcmUgcHJpbnRlZCB3aXRoIC1oLCBl
LmcuIC4vZmFub3RpZnkwMSAtaCkuCkkgd2FzIGV4cGVjdGluZyB0aGlzIHdvdWxkIGJlIGEgcHJv
YmxlbSwgYnV0IGluc3RlYWQgdGhlIHRlc3Qgd2FzIGJyb2tlbiBvbgpUdW1ibGV3ZWVkIHdpdGgg
dGhlIGRlZmF1bHQgVE1QRElSIHZhbHVlIC90bXAuCgo+ID4gRllJLCBpbiB0aGlzIGJyYW5jaDoK
PiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC9sdHAvY29tbWl0cy9mYW5vdGlmeV9mc2lk
CgpGWUkgdGhlIGZpcnN0IGNvbW1pdCBicmVha3MgYXQgbGVhc3QgdmZhdCBvbiBmYW5vdGlmeTEz
CiMgTFRQX1NJTkdMRV9GU19UWVBFPXZmYXQgLi9mYW5vdGlmeTEzCi4uLgp0c3RfdGVzdC5jOjE2
NTA6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiB2ZmF0ID09PQp0c3RfdGVzdC5jOjExMDU6IFRJTkZP
OiBGb3JtYXR0aW5nIC9kZXYvbG9vcDEgd2l0aCB2ZmF0IG9wdHM9JycgZXh0cmEgb3B0cz0nJwp0
c3RfdGVzdC5jOjExMTk6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AxIHRvIC90bXAvTFRQX2Zh
bk05d0xvbS9tbnRwb2ludCBmc3R5cD12ZmF0IGZsYWdzPTAKZmFub3RpZnkxMy5jOjE1MjogVElO
Rk86IFRlc3QgIzAuMTogRkFOX1JFUE9SVF9GSUQgd2l0aCBtYXJrIGZsYWc6IEZBTl9NQVJLX0lO
T0RFCmZhbm90aWZ5MTMuYzoxNTc6IFRDT05GOiBvdmVybGF5ZnMgbm90IHN1cHBvcnRlZCBvbiB2
ZmF0CmZhbm90aWZ5MTMuYzoxNTI6IFRJTkZPOiBUZXN0ICMxLjE6IEZBTl9SRVBPUlRfRklEIHdp
dGggbWFyayBmbGFnOiBGQU5fTUFSS19JTk9ERQpmYW5vdGlmeTEzLmM6MTU3OiBUQ09ORjogb3Zl
cmxheWZzIG5vdCBzdXBwb3J0ZWQgb24gdmZhdApmYW5vdGlmeTEzLmM6MTUyOiBUSU5GTzogVGVz
dCAjMi4xOiBGQU5fUkVQT1JUX0ZJRCB3aXRoIG1hcmsgZmxhZzogRkFOX01BUktfTU9VTlQKZmFu
b3RpZnkxMy5jOjE1NzogVENPTkY6IG92ZXJsYXlmcyBub3Qgc3VwcG9ydGVkIG9uIHZmYXQKZmFu
b3RpZnkxMy5jOjE1MjogVElORk86IFRlc3QgIzMuMTogRkFOX1JFUE9SVF9GSUQgd2l0aCBtYXJr
IGZsYWc6IEZBTl9NQVJLX01PVU5UCmZhbm90aWZ5MTMuYzoxNTc6IFRDT05GOiBvdmVybGF5ZnMg
bm90IHN1cHBvcnRlZCBvbiB2ZmF0CmZhbm90aWZ5MTMuYzoxNTI6IFRJTkZPOiBUZXN0ICM0LjE6
IEZBTl9SRVBPUlRfRklEIHdpdGggbWFyayBmbGFnOiBGQU5fTUFSS19GSUxFU1lTVEVNCmZhbm90
aWZ5MTMuYzoxNTc6IFRDT05GOiBvdmVybGF5ZnMgbm90IHN1cHBvcnRlZCBvbiB2ZmF0CmZhbm90
aWZ5MTMuYzoxNTI6IFRJTkZPOiBUZXN0ICM1LjE6IEZBTl9SRVBPUlRfRklEIHdpdGggbWFyayBm
bGFnOiBGQU5fTUFSS19GSUxFU1lTVEVNCmZhbm90aWZ5MTMuYzoxNTc6IFRDT05GOiBvdmVybGF5
ZnMgbm90IHN1cHBvcnRlZCBvbiB2ZmF0CnRzdF9kZXZpY2UuYzo0MDg6IFRJTkZPOiB1bW91bnQo
J21udHBvaW50JykgZmFpbGVkIHdpdGggRUJVU1ksIHRyeSAgMS4uLgp0c3RfZGV2aWNlLmM6NDEy
OiBUSU5GTzogTGlrZWx5IGd2ZnNkLXRyYXNoIGlzIHByb2JpbmcgbmV3bHkgbW91bnRlZCBmcywg
a2lsbCBpdCB0byBzcGVlZCB1cCB0ZXN0cy4KdHN0X2RldmljZS5jOjQwODogVElORk86IHVtb3Vu
dCgnbW50cG9pbnQnKSBmYWlsZWQgd2l0aCBFQlVTWSwgdHJ5ICAyLi4uCnRzdF9kZXZpY2UuYzo0
MDg6IFRJTkZPOiB1bW91bnQoJ21udHBvaW50JykgZmFpbGVkIHdpdGggRUJVU1ksIHRyeSAgMy4u
LgouLi4KdHN0X2RldmljZS5jOjQwODogVElORk86IHVtb3VudCgnbW50cG9pbnQnKSBmYWlsZWQg
d2l0aCBFQlVTWSwgdHJ5IDUwLi4uCnRzdF9kZXZpY2UuYzo0MTk6IFRXQVJOOiBGYWlsZWQgdG8g
dW1vdW50KCdtbnRwb2ludCcpIGFmdGVyIDUwIHJldHJpZXMKdHN0X3Rlc3QuYzoxNjUwOiBUSU5G
TzogPT09IFRlc3Rpbmcgb24gZXhmYXQgPT09CnRzdF90ZXN0LmM6MTEwNTogVElORk86IEZvcm1h
dHRpbmcgL2Rldi9sb29wMSB3aXRoIGV4ZmF0IG9wdHM9JycgZXh0cmEgb3B0cz0nJwp0c3RfdGVz
dC5jOjExMTk6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AxIHRvIC90bXAvTFRQX2Zhbk05d0xv
bS9tbnRwb2ludCBmc3R5cD1leGZhdCBmbGFncz0wCnRzdF90ZXN0LmM6MTExOTogVElORk86IFRy
eWluZyBGVVNFLi4uCkZVU0UgZXhmYXQgMS40LjAgKGxpYmZ1c2UyKQpmdXNlOiBtb3VudCBmYWls
ZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5CnRzdF90ZXN0LmM6MTExOTogVEJST0s6IG1vdW50
LmV4ZmF0IGZhaWxlZCB3aXRoIDI1NgoKSElOVDogWW91IF9NQVlfIGJlIG1pc3Npbmcga2VybmVs
IGZpeGVzOgoKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9YzI4NWEyZjAxZDY5Cmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21t
aXQvP2lkPWJjMjQ3M2M5MGZjYQoKCj4gPiBJIGhhdmUgYWxyZWFkeSBpbXBsZW1lbnRlZCBmYW5v
dGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoKQo+ID4gd2hpY2ggY2FuIGJlIHVzZWQgdG8gdGVz
dCBzdXBwb3J0IGZvciBhbiBldmVudC9tYXJrIG9uIGEgc3BlY2lmaWMgcGF0aC4KCj4gPiBJIGRp
ZCBub3QgbWFrZSB0aGUgY2hhbmdlIGluIGZhbm90aWZ5MTYuYyB0byB1c2UKPiA+IGZhbm90aWZ5
X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcygpIGluc3RlYWQgb2YKPiA+IGZhbm90aWZ5X3ttYXJrLGV2
ZW50c31fc3VwcG9ydGVkX2J5X2tlcm5lbCgpIGJ1dCBpdCB3b3VsZCBiZSB0cml2aWFsIHRvIGRv
LgoKPiBPSywgdGhpcyBpcyBwcm9iYWJseSBhIG1vcmUgcm9idXN0IGlkZWEgc28gdGhhdCB3ZSB0
ZXN0IGFsbCB0aGUgZmVhdHVyZXMKPiBhZ2FpbnN0IGEgcGF0aCB3ZSBhcmUgdGhlbiBhY3R1YWxs
eSBnb2luZyB0byB1c2UgZm9yIHRlc3RpbmcuIEknbGwgcGljayB0aGUKPiBjb21taXQgImZhbm90
aWZ5OiBHZW5lcmFsaXplIGhlbHBlciBmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoKSIg
ZnJvbQo+IHlvdXIgYnJhbmNoIGFuZCByZXdvcmsgdGhlIGZpeCBiYXNlZCBvbiB0aGF0IHRvbW9y
cm93LiBUaGFua3MhCgpHcmVhdCEKClRoYW5rcyBhIGxvdCB0byB5b3UgYm90aCEKCktpbmQgcmVn
YXJkcywKUGV0cgoKPiAJCQkJCQkJCUhvbnphCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
