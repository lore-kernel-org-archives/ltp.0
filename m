Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BCC433FE
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 10:10:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59FA73CC93A
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 11:10:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C42FE3C0123
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 11:10:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7DE21400188
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 11:10:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62B4A218CE;
 Thu, 24 Nov 2022 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669284603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77LAiRHlXeV7ywZ1WN4fCXkxFIFMyNDUIaziVNSPM1c=;
 b=l23mX10N3WVc1zyyNBHA7OYG9hELC0SCTaLuF1emKUF8QIhQlJWoSM/3T2gWhJoWThq8dE
 +ITnO3T3LKFfW8bxaaTBjrnvtJcjYzkawz6Q+u1UkWXroPFBPW/P5k0mgegcTbrX6/8E5e
 LfMnhKTNi7nRXgncBBGLn8Jt0gXIkCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669284603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77LAiRHlXeV7ywZ1WN4fCXkxFIFMyNDUIaziVNSPM1c=;
 b=2x5KqJtvFbLtP6ALv5LaJHHB4G8JsCU+D5po0CowlAQUVxGklXwI3ygcbPKHU3OUick//G
 eMJLiKkWGSY3mdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46B7813488;
 Thu, 24 Nov 2022 10:10:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vyFiEPtCf2MlOAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 24 Nov 2022 10:10:03 +0000
Message-ID: <bc4555d5-eee4-dad2-f558-058c04a44df3@suse.cz>
Date: Thu, 24 Nov 2022 11:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>
References: <20221116160715.10082-1-mdoucha@suse.cz>
 <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
 <Y3eJNAi81ucutljP@yuki>
 <CAASaF6yaPmG1Q5fdecM7xhE3uqHa_PCMZBGj-hUj9xrVU42Z6A@mail.gmail.com>
 <CAEemH2etbzDjbNipZGpNM6UqOfjAmrrM5Ht0PDj5VK7i98tOWA@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2etbzDjbNipZGpNM6UqOfjAmrrM5Ht0PDj5VK7i98tOWA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] save_restore: Introduce new struct field for
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjQuIDExLiAyMiA0OjA5LCBMaSBXYW5nIHdyb3RlOgo+IEJ1dCBiZWZvcmUgYXBwbHlpbmcg
cGF0Y2gtdjUgYXMgaXQgaXMsIEkgZm91bmQgYWRkaXRpb25hbCB0d28gdGlueSBpc3N1ZXM6Cj4g
Cj4gMS4gdGhlIHVzYWdlIGluIG5ld2xpYl90ZXN0cyBzaG91bGQgYmUgY29ycmVjdGVkIGFzIHdl
bGwKPiAyLiB0c3RfaHVnZXBhZ2UgbmVlZCB0byB1cGRhdGUgdGhlIGFyZ3VtZW50IGluIHRzdF9z
eXNfY29uZl9zYXZlKCkKCkdvb2QgY2F0Y2guIEknbSBzdXJwcmlzZWQgdGhhdCB0c3RfaHVnZXBh
Z2UuYyBjb21waWxlcyB3aXRoIG9ubHkgYSAKd2FybmluZy4uLgoKPiAKPiBJZiBldmVyeW9uZSBh
Z3JlZXMgb24gdGhlIGltcHJvdmVtZW50cywgSSB3aWxsIG1lcmdlIHdpdGggYmVsb3cgZml4ZXM6
Cj4gCj4gLS0tIGEvbGliL25ld2xpYl90ZXN0cy90ZXN0MTkuYwo+ICsrKyBiL2xpYi9uZXdsaWJf
dGVzdHMvdGVzdDE5LmMKPiBAQCAtMjQsOSArMjQsOSBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0
IHRlc3QgPSB7Cj4gIMKgIMKgIMKgIMKgIC50ZXN0X2FsbCA9IHJ1biwKPiAgwqAgwqAgwqAgwqAg
LnNldHVwID0gc2V0dXAsCj4gIMKgIMKgIMKgIMKgIC5zYXZlX3Jlc3RvcmUgPSAoY29uc3Qgc3Ry
dWN0IHRzdF9wYXRoX3ZhbFtdKSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7Ij8vcHJvYy9u
b25leGlzdGVudCIsIE5VTEx9LAo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgeyIhL3Byb2Mvc3lz
L2tlcm5lbC9udW1hX2JhbGFuY2luZyIsIE5VTEx9LAo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
eyIvcHJvYy9zeXMva2VybmVsL2NvcmVfcGF0dGVybiIsIE5VTEx9LAo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgeyIvcHJvYy9ub25leGlzdGVudCIsIE5VTEwsIFRTVF9TUl9TS0lQfSwKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHsiL3Byb2Mvc3lzL2tlcm5lbC9udW1hX2JhbGFuY2luZyIsIE5V
TEwsIFRTVF9TUl9UQlJPS30sCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB7Ii9wcm9jL3N5cy9r
ZXJuZWwvY29yZV9wYXR0ZXJuIiwgTlVMTCwgVFNUX1NSX1RDT05GfSwKPiAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAge30KPiAgwqAgwqAgwqAgwqAgfSwKPiAgwqB9Owo+IGRpZmYgLS1naXQgYS9s
aWIvbmV3bGliX3Rlc3RzL3Rlc3QyMC5jIGIvbGliL25ld2xpYl90ZXN0cy90ZXN0MjAuYwo+IGlu
ZGV4IDM5ODJhYjcuLjM3MjZjZWEgMTAwNjQ0Cj4gLS0tIGEvbGliL25ld2xpYl90ZXN0cy90ZXN0
MjAuYwo+ICsrKyBiL2xpYi9uZXdsaWJfdGVzdHMvdGVzdDIwLmMKPiBAQCAtMzksNyArMzksNyBA
QCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gIMKgIMKgIMKgIMKgIC50ZXN0X2Fs
bCA9IGRvX3Rlc3QsCj4gIMKgIMKgIMKgIMKgIC5odWdlcGFnZXMgPSB7MiwgVFNUX05FRURTfSwK
PiAgwqAgwqAgwqAgwqAgLnNhdmVfcmVzdG9yZSA9IChjb25zdCBzdHJ1Y3QgdHN0X3BhdGhfdmFs
W10pIHsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHsiIS9wcm9jL3N5cy9rZXJuZWwvbnVtYV9i
YWxhbmNpbmciLCAiMCJ9LAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgeyIvcHJvYy9zeXMva2Vy
bmVsL251bWFfYmFsYW5jaW5nIiwgIjAiLCBUU1RfU1JfVEJST0t9LAo+ICDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB7fQo+ICDCoCDCoCDCoCDCoCB9LAo+ICDCoH07Cj4gZGlmZiAtLWdpdCBhL2xp
Yi90c3RfaHVnZXBhZ2UuYyBiL2xpYi90c3RfaHVnZXBhZ2UuYwo+IGluZGV4IGU5N2NjNTYuLjQx
ZjY1ZDcgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9odWdlcGFnZS5jCj4gKysrIGIvbGliL3RzdF9o
dWdlcGFnZS5jCj4gQEAgLTcsNiArNyw3IEBACj4gCj4gIMKgI2luY2x1ZGUgInRzdF90ZXN0Lmgi
Cj4gIMKgI2luY2x1ZGUgInRzdF9odWdlcGFnZS5oIgo+ICsjaW5jbHVkZSAidHN0X3N5c19jb25m
LmgiCgp0c3Rfc3lzX2NvbmYuaCBpcyBhbHJlYWR5IGluY2x1ZGVkIHRocm91Z2ggdHN0X3Rlc3Qu
aAoKPiAgwqB1bnNpZ25lZCBsb25nIHRzdF9odWdlcGFnZXM7Cj4gIMKgY2hhciAqbnJfb3B0Owo+
IEBAIC0yNCw2ICsyNSwxMiBAQCB1bnNpZ25lZCBsb25nIHRzdF9yZXNlcnZlX2h1Z2VwYWdlcyhz
dHJ1Y3QgCj4gdHN0X2h1Z2VwYWdlICpocCkKPiAgwqB7Cj4gIMKgIMKgIMKgIMKgIHVuc2lnbmVk
IGxvbmcgdmFsLCBtYXhfaHBhZ2VzOwo+IAo+ICsgwqAgwqAgwqAgc3RydWN0IHRzdF9wYXRoX3Zh
bCBwdmwgPSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCAucGF0aCA9IFBBVEhfTlJfSFBBR0VT
LAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLnZhbCA9IE5VTEwsCj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAuZmxhZ3MgPSBUU1RfU1JfU0tJUCwKPiArIMKgIMKgIMKgIH07CgpUaGUgc2F2ZSgp
IGlzIGZvbGxvd2VkIGJ5IHVuY29uZGl0aW9uYWwgU0FGRV9GSUxFX1BSSU5URigpIHNvIHRoZSBm
bGFncyAKc2hvdWxkIGJlIFRTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfVENPTkZfUk8gaW5z
dGVhZC4gSSdsbCBzZW5kIGEgdjYuCgo+ICsKPiAgwqAgwqAgwqAgwqAgaWYgKGFjY2VzcyhQQVRI
X0hVR0VQQUdFUywgRl9PSykpIHsKPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGhwLT5w
b2xpY3kgPT0gVFNUX05FRURTKQo+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB0c3RfYnJrKFRDT05GLCAiaHVnZXRsYmZzIGlzIG5vdCBzdXBwb3J0ZWQiKTsKPiBAQCAtNTks
NyArNjYsNyBAQCB1bnNpZ25lZCBsb25nIHRzdF9yZXNlcnZlX2h1Z2VwYWdlcyhzdHJ1Y3QgCj4g
dHN0X2h1Z2VwYWdlICpocCkKPiAgwqAgwqAgwqAgwqAgfQo+IAo+ICDCoHNldF9odWdlcGFnZXM6
Cj4gLSB0c3Rfc3lzX2NvbmZfc2F2ZSgiPy9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiKTsKPiAr
IMKgIMKgIMKgIHRzdF9zeXNfY29uZl9zYXZlKCZwdmwpOwo+ICDCoCDCoCDCoCDCoCBTQUZFX0ZJ
TEVfUFJJTlRGKFBBVEhfTlJfSFBBR0VTLCAiJWx1IiwgdHN0X2h1Z2VwYWdlcyk7Cj4gIMKgIMKg
IMKgIMKgIFNBRkVfRklMRV9TQ0FORihQQVRIX05SX0hQQUdFUywgIiVsdSIsICZ2YWwpOwo+ICDC
oCDCoCDCoCDCoCBpZiAodmFsICE9IHRzdF9odWdlcGFnZXMpCj4gCj4gCj4gLS0gCj4gUmVnYXJk
cywKPiBMaSBXYW5nCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpRQSBFbmdp
bmVlciBmb3IgU29mdHdhcmUgTWFpbnRlbmFuY2UKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJ
YQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
