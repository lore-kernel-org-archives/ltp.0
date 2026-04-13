Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E50FE9380E
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776050775; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BEfibAkdRBkp09Q3l8mAikrj8XhliMCgjpHlthMIFJk=;
 b=jomUxaf8Usvjbz1esOJxeYvF9qdeUXxRFHr0y3SPLLgOoOgyNsY1qKFKHlna1NnhgTrrb
 Lo4LIk33I9tzSyzBpyN/DMnCGrD8f8cQh190ACMsKkn3jEfSVrHBF3Q9IJ4CT8CFjEm5+Fr
 PE9b+LB80mnpeoq5V53+FGn0nz91uIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE30B3E295A
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 05:26:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10D963DD13E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 05:25:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5663A600541
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 05:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776050748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkulzlithTP7oOu2npQxcOHxUF7aeI4n50UI6A+722s=;
 b=EZcAZKOIEC/vYEgS3ATUNh/STZbRyprBTIJfArU1p7KrEjSxEMEhugKCZr/dnT21WUvlSq
 nVzd5ZdQI89QWnpPGSvIipI+cNlnCXtNqWu67mXa2cIQBt11oSQ0hto1d5S/txSBjlk5D1
 HPE0+bn/kJIalUEFVqSBIcunRlRzU0w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-VvX6x84JOVWqsUymeU3HDg-1; Sun, 12 Apr 2026 23:25:46 -0400
X-MC-Unique: VvX6x84JOVWqsUymeU3HDg-1
X-Mimecast-MFC-AGG-ID: VvX6x84JOVWqsUymeU3HDg_1776050746
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c6e24ee93a6so1852871a12.0
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 20:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776050746; x=1776655546;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dkulzlithTP7oOu2npQxcOHxUF7aeI4n50UI6A+722s=;
 b=kWDz7L99HdUlPv0M8AGJb1cxxeNCHnUkd2QF0f3d8lpywNu+PyGU9U93fO5e443JCF
 lCHPAGNttklhtd7SuMkWWscLGCScaYtlEI/6C0UIjGa5NjsLQSyXH+2Ql6hM4x/WjwBN
 mFrWTB5yJI3ilE0EZsc25cmLW0VNTG8eEqiYqGE93K0YtpthzDHvoyyERtByw+WBB1e+
 JWUItLUcnB1P9NNLTySkpawJHjuzZSOh+vy/vtU5uIY8JzBbgHQBNy4P3OeniSgN0Xca
 QtZT5AEOwQmESBxYiezWI5m/MqckRabiFO7ch2xO8Fyd6h8Y8YV0Doqvy6bl6L4ZbmH/
 N7ug==
X-Gm-Message-State: AOJu0YxWWZblpze5lNEIMUygKRtX6qIgXGUoIAu630NheTPahQ3xe9Ik
 QGGs8oailiSPNfGpdBO8WHcUcKgsWRxm+npUmMnoZM1gmlGnl+OaNqcE2EfxV+z61p28P1mkfpr
 oXka6L3nkdTeasVkjgXc4CiAZrNWbeF87ztbGsvj/aONDR6Z7vGIk
X-Gm-Gg: AeBDiesXrcWo8/gqbgV1kJiQxSpVcBG+Cyy0r+k9xZJ7iO4j6dlOnarq8HFico6Ei5j
 cAqW9wykwnZ0l/ogQ4cDicQsf9RUC4g0i8GPWFtYIQCnHOZJv8VYB2BJPyangaMoRab/uczocjr
 VmNJKbpVNZI/iYMhWxo+R0VO3jG45Qzj5XjpBu2pIChbs6czNddeyUk/ZkjmbDMjIeL3TQYgoJc
 +4XPJgvLcWczEdj87EV5cyS/kCdmqp3Qbpy7XKq8XQGUXlGD/cxS1Gkk+iIinAGfVeRp6AWJnqW
 kAQtduwgi13274Hgy3vtbctlYrkXJXcf8lJrkEMsly10BW4I1WIojMPKjc07VVfBuaxyP68EaFf
 s2AdnRU1cjxeyw/TPcA==
X-Received: by 2002:a05:6a20:7486:b0:39f:c93e:c7f7 with SMTP id
 adf61e73a8af0-39fe3f29f63mr10656634637.0.1776050745620; 
 Sun, 12 Apr 2026 20:25:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:7486:b0:39f:c93e:c7f7 with SMTP id
 adf61e73a8af0-39fe3f29f63mr10656604637.0.1776050745049; 
 Sun, 12 Apr 2026 20:25:45 -0700 (PDT)
Received: from redhat.com ([123.121.104.131]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7921a1d0d2sm7476459a12.27.2026.04.12.20.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 20:25:44 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:25:42 +0800
To: Soma Das <somadas1@linux.ibm.com>
Message-ID: <adxiNs3KpMO-nEVG@redhat.com>
References: <6215241a-07c4-4eed-8549-0e0afc2fc096@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <6215241a-07c4-4eed-8549-0e0afc2fc096@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OUGSCTM4vGr2yswmfHHdmdYBFW-IBfVI1EZsnoehQJU_1776050746
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap: fix intermittent OOM kill of test parent in
 mmap22
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU29tYSwKCj4gwqBzdGF0aWMgdm9pZCBzdHJlc3NfY2hpbGQodm9pZCkKPiDCoHsKPiDCoCDC
oCDCoGZvciAoOzspIHsKPiBAQCAtNjMsOSArODIsMjUgQEAgc3RhdGljIHZvaWQgdGVzdF9tbWFw
KHZvaWQpCj4gCj4gwqAgwqAgwqB2ZWMgPSBTQUZFX01BTExPQyhucGFnZXMpOwo+IAo+ICvCoCDC
oCAvKgo+ICvCoCDCoCDCoCogUHJvdGVjdCB0aGUgcGFyZW50ICh0ZXN0IGhhcm5lc3MpIGZyb20g
dGhlIE9PTSBraWxsZXIuIEJvdGggcGFyZW50Cj4gK8KgIMKgIMKgKiBhbmQgY2hpbGQgc2hhcmUg
dGhlIHNhbWUgbWVtY2csIHNvIHdpdGhvdXQgYW4gZXhwbGljaXQgaGludCB0aGUgT09NCj4gK8Kg
IMKgIMKgKiBraWxsZXIgcGlja3MgYmFzZWQgb24gaGV1cmlzdGljcyB0aGF0IGNhbiBmYXZvdXIg
dGhlIHBhcmVudC4KPiArwqAgwqAgwqAqLwo+ICvCoCDCoCBzZXRfb29tX3Njb3JlX2FkaigtMTAw
MCk7Cj4gKwo+IMKgIMKgIMKgY2hpbGQgPSBTQUZFX0ZPUksoKTsKPiAtwqAgwqAgaWYgKCFjaGls
ZCkKPiArwqAgwqAgaWYgKCFjaGlsZCkgewo+ICvCoCDCoCDCoCDCoCAvKgo+ICvCoCDCoCDCoCDC
oCDCoCogTWFrZSB0aGUgY2hpbGQgdGhlIHByZWZlcnJlZCBPT00gdmljdGltLiBJZiBPT00gZmly
ZXMgd2hpbGUKPiArwqAgwqAgwqAgwqAgwqAqIHRoZSBzdHJlc3Mgd29ya2VyIGlzIGZpbGxpbmcg
bWVtb3J5LCB0aGUga2VybmVsIG11c3Qga2lsbCB0aGUKPiArwqAgwqAgwqAgwqAgwqAqIGNoaWxk
IChzdHJlc3Mgd29ya2VyKSBhbmQgbm90IHRoZSBwYXJlbnQgKHRlc3QgaGFybmVzcykuCj4gK8Kg
IMKgIMKgIMKgIMKgKiBvb21fc2NvcmVfYWRqPTEwMDAgaXMgdGhlIG1heGltdW0sIGd1YXJhbnRl
ZWluZyB0aGlzIHByb2Nlc3MKPiArwqAgwqAgwqAgwqAgwqAqIGlzIGNob3NlbiBmaXJzdCB3aXRo
aW4gdGhlIGNncm91cC4KPiArwqAgwqAgwqAgwqAgwqAqLwo+ICvCoCDCoCDCoCDCoCBzZXRfb29t
X3Njb3JlX2FkaigxMDAwKTsKClNldHRpbmcgdGhlIGNoaWxkJ3Mgb29tX3Njb3JlX2FkaiB0byAx
MDAwIGRvZXMgc2V2ZXJlbHkgY29tcHJvbWlzZSB0aGUKdmFsaWRpdHkgb2YgdGhlIHRlc3QuIFRo
aXMgd291bGQgdHlwaWNhbGx5IHJlc3VsdCBpbiBhIGZhbHNlIG5lZ2F0aXZlLgoKQmVjYXVzZSBv
bmNlIHRoZSBjaGlsZCBnZXRzIGtpbGxlZCB0aGUgbWVtb3J5IHN0cmVzcyB3aWxsIGRpc2FwcGVh
cgppbW1lZGlhdGVseSwgYnV0IHRoZSBwYXJlbnQgc3RpbGwga2VlcHMgbG9vcGluZyBmb3IgY2hl
Y2sgaWYga2VybmVsIHJlY2xhaW0KdGhvc2UgbWVtb3J5LCBpdCB3aWxsIGV2YW50YXVsbHkgcmVw
b3J0IFRGQUlMIHdoZW4gdGltZSBlbGFwc2VkLgoKSW5zdGVhZCBvZiBtb2RpZnlpbmcgb29tX3Nj
b3JlX2FkaiB0byBpbnRlcmZlcmUgd2l0aCB0aGUgT09NIGtpbGxlciwgYQpiZXR0ZXIgYXBwcm9h
Y2ggaXMgdG8gb3B0aW1pemUgaG93IHRoZSBjaGlsZCBwcm9jZXNzIGdlbmVyYXRlcyBtZW1vcnkK
cHJlc3N1cmUsIG1ha2luZyBpdCBtb3JlIHJlZmxlY3RpdmUgb2YgcmVhbC13b3JsZCBtZW1vcnkg
cmVjbGFpbSBzY2VuYXJpb3MuCgpGb3IgZXhhbXBsZSwgdGhlIGNoaWxkIHByb2Nlc3MgY2FuIGFs
bG9jYXRlIGxhcmdlciBjaHVua3MgKGUuZy4sIDFNQikgdG8KcmFwaWRseSBidWlsZCB1cCBtZW1v
cnkgcHJlc3N1cmUuIE9uY2UgdGhlIHRvdGFsIGFsbG9jYXRlZCBtZW1vcnkgYXBwcm9hY2hlcwp0
aGUgY2dyb3VwIGxpbWl0IChlLmcuLCA4MCUgY2FwYWNpdHkpLCBhIHNtYWxsIGRlbGF5IGNhbiBi
ZSBpbnRyb2R1Y2VkCmludG8gdGhlIGFsbG9jYXRpb24gbG9vcC4gVGhpcyBhcHByb2FjaCBlZmZp
Y2llbnRseSBkcml2ZXMgdGhlIHN5c3RlbSB0bwppdHMgbWVtb3J5IGxpbWl0IHdoaWxlIHByb3Zp
ZGluZyB0aGUga2VybmVsJ3MgcmVjbGFpbSBtZWNoYW5pc20gYSBzdWZmaWNpZW50CnRpbWUgd2lu
ZG93IHRvIGlkZW50aWZ5IGFuZCBkcm9wIE1BUF9EUk9QUEFCTEUgcGFnZXMuIEl0IGFsc28gZWZm
ZWN0aXZlbHkKYXZvaWRzIGFuIGluc3RhbnRhbmVvdXMgbWVtb3J5IHNwaWtlIHRoYXQgd291bGQg
b3RoZXJ3aXNlIHRyaWdnZXIgdGhlIE9PTQpraWxsZXIgcHJlbWF0dXJlbHkuCgojZGVmaW5lIENI
VU5LX1NJWkUgKDEwMjQgKiAxMDI0KQoKc3RhdGljIHZvaWQgc3RyZXNzX2NoaWxkKHNpemVfdCBj
Z19saW1pdCkKewoJc2l6ZV90IGFsbG9jYXRlZCA9IDA7CglzaXplX3QgdGhyZXNob2xkID0gY2df
bGltaXQgKiA4IC8gMTA7CgoJZm9yICg7OykgewoJCWNoYXIgKmJ1ZiA9IG1hbGxvYyhDSFVOS19T
SVpFKTsKCgkJaWYgKCFidWYpIHsKCQkJdXNsZWVwKDEwMDAwKTsKCQkJY29udGludWU7CgkJfQoK
CQltZW1zZXQoYnVmLCAnQicsIENIVU5LX1NJWkUpOwoJCWFsbG9jYXRlZCArPSBDSFVOS19TSVpF
OwoKCQlpZiAoYWxsb2NhdGVkID49IHRocmVzaG9sZCkgewoJCQl1c2xlZXAoMTAwMCk7CgkJfQoJ
fQp9CgpBbmQgc29tZSB3b3JrZmxvdyBpc3N1ZXM6CgogLSBwbGVhc2UgcmViYXNlIHlvdSBjb2Rl
IG9uIHRoZSBsYXRlc3QgYnJhbmNoIGJlZm9yZSBjb29raW5nIGEgcGF0Y2guCgogLSBVc2UgZ2l0
IHNlbmQtZW1haWwgdG8gc2VuZCBwYXRjaCB0byBMVFAgbWFpbGluZyBsaXN0LgoKIC0gRllJOiBM
VFAgaGFzIGFscmVhZHkgYWNoaWV2ZWQgdGhlIG9vbSBwcm90ZWN0aW9uIGZ1Y250aW9uczoKICAg
c2VlOiBsaWIvdHN0X21lbXV0aWxzLmgKCk5vdGU6CiBUaGlzIHdvcmstZW1haWwgd2lsbCBiZSBk
aXNhYmxlZCBzb29uLCByZXBseSB0bzogd2FuZ2xpLmFoYXVAZ21haWwuY29tCgotLSAKUmVnYXJk
cywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
