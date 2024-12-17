Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBA2E77184
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 21:46:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA78E3ECF43
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 22:46:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99D1A3ECF43
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:46:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E443D213885
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:46:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 294D12115A;
 Tue, 17 Dec 2024 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734471983;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48w5KySEWwHq6KwpHGmwGYUj091kIvZWmqSlxl7GP3k=;
 b=MOCViEXdEqfeSlcaSRQqVlBSVJ957/fN2CkSXim5m18oQt55HKOEpnb0tqk02+M53HrCJb
 P5EUB+wXu6E9jSnT4BLKbX41rjkv0lF5BSeB/KcOzXg1i80OOQnW/jGCcV9wxIlYtwjICD
 +u9ODhEl63gTHmycMD+glFblqI1FXE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734471983;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48w5KySEWwHq6KwpHGmwGYUj091kIvZWmqSlxl7GP3k=;
 b=wTwn+RmhDlfbWzoP9X8r8BMOzBI7OL94GHvHlBGBt961HJBu5dqPNpyGs2f5rpQMZrA78o
 GLsW0xlRBgCmu8Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MOCViEXd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wTwn+Rmh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734471983;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48w5KySEWwHq6KwpHGmwGYUj091kIvZWmqSlxl7GP3k=;
 b=MOCViEXdEqfeSlcaSRQqVlBSVJ957/fN2CkSXim5m18oQt55HKOEpnb0tqk02+M53HrCJb
 P5EUB+wXu6E9jSnT4BLKbX41rjkv0lF5BSeB/KcOzXg1i80OOQnW/jGCcV9wxIlYtwjICD
 +u9ODhEl63gTHmycMD+glFblqI1FXE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734471983;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48w5KySEWwHq6KwpHGmwGYUj091kIvZWmqSlxl7GP3k=;
 b=wTwn+RmhDlfbWzoP9X8r8BMOzBI7OL94GHvHlBGBt961HJBu5dqPNpyGs2f5rpQMZrA78o
 GLsW0xlRBgCmu8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9AC413A3C;
 Tue, 17 Dec 2024 21:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id npB8NS7xYWelEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Dec 2024 21:46:22 +0000
Date: Tue, 17 Dec 2024 22:46:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241217214621.GB29863@pevik>
References: <20241115164101.17983-1-chrubis@suse.cz>
 <CAASaF6wWy6HwbBRmTQcYg3WRwhxexE1ZUernL4WKQzOJYeO+Eg@mail.gmail.com>
 <Z0XgJVa9czWm2YMc@yuki.lan>
 <CAEemH2f9dBfdJM2DkdCnfaxFbMvtWM+USbkuvDcL=DDZs3sopQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f9dBfdJM2DkdCnfaxFbMvtWM+USbkuvDcL=DDZs3sopQ@mail.gmail.com>
X-Rspamd-Queue-Id: 294D12115A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] lib/tst_test.c: Fix tst_brk() handling
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

SGkgYWxsLAoKbmV3IGFwcHJvYWNoIGxvb2tzIGFzIGFuIGltcHJvdmVtZW50IHRvIG1lLgoKU28g
eW91IHBsYW4gdG8gc2VuZCB2MiB0byBzZW5kIHNpZ2tpbGwgc2lnbmFsIHRvIHRoZSB0ZXN0IHBy
b2Nlc3MgZ3JvdXAgaW4KdGhlIGhlYXJ0YmVhdCBoYW5kbGVyPwoKPiBPbiBUdWUsIE5vdiAyNiwg
MjAyNCBhdCAxMDo1MOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToK
Cj4gPiBIaSEKPiA+ID4gPiBUaGlzIG1ha2VzIHRoZSB0c3RfYnJrKCkgaGFuZGxpbmcgY2xlYW5l
ciBhbmQgc2FuZXIgYXMgaW5zdGVhZCBvZgo+ID4gPiA+IHByb3BhZ2F0aW5nIHRoZSB0c3RfYnJr
KCkgcmVzdWx0IGluIGEgcmV0dXJuIHZhbHVlIGFuIGFib3J0IGZsYWcgaXMKPiA+ID4gPiBpbnRy
b2R1Y2VkIGludG8gdGhlIHNoYXJlZCBtZW1vcnkuCgo+ID4gPiA+IE5vdzoKCj4gPiA+ID4gLSBB
bGwgdGhlIHByb2Nlc3NlcyBidXQgdGhlIGxpYnJhcnkgb25lIHRoYXQgcmVwb3J0cyB0aGUgcmVz
dWx0cyBleGl0Cj4gPiA+ID4gICB3aXRoIDAKPiA+ID4gPiAtIHRzdF9icmsoVEJST0ssIC4uLikg
aW5jcmVtZW50cyByZXN1bHQgY29udGVycywgc2V0cyB0aGUgYWJvcnQgZmxhZy4KPiA+ID4gPiAg
IGFuZCBleGl0IGN1cnJlbnQgcHJvY2Vzcwo+ID4gPiA+IC0gYWxsIG90aGVyIHRzdF9icmsoKSB2
YXJpYW50cyB3aWxsIGp1c3QgaW5jcmVtZW50cyB0aGUgY291bnRlcyBhbmQKPiA+ID4gPiAgIGV4
aXRzIHRoZSBjdXJyZW50IHByb2Nlc3MKCj4gPiA+IEl0IHJlbW92ZXMgdGhlIGVhc3kgd2F5IGZv
ciBwYXJlbnQgdG8gY2hlY2sgdGhhdCBjaGlsZCBoYXNuJ3QgcnVuIGludG8KPiA+ID4gYW55IGlz
c3VlcywKPiA+ID4gYnV0IEkgY2FuJ3QgcmVjYWxsIGEgc3BlY2lmaWMgdGVzdCB3ZSBoYXZlIHRv
ZGF5IHRoYXQgZGVwZW5kcyBvbiBpdC4KCj4gPiBJIHN1cHBvc2UgdGhhdCB3ZSBjYW4gbWFrZSB0
aGUgdHN0X2JyayBmbGFnIHBhcnQgb2YgYSBwdWJsaWMgQVBJIGlmCj4gPiBhbnlvbmUgbmVlZHMg
dGhhdCBidXQgSSBndWVzcyB0aGF0IGluIHRoZSBjYXNlIG9mIHRzdF9icmsoVEJST0ssIC4uLikK
PiA+IGFsbCB3ZSB3YW50IGlzIHRvIG1ha2UgdGhlIHRlc3QgcHJvY2Vzc2VzIGV4aXQgYXMgc29v
biBhcyBwb3NzaWJsZS4KCj4gPiA+ID4gVGhpcyBtYWtlcyB0aGUgdHN0X2JyaygpIGJlaGF2aW9y
IHdlbGwgZGVmaW5lZCBzbyB3ZSBjYW4gbm93IGV2ZW4gY2FsbAo+ID4gPiA+IHRzdF9icmsoKSB3
aXRoIFRGQUlMIGFuZCBUUEFTUyBhcyB3ZWxsLgoKPiA+ID4gV2hhdCdzIHRoZSB1c2UtY2FzZSBm
b3IgaXQ/IFdvdWxkbid0IGl0IGJlIG1vcmUgY2xlYXIgdG8ganVzdCByZXBvcnQKPiA+ID4gVFBB
U1MgKyBleGl0PwoKPiA+IEkgdGhpbmsgdGhpcyBtYWtlcyBhY3R1YWxseSB0aGUgQVBJIG1vcmUg
Y29uc2lzdGVudC4gSS5lLiB0c3RfcmVzKCkKPiA+IHJlcG9ydHMgcmVzdWx0IGFuZCB0c3RfYnJr
KCkgcmVwb3J0cyByZXN1bHQgYW5kIGV4aXRzIHRoZSBjdXJyZW50Cj4gPiBwcm9jZXNzLgoKKzEK
Cj4gPiBJIHRoaW5rIHRoYXQgd2UgYWxsIGNhcnJ5IGEgbWVudGFsIGJhZ2dhZ2UgdGhhdCBhc3Nv
Y2lhdGVzIHRoZSB0c3RfYnJrKCkKPiA+IGNhbGwgd2l0aCBhbiBlcnJvciwgYnV0IHRoYXQgaXMg
c29tZXRoaW5nIHdlIGZvcmNlZCB1cG9uIG91cnNlbHZlcy4KPiA+IEFGQUlLIGl0J3Mgc2hvcnQg
Zm9yIHRzdF9icmVhaywgd2hpY2ggaXRzZWxmIG9ubHkgc3VnZ2VzdHMgdGhhdCBpdCBkb2VzCj4g
PiBleGl0IHRoZSBjdXJyZW50IHByb2Nlc3MsIHNpbWlsYXIgdG8gYnJlYWsgYmVpbmcgdXNlZCBp
biBzd2l0Y2goKQo+ID4gc3RhdGVtZW50LgoKKzEuCgo+IEluZGVlZC4gV2l0aCB0aGlzIGNoYW5n
ZSwgd2UgZG9uJ3QgaGF2ZSB0byB1c2UgInRzdF9yZXMoKSArIHJldHVybiIgZm9yCj4gc29tZSBz
aXR1YXRpb25zLAo+IG9ubHkgdHN0X2JyayhUUEFTUywgKSB3b3VsZCBiZSBlbm91Z2guCgorMS4g
V2UgaGF2ZSB0c3RfYnJrKFRGQUlMKSBhbnl3YXkuIFdlIHNob3VsZCBhbHNvIHVuaWZ5IHNoZWxs
IEFQSS4KCm5pdCAoY29tbWVudGluZyB0aGUgaW1wbGVtZW50YXRpb24pOgoKKy8qCkRvbid0IHdl
IHdhbnQgdG8gaGF2ZSBpdCBpbiB0aGUgZG9jcywgZS5nLiAvKiogKyBkb2N1bWVudCBwYXJhbWV0
ZXJzPworICogUHJpbnRzIHJlc3VsdHMsIGNsZWFucyB1cCBhZnRlciB0aGUgdGVzdCBsaWJyYXJ5
IGFuZCBleGl0cyB0aGUgdGVzdCBsaWJyYXJ5CgorKysgYi9saWIvbmV3bGliX3Rlc3RzL3Rlc3Qy
My5jCnZlcnkgbml0OiBJIHdvdWxkIHByZWZlciBzaG9ydCBkZXNjcmlwdGlvbiBuYW1lcyBmb3Ig
dGVzdHMgdGhhbiBudW1iZXJzLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
