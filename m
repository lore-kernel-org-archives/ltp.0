Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D488C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 13:24:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 100CA3CD267
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 14:24:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F0263CD213
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 14:24:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE7121A0088D
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 14:24:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4463122A20;
 Mon, 14 Nov 2022 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668432250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdNqHVhjWYN5IuiTIRsNLQhID2Wt4klcHGt97Yu/aFs=;
 b=29XoeCTE/7g9Jwjbs36nUsrYcpY5Wk2QX9cO8nLD06K5VZnVJr+WOh1ldZCznjC/yG3xJ1
 M9ZdYxsGMTFl8jnGzGtJ/UeDfDxRcJvh4ayL7wB9kKg2rshBcyrwtnO1FlKNGr2JbaiD02
 LL2XiMfwdiBWvM11Zm6SNSy5X5lTlpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668432250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdNqHVhjWYN5IuiTIRsNLQhID2Wt4klcHGt97Yu/aFs=;
 b=Sp+KPSoZqZb+5msq6mE9qZis/F0QNn01Q6qYiTfFAmmJSFd2EWHIVLEan14J95+fxgjKZ4
 nRFZ6kU38rBVI7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DE0113A8C;
 Mon, 14 Nov 2022 13:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eb3xCXpBcmMARgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 14 Nov 2022 13:24:10 +0000
Date: Mon, 14 Nov 2022 14:25:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y3JBzeBst/HufYqu@yuki>
References: <20221114093233.4668-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114093233.4668-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] save_restore: Introduce new struct field for
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

SGkhCj4gZGlmZiAtLWdpdCBhL2RvYy9jLXRlc3QtYXBpLnR4dCBiL2RvYy9jLXRlc3QtYXBpLnR4
dAo+IGluZGV4IDg4NDRkOWYyZi4uZmE3ZTJkM2IwIDEwMDY0NAo+IC0tLSBhL2RvYy9jLXRlc3Qt
YXBpLnR4dAo+ICsrKyBiL2RvYy9jLXRlc3QtYXBpLnR4dAo+IEBAIC0xNjA1LDM1ICsxNjA1LDMz
IEBAIExUUCBsaWJyYXJ5IGNhbiBiZSBpbnN0cnVjdGVkIHRvIHNhdmUgYW5kIHJlc3RvcmUgdmFs
dWUgb2Ygc3BlY2lmaWVkCj4gIGZpZWxkICdzYXZlX3Jlc3RvcmUnLiBJdCBpcyBhIE5VTEwtdGVy
bWluYXRlZCBhcnJheSBvZiBzdHJ1Y3QKPiAgJ3RzdF9wYXRoX3ZhbCcgd2hlcmUgZWFjaCB0c3Rf
cGF0aF92YWwucGF0aCByZXByZXNlbnRzIGEgZmlsZSwgd2hvc2UKPiAgdmFsdWUgaXMgc2F2ZWQg
YXQgdGhlIGJlZ2lubmluZyBhbmQgcmVzdG9yZWQgYXQgdGhlIGVuZCBvZiB0aGUgdGVzdC4KPiAt
SWYgbm9uLU5VTEwgdmFsdWUgaXMgcGFzc2VkIGl0IGlzIHdyaXR0ZW4gdG8gdGhlIHJlc3BlY3Rp
dmUgZmlsZSBhdAo+IC10aGUgYmVnaW5uaW5nIG9mIHRoZSB0ZXN0LiBPbmx5IHRoZSBmaXJzdCBs
aW5lIG9mIGEgc3BlY2lmaWVkIGZpbGUKPiAtaXMgc2F2ZWQgYW5kIHJlc3RvcmVkLgo+IC0KPiAt
UGF0aG5hbWVzIGNhbiBiZSBvcHRpb25hbGx5IHByZWZpeGVkIHRvIHNwZWNpZnkgaG93IHN0cmlj
dGx5IChkdXJpbmcKPiAtJ3N0b3JlJykgYXJlIGhhbmRsZWQgZXJyb3JzOgo+IC0KPiAtKiAobm8g
cHJlZml4KSAtIHRlc3QgZW5kcyB3aXRoICdUQ09ORicsIGlmIGZpbGUgZG9lc24ndCBleGlzdAo+
IC0qICc/JyAgICAgICAgIC0gdGVzdCBwcmludHMgaW5mbyBtZXNzYWdlIGFuZCBjb250aW51ZXMs
Cj4gLSAgICAgICAgICAgICAgICBpZiBmaWxlIGRvZXNuJ3QgZXhpc3Qgb3Igb3Blbi9yZWFkIGZh
aWxzCj4gLSogJyEnICAgICAgICAgLSB0ZXN0IGVuZHMgd2l0aCAnVEJST0snLCBpZiBmaWxlIGRv
ZXNuJ3QgZXhpc3QKPiArSWYgbm9uLU5VTEwgc3RyaW5nIGlzIHBhc3NlZCBpbiB0c3RfcGF0aF92
YWwudmFsLCBpdCBpcyB3cml0dGVuCj4gK3RvIHRoZSByZXNwZWN0aXZlIGZpbGUgYXQgdGhlIGJl
Z2lubmluZyBvZiB0aGUgdGVzdC4gT25seSB0aGUgZmlyc3QgbGluZQo+ICtvZiBhIHNwZWNpZmll
ZCBmaWxlIGlzIHNhdmVkIGFuZCByZXN0b3JlZC4KPiArCj4gK0J5IGRlZmF1bHQsIHRoZSB0ZXN0
IHdpbGwgZW5kIHdpdGggVENPTkYgaWYgdGhlIGZpbGUgaXMgcmVhZC1vbmx5IG9yCj4gK2RvZXMg
bm90IGV4aXN0LiBJZiB0aGUgb3B0aW9uYWwgd3JpdGUgb2YgbmV3IHZhbHVlIGZhaWxzLCB0aGUg
dGVzdCB3aWxsIGVuZAo+ICt3aXRoICdUQlJPSycuIFRoaXMgYmVoYXZpb3IgY2FuIGJlIGNoYW5n
ZWQgdXNpbmcgdHN0X3BhdGhfdmFsLmZsYWdzOgoKSSdtIG5vdCBzdXJlIGlmIGl0J3MgYSBnb29k
IGlkZWEgdG8gaGF2ZSBkZWZhdWx0IHdpdGhvdXQgYW55IGNvbnN0YW50cwpwYXNzZWQuIFdoZW4g
SSBsb29rIGF0IHRoZSBmaWxlX3Jlc3RvcmUgcmVjb3JkcyBpbiB0aGUgdGVzdHMgaXQgYWxsCm1h
a2VzIHNlbnNlIHVudGlsIEkgcmVhY2ggYSBwYXJ0IHdoZXJlIDAgaXMgcGFzc2VkIHRvIHRoZSBm
bGFncy4gSSB0aGluawp0aGF0IGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gbWFrZSBldmVyeXRoaW5n
IGFzIHNlbGYgZGVzY3JpYmluZyBhcwpwb3NzaWJsZS4KCldvdWxkIHlvdSBjb25zaWRlciBhZGRp
bmcgVFNUX1NSX1RDT05GX01JU1NJTkcgYW5kIFRTVF9TUl9UQ09ORl9STz8KCj4gKyogJ1RTVF9T
Ul9GQUlMX01JU1NJTkcnIOKAkyBFbmQgdGVzdCB3aXRoICdUQlJPSycgaWYgdGhlIGZpbGUgZG9l
cyBub3QgZXhpc3QKClRoaXMgRkFJTCBwYXJ0IGluIHRoaXMgbmFtZSBpcyBxdWl0ZSBtaXNsZWFk
aW5nIHNpbmNlIHRoZSB0ZXN0IGVuZHMgd2l0aApUQlJPSy4gSSB3b3VsZCBzYXkgdGhhdCBpdCB3
b3VsZCBiZSBtdWNoIG1vcmUgY2xlYXIgaWYgaXQgd2FzIG5hbWVkClRTVF9TUl9UQlJPS19NSVNT
SU5HLgoKPiArKiAnVFNUX1NSX1NLSVBfTUlTU0lORycg4oCTIENvbnRpbnVlIHdpdGhvdXQgc2F2
aW5nIHRoZSBmaWxlIGlmIGl0IGRvZXMgbm90IGV4aXN0Cj4gKyogJ1RTVF9TUl9GQUlMX1JPJyDi
gJMgRW5kIHRlc3Qgd2l0aCAnVEJST0snIGlmIHRoZSBmaWxlIGlzIHJlYWQtb25seQo+ICsqICdU
U1RfU1JfU0tJUF9STycg4oCTIENvbnRpbnVlIHdpdGhvdXQgc2F2aW5nIHRoZSBmaWxlIGlmIGl0
IGlzIHJlYWQtb25seQo+ICsqICdUU1RfU1JfSUdOT1JFX0VSUicg4oCTIElnbm9yZSBlcnJvcnMg
d2hlbiB3cml0aW5nIG5ldyB2YWx1ZSBpbnRvIHRoZSBmaWxlCj4gKyogJ1RTVF9TUl9SRVFVSVJF
RCcg4oCTIEVxdWl2YWxlbnQgdG8gJ1RTVF9TUl9GQUlMX01JU1NJTkcgfCBUU1RfU1JfRkFJTF9S
TycKPiArKiAnVFNUX1NSX0NPTkRfQUNDRVNTJyDigJMgRXF1aXZhbGVudCB0byAnVFNUX1NSX1NL
SVBfTUlTU0lORyB8IFRTVF9TUl9TS0lQX1JPJwo+ICAKPiAgJ3Jlc3RvcmUnIGlzIGFsd2F5cyBz
dHJpY3QgYW5kIHdpbGwgVFdBUk4gaWYgaXQgZW5jb3VudGVycyBhbnkgZXJyb3IuCj4gIAo+ICBb
c291cmNlLGNdCj4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAtc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKPiAtewo+IC0JRklMRV9QUklOVEYoIi9wcm9jL3N5cy9rZXJuZWwvY29yZV9wYXR0ZXJu
IiwgIi9teXBhdGgiKTsKPiAtCVNBRkVfVFJZX0ZJTEVfUFJJTlRGKCIvcHJvYy9zeXMvdXNlci9t
YXhfdXNlcl9uYW1lc3BhY2VzIiwgIiVkIiwgMTApOwo+IC19Cj4gLQo+ICBzdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7Cj4gIAkuLi4KPiAgCS5zZXR1cCA9IHNldHVwLAo+ICAJLnNhdmVf
cmVzdG9yZSA9IChjb25zdCBzdHJ1Y3QgdHN0X3BhdGhfdmFsW10pIHsKPiAtCQl7Ii9wcm9jL3N5
cy9rZXJuZWwvY29yZV9wYXR0ZXJuIiwgTlVMTH0sCj4gLQkJeyI/L3Byb2Mvc3lzL3VzZXIvbWF4
X3VzZXJfbmFtZXNwYWNlcyIsIE5VTEx9LAo+IC0JCXsiIS9zeXMva2VybmVsL21tL2tzbS9ydW4i
LCAiMSJ9LAo+ICsJCXsiL3Byb2Mvc3lzL2tlcm5lbC9jb3JlX3BhdHRlcm4iLCBOVUxMLCAwfSwK
PiArCQl7Ii9wcm9jL3N5cy91c2VyL21heF91c2VyX25hbWVzcGFjZXMiLCBOVUxMLCBUU1RfU1Jf
Q09ORF9BQ0NFU1N9LAo+ICsJCXsiL3N5cy9rZXJuZWwvbW0va3NtL3J1biIsICIxIiwgVFNUX1NS
X1JFUVVJUkVEfSwKPiAgCQl7fQo+ICAJfSwKPiAgfTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90
c3Rfc3lzX2NvbmYuaCBiL2luY2x1ZGUvdHN0X3N5c19jb25mLmgKPiBpbmRleCBiN2JiZTM2ZmMu
LmI1MmI4OTEzZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3RzdF9zeXNfY29uZi5oCj4gKysrIGIv
aW5jbHVkZS90c3Rfc3lzX2NvbmYuaAo+IEBAIC01LDE0ICs1LDIzIEBACj4gICNpZm5kZWYgVFNU
X1NZU19DT05GX0hfXwo+ICAjZGVmaW5lIFRTVF9TWVNfQ09ORl9IX18KPiAgCj4gKyNkZWZpbmUg
VFNUX1NSX0ZBSUxfTUlTU0lORyAweDEKPiArI2RlZmluZSBUU1RfU1JfU0tJUF9NSVNTSU5HIDB4
Mgo+ICsjZGVmaW5lIFRTVF9TUl9GQUlMX1JPIDB4NAo+ICsjZGVmaW5lIFRTVF9TUl9TS0lQX1JP
IDB4OAo+ICsjZGVmaW5lIFRTVF9TUl9JR05PUkVfRVJSIDB4MTAKPiArCj4gKyNkZWZpbmUgVFNU
X1NSX1JFUVVJUkVEIChUU1RfU1JfRkFJTF9NSVNTSU5HIHwgVFNUX1NSX0ZBSUxfUk8pCj4gKyNk
ZWZpbmUgVFNUX1NSX0NPTkRfQUNDRVNTIChUU1RfU1JfU0tJUF9NSVNTSU5HIHwgVFNUX1NSX1NL
SVBfUk8pCj4gKwo+ICBzdHJ1Y3QgdHN0X3BhdGhfdmFsIHsKPiAgICAgICAgICBjb25zdCBjaGFy
ICpwYXRoOwo+ICAgICAgICAgIGNvbnN0IGNoYXIgKnZhbDsKPiArCXVuc2lnbmVkIGludCBmbGFn
czsKPiAgfTsKPiAgCj4gLWludCB0c3Rfc3lzX2NvbmZfc2F2ZV9zdHIoY29uc3QgY2hhciAqcGF0
aCwgY29uc3QgY2hhciAqdmFsdWUpOwo+IC1pbnQgdHN0X3N5c19jb25mX3NhdmUoY29uc3QgY2hh
ciAqcGF0aCk7Cj4gLXZvaWQgdHN0X3N5c19jb25mX3NldChjb25zdCBjaGFyICpwYXRoLCBjb25z
dCBjaGFyICp2YWx1ZSk7Cj4gK3ZvaWQgdHN0X3N5c19jb25mX3NhdmVfc3RyKGNvbnN0IGNoYXIg
KnBhdGgsIGNvbnN0IGNoYXIgKnZhbHVlKTsKPiAraW50IHRzdF9zeXNfY29uZl9zYXZlKGNvbnN0
IHN0cnVjdCB0c3RfcGF0aF92YWwgKmNvbmYpOwo+ICB2b2lkIHRzdF9zeXNfY29uZl9yZXN0b3Jl
KGludCB2ZXJib3NlKTsKPiAgdm9pZCB0c3Rfc3lzX2NvbmZfZHVtcCh2b2lkKTsKPiAgCj4gZGlm
ZiAtLWdpdCBhL2xpYi90c3Rfc3lzX2NvbmYuYyBiL2xpYi90c3Rfc3lzX2NvbmYuYwo+IGluZGV4
IDAwMzY5ODgyNS4uN2FhMGY0NmJkIDEwMDY0NAo+IC0tLSBhL2xpYi90c3Rfc3lzX2NvbmYuYwo+
ICsrKyBiL2xpYi90c3Rfc3lzX2NvbmYuYwo+IEBAIC0yMCw2ICsyMCwxNCBAQCBzdHJ1Y3QgdHN0
X3N5c19jb25mIHsKPiAgCj4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3N5c19jb25mICpzYXZlX3Jlc3Rv
cmVfZGF0YTsKPiAgCj4gK3N0YXRpYyB2b2lkIHByaW50X2Vycm9yKGludCBpbmZvX29ubHksIGNv
bnN0IGNoYXIgKmVyciwgY29uc3QgY2hhciAqcGF0aCkKPiArewo+ICsJaWYgKGluZm9fb25seSkK
PiArCQl0c3RfcmVzKFRJTkZPLCBlcnIsIHBhdGgpOwo+ICsJZWxzZQo+ICsJCXRzdF9icmsoVEJS
T0sgfCBURVJSTk8sIGVyciwgcGF0aCk7Cj4gK30KCkNhbiB3ZSBwbGVhc2UgZWl0aGVyIG1ha2Ug
dGhpcyBhIG1hY3JvIG9yIHBhc3MgYSBfX0xJTkVfXyBzbyB0aGF0IHRoZQpsaW5lIG51bWJlciBp
biB0aGUgZXJyb3IgbWVzc2FnZSBpcyBjb3JyZWN0PwoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1Ymlz
QHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
