Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6922C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:33:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D9FF3C2B90
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:33:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91E43C2B90
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:32:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4233410006BD
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:32:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D7DBC21EBA;
 Tue, 27 May 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A22C4136E0;
 Tue, 27 May 2025 11:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GBksJuGiNWhCBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 May 2025 11:32:49 +0000
Date: Tue, 27 May 2025 13:32:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250527113244.GA188735@pevik>
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
 <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
 <20250527093436.GC173684@pevik>
 <CAEemH2cCL9LpBRMnfJtShmdtwKTHLMC2hQeC_sFKyh4KWwUt0Q@mail.gmail.com>
 <20250527110043.GA186218@pevik> <aDWfJ97gIGTRpMQI@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aDWfJ97gIGTRpMQI@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: D7DBC21EBA
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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

SGkgQ3lyaWwsIGFsbCwKCj4gSGkhCj4gPiA+IFRoYXQncyByaWdodCwganVzdCBjb25maXJtZWQg
d2l0aCBDeXJpbCwgc28gZmFyIHdlIG5lZWQgdG8gZG8gbm90aGluZwo+ID4gPiB1bmxlc3MgdHN0
X2dldF9zdXBwb3J0ZWRfZnNfdHlwZXMoKSBpcyBhYnVzZWQgc29tZXdoZXJlLgoKPiA+IEFidXNp
bmcgdGhlIGZ1bmN0aW9uIHNob3VsZCBiZSBwcmV2ZW50ZWQgaWYgQ3lyaWwgYWRkcyBiZWZvcmUg
bWVyZ2UgJ3N0YXRpYycKPiA+IGtleXdvcmQgdG8gdGhlIGZ1bmN0aW9uIChhcyBJIHN1Z2dlc3Rl
ZCBlYXJsaWVyKS4KCj4gVGhhdCdzIGEgZGlmZmVyZW50IGZ1bmN0aW9uIGFuZCB0aGF0IGlzIGdv
aW5nIHRvIGJlIHN0YXRpYyBpbiB0aGUgZmluYWwKPiBwYXRjaC4KCkFoLCB0aGFua3MgZm9yIGlu
Zm8uCgo+IFRoaXMgaXMgdGhlIGZ1bmN0aW9uIHRoYXQgaXMgY2FsbGVkIGZyb20gdHN0X3Rlc3Qu
YyBhbmQgSSBndWVzcyB0aGF0IHdlCj4gY2FuIHJlbW92ZSBpdCBmcm9tIHRoZSB0c3RfZnMuaCBp
biBvcmRlciB0byBtYWtlIHN1cmUgbm9ib2R5IHRyaWVzIHRvCj4gbWlzdXNlIGl0LiBUaGF0IHdv
dWxkIGxvb2sgbGlrZToKCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X2ZzLmggYi9pbmNsdWRl
L3RzdF9mcy5oCj4gaW5kZXggMTljMjQwZTA3Li5jZWFlNzhlN2UgMTAwNjQ0Cj4gLS0tIGEvaW5j
bHVkZS90c3RfZnMuaAo+ICsrKyBiL2luY2x1ZGUvdHN0X2ZzLmgKPiBAQCAtMjAzLDEzICsyMDMs
NiBAQCBlbnVtIHRzdF9mc19pbXBsIHsKPiAgICovCj4gIGVudW0gdHN0X2ZzX2ltcGwgdHN0X2Zz
X2lzX3N1cHBvcnRlZChjb25zdCBjaGFyICpmc190eXBlKTsKCj4gLS8qCj4gLSAqIFJldHVybnMg
TlVMTC10ZXJtaW5hdGVkIGFycmF5IG9mIGtlcm5lbC1zdXBwb3J0ZWQgZmlsZXN5c3RlbXMuCj4g
LSAqCj4gLSAqIEBza2lwbGlzdCBBIE5VTEwgdGVybWluYXRlZCBhcnJheSBvZiBmaWxlc3lzdGVt
cyB0byBza2lwLgo+IC0gKi8KPiAtY29uc3QgY2hhciAqKnRzdF9nZXRfc3VwcG9ydGVkX2ZzX3R5
cGVzKGNvbnN0IGNoYXIgKmNvbnN0ICpza2lwbGlzdCk7Cj4gLQo+ICAvKgo+ICAgKiBSZXR1cm5z
IDEgaWYgZmlsZXN5c3RlbSBpcyBpbiBza2lwbGlzdCAwIG90aGVyd2lzZS4KPiAgICoKPiBkaWZm
IC0tZ2l0IGEvbGliL3RzdF9pbnRlcm5hbC5oIGIvbGliL3RzdF9pbnRlcm5hbC5oCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLmEwYWU3MzNmNgo+IC0tLSAvZGV2L251
bGwKPiArKysgYi9saWIvdHN0X2ludGVybmFsLmgKPiBAQCAtMCwwICsxLDE3IEBACj4gKy8qIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCj4gKy8qCj4gKyAqIENv
cHlyaWdodCAoYykgMjAxNS0yMDI1IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+ICsg
KiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAxNy0yMDI1Cj4gKyAqLwo+ICsK
PiArI2lmbmRlZiBUU1RfSU5URVJOQUxfSF9fCj4gKyNkZWZpbmUgVFNUX0lOVEVSTkFMX0hfXwo+
ICsKPiArLyoKPiArICogUmV0dXJucyBOVUxMLXRlcm1pbmF0ZWQgYXJyYXkgb2Yga2VybmVsLXN1
cHBvcnRlZCBmaWxlc3lzdGVtcy4KPiArICoKPiArICogQHNraXBsaXN0IEEgTlVMTCB0ZXJtaW5h
dGVkIGFycmF5IG9mIGZpbGVzeXN0ZW1zIHRvIHNraXAuCj4gKyAqLwo+ICtjb25zdCBjaGFyICoq
dHN0X2dldF9zdXBwb3J0ZWRfZnNfdHlwZXMoY29uc3QgY2hhciAqY29uc3QgKnNraXBsaXN0KTsK
PiArCj4gKyNlbmRpZiAvKiBUU1RfSU5URVJOQUxfSF9fICovCj4gZGlmZiAtLWdpdCBhL2xpYi90
c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMgYi9saWIvdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jCj4g
aW5kZXggNDYxNjVlYmM2Li5jYzU1MjJhMDggMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9zdXBwb3J0
ZWRfZnNfdHlwZXMuYwo+ICsrKyBiL2xpYi90c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMKPiBAQCAt
MTQsNiArMTQsNyBAQAo+ICAjZGVmaW5lIFRTVF9OT19ERUZBVUxUX01BSU4KPiAgI2luY2x1ZGUg
InRzdF90ZXN0LmgiCj4gICNpbmNsdWRlICJ0c3RfZnMuaCIKPiArI2luY2x1ZGUgInRzdF9pbnRl
cm5hbC5oIgoKPiAgLyoKPiAgICogTk9URTogbmV3IGZpbGVzeXN0ZW0gc2hvdWxkIGJlIGFsc28g
YWRkZWQgdG8KPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+
IGluZGV4IDQ1ZmMyODQ5OC4uZjYyY2MxOTVhIDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfdGVzdC5j
Cj4gKysrIGIvbGliL3RzdF90ZXN0LmMKPiBAQCAtMzgsNiArMzgsNyBAQAo+ICAjaW5jbHVkZSAi
b2xkX2RldmljZS5oIgo+ICAjaW5jbHVkZSAib2xkX3RtcGRpci5oIgo+ICAjaW5jbHVkZSAibHRw
LXZlcnNpb24uaCIKPiArI2luY2x1ZGUgInRzdF9pbnRlcm5hbC5oIgoKPiAgLyoKPiAgICogSGFj
ayB0byBnZXQgVENJRCBkZWZpbmVkIGluIG5ld2xpYiB0ZXN0cwoKRllJIGFsc28gdGVzdGNhc2Vz
L2xpYi90c3Rfc3VwcG9ydGVkX2ZzLmMgdXNlcyBpdDoKCnRzdF9zdXBwb3J0ZWRfZnMuYzogSW4g
ZnVuY3Rpb24g4oCYbWFpbuKAmToKdHN0X3N1cHBvcnRlZF9mcy5jOjE1MjoyMzogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRzdF9nZXRfc3VwcG9ydGVkX2ZzX3R5
cGVz4oCZIFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDE1MiB8ICAgICAgICAg
ZmlsZXN5c3RlbXMgPSB0c3RfZ2V0X3N1cHBvcnRlZF9mc190eXBlcygoY29uc3QgY2hhciAqIGNv
bnN0Kilza2lwbGlzdCk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CnRzdF9zdXBwb3J0ZWRfZnMuYzoxNTI6MjE6IGVycm9yOiBhc3NpZ25t
ZW50IHRvIOKAmGNvbnN0IGNoYXIgKiBjb25zdCrigJkgZnJvbSDigJhpbnTigJkgbWFrZXMgcG9p
bnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCiAgMTUy
IHwgICAgICAgICBmaWxlc3lzdGVtcyA9IHRzdF9nZXRfc3VwcG9ydGVkX2ZzX3R5cGVzKChjb25z
dCBjaGFyICogY29uc3QqKXNraXBsaXN0KTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF4K
bWFrZTogKioqIFsuLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQ4OiB0c3Rfc3VwcG9ydGVkX2Zz
XSBFcnJvciAxCgpUaGVyZWZvcmUgd2UgbmVlZCBlaXRoZXIgcmVsYXRpdmUgcGF0aCAoYmVsb3cp
IG9yIHR3ZWFrIENGTEFHUyB0byBhZGQgLUkuCgpPdGhlcndpc2UgTEdUTSwgaWRlYWxseSBzZW5k
IGEgcGF0Y2guCgpLaW5kIHJlZ2FyZHMsClBldHIKCisrKyB0ZXN0Y2FzZXMvbGliL3RzdF9zdXBw
b3J0ZWRfZnMuYwpAQCAtMTQsNiArMTQsNyBAQAogI2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlO
CiAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKICNpbmNsdWRlICJ0c3RfZnMuaCIKKyNpbmNsdWRlICIu
Li8uLi9saWIvdHN0X2ludGVybmFsLmgiCgogI2RlZmluZSBlcnJfZXhpdCguLi4pICh7IFwKICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwgX19WQV9BUkdTX18pOyBcCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
