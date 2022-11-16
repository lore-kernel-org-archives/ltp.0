Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20F8C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 15:45:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6E03C7611
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 16:45:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E0273C06C8
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:45:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1AD26008E6
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:45:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23C6622DC9;
 Wed, 16 Nov 2022 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668613508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGHs5ibd+nPvPIhuMwv4wJCJn7OQpY6mGmNXY9TPrkE=;
 b=sq3IJdFgywI9IXFPHO3NHcEkuIprawxBGRFuLbM0Ih9QvW9OZRiU1F30MGZlWsp+zmi2Xp
 Z+pWe2+zMowN5Dfb8Nqa8WRU6GX/Kty1rCv9TNhzd4HS++QjTxxIO/jSRzwfhhPjcmUdFd
 Tk8ptvirVlVm2Q4Kwtp8sF+rGh15m8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668613508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGHs5ibd+nPvPIhuMwv4wJCJn7OQpY6mGmNXY9TPrkE=;
 b=RkGMuLLlB6Sylkv3NWLQz3Ct0zR3Uuj9GPt7E+lwE7bfeNWQMEQi8oy3l5BVmoAf3tml5Z
 TxNnkUUSryauuXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FC66134CE;
 Wed, 16 Nov 2022 15:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gL36AoQFdWPfdQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Nov 2022 15:45:08 +0000
Date: Wed, 16 Nov 2022 16:46:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y3UF2Jgkf0Svj7lm@yuki>
References: <20221116145411.21299-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116145411.21299-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] save_restore: Introduce new struct field for
 flags
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

SGkhCj4gKyogJ1RTVF9TUl9UQlJPS19NSVNTSU5HJyDigJMgRW5kIHRlc3Qgd2l0aCAnVEJST0sn
IGlmIHRoZSBmaWxlIGRvZXMgbm90IGV4aXN0Cj4gKyogJ1RTVF9TUl9UQ09ORl9NSVNTSU5HJyDi
gJMgRW5kIHRlc3Qgd2l0aCAnVENPTkYnIGlmIHRoZSBmaWxlIGRvZXMgbm90IGV4aXN0Cj4gKyog
J1RTVF9TUl9TS0lQX01JU1NJTkcnIOKAkyBDb250aW51ZSB3aXRob3V0IHNhdmluZyB0aGUgZmls
ZSBpZiBpdCBkb2VzIG5vdCBleGlzdAo+ICsqICdUU1RfU1JfVEJST0tfUk8nIOKAkyBFbmQgdGVz
dCB3aXRoICdUQlJPSycgaWYgdGhlIGZpbGUgaXMgcmVhZC1vbmx5Cj4gKyogJ1RTVF9TUl9UQ09O
Rl9STycg4oCTIEVuZCB0ZXN0IHdpdGggJ1RDT05GJyBpZiB0aGUgZmlsZSBpcyByZWFkLW9ubHkK
PiArKiAnVFNUX1NSX1NLSVBfUk8nIOKAkyBDb250aW51ZSB3aXRob3V0IHNhdmluZyB0aGUgZmls
ZSBpZiBpdCBpcyByZWFkLW9ubHkKPiArKiAnVFNUX1NSX0lHTk9SRV9FUlInIOKAkyBJZ25vcmUg
ZXJyb3JzIHdoZW4gd3JpdGluZyBuZXcgdmFsdWUgaW50byB0aGUgZmlsZQo+ICsKPiArQ29tbW9u
IGZsYWcgY29tYmluYXRpb25zIGFsc28gaGF2ZSBzaG9ydGN1dHM6Cj4gKwo+ICsqICdUU1RfU1Jf
VENPTkYnIOKAkyBFcXVpdmFsZW50IHRvICdUU1RfU1JfVENPTkZfTUlTU0lORyB8IFRTVF9TUl9U
Q09ORl9STycKPiArKiAnVFNUX1NSX1RCUk9LJyDigJMgRXF1aXZhbGVudCB0byAnVFNUX1NSX1RC
Uk9LX01JU1NJTkcgfCBUU1RfU1JfVEJST0tfUk8nCj4gKyogJ1RTVF9TUl9TS0lQJyDigJMgRXF1
aXZhbGVudCB0byAnVFNUX1NSX1NLSVBfTUlTU0lORyB8IFRTVF9TUl9TS0lQX1JPJwoKVGhpcyBs
b29rcyBnb29kIG5vdywgZ3JlYXQgd29yayEKCj4gICdyZXN0b3JlJyBpcyBhbHdheXMgc3RyaWN0
IGFuZCB3aWxsIFRXQVJOIGlmIGl0IGVuY291bnRlcnMgYW55IGVycm9yLgo+ICAKPiAgW3NvdXJj
ZSxjXQo+ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gLXN0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Cj4gLXsKPiAtCUZJTEVfUFJJTlRGKCIvcHJvYy9zeXMva2VybmVsL2NvcmVfcGF0dGVybiIsICIv
bXlwYXRoIik7Cj4gLQlTQUZFX1RSWV9GSUxFX1BSSU5URigiL3Byb2Mvc3lzL3VzZXIvbWF4X3Vz
ZXJfbmFtZXNwYWNlcyIsICIlZCIsIDEwKTsKPiAtfQo+IC0KPiAgc3RhdGljIHN0cnVjdCB0c3Rf
dGVzdCB0ZXN0ID0gewo+ICAJLi4uCj4gIAkuc2V0dXAgPSBzZXR1cCwKPiAgCS5zYXZlX3Jlc3Rv
cmUgPSAoY29uc3Qgc3RydWN0IHRzdF9wYXRoX3ZhbFtdKSB7Cj4gLQkJeyIvcHJvYy9zeXMva2Vy
bmVsL2NvcmVfcGF0dGVybiIsIE5VTEx9LAo+IC0JCXsiPy9wcm9jL3N5cy91c2VyL21heF91c2Vy
X25hbWVzcGFjZXMiLCBOVUxMfSwKPiAtCQl7IiEvc3lzL2tlcm5lbC9tbS9rc20vcnVuIiwgIjEi
fSwKPiArCQl7Ii9wcm9jL3N5cy9rZXJuZWwvY29yZV9wYXR0ZXJuIiwgTlVMTCwgVFNUX1NSX1RD
T05GfSwKPiArCQl7Ii9wcm9jL3N5cy91c2VyL21heF91c2VyX25hbWVzcGFjZXMiLCBOVUxMLCBU
U1RfU1JfU0tJUH0sCj4gKwkJeyIvc3lzL2tlcm5lbC9tbS9rc20vcnVuIiwgIjEiLCBUU1RfU1Jf
VEJST0t9LAo+ICAJCXt9Cj4gIAl9LAo+ICB9Owo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9z
eXNfY29uZi5oIGIvaW5jbHVkZS90c3Rfc3lzX2NvbmYuaAo+IGluZGV4IGI3YmJlMzZmYy4uNGM4
NTc2N2JlIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X3N5c19jb25mLmgKPiArKysgYi9pbmNs
dWRlL3RzdF9zeXNfY29uZi5oCj4gQEAgLTUsMTQgKzUsMjYgQEAKPiAgI2lmbmRlZiBUU1RfU1lT
X0NPTkZfSF9fCj4gICNkZWZpbmUgVFNUX1NZU19DT05GX0hfXwo+ICAKPiArI2RlZmluZSBUU1Rf
U1JfVENPTkZfTUlTU0lORyAweDAKPiArI2RlZmluZSBUU1RfU1JfVEJST0tfTUlTU0lORyAweDEK
PiArI2RlZmluZSBUU1RfU1JfU0tJUF9NSVNTSU5HIDB4Mgo+ICsjZGVmaW5lIFRTVF9TUl9UQ09O
Rl9STyAweDAKPiArI2RlZmluZSBUU1RfU1JfVEJST0tfUk8gMHg0Cj4gKyNkZWZpbmUgVFNUX1NS
X1NLSVBfUk8gMHg4Cj4gKyNkZWZpbmUgVFNUX1NSX0lHTk9SRV9FUlIgMHgxMAo+ICsKPiArI2Rl
ZmluZSBUU1RfU1JfVENPTkYgKFRTVF9TUl9UQ09ORl9NSVNTSU5HIHwgVFNUX1NSX1RDT05GX1JP
KQo+ICsjZGVmaW5lIFRTVF9TUl9UQlJPSyAoVFNUX1NSX1RCUk9LX01JU1NJTkcgfCBUU1RfU1Jf
VEJST0tfUk8pCj4gKyNkZWZpbmUgVFNUX1NSX1NLSVAgKFRTVF9TUl9TS0lQX01JU1NJTkcgfCBU
U1RfU1JfU0tJUF9STykKPiArCj4gIHN0cnVjdCB0c3RfcGF0aF92YWwgewo+ICAgICAgICAgIGNv
bnN0IGNoYXIgKnBhdGg7Cj4gICAgICAgICAgY29uc3QgY2hhciAqdmFsOwo+ICsJdW5zaWduZWQg
aW50IGZsYWdzOwo+ICB9Owo+ICAKPiAtaW50IHRzdF9zeXNfY29uZl9zYXZlX3N0cihjb25zdCBj
aGFyICpwYXRoLCBjb25zdCBjaGFyICp2YWx1ZSk7Cj4gLWludCB0c3Rfc3lzX2NvbmZfc2F2ZShj
b25zdCBjaGFyICpwYXRoKTsKPiAtdm9pZCB0c3Rfc3lzX2NvbmZfc2V0KGNvbnN0IGNoYXIgKnBh
dGgsIGNvbnN0IGNoYXIgKnZhbHVlKTsKPiArdm9pZCB0c3Rfc3lzX2NvbmZfc2F2ZV9zdHIoY29u
c3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqdmFsdWUpOwo+ICtpbnQgdHN0X3N5c19jb25mX3Nh
dmUoY29uc3Qgc3RydWN0IHRzdF9wYXRoX3ZhbCAqY29uZik7Cj4gIHZvaWQgdHN0X3N5c19jb25m
X3Jlc3RvcmUoaW50IHZlcmJvc2UpOwo+ICB2b2lkIHRzdF9zeXNfY29uZl9kdW1wKHZvaWQpOwo+
ICAKPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9zeXNfY29uZi5jIGIvbGliL3RzdF9zeXNfY29uZi5j
Cj4gaW5kZXggMDAzNjk4ODI1Li43OGVkNTc3ZTIgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9zeXNf
Y29uZi5jCj4gKysrIGIvbGliL3RzdF9zeXNfY29uZi5jCj4gQEAgLTIwLDYgKzIwLDE0IEBAIHN0
cnVjdCB0c3Rfc3lzX2NvbmYgewo+ICAKPiAgc3RhdGljIHN0cnVjdCB0c3Rfc3lzX2NvbmYgKnNh
dmVfcmVzdG9yZV9kYXRhOwo+ICAKPiArc3RhdGljIHZvaWQgcHJpbnRfZXJyb3IoaW50IGluZm9f
b25seSwgY29uc3QgY2hhciAqZXJyLCBjb25zdCBjaGFyICpwYXRoKQo+ICt7Cj4gKwlpZiAoaW5m
b19vbmx5KQo+ICsJCXRzdF9yZXMoVElORk8gfCBURVJSTk8sIGVyciwgcGF0aCk7Cj4gKwllbHNl
Cj4gKwkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgZXJyLCBwYXRoKTsKPiArfQoKSWYgSSByZW1t
ZWJlciBjb3JyZWN0bHkgSSBkaWQgYXNrIGZvciB0aGlzIHRvIGJlY29tZSBhIG1hY3JvIG9yIHBh
c3MKX19MSU5FX18gc28gdGhhdCB3ZSBoYXZlIGEgY29ycmVjdCBsaW5lcyBpbiB0aGUgZXJyb3Ig
b3V0cHV0IGFuZCB5b3UKaGF2ZW4ndCBjb21tZW50ZWQgb24gdGhhdC4KCk90aGVyd2lzZSB0aGUg
cmVzdCBsb29rcyBnb29kIHRvIG1lLgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
