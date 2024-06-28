Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B38C2BD09
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 14:20:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58DF43D438B
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 16:20:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C37F3D4363
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 16:19:46 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B7C2200B02
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 16:19:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1660821BD2;
 Fri, 28 Jun 2024 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719584384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neW3g7ljCWd3ucqQZ7c2jBtXsBFTZ/PLLp0x6RCJdb8=;
 b=18s9z1EJPRlbv+5SwvY/kTeLimzib1u7Ok8RXJD85voADQcCNMKSnKaF/wmKk/JxZxxTOM
 syfBeBbGuYHgvVwBAB8YDmRA+mHhE/IIX0jSmepgZaWmhtHUG/3hv/it0HvHfb5SdYXbU6
 6f3vWypiB/Kb5MGeXTyPMrFCB9AOtJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719584384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neW3g7ljCWd3ucqQZ7c2jBtXsBFTZ/PLLp0x6RCJdb8=;
 b=CWnlkyhnVJTWcZBwjWwp7WAQNVnT6AwQSVYyFQ70jl2ED/tk6tWfu7PirDrgArX/53cWnC
 l1MLBhZdnfDj9SDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=18s9z1EJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CWnlkyhn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719584384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neW3g7ljCWd3ucqQZ7c2jBtXsBFTZ/PLLp0x6RCJdb8=;
 b=18s9z1EJPRlbv+5SwvY/kTeLimzib1u7Ok8RXJD85voADQcCNMKSnKaF/wmKk/JxZxxTOM
 syfBeBbGuYHgvVwBAB8YDmRA+mHhE/IIX0jSmepgZaWmhtHUG/3hv/it0HvHfb5SdYXbU6
 6f3vWypiB/Kb5MGeXTyPMrFCB9AOtJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719584384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neW3g7ljCWd3ucqQZ7c2jBtXsBFTZ/PLLp0x6RCJdb8=;
 b=CWnlkyhnVJTWcZBwjWwp7WAQNVnT6AwQSVYyFQ70jl2ED/tk6tWfu7PirDrgArX/53cWnC
 l1MLBhZdnfDj9SDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBE2713375;
 Fri, 28 Jun 2024 14:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E+qUOX/GfmaaEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jun 2024 14:19:43 +0000
Date: Fri, 28 Jun 2024 16:19:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <Zn7GdRv33zuC1Eig@yuki>
References: <20240322052812.633953-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240322052812.633953-1-shirisha@linux.ibm.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1660821BD2
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Migrating the
 libhugetlbfs/testcases/truncate.c test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gVGVzdCBEZXNjcmlwdGlvbjogVGVzdCBpcyB1c2VkIHRvIHZlcmlmeSB0aGUgY29ycmVj
dCBmdW5jdGlvbmFsaXR5Cj4gYW5kIGNvbXBhdGliaWxpdHkgb2YgdGhlIGxpYnJhcnkgd2l0aCB0
aGUgInRydW5jYXRlIiBzeXN0ZW0KPiBjYWxsIHdoZW4gb3BlcmF0aW5nIG9uIGZpbGVzIHJlc2lk
aW5nIGluIGEgbW91bnRlZAo+IGh1Z2UgcGFnZSBmaWxlc3lzdGVtLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IFNoaXJpc2hhIEcgPHNoaXJpc2hhQGxpbnV4LmlibS5jb20+Cj4gLS0tCj4gdjQ6Cj4gIC0t
QWRkcmVzc2VkIHRoZSBiZWxvdyByZXF1ZXN0ZWQgY2hhbmdlcwo+ICAgMS4gQWRkZWQgU0FGRV9G
VFJVTkNBVEUoKQo+ICAgMi4gRml4ZWQgcnVuIHRlc3QgbW9yZSB0aW1lcyAoLWlOKQo+ICAgMy4g
Rml4ZWQgd2FybmluZzogdW51c2VkIHBhcmFtZXRlciDigJhzaWdudW3igJkgWy1XdW51c2VkLXBh
cmFtZXRlcl0KPiAgIDQuIEFkZGVkIGJsYW5rIGxpbmVzIHdoZXJldmVyIG5lZWRlZCB3aGljaCBo
ZWxwcyB0aGUgcmVhZGFiaWxpdHkKPiAgIDUuIFJhbiBtYWtlIGNoZWNrIGFuZCBmaXhlZCB0aGUg
aXNzdWVzCj4gLS0tCj4gdjM6Cj4gIC1BZGRyZXNzZWQgdGhlIGJlbG93IHJlcXVlc3RlZCBjaGFu
Z2VzIAo+ICAgMS4gUmVtb3ZlZCBSQU5ET01fQ09OU1RBTlQKPiAgIDIuIE1hZGUgaHBhZ2Vfc2l6
ZSBhbmQgZmQgdG8gc3RhdGljCj4gICAzLiBVc2VkIGEgdm9sYXRpbGUgdmFyaWFibGUgYXMgYSBm
bGFnCj4gICAgICB0byBwYXNzIHRlc3QgaW4gdGhlIHJ1bl90ZXN0KCkKPiAgIDQuIFJlbW92ZWQg
dGhlIGZhaWx1cmUgY29uZGl0aW9uIGZvciBTQUZFX01NQVAoKQo+ICAgNS4gSGF2ZSBzZXR1cCB0
aGUgaGFuZGxlciBpbiB0aGUgc2V0dXAoKQo+ICAgNi4gQWRkZWQgU0FGRV9NVU5NQVAoKQo+ICAg
Ny4gUmFuIG1ha2UgY2hlY2sgYW5kIGZpeGVkIGFsbCBpc3N1ZXMKPiAtLS0KPiB2MjoKPiAgLUNv
cnJlY3RlZCB0eXBvCj4gLS0tCj4gIHJ1bnRlc3QvaHVnZXRsYiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxICsKPiAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSAgICAg
ICAgICAgICAgIHwgIDEgKwo+ICAuLi4va2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2Vt
bWFwMzMuYyAgfCA4NyArKysrKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgODkg
aW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0v
aHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMzLmMKPiAKPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9o
dWdldGxiIGIvcnVudGVzdC9odWdldGxiCj4gaW5kZXggMjk5YzA3YWM5Li4xMzAwZTgwZmIgMTAw
NjQ0Cj4gLS0tIGEvcnVudGVzdC9odWdldGxiCj4gKysrIGIvcnVudGVzdC9odWdldGxiCj4gQEAg
LTM1LDYgKzM1LDcgQEAgaHVnZW1tYXAyOSBodWdlbW1hcDI5Cj4gIGh1Z2VtbWFwMzAgaHVnZW1t
YXAzMAo+ICBodWdlbW1hcDMxIGh1Z2VtbWFwMzEKPiAgaHVnZW1tYXAzMiBodWdlbW1hcDMyCj4g
K2h1Z2VtbWFwMzMgaHVnZW1tYXAzMwo+ICBodWdlbW1hcDA1XzEgaHVnZW1tYXAwNSAtbQo+ICBo
dWdlbW1hcDA1XzIgaHVnZW1tYXAwNSAtcwo+ICBodWdlbW1hcDA1XzMgaHVnZW1tYXAwNSAtcyAt
bQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQo+IGluZGV4IGM5NmZlOGJmYy4uNDQ0YWNkZjUyIDEw
MDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCj4gQEAgLTM0LDYgKzM0LDcgQEAKPiAgL2h1Z2V0
bGIvaHVnZW1tYXAvaHVnZW1tYXAzMAo+ICAvaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMxCj4g
IC9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzIKPiArL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1t
YXAzMwo+ICAvaHVnZXRsYi9odWdlc2htYXQvaHVnZXNobWF0MDEKPiAgL2h1Z2V0bGIvaHVnZXNo
bWF0L2h1Z2VzaG1hdDAyCj4gIC9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwMwo+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMy5jCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLmViMjFlMjA0Ywo+IC0tLSAv
ZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1
Z2VtbWFwMzMuYwo+IEBAIC0wLDAgKzEsODcgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArLyoKPiArICogQ29weXJpZ2h0IChDKSAyMDA1LTIwMDYg
SUJNIENvcnBvcmF0aW9uLgo+ICsgKiBBdXRob3I6IERhdmlkIEdpYnNvbiAmIEFkYW0gTGl0a2UK
PiArICovCj4gKwo+ICsvKlwKPiArICogW0Rlc2NyaXB0aW9uXQo+ICsgKgo+ICsgKiBUZXN0IGNh
c2UgaXMgdXNlZCB0byB2ZXJpZnkgdGhlIGNvcnJlY3QgZnVuY3Rpb25hbGl0eQo+ICsgKiBhbmQg
Y29tcGF0aWJpbGl0eSBvZiB0aGUgbGlicmFyeSB3aXRoIHRoZSAidHJ1bmNhdGUiIHN5c3RlbSBj
YWxsIHdoZW4KPiArICogb3BlcmF0aW5nIG9uIGZpbGVzIHJlc2lkaW5nIGluIGEgbW91bnRlZCBo
dWdlIHBhZ2UgZmlsZXN5c3RlbS4KPiArICovCj4gKwo+ICsjaW5jbHVkZSAiaHVnZXRsYi5oIgo+
ICsjaW5jbHVkZSA8c2V0am1wLmg+Cj4gKyNpbmNsdWRlIDxzaWduYWwuaD4KPiArCj4gKyNkZWZp
bmUgTU5UUE9JTlQgImh1Z2V0bGJmcy8iCj4gKwo+ICtzdGF0aWMgbG9uZyBocGFnZV9zaXplOwo+
ICtzdGF0aWMgaW50IGZkOwo+ICtzdGF0aWMgc2lnam1wX2J1ZiBzaWdfZXNjYXBlOwo+ICtzdGF0
aWMgdm9sYXRpbGUgaW50IHRlc3RfcGFzczsKPiArc3RhdGljIGludCBzaWdidXNfY291bnQ7Cj4g
Kwo+ICtzdGF0aWMgdm9pZCBzaWdidXNfaGFuZGxlcihpbnQgc2lnbnVtIExUUF9BVFRSSUJVVEVf
VU5VU0VEKQo+ICt7Cj4gKwl0ZXN0X3Bhc3MgPSAxOwo+ICsJc2lnbG9uZ2ptcChzaWdfZXNjYXBl
LCAxNyk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQpCj4gK3sKPiArCXZv
aWQgKnA7Cj4gKwl2b2xhdGlsZSB1bnNpZ25lZCBpbnQgKnE7Cj4gKwo+ICsJc2lnYnVzX2NvdW50
ID0gMDsKPiArCXRlc3RfcGFzcyA9IDA7Cj4gKwo+ICsJc3RydWN0IHNpZ2FjdGlvbiBteV9zaWdh
Y3Rpb247Cj4gKwo+ICsJbXlfc2lnYWN0aW9uLnNhX2hhbmRsZXIgPSBzaWdidXNfaGFuZGxlcjsK
PiArCXAgPSBTQUZFX01NQVAoTlVMTCwgaHBhZ2Vfc2l6ZSwgUFJPVF9SRUFEfFBST1RfV1JJVEUs
IE1BUF9TSEFSRUQsCj4gKwkJCWZkLCAwKTsKPiArCXEgPSBwOwo+ICsJKnEgPSAwOwo+ICsJU0FG
RV9TSUdBQ1RJT04oU0lHQlVTLCAmbXlfc2lnYWN0aW9uLCBOVUxMKTsKPiArCj4gKwlTQUZFX0ZU
UlVOQ0FURShmZCwgMCk7Cj4gKwo+ICsJaWYgKHNpZ3NldGptcChzaWdfZXNjYXBlLCAxKSA9PSAw
KQo+ICsJCSpxOwo+ICsJZWxzZQo+ICsJCXNpZ2J1c19jb3VudCsrOwo+ICsKCllvdSBzaG91bGQg
cmVzZXQgdGhlIFNJR0JVUyBoYW5kbGVyIHRvIFNJR0RGTCBoZXJlLCBvdGhlcndpc2UgYWxsCnN1
YnNlcXVlbnQgcnVucyBydW4gd2l0aCB0aGUgaGFuZGxlciBpbnN0YWxsZWQgZHVyaW5nIHRoZSB3
aG9sZQpydW5fdGVzdCgpIGZ1bmN0aW9uLiBJIHN1cHBvc2UgdGhhdCB5b3UgcHVycG9zZWx5IGlu
c3RhbGwgaXQgYWZ0ZXIgeW91CmhhdmUgZmF1bHRlZCBhIHBhZ2UgaW4gdGhlIGZpbGUgd2l0aCAq
cSA9IDAgdG8ganVtcCB0byB0aGUKc2lnYnVzX2NvdW50KysgYnJhbmNoLgoKPiArCWlmIChzaWdi
dXNfY291bnQgIT0gMSkKPiArCQl0c3RfcmVzKFRGQUlMLCAiRGlkbid0IFNJR0JVUyIpOwo+ICsK
PiArCWlmICh0ZXN0X3Bhc3MgPT0gMSkKPiArCQl0c3RfcmVzKFRQQVNTLCAiRXhwZWN0ZWQgU0lH
QlVTIHRyaWdnZXJlZCIpOwoKVGhpcyBpcyByZWFsbHkgcmVkdW5kYW50LiBTaW5jZSB3ZSB1c2Ug
c2lnbG9uZ2ptcCgpIHdlIGRvbid0IG5lZWQgYQp2YXJpYWJsZSBzZXQgaW4gdGhlIHNpZ25hbCBo
YW5kbGVyLiBBbmQgd2UgaGF2ZSB0byByZXBvcnQgc29tZSByZXN1bHQKZWl0aGVyIGNhc2UsIHNv
IHRoaXMgc2hvdWxkIHJlYWxseSBiZToKCglpZiAoc2lnYnVzX2NvdW50KQoJCXRzdF9yZXMoVFBB
U1MsICJHb3QgU0lHQlVTIik7CgllbHNlCgkJdHN0X3JlcyhURkFJTCwgIkhhdmVuJ3QgZ290IFNJ
R0JVUyIpOwoKPiArCVNBRkVfTVVOTUFQKHAsIGhwYWdlX3NpemUpOwo+ICt9Cj4gKwo+ICsKPiAr
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiArewo+ICsJaHBhZ2Vfc2l6ZSA9IHRzdF9nZXRfaHVn
ZXBhZ2Vfc2l6ZSgpOwo+ICsJZmQgPSB0c3RfY3JlYXRfdW5saW5rZWQoTU5UUE9JTlQsIDApOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gK3sKPiArCWlmIChmZCA+IDAp
Cj4gKwkJU0FGRV9DTE9TRShmZCk7Cj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3Qg
dGVzdCA9IHsKPiArCS5uZWVkc19yb290ID0gMSwKPiArCS5tbnRwb2ludCA9IE1OVFBPSU5ULAo+
ICsJLm5lZWRzX2h1Z2V0bGJmcyA9IDEsCj4gKwkubmVlZHNfdG1wZGlyID0gMSwKPiArCS5zZXR1
cCA9IHNldHVwLAo+ICsJLmNsZWFudXAgPSBjbGVhbnVwLAo+ICsJLnRlc3RfYWxsID0gcnVuX3Rl
c3QsCj4gKwkuaHVnZXBhZ2VzID0gezEsIFRTVF9ORUVEU30sCj4gK307Cj4gLS0gCj4gMi4zOS4z
Cj4gCgo+IAo+IC0tIAo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAoKCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
