Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF80C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 10:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD1513CD957
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 11:10:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E65023CD947
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 11:10:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34817600B25
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 11:10:13 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC045219AE;
 Wed, 29 Nov 2023 10:10:12 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 40DA61377E;
 Wed, 29 Nov 2023 10:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id FpMwDQQOZ2V2XQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 29 Nov 2023 10:10:12 +0000
Date: Wed, 29 Nov 2023 11:10:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231129101010.GA535399@pevik>
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
 <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
 <20231128165132.GA406520@pevik>
 <CAEemH2fqamX720diM1N+iN9a8HM30_5sHg8V0EMHgHdrh3iZPw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fqamX720diM1N+iN9a8HM30_5sHg8V0EMHgHdrh3iZPw@mail.gmail.com>
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: AC045219AE
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: david@redhat.com, Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
 oliver.sang@intel.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIE5vdiAyOSwgMjAyMyBhdCAxMjo1MeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPiBIaSBTdGVmYW4sIExpLAoKPiA+ID4gSGkgU3RlZmFuLCBQZXRy
LAoKPiA+ID4gT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMzo0NuKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiA+ID4gSGkgU3RlZmFuLAoKPiA+ID4gPiA+IFRoaXMg
ZGlzYWJsZXMgdGhlICJzbWFydCBzY2FuIiBLU00gZmVhdHVyZSB0byBtYWtlIHN1cmUgdGhhdCB0
aGUKPiA+IHZvbGF0aWxlCj4gPiA+ID4gPiBjb3VudCByZW1haW5zIGF0IDAuCgo+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogU3RlZmFuIFJvZXNjaCA8ZGV2a2VybmVsLmlvPgo+ID4gPiA+IG5pdDog
eW91IGZvcmdvdCAnc2hyQCcKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gUm9lc2NoIDxz
aHJAZGV2a2VybmVsLmlvPgoKPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPgo+ID4gPiA+ID4gQ2xvc2VzOgoKPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDIzMTExNjExMzIuMTNkOGNlNWEtb2xpdmVyLnNhbmdA
aW50ZWwuY29tCj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9s
aWIvbWVtLmMgfCA0ICsrKysKPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspCgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0u
Ywo+ID4gPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jCj4gPiA+ID4gPiBpbmRl
eCBmYmZlZWYwMjYuLmVmMjc0YTNhYyAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0v
bGliL21lbS5jCj4gPiA+ID4gPiBAQCAtNDU0LDYgKzQ1NCw5IEBAIHZvaWQgY3JlYXRlX3NhbWVf
bWVtb3J5KGludCBzaXplLCBpbnQgbnVtLCBpbnQKPiA+IHVuaXQpCj4gPiA+ID4gPiAgICAgICAg
ICAgICAgeydhJywgc2l6ZSpNQn0sIHsnYScsIHNpemUqTUJ9LCB7J2QnLCBzaXplKk1CfSwgeydk
JywKPiA+ID4gPiBzaXplKk1CfSwKPiA+ID4gPiA+ICAgICAgIH07Cgo+ID4gPiA+ID4gKyAgLyog
RGlzYWJsZSBzbWFydCBzY2FuIGZvciBjb3JyZWN0IHZvbGF0aWxlIGNvdW50cy4gKi8KPiA+ID4g
PiA+ICsgIFNBRkVfRklMRV9QUklOVEYoUEFUSF9LU00gInNtYXJ0X3NjYW4iLCAiMCIpOwo+ID4g
PiA+IE5PVEUsIHRoaXMgZmFpbHMgb24gdGhlIHN5c3RlbXMgd2l0aG91dCAvc3lzL2tlcm5lbC9t
bS9rc20vc21hcnRfc2NhbjoKCj4gPiA+ID4gbWVtLmM6NDU4OiBUQlJPSzogRmFpbGVkIHRvIG9w
ZW4gRklMRSAnL3N5cy9rZXJuZWwvbW0va3NtL3NtYXJ0X3NjYW4nCj4gPiBmb3IKPiA+ID4gPiB3
cml0aW5nOiBFQUNDRVMgKDEzKQoKPiA+ID4gPiBOT1RFLCB3ZSBub3JtYWxseSBoYW5kbGUgdGhl
IHNldHVwIGxpa2UgdGhpcyBpbiB0ZXN0IHNldHVwIGZ1bmN0aW9uLgoKPiA+ID4gPiBCdXQgbmV3
IEFQSSBoYXMgLnNhdmVfcmVzdG9yZSB3aGljaCBpcyBtb3JlIHJvYnVzdCBmb3IgdGFza3MgIGxp
a2UKPiA+IHRoaXMuCj4gPiA+ID4gSXQncyBhbHJlYWR5IHVzZWQgaW4ga3NtMDEuYywgeW91IG5l
ZWQganVzdCB0byBhZGQgdGhpcyBsaW5lOgo+ID4gPiA+ICAgICAgICAgeyIvc3lzL2tlcm5lbC9t
bS9rc20vc21hcnRfc2NhbiIsICIwIiwgVFNUX1NSX1NLSVB9LAoKCj4gPiA+IEkgZ3Vlc3Mgd2Ug
bmVlZCB0byBzZXQgJ1RTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfVEJST0tfUk8nCj4gPiA+
IGFzIHRoZSBsYXN0IGZpZWxkLiBCZWNhdXNlIFRTVF9TUl9TS0lQIHdpbGwgY29udGludWUgdGhl
IHRlc3Qgd2l0aG91dAo+ID4gPiB3cml0aW5nICcwJyB0byB0aGUgc21hcnRfc2NhbiBmaWxlLCB0
aGF0J3Mgbm90IGNvcnJlY3QgaWYgdGhlIGZpbGUKPiA+IGV4aXN0cy4KPiA+ID4gSXQgd2lsbAo+
ID4gPiBpZ25vcmUgYSBrZXJuZWwgYnVnIChzbWFydF9zY2FuIGNhbid0IGJlIHdyaXR0ZW4pIGJ5
IHRoYXQgY29uZmlnLgoKPiA+ID4gUGVyIHRoZSBEb2MgUGV0ciBwb2ludGVkIGJlbG93Ogo+ID4g
PiAgIFRTVF9TUl9TS0lQX01JU1NJTkcg4oCTIENvbnRpbnVlIHdpdGhvdXQgc2F2aW5nIHRoZSBm
aWxlIGlmIGl0IGRvZXMgbm90Cj4gPiA+IGV4aXN0Cj4gPiA+ICAgVFNUX1NSX1RCUk9LX1JPIOKA
kyBFbmQgdGVzdCB3aXRoIFRCUk9LIGlmIHRoZSBmaWxlIGlzIHJlYWQtb25seQo+ID4gPiAgIFRT
VF9TUl9TS0lQX1JPIOKAkyBDb250aW51ZSB3aXRob3V0IHNhdmluZyB0aGUgZmlsZSBpZiBpdCBp
cyByZWFkLW9ubHkKPiA+ID4gICBUU1RfU1JfU0tJUCDigJMgRXF1aXZhbGVudCB0byAnVFNUX1NS
X1NLSVBfTUlTU0lORyB8IFRTVF9TUl9TS0lQX1JPJwoKCgo+ID4gPiA+IChpbnN0ZWFkIG9mIGJv
dGggU0FGRV9GSUxFX1BSSU5URikKCj4gPiA+ID4gU2VlOgoKCj4gPiBodHRwczovL2dpdGh1Yi5j
b20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL0MtVGVzdC1BUEkjMTI3LXNhdmluZy0tcmVz
dG9yaW5nLXByb2NzeXMtdmFsdWVzCgo+ID4gPiA+IEkgd29uZGVyIGlmIGtzbTAxLmMgaXMgdGhl
IG9ubHkga3NtIHRlc3Qgd2hpY2ggbmVlZHMgdG8gZGlzYWJsZSB0aGlzLgoKCj4gPiA+IEkgdGhp
bmsgYWxsIG9mIHRoZSBrc20wKi5jIHRlc3RzIHNob3VsZCBkaXNhYmxlIGl0IGJ5IHRoZSBjb25m
aWcuIFRoZQo+ID4gPiBzbWFydF9zY2FuCj4gPiA+IHdpbGwgaW1wYWN0IGFsbCB0aGUgdGVzdHMg
d2l0aCBpbnZva2Uga2V5IGZ1bmN0aW9uIGNyZWF0ZV9zYW1lX21lbW9yeSgpLgoKPiA+IGtzbTA1
LmMgYW5kIGtzbTA2LmMgZG9lcyBub3QgdXNlIGNyZWF0ZV9zYW1lX21lbW9yeSgpLiBPciBkaWQg
SSBvdmVybG9vawo+ID4gc29tZXRoaW5nPwoKCj4gR29vZCBjYXRjaCwgSSBsb29rZWQgaW50byB0
aGVzZSB0ZXN0cywgc2VlbXMgb25seSBrc20wNSBpcyBkZWJhdGFibGUKPiBmb3IgZGlzYWJsaW5n
IHNtYXJ0X3NjYW4sIGFzIGEgc2ltcGxlIHJlZ3Jlc3Npb24sIGl0IHN1Z2dlc3RzIGRpc2FibGlu
Zwo+IGtzbSBkYWVtb24gdG8gYXZvaWQgZGlzdHVyYiBhY2NvcmRpbmcgdG8gc29tZSB3b3JrbG9h
ZC4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rl
ci90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDUuYyNMMzAKCj4ga3NtMDYgaXMgZGVmaW5p
dGVseSBuZWVkIGRpc2FibGUgc21hcnRfc2NhbiwgaXQgdGVzdHMgS1NNIGluIGRpZmZlcmVudAo+
ICdydW4nIHN0YXRlIGZvciBtZXJnZV9hY2Nyb3Nfbm9kZXMuCgpUaGFua3MgZm9yIGhhdmluZyBh
IGxvb2suCgo+IFRvIGJlIG9uIHRoZSBzYWZlIHNpZGUsIEkgd291bGQgc3VnZ2VzdCBhcHBseWlu
ZyB0aGUgcGF0Y2ggdG8gYWxsIGtzbSoKPiB0ZXN0cywKPiBhbmQgd3JpdGUgYSBuZXcgc2luZ2xl
IGZvciBzbWFydF9zY2FuIGlmIG5lZWRlZC4KCkFncmVlLiBJIHZvdGUgZm9yIG5ldyBzaW5nbGUg
Zm9yIHNtYXJ0X3NjYW4gcmVsYXRlZCB0ZXN0LgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
