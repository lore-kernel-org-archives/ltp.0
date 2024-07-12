Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEFDC3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AA553D1B12
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 15:35:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEE5E3CBA12
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 15:45:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=leemhuis.info (client-ip=80.237.130.52;
 helo=wp530.webpack.hosteurope.de; envelope-from=regressions@leemhuis.info;
 receiver=lists.linux.it)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 918371415318
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 15:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=gWM32B86wx1XISKeXKW53i5p7I1IPlyOLxGF4sKFg+M=; t=1720791954;
 x=1721223954; b=MiwKLokhz8UT4sRwDoUJlzz0m98nyNzN52RFYcH5xhOL1nhjoaBGnL6EfaUY8
 ZzBxC1iJztuQC6dUk6nNkeuRIGWISYedxE4IP6vQ9x46lUYz/2ZE1YCb8O+Be5Vc9aAsOGHPndYbU
 otwTLVGyXeNPgZgITBhZE7kV7Av//m4aURwUuuHobdhKiT+UQgow9ARwWvwPBEgyRUAoQtcsfKqGH
 h2attjNgJ8l/cOKu0/s3YDXI47qQbKM0EM3tW8irFI5Kp4NiMWjlR9/qAn5gJjp1cVRX618HAq7C0
 K991WW2j/XSPDRFCvc7FK05uJoDLjEiK0hXk1A23b+BaubXGhg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1sSGao-0000g3-Oz; Fri, 12 Jul 2024 15:45:46 +0200
Message-ID: <868ccc20-00b3-4472-b081-0d26254a0f66@leemhuis.info>
Date: Fri, 12 Jul 2024 15:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chuck Lever III <chuck.lever@oracle.com>, Greg KH <greg@kroah.com>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
 <2024070638-shale-avalanche-1b51@gregkh>
 <E1A8C506-12CF-474B-9C1C-25EC93FCC206@oracle.com>
 <2024070814-very-vitamins-7021@gregkh>
 <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <64D2D29F-BCC0-4A44-BB75-D85B80B75959@oracle.com>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1720791954;
 abaaed9f; 
X-HE-SMSGID: 1sSGao-0000g3-Oz
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 18 Jul 2024 15:35:27 +0200
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Sherry Yang <sherry.yang@oracle.com>, linux-stable <stable@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 Calum Mackay <calum.mackay@oracle.com>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMDguMDcuMjQgMTk6NDksIENodWNrIExldmVyIElJSSB3cm90ZToKPj4gT24gSnVsIDgsIDIw
MjQsIGF0IDY6MzbigK9BTSwgR3JlZyBLSCA8Z3JlZ0Brcm9haC5jb20+IHdyb3RlOgo+PiBPbiBT
YXQsIEp1bCAwNiwgMjAyNCBhdCAwNzo0NjoxOUFNICswMDAwLCBTaGVycnkgWWFuZyB3cm90ZToK
Pj4+PiBPbiBKdWwgNiwgMjAyNCwgYXQgMTI6MTHigK9BTSwgR3JlZyBLSCA8Z3JlZ0Brcm9haC5j
b20+IHdyb3RlOgo+Pj4+IE9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDAyOjE5OjE4UE0gKzAwMDAs
IENodWNrIExldmVyIElJSSB3cm90ZToKPj4+Pj4+IE9uIEp1bCAyLCAyMDI0LCBhdCA2OjU14oCv
UE0sIENhbHVtIE1hY2theSA8Y2FsdW0ubWFja2F5QG9yYWNsZS5jb20+IHdyb3RlOgo+Pj4+Pj4g
T24gMDIvMDcvMjAyNCA1OjU0IHBtLCBDYWx1bSBNYWNrYXkgd3JvdGU6Cj4+Pj4+Pj4gSSBub3Rp
Y2VkIHlvdXIgTFRQIHBhdGNoIFsxXVsyXSB3aGljaCBhZGp1c3RzIHRoZSBuZnNzdGF0MDEgdGVz
dCBvbiB2Ni45IGtlcm5lbHMsIHRvIGFjY291bnQgZm9yIEpvc2VmJ3MgY2hhbmdlcyBbM10sIHdo
aWNoIHJlc3RyaWN0IHRoZSBORlMvUlBDIHN0YXRzIHBlci1uYW1lc3BhY2UuCj4+Pj4+Pj4gSSBz
ZWUgdGhhdCBKb3NlZidzIGNoYW5nZXMgd2VyZSBiYWNrcG9ydGVkLCBhcyBmYXIgYmFjayBhcyBs
b25ndGVybSB2NS40LAo+IFsuLi5dCj4+Pj4+PiBJJ20gd29uZGVyaW5nIGlmIHRoaXMgZGlmZmVy
ZW5jZSBiZXR3ZWVuIE5GUyBjbGllbnQsIGFuZCBORlMgc2VydmVyLCBzdGF0IGJlaGF2aW91ciwg
YWNyb3NzIGtlcm5lbCB2ZXJzaW9ucywgbWF5IHBlcmhhcHMgY2F1c2Ugc29tZSB1c2VyIGNvbmZ1
c2lvbj8KPj4+Pj4KPj4+Pj4gQXMgYSByZWZyZXNoZXIgZm9yIHRoZSBzdGFibGUgZm9sa2VuLCBK
b3NlZidzIGNoYW5nZXMgbWFrZQo+Pj4+PiBuZnNzdGF0cyBzaWxvJ2QsIHNvIHRoZXkgbm8gbG9u
Z2VyIHNob3cgY291bnRzIGZyb20gdGhlIHdob2xlCj4+Pj4+IHN5c3RlbSwgYnV0IG9ubHkgZm9y
IE5GUyBvcGVyYXRpb25zIHJlbGF0aW5nIHRvIHRoZSBsb2NhbCBuZXQKPj4+Pj4gbmFtZXNwYWNl
LiBUaGF0IGlzIGEgc3VycHJpc2luZyBjaGFuZ2UgZm9yIHNvbWUgdXNlcnMsIHRvb2xzLAo+Pj4+
PiBhbmQgdGVzdGluZy4KPj4+Pj4KPj4+Pj4gSSdtIG5vdCBjbGVhciBvbiB3aGV0aGVyIHRoZXJl
IGFyZSBhbnkgcnVsZXMvZ3VpZGVsaW5lcyBhcm91bmQKPj4+Pj4gTFRTIGJhY2twb3J0cyBjYXVz
aW5nIGJlaGF2aW9yIGNoYW5nZXMgdGhhdCB1c2VyIHRvb2xzLCBsaWtlCj4+Pj4+IG5mc3N0YXQs
IG1pZ2h0IGJlIGltcGFjdGVkIGJ5Lgo+Pj4+Cj4+Pj4gVGhlIHNhbWUgcnVsZXMgdGhhdCBhcHBs
eSBmb3IgTGludXMncyB0cmVlIChpLmUuIG5vIHVzZXJzcGFjZQo+Pj4+IHJlZ3Jlc3Npb25zLikK
Pj4+IFsuLi5dCj4+PiBJZiBubyB1c2Vyc3BhY2UgcmVncmVzc2lvbiwgc2hvdWxkIHdlIHJldmVy
dCB0aGUgSm9zZWbigJlzIE5GUyBjbGllbnQtc2lkZSBjaGFuZ2VzIG9uIExUUz8KPj4KPj4gVGhp
cyBzb3VuZHMgbGlrZSBhIHJlZ3Jlc3Npb24gaW4gTGludXMncyB0cmVlIHRvbywgc28gd2h5IGlz
bid0IGl0Cj4+IHJldmVydGVkIHRoZXJlIGZpcnN0Pwo+IAo+IFRoZXJlIGlzIGEgY2hhbmdlIGlu
IGJlaGF2aW9yIGluIHRoZSB1cHN0cmVhbSBjb2RlLCBidXQgSm9zZWYncwo+IHBhdGNoZXMgZml4
IGFuIGluZm9ybWF0aW9uIGxlYWsgYW5kIG1ha2UgdGhlIHN0YXRpc3RpY3MgbW9yZQo+IHNlbnNp
YmxlIGluIGNvbnRhaW5lciBlbnZpcm9ubWVudHMuIEknbSBub3QgY2VydGFpbiB0aGF0Cj4gc2hv
dWxkIGJlIGNvbnNpZGVyZWQgYSByZWdyZXNzaW9uLCBidXQgY29uZmVzcyBJIGRvbid0IGtub3cK
PiB0aGUgcmVncmVzc2lvbiBydWxlcyB0byB0aGlzIGZpbmUgYSBkZWdyZWUgb2YgZGV0YWlsLgoK
Q2h1Y2sgcG9pbnRlZCBtZSB0byB0aGlzIHRocmVhZCAoSSBoYWQgYW4gZXllIG9uIGl0IGFscmVh
ZHkgYW55d2F5KSBhbmQKYXNrZWQgZm9yIGFkdmljZS4gVGFrZSBldmVyeXRoaW5nIEkgd3JpdGUg
aGVyZSB3aXRoIGEgZ3JhaW4gb2Ygc2FsdCwgYXMKdGhpcyBpcyBzb21ld2hhdCB0cmlja3kgc2l0
dWF0aW9uIHdoaWNoIG1ha2VzIGl0IGhhcmQgdG8gcHJlZGljdCBob3cKTGludXMgd291bGQgYWN0
dWFsbHkgd2FudCB0byBzZWUgdGhpcyBoYW5kbGVkLiBNYXliZSBJIHNob3VsZCBoYXZlIENDZWQK
aGltLCBidXQgSSBkb3VidCBoZSBjYXJlcyByaWdodCBub3c7IGJ1dCB3ZSBtYXliZSBzaG91bGQg
YnJpbmcgaGltIGluLAppZiBhbiBhY3R1YWwgdXNlciBjb21wbGFpbnMuCgpXaXRoIHRoYXQgb3V0
IG9mIHRoZSB3YXksIGxldCBtZSB3cml0ZSBhIGZldyB0aG91Z2h0czoKCiogVGhhdCBzb21lIHRl
c3QgYnJlYWtzIGlzIG5vdCBhIHJlZ3Jlc3Npb24sIGFzIHJlZ3Jlc3Npb25zIGFyZSBhYm91dAoi
cHJhY3RpY2FsIGlzc3VlcyIsIG5vdCBzb21lIEFCSS9BUEkgY2hhbmdlcyB0aGF0IG9ubHkgc29t
ZSB0ZXN0cyBjYXJlCmFib3V0LiBTbyBpZiBpdCdzIGp1c3QgYSB0ZXN0IHRoYXQgYnJva2UgdXBk
YXRlIGl0LgoKKiBJZiBhIHVzZXIgd291bGQgcmVwb3J0ZWQgc29tZXRoaW5nIGxpa2UgInRoaXMg
Y2hhbmdlIGJyb2tlIG15IGFwcCIgaXQKb2J2aW91c2x5IHdvdWxkIGJlIHNvbWV0aGluZyB0b3Rh
bGx5IGRpZmZlcmVudC4gQnV0IHRoYXQgZGlkIG5vdCBoYXBwZW4KeWV0IGFmYWljcyAtLSBvciBk
aWQgaXQ/IEJ1dCBmcm9tIHRoZSBkaXNjdXNzaW9uIGl0IHNvdW5kcyBsaWtlIHRoYXQgaXMKc29t
ZXRoaW5nIHRoYXQgd2lsbCBsaWtlbHkgaGFwcGVuIGRvd24gdGhlIHJvYWQuIElmIHRoYXQncyB0
aGUgY2FzZSBJJ2QKc2F5IGl0J3MgYmVzdCB0byBwcmV2ZW50IHRoYXQgZnJvbSBoYXBwZW5pbmcu
CgoqIE5vdCBzdXJlIGhvdyBMaW51cyB3b3VsZCByZWFjdCBpZiBhIHVzZXIgd291bGQgY29tcGxh
aW4gdGhhdCBzb21lCndvcmtmbG93IGJyb2tlIGJlY2F1c2UgcnBjX3N0YXQgYXJlIG5vdyBwZXIg
bmV0IG5hbWVzcGFjZSBhbmQgc2hvd3MKZGlmZmVyZW50IG51bWJlcnMgKGUuZy4gdXNpbmcgYSBm
b3JtYXQgdGhhdCBkb2VzIG5vdCBicmVhayBhbnkgYXBwcykuIEl0CndvdWxkIGxpa2VseSBkZXBl
bmQgb24gdGhlIGFjdHVhbCBjYXNlIGFuZCBob3cgYmFkIGhlIHdvdWxkIGNvbnNpZGVyIHRoZQpp
bmZvcm1hdGlvbiBsZWFrLgoKPiBJZiBpdCBpcyBpbmRlZWQgYSByZWdyZXNzaW9uLCBob3cgY2Fu
IHdlIGdvIGFib3V0IHJldGFpbmluZwo+IGJvdGggYmVoYXZpb3JzIChzZWxlY3RhYmxlIGJ5IEtj
b25maWcgb3IgcGVyaGFwcyBhZG1pbmlzdHJhdGl2ZQo+IFVJKT8KClRoYXQgbGlrZWx5IG1pZ2h0
IGJlIHRoZSBiZXN0IGlkZWEgaWYgdXNlciByZXBvcnQgYW4gYWN0dWFsIHJlZ3Jlc3Npb24KZHVl
IHRvIHRoaXMuIEJ1dCBzd2l0Y2hpbmcgdGhlIGZvcm1hdCBvZiBhbnkgZXhpc3RpbmcgZmlsZSBj
cmVhdGVzIHF1aXRlCnNvbWUgdHJvdWJsZSwgYXMgb3RoZXJzIGFscmVhZHkgbWVudGlvbmVkIGlu
IHRoaXMgdGhyZWFkLiBTbyBtYXliZQpwcm92aWRpbmcgdGhlIG5ld2VyIGZvcm1hdCBpbiBhIGRp
ZmZlcmVudCBmaWxlIGFuZCBhbGxvd2luZyB0byBkaXNhYmxlCnRoZSBvbGRlciBvbmUgdGhvdWdo
IGEgS2NvbmZpZyBzZXR0aW5nIG1pZ2h0IGJlIHRoZSBiZXN0IHdheSBmb3J3YXJkLgpTdXJlLCBp
dCB3b3VsZCB0YWtlIHllYXJzIHVudGlsIHBlb3BsZSB3b3VsZCBoYXZlIHN3aXRjaGVkIG92ZXIs
IGJ1dAp0aGF0J3MgaG93IGl0IGlzIHdpdGggb3VyICJubyByZWdyZXNzaW9ucyIgcnVsZS4KCkRv
ZXMgdGhhdCBoZWxwPwoKQ2lhbywgVGhvcnN0ZW4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
