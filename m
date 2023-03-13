Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BEEC6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 08:24:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D576C3CAE93
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 09:24:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8B333C1047
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 09:24:19 +0100 (CET)
Received: from m15221.mail.126.com (m15221.mail.126.com [220.181.15.221])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 1C9EF100054A
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 09:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=bwypAnAVum/kwiv0yYbLcDWDVd69uS7shx8X0pOKkbQ=; b=Q
 WnFwB3FiZBbOo95FjWAxF2/9YPJSFtNlpVzA28YRG/EEztMxbXq+YFc/5al4JgaF
 UlhvNbrLguA8HWeOXrJqdhuU+NbDmCf5R8YHIgFhj0gM+zh29DOQTf4yDyuj/Rtf
 0m71PiIbABaxrcqAcWvgox22VkNl+A5uBkFbPNYb3I=
Received: from gehao618$163.com ( [240e:468:612:2310:1c39:99f2:36d2:addf] )
 by ajax-webmail-wmsvr208 (Coremail) ; Mon, 13 Mar 2023 16:24:12 +0800
 (GMT+08:00)
X-Originating-IP: [240e:468:612:2310:1c39:99f2:36d2:addf]
Date: Mon, 13 Mar 2023 16:24:12 +0800 (GMT+08:00)
From: gehao618 <gehao618@163.com>
To: "Li Wang" <liwang@redhat.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 MailMasterIOS/7.12.5.1913_(15.6.1) Copyright (c) 2002-2023 www.mailtech.cn
 163com
In-Reply-To: <CAEemH2f5jwOzP37ObYnMvgafeX2EO53G4jmDiBvtaFvcG0sbtQ@mail.gmail.com>
References: <20230309031517.198523-1-gehao@kylinos.cn>
 <20230309091655.225444-1-gehao@kylinos.cn>
 <CAEemH2f5jwOzP37ObYnMvgafeX2EO53G4jmDiBvtaFvcG0sbtQ@mail.gmail.com>
X-CM-CTRLMSGS: QbrqAQ==
X-NTES-SC: AL_QuycCvqSukAu5CeRYukXm08Qg+Y5UMq4uPQu1YBTN5E0mCDB/iwFX1Z8A3zf0sa3CAW3mTGYYBNi18p0R5V4fKSh7y0iQENc0H+A6obMMvLZ
MIME-Version: 1.0
Message-ID: <c39b6d7.3f25.186da11eb00.Coremail.gehao618@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: j8eowAD3PSes3Q5k_EgcAA--.46515W
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/xtbBdRcxFlaED-RuawABso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V2] memcg_stress_test.sh: Fix reserved mem
 calculate
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
Cc: gehao <gehao@kylinos.cn>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkKCgogICAgVGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dC4KICAgIEkgZ2V0IGEg
bG90IG9mIGluc3BpcmF0aW9uIGZvcm0gaXQuCiAgICBUaGVzZSBjYWxjdWxhdGlvbnMgYXJlIG1v
cmUgYWNjdXJhdGUuCgoKVGhhbmtzCkJlc3QgUmVnYXJkcwpIYW8KLS0tLSBSZXBsaWVkIE1lc3Nh
Z2UgLS0tLQp8IEZyb20gfCBMaSBXYW5nPGxpd2FuZ0ByZWRoYXQuY29tPiB8CnwgRGF0ZSB8IDAz
LzEzLzIwMjMgMTM6NTkgfAp8IFRvIHwgSGFvIEdlPGdlaGFvQGt5bGlub3MuY24+IHwKfCBDYyB8
IGx0cDxsdHBAbGlzdHMubGludXguaXQ+IHwKfCBTdWJqZWN0IHwgUmU6IFtMVFBdIFtQQVRDSCBW
Ml0gbWVtY2dfc3RyZXNzX3Rlc3Quc2g6IEZpeCByZXNlcnZlZCBtZW0gY2FsY3VsYXRlIHwKSGkg
SGFvLAoKT24gVGh1LCBNYXIgOSwgMjAyMyBhdCA1OjE34oCvUE0gSGFvIEdlIDxnZWhhb0BreWxp
bm9zLmNuPiB3cm90ZToKCj4gV2hlbiBydW5uaW5nIHRoaXMgdGVzdCBjYXNlIG9uIGEgbWFjaGlu
ZSB3aXRoIGxhcmdlIG1lbW9yeSwKPiBhbmQgd2l0aG91dCBzd2FwIG9yIHN3YXAgaXMgdG9vIHNt
YWxsLGV4aXN0aW5nIHJlc2VydmVkCj4gbWVtb3J5IGlzIHRvbyBzbWFsbCBmb3IgYSBtYWNoaW5l
IHdpdGggbGFyZ2UgbWVtb3J5LGFuZAo+IHdpbGwgY2F1c2UgZm9ya2luZyBhIHN1YnByb2Nlc3Mg
dG8gcnVuIGEgY29tbWFuZCB3aWxsIGZhaWwKPiBkdWUgdG8gbWVtb3J5IGlzIGV4aGF1c3RlZCxz
byBvcHRpbWl6ZSByZXNlcnZlZCBtZW1vcnkKPiBjYWxjdWxhdGUgdG8gdGVuIHBlcmNlbnQgb2Yg
ZnJlZSBtZW1vcnkuCj4KPiBIZXJlIGlzIGFuIGV4YW1wbGU6Cj4KPiBmcmVlIC1tCj4gICAgICAg
ICAgICAgICB0b3RhbCAgICAgICAgdXNlZCAgICAgICAgZnJlZSAgICAgIHNoYXJlZCAgYnVmZi9j
YWNoZQo+ICBhdmFpbGFibGUKPiBNZW06ICAgICAgICAgMjYwMTg0ICAgICAgICAyOTU5ICAgICAg
MjU1ODU0ICAgICAgICAgIDYyICAgICAgICAxMzcwCj4gMjM2MzQ2Cj4gU3dhcDogICAgICAgICAg
NDA5NSAgICAgICAgICAgMCAgICAgICAgNDA5NQo+Cj4gd2hlbiB5b3UgcnVuIHRoaXMgdGVzdGNh
c2UsY29uc29sZSB3aWxsIHJlcG9ydAo+IGZvcmvvvJpDYW5ub3QgYWxsb2NhdGUgbWVtb3J5Cj4K
PiBTaWduZWQtb2ZmLWJ5OiBIYW8gR2UgPGdlaGFvQGt5bGlub3MuY24+Cj4gLS0tCj4gIC4uLi9r
ZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoICAgIHwg
NiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQKPiBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cv
c3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCj4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xs
ZXJzL21lbWNnL3N0cmVzcy9tZW1jZ19zdHJlc3NfdGVzdC5zaAo+IGluZGV4IGNiNTI4NDBkNy4u
ZjI2YTlmNzJhIDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVt
Y2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9j
b250cm9sbGVycy9tZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2gKPiBAQCAtNDAsNyAr
NDAsNyBAQCBzZXR1cCgpCj4gICAgICAgICBNRU09JCgoICRtZW1fZnJlZSArICRzd2FwX2ZyZWUg
LyAyICkpCj4gICAgICAgICBNRU09JCgoICRNRU0gLyAxMDI0ICkpCj4gICAgICAgICBSVU5fVElN
RT0kKCggMTUgKiA2MCApKQo+IC0gICAgICAgWyAiJHBnc2l6ZSIgPSAiNDA5NiIgXSAmJiBUSFJF
QURfU1BBUkVfTUI9MSB8fCBUSFJFQURfU1BBUkVfTUI9OAo+ICsgICAgICAgUkVTRVJWRURfTUVN
T1JZPSQoKCAkTUVNICogMTAvMTAwICkpCj4KClRoYW5rcyBmb3IgdGhlIGltcHJvdmVtZW50IHdv
cmsuCgpCdXQgSU1ITywgdGhpcyBkb2VzIG5vdCBjb21wbGV0ZWx5IHJlc29sdmUgdGhlIHBvdGVu
dGlhbCBpc3N1ZSB3aGljaAppbiBlYXRpbmcgZnJlZV9tZW0gZm9yIHN0cmVzcyB0ZXN0aW5nLgoK
V2UgaGF2ZSB0byBjb25zaWRlciBtYW55IHNjZW5hcmlvcyBmb3IgdGhlIHN5c3RlbSdzIGF2YWls
YWJsZSBtZW1vcnkKaW5jbHVkaW5nIHdpdGhvdXQgc3dhcCBmaWxlLCBmcmVlX21lbSA+IGF2YWls
X21lbSwgYW5kIG1pbl9mcmVlX2tieXRlcwppbXBhY3Rpb24uCgpGb3IgZXhhbXBsZSwgeW91ciBw
YXRjaCBtYXkgX25vdF8gd29yayBvbiB0aGlzOgoKTWVtVG90YWw6ICAgICAgIDM2MDQ0NTQ0IGtC
Ck1lbUZyZWU6ICAgICAgICAyOTE3NzcyOCBrQgpNZW1BdmFpbGFibGU6ICAgMjYzOTE0ODgga0IK
Li4uClN3YXBUb3RhbDogICAgICAgICAgICAgMCBrQgpTd2FwRnJlZTogICAgICAgICAgICAgIDAg
a0IKCkkgd291bGQgc3VnZ2VzdCB5b3UgdGFrZSBhIGxvb2sgaW50bzoKCmh0dHBzOi8vZ2l0aHVi
LmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2xpYi90c3RfbWVtdXRpbHMu
YyNMMTkKdG8gc2VlIGhvdyB0aGlzIGZ1bmN0aW9uIHRyZWF0cyB0aGlzIGFuZCBrZWVwcyBhIHNh
ZmV0eSBtZW0gbWFyZ2luLgpIb3BlIGl0IGdpdmVzIHlvdSBzb21lIGluc3BpcmF0aW9uLgoKCgoK
Pgo+ICAgICAgICAgdHN0X3JlcyBUSU5GTyAiQ2FsY3VsYXRlZCBhdmFpbGFibGUgbWVtb3J5ICRN
RU0gTUIiCj4gIH0KPiBAQCAtOTMsMTIgKzkzLDEyIEBAIHJ1bl9zdHJlc3MoKQo+Cj4gIHRlc3Qx
KCkKPiAgewo+IC0gICAgICAgcnVuX3N0cmVzcyAxNTAgJCgoICgkTUVNIC0gMTUwICogJFRIUkVB
RF9TUEFSRV9NQikgLyAxNTAgKSkgNQo+ICRSVU5fVElNRQo+ICsgICAgICAgcnVuX3N0cmVzcyAx
NTAgJCgoICgkTUVNIC0gJFJFU0VSVkVEX01FTU9SWSkgLyAxNTAgKSkgNSAkUlVOX1RJTUUKPiAg
fQo+Cj4gIHRlc3QyKCkKPiAgewo+IC0gICAgICAgcnVuX3N0cmVzcyAxICQoKCAkTUVNIC0gJFRI
UkVBRF9TUEFSRV9NQikpIDUgJFJVTl9USU1FCj4gKyAgICAgICBydW5fc3RyZXNzIDEgJCgoICRN
RU0gLSAkUkVTRVJWRURfTUVNT1JZKSkgNSAkUlVOX1RJTUUKPiAgfQo+Cj4gIC4gY2dyb3VwX2xp
Yi5zaAo+IC0tCj4gMi4yNS4xCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLQpSZWdhcmRzLApMaSBXYW5nCgotLQpN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
