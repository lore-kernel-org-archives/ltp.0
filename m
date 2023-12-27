Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6624C46CD4
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 14:29:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBB273CC120
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 15:29:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8848E3C94EA
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 15:28:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E00F96008F9
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 15:28:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34C4D1F383;
 Wed, 27 Dec 2023 14:28:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4C8413635;
 Wed, 27 Dec 2023 14:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WfsgNqc0jGVNMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 Dec 2023 14:28:55 +0000
Date: Wed, 27 Dec 2023 15:28:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231227142850.GA757946@pevik>
References: <20231227065118.209595-1-shichen@redhat.com>
 <20231227091039.GA727588@pevik>
 <CAEemH2fm47fhXBJd_3GBopqZPMCEVhFYM7Wrw-pukOtBn_Jnow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fm47fhXBJd_3GBopqZPMCEVhFYM7Wrw-pukOtBn_Jnow@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 34C4D1F383
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tools: Fix syntax error caused by "; ;
 " in create_dmesg_entry awk script
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
Cc: Shizhao Chen <shichen@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLCBTaGl6aGFvLAoKPiBPbiBXZWQsIERlYyAyNywgMjAyMyBhdCA1OjEw4oCvUE0g
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIFNoaXpoYW8sCgo+ID4g
PiBXaGVuIHJ1bm5pbmcgcnVubHRwIHdpdGggYm90aCAtUyBhbmQgLUsgcHJvdmlkZWQsIHRlc3Rz
IHRoYXQgYXJlCj4gPiBzdXBwb3NlZCB0byBiZQo+ID4gPiAic2tpcHBlZCIgYW5kIHJlcG9ydCBU
Q09ORiByZXN1bHRzIHdlcmUgZmFpbGluZyBkdWUgdG8gYW4gdW5leHBlY3RlZAo+ID4gc2VtaWNv
bG9uCj4gPiA+IGF0IHRoZSBlbmQgb2YgdGhlIGNvbnN0cnVjdGVkIGNvbW1hbmQuCgo+ID4gPiBg
LVNgIHJlcGxhY2UgdGhlIHRlc3QgY29tbWFuZCB3aXRoIGBleGl0IDMyO2AKPiA+ID4gYC1LYCBh
cHBlbmRzIGFub3RoZXIgc2VtaWNvbG9uIHRvIHRoZSBjb21tYW5kIHRoZW4gd2UgZ2V0IGBleGl0
IDMyOztgCgo+ID4gPiBGb3IgZXhhbXBsZToKCj4gPiA+ICAgPj4+IDc4MDptYWR2aXNlMDZfX3dp
dGhfZG1lc2dfZW50cnkgQlJPSyA8PDwKCj4gPiA+ICAgICAgICAxICAgICAgPDw8dGVzdF9zdGFy
dD4+Pgo+ID4gPiAgICAgICAgMiAgICAgIHRhZz1tYWR2aXNlMDZfX3dpdGhfZG1lc2dfZW50cnkg
c3RpbWU9MTcwMzU1NjA2MQo+ID4gPiAgICAgICAgMyAgICAgIGNtZGxpbmU9ImRtZXNnIC1jIDE+
L2Rldi9udWxsIDI+JjE7IGV4aXQgMzI7OyBkbWVzZyA+Cj4gPiAvbW50L3Rlc3RhcmVhL2x0cC9v
dXRwdXQvRE1FU0dfRElSX1JIRUxLVDFMSVRFLkZJTFRFUkVELWRtZXNnLW91dHB1dC01MzEyNy0w
ODo0ODoyM1BNL21hZHZpc2UwNi5kbWVzZy5sb2ciCj4gPiA+ICAgICAgICA0ICAgICAgY29udGFj
dHM9IiIKPiA+ID4gICAgICAgIDUgICAgICBhbmFseXNpcz1leGl0Cj4gPiA+ICAgICAgICA2ICAg
ICAgPDw8dGVzdF9vdXRwdXQ+Pj4KPiA+ID4gICAgICAgIDcgICAgICBzaDogLWM6IGxpbmUgMTog
c3ludGF4IGVycm9yIG5lYXIgdW5leHBlY3RlZCB0b2tlbiBgOzsnCj4gPiA+ICAgICAgICA4ICAg
ICAgc2g6IC1jOiBsaW5lIDE6IGBkbWVzZyAtYyAxPi9kZXYvbnVsbCAyPiYxOyBleGl0IDMyOzsK
PiA+IGRtZXNnID4KPiA+IC9tbnQvdGVzdGFyZWEvbHRwL291dHB1dC9ETUVTR19ESVJfUkhFTEtU
MUxJVEUuRklMVEVSRUQtZG1lc2ctb3V0cHV0LTUzMTI3LTA4OjQ4OjIzUE0vbWFkdmlzZTA2LmRt
ZXNnLmxvZycKPiA+ID4gICAgICAgIDkgICAgICA8PDxleGVjdXRpb25fc3RhdHVzPj4+Cj4gPiA+
ICAgICAgIDEwICAgICAgaW5pdGlhdGlvbl9zdGF0dXM9Im9rIgo+ID4gPiAgICAgICAxMSAgICAg
IGR1cmF0aW9uPTAgdGVybWluYXRpb25fdHlwZT1leGl0ZWQgdGVybWluYXRpb25faWQ9Mgo+ID4g
Y29yZWZpbGU9bm8KPiA+ID4gICAgICAgMTIgICAgICBjdXRpbWU9MCBjc3RpbWU9MQo+ID4gPiAg
ICAgICAxMyAgICAgIDw8PHRlc3RfZW5kPj4+Cgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl6aGFv
IENoZW4gPHNoaWNoZW5AcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICB0b29scy9jcmVhdGVf
ZG1lc2dfZW50cmllc19mb3JfZWFjaF90ZXN0LmF3ayB8IDEgKwo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspCgo+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvY3JlYXRlX2RtZXNn
X2VudHJpZXNfZm9yX2VhY2hfdGVzdC5hd2sKPiA+IGIvdG9vbHMvY3JlYXRlX2RtZXNnX2VudHJp
ZXNfZm9yX2VhY2hfdGVzdC5hd2sKPiA+ID4gaW5kZXggMjVkNzUwYTU1Li43YTIyYmI0YTYgMTAw
NjQ0Cj4gPiA+IC0tLSBhL3Rvb2xzL2NyZWF0ZV9kbWVzZ19lbnRyaWVzX2Zvcl9lYWNoX3Rlc3Qu
YXdrCj4gPiA+ICsrKyBiL3Rvb2xzL2NyZWF0ZV9kbWVzZ19lbnRyaWVzX2Zvcl9lYWNoX3Rlc3Qu
YXdrCj4gPiA+IEBAIC0yNyw2ICsyNyw3IEBAIE5GICYmICEgL14jLyB7Cj4gPiA+ICAgICAgIGZv
ciAoaSA9IDI7IGkgPD0gTkY7IGkrKykgewo+ID4gPiAgICAgICAgICAgICAgIHMgPSBzICIgIiAk
aQo+ID4gPiAgICAgICB9Cj4gPiA+ICsgICAgIHN1YigvOyQvLCAiIiwgcykKCj4gPiBGcm9tIHRo
ZSBhYm92ZSBjb250ZXh0IGFyZSB5b3Ugc3VyZSB0aGF0IHRoZXJlIHdpbGwgbm90IGJlIG1pc3Np
bmcKPiA+IHNlbWljb2xvbj8KPiA+IChlLmcuIGJldHdlZW4gZG1lc2cgYW5kIGV4aXQpCgo+ID4g
V291bGRuJ3QgaXQgYmUgc2FmZSB0byBtYWtlIHN1cmUgdGhlcmUgaXMgb25seSBvbmx5IHNpbmds
ZSBzZW1pY29sb24gYXQKPiA+IHRoZSBlbmQ/CgoKPiA+IHN1YigvWztdKyQvLCAiOyIpCgoKPiBI
bW0sIHRoYXQgd291bGQgbm90IHdvcmsgYXMgZXhwZWN0ZWQgYmVjYXVzZSBpbiB0aGUgbmV4dCBs
aW5lCj4gZm9yY2VzIGFkZGluZyBhIHNlbWljb2xvbi4KCj4gICAgIHMgPSBzICI7IGRtZXNnID4g
IiBETUVTR19ESVIgIi8iICQxICIuZG1lc2cubG9nIgoKPiBVbmxlc3Mgd2UgbWFrZSBhIG1pbm9y
IGFkanVzdG1lbnRzIHRvIHlvdXIgdmVyc2lvbjoKCj4gICAgIHN1YigvWztdKyQvLCAiIiwgcykK
CkFoLCB0aGFua3MgTGkhCgpJJ20gb2sgdG8gbWVyZ2UgeW91ciBzdWdnZXN0aW9uLCBqdXN0IHdh
aXQgbGl0dGxlIGxvbmdlciBmb3IgU2hpemhhbywgaW4gY2FzZSB3ZQpvdmVybG9va2VkIHNvbWV0
aGluZy4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBPdGhlcndpc2UgTEdUTToKPiBSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
