Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A00DC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 08:29:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23E9F3C969F
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 10:29:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 420EF3C95D9
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 10:29:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 505211000799
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 10:29:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 210911F92C;
 Mon, 15 Aug 2022 08:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660552141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHF7VQ7E7tnhWYjHf2xQSQkKkMi5s45cnBBXNkK6esk=;
 b=p/yZPiSjgl/Tmt1tBjiQTEO8ksCv8z2fkiFigb2tcOsubyl6aPic24UqUiqYKQVDQq1qgB
 Vow8zFOaTuOBDBtRqG7YJ/AB1DdfPH/BFE9zMj/8bifDrK4tlRdETTNx89McYQ5NBXsJzR
 +Jics0EQbs2GiakQIqJ+TA/bf1aqSxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660552141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHF7VQ7E7tnhWYjHf2xQSQkKkMi5s45cnBBXNkK6esk=;
 b=P4uj4EaCGMWAYlZ1cAb/v/jKWVSK8WrhLC9MXcYoyPF/0HC4mNhfDfxpRZH1r5rm/Z98Fs
 B7EaHLDZf+In/nCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EADDB13A99;
 Mon, 15 Aug 2022 08:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3ZCON8wD+mJYPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Aug 2022 08:29:00 +0000
Date: Mon, 15 Aug 2022 10:28:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YvoDyrIGa3/BsqI3@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWHUsCgouLi4KPiA+Pj4gLQlTQUZFX1JFQUQoMCwgb3RmZCwgcmVhZGJ1Ziwgc2l6ZW9mKHJl
YWRidWYpKTsKPiA+Pj4gKwlub2JvZHlfdWlkID0gbHRwdXNlci0+cHdfdWlkOwo+ID4+PiArCW5v
Ym9keV9naWQgPSBsdHB1c2VyLT5wd19naWQ7Cgo+ID4+PiAtCVNBRkVfRlNUQVQob3RmZCwgJmZp
bGVfc3RhdCk7Cj4gPj4+ICsJc25wcmludGYoZmlsZSwgUEFUSF9NQVgsICIlcy8lcyIsIE1OVFBP
SU5ULCBURVNUQklOKTsKPiA+Pj4gKwlUU1RfUkVTT1VSQ0VfQ09QWShOVUxMLCBURVNUQklOLCBm
aWxlKTsKCj4gPj4gSW4gZmFjdCwgb2xkIHRlc3QgY2FzZSBjb3B5IHJlc291cmNlIGZpbGUgd2hl
biBtb3VudCBmaWxleXN0ZW0sIGJ1dCBub3csCj4gPj4geW91IGNoYW5nZSB0aGlzLiAgU28gaW4g
dGVzdF9ub3N1aWQgZnVuY3Rpb24sIHlvdSB0ZXN0IG5vc3VpZCBiZWhhdmlvdXIKPiA+PiBpbiB0
bXBkaXIgaW5zdGVhZCBvZiBkaWZmZXJlbnQgZmlsZXN5c3RlbXMuCgo+ID4gb2xkIGNvZGUgaW4g
c2V0dXA6Cj4gPiAgICAgIGZzX3R5cGUgPSB0c3RfZGV2X2ZzX3R5cGUoKTsKPiA+ICAgICAgZGV2
aWNlID0gdHN0X2FjcXVpcmVfZGV2aWNlKGNsZWFudXApOwoKPiA+ICAgICAgaWYgKCFkZXZpY2Up
Cj4gPiAgICAgICAgICB0c3RfYnJrbShUQ09ORiwgY2xlYW51cCwgIkZhaWxlZCB0byBvYnRhaW4g
YmxvY2sgZGV2aWNlIik7Cgo+ID4gICAgICB0c3RfbWtmcyhjbGVhbnVwLCBkZXZpY2UsIGZzX3R5
cGUsIE5VTEwsIE5VTEwpOwoKPiA+ICAgICAgU0FGRV9NS0RJUihjbGVhbnVwLCBtbnRwb2ludCwg
RElSX01PREUpOwoKPiA+ICAgICAgU0FGRV9NT1VOVChjbGVhbnVwLCBkZXZpY2UsIG1udHBvaW50
LCBmc190eXBlLCAwLCBOVUxMKTsKPiA+ICAgICAgVFNUX1JFU09VUkNFX0NPUFkoY2xlYW51cCwg
Im1vdW50MDNfc2V0dWlkX3Rlc3QiLCBwYXRoX25hbWUpOwoKPiA+IG5ldyBjb2RlOgo+ID4gICAg
ICBzbnByaW50ZihmaWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQsIFRFU1RCSU4pOwo+
ID4gICAgICBTQUZFX0NQKFRFU1RCSU4sIGZpbGUpOwoKPiA+IFdlbGwsIExpIGluIGhpcyB2MiBy
ZW1vdmVkIHRoZSBjb2RlIGJlY2F1c2UgdGhlcmUgaXMgLm1udHBvaW50ID0gTU5UUE9JTlQsIGlu
Cj4gPiBzdHJ1Y3QgdHN0X3Rlc3QsIHRoZXJlZm9yZSBNTlRQT0lOVCBpcyBtb3VudGVkIGluIHRo
ZSBmaWxlc3lzdGVtLCByaWdodD8KCj4gPiBCdXQgaGUgYWxzbyBkaWQgU0FGRV9TVEFUIGFuZCBT
QUZFX0NITU9EIG9uIE1OVFBPSU5ULCB3aGljaCBpcyBJTUhPIHdyb25nCj4gPiAob3IgYXQgbGVh
c3QgZGlmZmVyZW50IGZyb20gdGhlIG9sZCBjb2RlKS4KCj4gWWVzLCBpdCBpcyB3cm9uZy4gSSBn
dWVzcyBDaGVuIG1pc3VuZGVydGFuZCBtbnRwb2ludCB1c2FnZShpdCBqdXN0IAo+IGNyZWF0ZSBt
bnRwb2ludCBpbnN0ZWFkIG1vdW50IGRldiB0byBhIG1vdXRwb2ludCkuCgo+IFNvIGRvIHlvdSB3
aWxsIGZpeCB0aGlz77yfCgpZZXMsIHNlZSB0aGUgZGlmZiBiZWxvdy4gSSdtIHdhaXRpbmcgbGl0
dGxlIGxvbmdlciBpZiBhbnlib2R5IGVsc2UgaGFzIHNvbWUKY29tbWVudHMgYmVmb3JlIG1lcmdp
bmcgaXQuCgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LgoKPiBCZXN0IFJlZ2FyZHMKPiBZYW5nIFh1
CgpkaWZmIC0tZ2l0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jCmluZGV4IDc0YjAxOGQ3OC4u
OWM1ODc4M2Q3IDEwMDY0NAotLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3Vu
dDAzLmMKKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jCkBAIC0x
NSw3ICsxNSw2IEBACiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSA8c3lzL3dhaXQu
aD4KICNpbmNsdWRlIDxwd2QuaD4KLSNpbmNsdWRlICJvbGRfcmVzb3VyY2UuaCIKICNpbmNsdWRl
ICJ0c3RfdGVzdC5oIgogI2luY2x1ZGUgImxhcGkvbW91bnQuaCIKIApAQCAtMTQ1LDcgKzE0NCw3
IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAJbm9ib2R5X2dpZCA9IGx0cHVzZXItPnB3X2dp
ZDsKIAogCXNucHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMvJXMiLCBNTlRQT0lOVCwgVEVTVEJJ
Tik7Ci0JVFNUX1JFU09VUkNFX0NPUFkoTlVMTCwgVEVTVEJJTiwgZmlsZSk7CisJU0FGRV9DUChU
RVNUQklOLCBmaWxlKTsKIAogCVNBRkVfU1RBVChmaWxlLCAmc3QpOwogCWlmIChzdC5zdF9tb2Rl
ICE9IFNVSURfTU9ERSkKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
