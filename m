Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF98C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 07:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A96323CB858
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:41:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E28FA3CA166
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:41:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93E6C1400B8F
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:41:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE6CE1F80F;
 Wed, 26 Aug 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48D1513533;
 Wed, 26 Aug 2026 07:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k8EhC6CYjmoqAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 26 Aug 2026 07:41:20 +0000
Date: Wed, 26 Aug 2026 09:41:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Namjae Jeon <linkinjeon@kernel.org>
Message-ID: <20260826074114.GA32334@pevik>
References: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6a463902.41a38e5f.27f5bd.337a@mx.google.com>
 <akzN_iISxNTztbEw@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <20260825112755.GA62429@pevik> <ao2TtyQpCGP5TLpx@yuki.lan>
 <20260825132604.GA70046@pevik> <ao2cpyGYcL-rZLgc@yuki.lan>
 <CAKYAXd_3Za8Jzan9VV4WrK1ATB2WXTazLVuGJ5ViQ8RGp0xbLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKYAXd_3Za8Jzan9VV4WrK1ATB2WXTazLVuGJ5ViQ8RGp0xbLw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: EE6CE1F80F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
Cc: regressions@lists.linux.dev, Yuezhang Mo <yuezhang.mo@sony.com>,
 linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTmFtamFlLAoKPiBPbiBUdWUsIEF1ZyAyNSwgMjAyNiBhdCAxMDo0NuKAr1BNIEN5cmlsIEhy
dWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSEKPiBIaSBDeXJpbCwgUGV0ciwK
PiA+ID4gPiBUaGF0IGRvZXMgbm90IG1ha2UgbXVjaCBzZW5zZSwgaWYgc3dhcF9hY3RpdmF0ZSB3
YXMgYWRkZWQgdG8ga2VybmVsLAo+ID4gPiA+IHByZS1maWxsaW5nIHRoZSBmYWxsb2NhdGVkIGZp
bGUgc2hvdWxkbid0IGJlIG5lZWRlZCBhbnltb3JlLgoKPiA+ID4gR29vZCBjYXRjaCwgeW91J3Jl
IHJpZ2h0LiBJJ20gYWxzbyBjb25mdXNlZCwgYmVmb3JlIHY3LjIgc3dhcCB3b3JrZWQgb24gZXhm
YXQsCj4gPiA+IG5vdyBldmVuIHdpdGggODJhODFhNzM1MmJjICgiZXhmYXQ6IGFkZCBpb21hcCBi
dWZmZXJlZCBJL08gc3VwcG9ydCIpIFsyXQo+ID4gPiBhbmQgeW91ciBmaXggMDNhNDM2NzdjYTkx
ICgiZXhmYXQ6IGFkZCBzd2FwX2FjdGl2YXRlIHN1cHBvcnQiKSBbM10gaXMgbm90Cj4gPiA+IHdv
cmtpbmcuIE9idmlvdXNseSB0aGUgZml4IHdhcyBub3QgZ29vZCBlbm91Z2guCgo+ID4gVGhlcmUg
d2VyZSB0d28gYnVncyBJIHN1cHBvc2UsIG9uZSBpcyB0aGF0IGZhbGxvY2F0ZSgpIHN1cHBvcnQg
Zm9yIGV4ZmF0IGJyb2tlCj4gPiB0aGUgc3dhcG9uIG9uIGZhbGxvY2F0ZWQgZmlsZS4gVGhlIHNl
Y29uZCBidWcgd2FzIGludHJvZHVjZWQgbGF0ZXIgd2hlbgo+ID4gZXhmYXQgd2FzIHJld3JpdHRl
biB0byB1c2UgaW9tYXAuIFRoZSBpb21hcCBjYXNlIHdhcyBmaXhlZCBpbiB0aGUgcGF0Y2gKPiA+
IGFib3ZlLCBob3dldmVyIGl0IGxvb2tzIGxpa2UgdGhlIG9yaWdpbmFsIGJ1ZyBjYXVzZWQgYnkg
ZmFsbG9jYXRlKCkKPiA+IGltcGxlbWVudGF0aW9uIGZvciBleGZhdCBpcyBzdGlsbCB0aGVyZS4K
PiBDYW4geW91IGNoZWNrIGlmIGFuIGF0dGFjaGVkIHBhdGNoIGltcHJvdmVzIHRoaXMgaXNzdWU/
Cj4gVGhhbmtzLgoKTEdUTS4KClRlc3RlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
CgpUZXN0ZWQgb24gcmFwaWRvLWxpbnV4IHdpdGg6CkNPTkZJR19FWEZBVF9GUz15CkNPTkZJR19F
WEZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0idXRmOCIKCkhvcGVmdWxseSBKYW4gd2lsbCB0ZXN0IGl0
IGFzIHdlbGwsIGJ1aWx0IGFzIG1vZHVsZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBGcm9tIDU2
NzlhNjI0ODE2NDU0YzhlNzY4Mzg0MmViMGFiM2YxYWRmMGRjY2EgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxCj4gRnJvbTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4KPiBEYXRl
OiBXZWQsIDI2IEF1ZyAyMDI2IDA5OjE0OjE0ICswOTAwCj4gU3ViamVjdDogW1BBVENIXSBleGZh
dDogbWFwIGFsbG9jYXRlZCBleHRlbnRzIGZvciBzd2FwIGFjdGl2YXRpb24KCj4gZXhGQVQgcmVw
b3J0cyBhbGxvY2F0ZWQgcmFuZ2VzIGJleW9uZCB2YWxpZF9zaXplIGFzIElPTUFQX0hPTEUgd2hl
bgo+IElPTUFQX1JFUE9SVCBpcyBzZXQuIGlvbWFwX3N3YXBmaWxlX2FjdGl2YXRlKCkgYWxzbyB1
c2VzIElPTUFQX1JFUE9SVAo+IHdoaWxlIGNvbGxlY3RpbmcgcGh5c2ljYWwgZXh0ZW50cyBmb3Ig
YSBzd2FwIGZpbGUsIHNvIGl0IHRyZWF0cyB0aGUKPiBwcmVhbGxvY2F0ZWQgdGFpbCBhcyB1bmFs
bG9jYXRlZCBhbmQgcmVqZWN0cyB0aGUgZmlsZSB3aXRoIC1FSU5WQUwuCgo+IFVzZSBzd2FwLXNw
ZWNpZmljIGlvbWFwIG9wZXJhdGlvbnMgdGhhdCBzdXBwcmVzcyBJT01BUF9SRVBPUlQgYmVmb3Jl
Cj4gbWFwcGluZyB0aGUgZmlsZS4gVGhpcyByZXBvcnRzIHBoeXNpY2FsbHkgYWxsb2NhdGVkIHJh
bmdlcyBhcwo+IElPTUFQX1VOV1JJVFRFTiBkdXJpbmcgc3dhcCBhY3RpdmF0aW9uIHdpdGhvdXQg
Y2hhbmdpbmcgdGhlCj4gYnl0ZS1hY2N1cmF0ZSBTRUVLX0hPTEUgYW5kIFNFRUtfREFUQSBiZWhh
dmlvciBvZiB0aGUgcmVndWxhciBpb21hcAo+IG9wZXJhdGlvbnMuCgo+IEZpeGVzOiAwM2E0MzY3
N2NhOTEgKCJleGZhdDogYWRkIHN3YXBfYWN0aXZhdGUgc3VwcG9ydCIpCj4gU2lnbmVkLW9mZi1i
eTogTmFtamFlIEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4KPiAtLS0KPiAgZnMvZXhmYXQv
aW9tYXAuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCj4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lvbWFw
LmMgYi9mcy9leGZhdC9pb21hcC5jCj4gaW5kZXggMGM4MDViZjY2NzZhLi5iZjhiYWY3OGE5Yjgg
MTAwNjQ0Cj4gLS0tIGEvZnMvZXhmYXQvaW9tYXAuYwo+ICsrKyBiL2ZzL2V4ZmF0L2lvbWFwLmMK
PiBAQCAtMTU1LDYgKzE1NSwyMiBAQCBjb25zdCBzdHJ1Y3QgaW9tYXBfb3BzIGV4ZmF0X2lvbWFw
X29wcyA9IHsKPiAgCS5pb21hcF9iZWdpbiA9IGV4ZmF0X2lvbWFwX2JlZ2luLAo+ICB9OwoKPiAr
c3RhdGljIGludCBleGZhdF9zd2FwX2lvbWFwX2JlZ2luKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxv
ZmZfdCBvZmZzZXQsCj4gKwkJbG9mZl90IGxlbmd0aCwgdW5zaWduZWQgaW50IGZsYWdzLCBzdHJ1
Y3QgaW9tYXAgKmlvbWFwLAo+ICsJCXN0cnVjdCBpb21hcCAqc3JjbWFwKQo+ICt7Cj4gKwkvKgo+
ICsJICogU3dhcCBhY3RpdmF0aW9uIG5lZWRzIHRoZSBwaHlzaWNhbCBtYXBwaW5ncyBvZiBwcmVh
bGxvY2F0ZWQKPiArCSAqIHJhbmdlcy4gRG8gbm90IHJlcG9ydCB0aGUgVkRMIHRhaWwgYXMgYSBo
b2xlLgo+ICsJICovCj4gKwlyZXR1cm4gX19leGZhdF9pb21hcF9iZWdpbihpbm9kZSwgb2Zmc2V0
LCBsZW5ndGgsCj4gKwkJCWZsYWdzICYgfklPTUFQX1JFUE9SVCwgaW9tYXAsIGZhbHNlKTsKPiAr
fQo+ICsKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpb21hcF9vcHMgZXhmYXRfc3dhcF9pb21hcF9v
cHMgPSB7Cj4gKwkuaW9tYXBfYmVnaW4gPSBleGZhdF9zd2FwX2lvbWFwX2JlZ2luLAo+ICt9Owo+
ICsKPiAgLyoKPiAgICogZXhmYXRfd3JpdGVfaW9tYXBfZW5kIC0gVXBkYXRlIHRoZSBzdGF0ZSBh
ZnRlciB3cml0ZQo+ICAgKgo+IEBAIC0yNzQsNSArMjkwLDYgQEAgY29uc3Qgc3RydWN0IGlvbWFw
X3JlYWRfb3BzIGV4ZmF0X2lvbWFwX2Jpb19yZWFkX29wcyA9IHsKPiAgaW50IGV4ZmF0X2lvbWFw
X3N3YXBfYWN0aXZhdGUoc3RydWN0IHN3YXBfaW5mb19zdHJ1Y3QgKnNpcywKPiAgCQkJICAgICAg
IHN0cnVjdCBmaWxlICpmaWxlLCBzZWN0b3JfdCAqc3BhbikKPiAgewo+IC0JcmV0dXJuIGlvbWFw
X3N3YXBmaWxlX2FjdGl2YXRlKHNpcywgZmlsZSwgc3BhbiwgJmV4ZmF0X2lvbWFwX29wcyk7Cj4g
KwlyZXR1cm4gaW9tYXBfc3dhcGZpbGVfYWN0aXZhdGUoc2lzLCBmaWxlLCBzcGFuLAo+ICsJCQkJ
ICAgICAgICZleGZhdF9zd2FwX2lvbWFwX29wcyk7Cj4gIH0KCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
