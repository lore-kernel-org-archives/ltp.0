Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F417C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6F763CB5BA
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 15:32:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC3693CB585
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:31:45 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BF452001CE
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:31:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0688B21185;
 Fri, 11 Apr 2025 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744378302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0j9yJQZ2z2nrpNapG/CVfWcN1yrqs704jVoUtt/GDpI=;
 b=XrlM1WbpD1RM6Lnf8sG6dH1kLkEw82HkrxxhQzii1Sw5aI3nJ5EVZ0OsHf/M4TSOCDAMnf
 QNlPN8tzkhvHjI997HigUmq/Wih2DMh6yw/6FtiJiZ1cadMWj/gPegJqhUOeG7QnOc1RrU
 EdUt4FIxqXrYuCVbAr9OVFJHd8iRsDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744378302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0j9yJQZ2z2nrpNapG/CVfWcN1yrqs704jVoUtt/GDpI=;
 b=Ba6lxpAPeUxwdomK8ita/y5U+aex6rYaKq7aHabwwcaihNnrhuW1tvzo6lUV0ypCqtEKuB
 WO/WEZTm4iHPj8Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744378302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0j9yJQZ2z2nrpNapG/CVfWcN1yrqs704jVoUtt/GDpI=;
 b=XrlM1WbpD1RM6Lnf8sG6dH1kLkEw82HkrxxhQzii1Sw5aI3nJ5EVZ0OsHf/M4TSOCDAMnf
 QNlPN8tzkhvHjI997HigUmq/Wih2DMh6yw/6FtiJiZ1cadMWj/gPegJqhUOeG7QnOc1RrU
 EdUt4FIxqXrYuCVbAr9OVFJHd8iRsDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744378302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0j9yJQZ2z2nrpNapG/CVfWcN1yrqs704jVoUtt/GDpI=;
 b=Ba6lxpAPeUxwdomK8ita/y5U+aex6rYaKq7aHabwwcaihNnrhuW1tvzo6lUV0ypCqtEKuB
 WO/WEZTm4iHPj8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE3BD13886;
 Fri, 11 Apr 2025 13:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JjTzNL0Z+WdOdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Apr 2025 13:31:41 +0000
Date: Fri, 11 Apr 2025 15:31:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250411133140.GA328202@pevik>
References: <20250408125507.GA225750@pevik> <20250408130003.GB225750@pevik>
 <CAOQ4uxicMYZM4kYoE0G9WsUzkEhzJs-Ecsx3sh9WyvNko4=mJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxicMYZM4kYoE0G9WsUzkEhzJs-Ecsx3sh9WyvNko4=mJQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] fanotify: avoid TCONF on btrfs on TMPDIR
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIEFwciA4LCAyMDI1IGF0IDM6MDDigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4gPgo+ID4gSGkgQW1pciwgSmFuLAo+ID4KPiA+IFRoZSBzdWJqZWN0IHdh
cyBzdXBwb3NlZCB0byBiZSAiZmFub3RpZnk6IGF2b2lkIFRDT05GIG9uIGJ0cmZzIG9uIFRNUERJ
UiIuCj4gPgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgo+ID4KPiA+ID4gTFRQIHRlc3RlZCBv
biBidHJmcyBvbiBUTVBESVIgaXMgc2tpcHBlZCB3aXRoIFRDT05GOgo+ID4gPiAjIFRNUERJUj0v
dmFyL3RtcCAuL2Zhbm90aWZ5MjMKPiA+ID4gdHN0X3RtcGRpci5jOjMxNjogVElORk86IFVzaW5n
IC92YXIvdG1wL0xUUF9mYW56TjNzT1MgYXMgdG1wZGlyIChidHJmcyBmaWxlc3lzdGVtKQo+ID4g
PiB0c3RfZGV2aWNlLmM6OTg6IFRJTkZPOiBGb3VuZCBmcmVlIGRldmljZSAwICcvZGV2L2xvb3Aw
Jwo+ID4gPiB0c3RfdGVzdC5jOjExOTQ6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0
aCBleHQyIG9wdHM9JycgZXh0cmEgb3B0cz0nJwo+ID4gPiBta2UyZnMgMS40Ny4wICg1LUZlYi0y
MDIzKQo+ID4gPiB0c3RfdGVzdC5jOjEyMDY6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRv
IC92YXIvdG1wL0xUUF9mYW56TjNzT1MvZnNfbW50IGZzdHlwPWV4dDIgZmxhZ3M9MAo+ID4gPiB0
c3RfdGVzdC5jOjE5Mjg6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMTkwLWcyYzc5ZTMw
YzJjCj4gPiA+IHRzdF90ZXN0LmM6MTkzMjogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTQuMC0z
Lmc1ZTc3NTRlLWRlZmF1bHQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gTWFyIDMxIDE0OjM0
OjMxIFVUQyAyMDI1ICg1ZTc3NTRlKSB4ODZfNjQKPiA+ID4gdHN0X2tjb25maWcuYzo4ODogVElO
Rk86IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+ID4gPiB0c3Rfa2Nv
bmZpZy5jOjY3NjogVElORk86IENPTkZJR19GQVVMVF9JTkpFQ1RJT04ga2VybmVsIG9wdGlvbiBk
ZXRlY3RlZCB3aGljaCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiA+ID4gdHN0X3Rlc3QuYzox
NzQ4OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDAwcwo+ID4gPiBm
YW5vdGlmeTIzLmM6MjMzOiBUQ09ORjogRkFOX0FUVFJJQiBub3Qgc3VwcG9ydGVkIG9uIGV4dDIg
ZmlsZXN5c3RlbQo+ID4KPiA+ID4gVGhlIHNhbWUgaXMgZmFub3RpZnkyMi5jCj4gPiA+IGZhbm90
aWZ5MjIuYzoyOTY6IFRDT05GOiBGQU5fRlNfRVJST1Igbm90IHN1cHBvcnRlZCBvbiBleHQ0IGZp
bGVzeXN0ZW0KPiA+Cj4gPiA+IFRoZXkgd29yayBvbiB0bXBmcyBvbiBUTVBESVI6Cj4gPgo+ID4g
PiAjIC4vZmFub3RpZnkyMwo+ID4gPiB0c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3Rt
cC9MVFBfZmFuaDZUVW40IGFzIHRtcGRpciAodG1wZnMgZmlsZXN5c3RlbSkKPiA+ID4gdHN0X2Rl
dmljZS5jOjk4OiBUSU5GTzogRm91bmQgZnJlZSBkZXZpY2UgMCAnL2Rldi9sb29wMCcKPiA+ID4g
dHN0X3Rlc3QuYzoxMTk0OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggZXh0MiBv
cHRzPScnIGV4dHJhIG9wdHM9JycKPiA+ID4gbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykKPiA+
ID4gdHN0X3Rlc3QuYzoxMjA2OiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0byAvdG1wL0xU
UF9mYW5oNlRVbjQvZnNfbW50IGZzdHlwPWV4dDIgZmxhZ3M9MAo+ID4gPiB0c3RfdGVzdC5jOjE5
Mjg6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMTkwLWcyYzc5ZTMwYzJjCj4gPiA+IHRz
dF90ZXN0LmM6MTkzMjogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTQuMC0zLmc1ZTc3NTRlLWRl
ZmF1bHQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gTWFyIDMxIDE0OjM0OjMxIFVUQyAyMDI1
ICg1ZTc3NTRlKSB4ODZfNjQKPiA+ID4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcg
a2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+ID4gPiB0c3Rfa2NvbmZpZy5jOjY3Njog
VElORk86IENPTkZJR19GQVVMVF9JTkpFQ1RJT04ga2VybmVsIG9wdGlvbiBkZXRlY3RlZCB3aGlj
aCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiA+ID4gdHN0X3Rlc3QuYzoxNzQ4OiBUSU5GTzog
T3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDAwcwo+ID4gPiBmYW5vdGlmeTIzLmM6
MTA5OiBUUEFTUzogRkFOX01BUktfQUREIGZhaWxlZCB3aXRoIEVFWElTVCBhcyBleHBlY3RlZCB3
aGVuIHRyeWluZyB0byBkb3duZ3JhZGUgdG8gZXZpY3RhYmxlIG1hcmsKPiA+ID4gZmFub3RpZnky
My5jOjcyOiBUUEFTUzogRkFOX01BUktfUkVNT1ZFIGZhaWxlZCB3aXRoIEVOT0VOVCBhcyBleHBl
Y3RlZCBhZnRlciBlbXB0eSBtYXNrCj4gPiA+IGZhbm90aWZ5MjMuYzoxNTU6IFRQQVNTOiBHb3Qg
bm8gZXZlbnRzIGFzIGV4cGVjdGVkCj4gPiA+IGZhbm90aWZ5MjMuYzo3MjogVFBBU1M6IEZBTl9N
QVJLX1JFTU9WRSBmYWlsZWQgd2l0aCBFTk9FTlQgYXMgZXhwZWN0ZWQgYWZ0ZXIgZHJvcF9jYWNo
ZXMKPiA+ID4gZmFub3RpZnkyMy5jOjE5NjogVFBBU1M6IGdvdCBldmVudDogbWFzaz00Cj4gPiA+
IGZhbm90aWZ5MjMuYzoxOTY6IFRQQVNTOiBnb3QgZXZlbnQ6IG1hc2s9NAo+ID4gPiBmYW5vdGlm
eTIzLmM6NTY6IFRJTkZPOiBVbW91bnRpbmcgL3RtcC9MVFBfZmFuaDZUVW40L2ZzX21udAo+ID4g
PiBmYW5vdGlmeTIzLmM6NTc6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAvTFRQ
X2Zhbmg2VFVuNC9mc19tbnQgZnN0eXA9ZXh0MiBmbGFncz0wCj4gPgo+ID4gPiBJcyB0aGVyZSBh
IHdheSB0byBhdm9pZCBUQ09ORiBvbiBidHJmcz8KPiAKPiBJIHRoaW5rIHRoYXQgc2hvdWxkIGRv
IGl0Ogo+IAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkyMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eTIyLmMKPiBAQCAtMjk1LDcgKzI5NSw3IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsK
PiAgICAgICAgIFJFUVVJUkVfRkFOT1RJRllfRVZFTlRTX1NVUFBPUlRFRF9PTl9GUyhGQU5fQ0xB
U1NfTk9USUZ8RkFOX1JFUE9SVF9GSUQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRkFOX01BUktfRklMRVNZU1RFTSwKPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGQU5fRlNfRVJST1IsICIuIik7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRkFOX0ZTX0VSUk9S
LCBNT1VOVF9QQVRIKTsKPiAgICAgICAgIHByZV9jb3JydXB0X2ZzKCk7Cj4gCj4gICAgICAgICBm
ZF9ub3RpZnkgPSBTQUZFX0ZBTk9USUZZX0lOSVQoRkFOX0NMQVNTX05PVElGfEZBTl9SRVBPUlRf
RklELAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zh
bm90aWZ5MjMuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eTIzLmMKPiBpbmRleCA4OTZhOGE4NTAuLjI2YzllODdmYiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gQEAgLTIyOSwxMCArMjI5
LDEwIEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiAgICAgICAgIFNBRkVfVE9VQ0go
VEVTVF9GSUxFLCAwNjY2LCBOVUxMKTsKPiAKPiAtICAgICAgIFJFUVVJUkVfTUFSS19UWVBFX1NV
UFBPUlRFRF9PTl9GUyhGQU5fTUFSS19FVklDVEFCTEUsICIuIik7Cj4gKyAgICAgICBSRVFVSVJF
X01BUktfVFlQRV9TVVBQT1JURURfT05fRlMoRkFOX01BUktfRVZJQ1RBQkxFLCBNT1VOVF9QQVRI
KTsKPiAgICAgICAgIFJFUVVJUkVfRkFOT1RJRllfRVZFTlRTX1NVUFBPUlRFRF9PTl9GUyhGQU5f
Q0xBU1NfTk9USUZ8RkFOX1JFUE9SVF9GSUQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRkFOX01BUktfRklMRVNZU1RFTSwKPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGQU5fQVRUUklCLCAiLiIpOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZBTl9BVFRSSUIs
IE1PVU5UX1BBVEgpOwo+IAoKPiAtLQoKVGhhbmtzIGZvciBhIGhpbnQsIGluZGVlZCBpdCB3b3Jr
cy4gSSBDY2VkIHlvdSB3aXRoIGEgcGF0Y2guCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcv
cHJvamVjdC9sdHAvcGF0Y2gvMjAyNTA0MTExMzI5NTUuMzMwMjI2LTEtcHZvcmVsQHN1c2UuY3ov
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI1MDQxMTEzMjk1NS4zMzAyMjYtMS1wdm9y
ZWxAc3VzZS5jei8KCj4gCj4gSSBhbHNvIHNlZSBhIGJ1bmNoIG9mOgo+IAo+ICQgZ2l0IGdyZXAg
J3N1cHBvcnRlZF9vbl9mcy4qXCJcLlwiJwo+IGZhbm90aWZ5MDEuYzogICBpZiAoZmFub3RpZnlf
ZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKEZBTl9SRVBPUlRfRklELAo+IEZBTl9NQVJLX01PVU5ULCBG
QU5fT1BFTiwgIi4iKSkgewo+IGZhbm90aWZ5MDUuYzogICBmZF9lcnJvcl91bnN1cHBvcnRlZCA9
Cj4gZmFub3RpZnlfaW5pdF9mbGFnc19zdXBwb3J0ZWRfb25fZnMoRkFOX1JFUE9SVF9GRF9FUlJP
UiwgIi4iKTsKPiBmYW5vdGlmeTExLmM6ICAgZmFuX3JlcG9ydF90aWRfdW5zdXBwb3J0ZWQgPQo+
IGZhbm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKEZBTl9SRVBPUlRfVElELCAiLiIp
Owo+IGZhbm90aWZ5MjEuYzogICAgICAgICAgIGZkX2Vycm9yX3Vuc3VwcG9ydGVkID0KPiBmYW5v
dGlmeV9pbml0X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZEX0VSUk9SLCAiLiIp
Owo+IAo+IFRoZSBmaXJzdCBvbmUgaXMgaW50ZW50aW9uYWwuCj4gVGhlIHR3byBGQU5fUkVQT1JU
X0ZEX0VSUk9SIG9uZXMgY291bGQgdXNlIE1PVU5UX1BBVEgsCj4gYnV0IEkgZG9uJ3QgdGhpbmsg
dGhhdCBpcyBjcml0aWNhbC4KCisxLCB0aGVyZWZvcmUgSSBrZXB0IGl0IHRoZSBzYW1lLgoKS2lu
ZCByZWdhcmRzLApQZXRyCgo+IFRoZXJlIGlzIG5vdGhpbmcgYWJvdXQgdGhvc2UgZmxhZ3MgdGhh
dCBpcyBmcyBzcGVjaWZpYywgc28gaXQgaXMgYQo+IHB1cmUga2VybmVsIGZlYXR1cmUgdGVzdC4K
PiAKPiBUaGUgcHJvYmxlbSB3aXRoIGZhbm90aWZ5ezIyLDIzfSB3YXMgd2l0aCB0aGUgZmxhZyBG
QU5fTUFSS19GSUxFU1lTVEVNIHRoYXQKPiBpcyBub3Qgc3VwcG9ydGVkIG9uIGEgYnRyZnMgc3Vi
dm9sdW1lLgo+IAo+IFRoYW5rcywKPiBBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
