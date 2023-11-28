Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B099DC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:11:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A2A23CDA97
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 12:11:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BBA33CD9D8
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:11:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0B76208E0C
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:10:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8156C1F6E6;
 Tue, 28 Nov 2023 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701169826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5WyCsV3GHI853TjCrhSSraaTn2EcEANt0fR7GXYmTs=;
 b=Js7OzogrD+O0veeKsEWLHzz2ATCa+5upBDnQUSjVTTKZDrnAyGZb6dJ8voID6pR3vKGN+J
 NGGNCtWxW96dVZ0863hyYwfqRGDlMh2BYYkGP0dNAUSd8EYOhNhGTdrJrJREf+TF7xH0/d
 qLiiWZHMh99/lt9kRWwUFIBYAblBHuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701169826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5WyCsV3GHI853TjCrhSSraaTn2EcEANt0fR7GXYmTs=;
 b=IDnK/K9vLE5DxEoIFRNEEmfdGP7Mh+5rJGB0LqXcUgroWiqTw96gjtm6ni9lirOop0+2/x
 E6zVZ9VekJeE9gDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 25448139FC;
 Tue, 28 Nov 2023 11:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 36wjBaLKZWWDcgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 11:10:26 +0000
Date: Tue, 28 Nov 2023 12:10:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <20231128111024.GA364870@pevik>
References: <20230929091401.205277-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230929091401.205277-1-shirisha@linux.ibm.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.00 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpNYXliZSBJJ20gc2xvdywgYnV0IGl0IHdhcyBub3Qgbm90IG9idmlvdXMgZnJvbSB0aGUg
c3ViamVjdCAiTWlncmF0aW5nIHRoZQpsaWJodWdldGxiZnMvdGVzdGNhc2VzL3RydW5jYXRlLmMg
dGVzdCIgdGhhdCB5b3UgbWlncmF0ZSB0ZXN0IGZyb206Cmh0dHBzOi8vZ2l0aHViLmNvbS9saWJo
dWdldGxiZnMvbGliaHVnZXRsYmZzL2Jsb2IvbWFzdGVyL3Rlc3RzL3RydW5jYXRlLmMKCkknZCBw
ZXJzb25hbGx5IGhhdmUgc3ViamVjdAoKQWRkIGh1Z2VtbWFwMzMgKHZlcnkgc29ydCBkZXNjcmlw
dGlvbiBvZiB0aGUgdGVzdCkKCkFuZCB0aGVuIGxhdGVyIG1lbnRpb24gaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlIHRoYXQgdGhlIHRlc3Qgb3JpZ2luYXRlcyBmcm9tCmh0dHBzOi8vZ2l0aHViLmNvbS9s
aWJodWdldGxiZnMvbGliaHVnZXRsYmZzL2Jsb2IvbWFzdGVyL3Rlc3RzL3RydW5jYXRlLmMKCk5P
VEU6IGlmIHlvdSBydW4gdGVzdCBtb3JlIHRpbWVzICgtaU4pLCBpdCBmYWlscywgZS5nLjoKCi4v
aHVnZW1tYXAzMyAtaTIKdHN0X2h1Z2VwYWdlLmM6ODQ6IFRJTkZPOiAxIGh1Z2VwYWdlKHMpIHJl
c2VydmVkCnRzdF90ZXN0LmM6MTAzNzogVElORk86IE1vdW50aW5nIG5vbmUgdG8gL3RtcC9MVFBf
aHVnaVVMVEo3L2h1Z2V0bGJmcyBmc3R5cD1odWdldGxiZnMgZmxhZ3M9MAp0c3RfdGVzdC5jOjE2
OTA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyMzA5MjktMTUyLWdjZTg3YzhkZTMKdHN0X3Rlc3Qu
YzoxNTc0OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKaHVnZW1tYXAzMy5j
OjU2OiBUUEFTUzogRXhwZWN0ZWQgU0lHQlVTIHRyaWdnZXJlZAp0c3RfdGVzdC5jOjE2MzQ6IFRC
Uk9LOiBUZXN0IGtpbGxlZCBieSBTSUdCVVMhCgpDb3VsZCB5b3UgcGxlYXNlIGZpeCBpdD8KCkFs
c28sIHdlIHVzZSBzdGF0aWMgd2hlbmV2ZXIgd2UgY2FuLCBwbGVhc2UgZml4IHRoZXNlOgoKJCBt
YWtlIGNoZWNrLWh1Z2VtbWFwMzMKQ0hFQ0sgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9o
dWdlbW1hcC9odWdlbW1hcDMzLmMKaHVnZW1tYXAzMy5jOjYxOjY6IHdhcm5pbmc6IFN5bWJvbCAn
c2V0dXAnIGhhcyBubyBwcm90b3R5cGUgb3IgbGlicmFyeSAoJ3RzdF8nKSBwcmVmaXguIFNob3Vs
ZCBpdCBiZSBzdGF0aWM/Cmh1Z2VtbWFwMzMuYzo3MTo2OiB3YXJuaW5nOiBTeW1ib2wgJ2NsZWFu
dXAnIGhhcyBubyBwcm90b3R5cGUgb3IgbGlicmFyeSAoJ3RzdF8nKSBwcmVmaXguIFNob3VsZCBp
dCBiZSBzdGF0aWM/Cgo+IFRlc3QgRGVzY3JpcHRpb246ClRoaXMgbGluZSBpcyB1c2VsZXNzLgoK
PiBUZXN0IGlzIHVzZWQgdG8gdmVyaWZ5IHRoZSBjb3JyZWN0IGZ1bmN0aW9uYWxpdHkgYW5kCj4g
Y29tcGF0aWJpbGl0eSBvZiB0aGUgbGlicmFyeSB3aXRoIHRoZSAidHJ1bmNhdGUiIHN5c3RlbQo+
IGNhbGwgd2hlbiBvcGVyYXRpbmcgb24gZmlsZXMgcmVzaWRpbmcgaW4gYSBtb3VudGVkCj4gaHVn
ZSBwYWdlIGZpbGVzeXN0ZW0uCgo+IFNpZ25lZC1vZmYtYnk6IFNoaXJpc2hhIEcgPHNoaXJpc2hh
QGxpbnV4LmlibS5jb20+Cj4gLS0tCj4gdjM6Cj4gIC1BZGRyZXNzZWQgdGhlIGJlbG93IHJlcXVl
c3RlZCBjaGFuZ2VzIAo+ICAgMS4gUmVtb3ZlZCBSQU5ET01fQ09OU1RBTlQKPiAgIDIuIE1hZGUg
aHBhZ2Vfc2l6ZSBhbmQgZmQgdG8gc3RhdGljCj4gICAzLiBVc2VkIGEgdm9sYXRpbGUgdmFyaWFi
bGUgYXMgYSBmbGFnCj4gICAgICB0byBwYXNzIHRlc3QgaW4gdGhlIHJ1bl90ZXN0KCkKPiAgIDQu
IFJlbW92ZWQgdGhlIGZhaWx1cmUgY29uZGl0aW9uIGZvciBTQUZFX01NQVAoKQo+ICAgNS4gSGF2
ZSBzZXR1cCB0aGUgaGFuZGxlciBpbiB0aGUgc2V0dXAoKQo+ICAgNi4gQWRkZWQgU0FGRV9NVU5N
QVAoKQo+ICAgNy4gUmFuIG1ha2UgY2hlY2sgYW5kIGZpeGVkIGFsbCBpc3N1ZXMKPiAtLS0KPiB2
MjoKPiAgLUNvcnJlY3RlZCB0eXBvCj4gLS0tCj4gIHJ1bnRlc3QvaHVnZXRsYiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGln
bm9yZSAgICAgICAgICAgICAgIHwgIDEgKwo+ICAuLi4va2VybmVsL21lbS9odWdldGxiL2h1Z2Vt
bWFwL2h1Z2VtbWFwMzMuYyAgfCA4OCArKysrKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hh
bmdlZCwgOTAgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tl
cm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMzLmMKCj4gZGlmZiAtLWdpdCBhL3J1
bnRlc3QvaHVnZXRsYiBiL3J1bnRlc3QvaHVnZXRsYgo+IGluZGV4IDI5OWMwN2FjOS4uMTMwMGU4
MGZiIDEwMDY0NAo+IC0tLSBhL3J1bnRlc3QvaHVnZXRsYgo+ICsrKyBiL3J1bnRlc3QvaHVnZXRs
Ygo+IEBAIC0zNSw2ICszNSw3IEBAIGh1Z2VtbWFwMjkgaHVnZW1tYXAyOQo+ICBodWdlbW1hcDMw
IGh1Z2VtbWFwMzAKPiAgaHVnZW1tYXAzMSBodWdlbW1hcDMxCj4gIGh1Z2VtbWFwMzIgaHVnZW1t
YXAzMgo+ICtodWdlbW1hcDMzIGh1Z2VtbWFwMzMKPiAgaHVnZW1tYXAwNV8xIGh1Z2VtbWFwMDUg
LW0KPiAgaHVnZW1tYXAwNV8yIGh1Z2VtbWFwMDUgLXMKPiAgaHVnZW1tYXAwNV8zIGh1Z2VtbWFw
MDUgLXMgLW0KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSBi
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKPiBpbmRleCA3MjU4NDg5ZWQuLmQxMzBk
NGRjZCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCj4gKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQo+IEBAIC0zNCw2ICszNCw3IEBACj4g
IC9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzAKPiAgL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1t
YXAzMQo+ICAvaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMyCj4gKy9odWdldGxiL2h1Z2VtbWFw
L2h1Z2VtbWFwMzMKPiAgL2h1Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDAxCj4gIC9odWdldGxi
L2h1Z2VzaG1hdC9odWdlc2htYXQwMgo+ICAvaHVnZXRsYi9odWdlc2htYXQvaHVnZXNobWF0MDMK
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdl
bW1hcDMzLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFw
MzMuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi4zNDA1NjI3ZjYK
PiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdl
bW1hcC9odWdlbW1hcDMzLmMKPiBAQCAtMCwwICsxLDg4IEBACj4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAoQykgMjAw
NS0yMDA2IElCTSBDb3Jwb3JhdGlvbi4KTWF5YmUgYWxzbyB5b3VyIG9yIExUUCBjb3B5cmlnaHQg
aGVyZSwgYXMgY2xlYXJseSB0aGVyZSBpcyBMVFAgc3BlY2lmaWMgY29kZS4KCj4gKyAqIEF1dGhv
cjogRGF2aWQgR2lic29uICYgQWRhbSBMaXRrZQo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKiBbRGVz
Y3JpcHRpb25dCj4gKyAqCj4gKyAqIFRlc3QgTmFtZTogdHJ1bmNhdGUKVGhpcyBpcyB3cm9uZyBh
bmQgdXNlbGVzcywgcGxlYXNlIHJlbW92ZSBpdC4KPiArICoKPiArICogVGVzdCBjYXNlIGlzIHVz
ZWQgdG8gdmVyaWZ5IHRoZSBjb3JyZWN0IGZ1bmN0aW9uYWxpdHkKPiArICogYW5kIGNvbXBhdGli
aWxpdHkgb2YgdGhlIGxpYnJhcnkgd2l0aCB0aGUgInRydW5jYXRlIiBzeXN0ZW0gY2FsbCB3aGVu
Cj4gKyAqIG9wZXJhdGluZyBvbiBmaWxlcyByZXNpZGluZyBpbiBhIG1vdW50ZWQgaHVnZSBwYWdl
IGZpbGVzeXN0ZW0uCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgImh1Z2V0bGIuaCIKPiArI2luY2x1
ZGUgPHNldGptcC5oPgo+ICsjaW5jbHVkZSA8c2lnbmFsLmg+Cj4gKwo+ICsjZGVmaW5lIE1OVFBP
SU5UICJodWdldGxiZnMvIgo+ICsKPiArc3RhdGljIGxvbmcgaHBhZ2Vfc2l6ZTsKPiArc3RhdGlj
IGludCBmZDsKPiArc3RhdGljIHNpZ2ptcF9idWYgc2lnX2VzY2FwZTsKPiArc3RhdGljIHZvbGF0
aWxlIGludCB0ZXN0X3Bhc3M7Cj4gK3N0YXRpYyBpbnQgc2lnYnVzX2NvdW50Owo+ICsKPiArc3Rh
dGljIHZvaWQgc2lnYnVzX2hhbmRsZXIoaW50IHNpZ251bSkKCmh1Z2VtbWFwMzMuYzoyOTozMjog
d2FybmluZzogdW51c2VkIHBhcmFtZXRlciDigJhzaWdudW3igJkgWy1XdW51c2VkLXBhcmFtZXRl
cl0KICAgMjkgfCBzdGF0aWMgdm9pZCBzaWdidXNfaGFuZGxlcihpbnQgc2lnbnVtKQoKVGhlcmVm
b3JlIHVzZQpzdGF0aWMgdm9pZCBzaWdidXNfaGFuZGxlcihpbnQgc2lnbnVtIExUUF9BVFRSSUJV
VEVfVU5VU0VEKQoKPiArewo+ICsJdGVzdF9wYXNzID0gMTsKPiArCXNpZ2xvbmdqbXAoc2lnX2Vz
Y2FwZSwgMTcpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBydW5fdGVzdCh2b2lkKQo+ICt7Cj4g
Kwl2b2lkICpwOwo+ICsJdm9sYXRpbGUgdW5zaWduZWQgaW50ICpxOwo+ICsKPiArCXNpZ2J1c19j
b3VudCA9IDA7Cj4gKwl0ZXN0X3Bhc3MgPSAwOwo+ICsJaW50IGVycjsKPiArCj4gKwlwID0gU0FG
RV9NTUFQKE5VTEwsIGhwYWdlX3NpemUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfU0hBUkVE
LAo+ICsJCQlmZCwgMCk7Cj4gKwlxID0gcDsKPiArCSpxID0gMDsKPiArCWVyciA9IGZ0cnVuY2F0
ZShmZCwgMCk7CkJsYW5rIGxpbmUgaGVyZSB3b3VsZCBoZWxwIHJlYWRhYmlsaXR5LgoKPiArCWlm
IChlcnIpCj4gKwkJdHN0X3JlcyhURkFJTCwgImZ0cnVuY2F0ZSBmYWlsZWQiKTsKQWxzbyBoZXJl
Lgo+ICsJaWYgKHNpZ3NldGptcChzaWdfZXNjYXBlLCAxKSA9PSAwKQo+ICsJCSpxOwo+ICsJZWxz
ZQo+ICsJCXNpZ2J1c19jb3VudCsrOwpBbmQgaGVyZS4KPiArCWlmIChzaWdidXNfY291bnQgIT0g
MSkKPiArCQl0c3RfcmVzKFRGQUlMLCAiRGlkbid0IFNJR0JVUyIpOwpBbmQgaGVyZS4KPiArCWlm
ICh0ZXN0X3Bhc3MgPT0gMSkKPiArCQl0c3RfcmVzKFRQQVNTLCAiRXhwZWN0ZWQgU0lHQlVTIHRy
aWdnZXJlZCIpOwpBbmQgaGVyZS4KPiArCVNBRkVfTVVOTUFQKHAsIGhwYWdlX3NpemUpOwo+ICt9
CgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
