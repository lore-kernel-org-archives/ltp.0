Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ADBC433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 10:09:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9821C3CAD3C
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:09:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDA9A3CAC41
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:09:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id B02F120090F
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:09:15 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A823D1FB;
 Tue,  1 Nov 2022 03:09:19 -0700 (PDT)
Received: from [10.1.26.44] (e126380.cambridge.arm.com [10.1.26.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC63F3F5A1;
 Tue,  1 Nov 2022 03:09:12 -0700 (PDT)
Message-ID: <119655bb-9534-7f83-6203-d6ce260622d6@arm.com>
Date: Tue, 1 Nov 2022 10:09:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221027163654.414017-1-teo.coupriediaz@arm.com>
 <20221027163654.414017-2-teo.coupriediaz@arm.com> <Y1/Oh4VCUiUSFIvK@yuki>
 <99c55c0c-1f51-5282-6198-dbcb6d919ea3@arm.com> <Y2AItxvngzUPG8U1@yuki>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y2AItxvngzUPG8U1@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] regen.sh: Use intptr_t for tst_syscall
 return
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

SGksCj4gSGkhCj4+IEkgYWdyZWUsIEkgd291bGRuJ3Qgd2FudCB0byBtZXJnZSBpdC4KPj4gQXMg
bWVudGlvbmVkIGluIHRoZSBjb3ZlciwgSSB3YW50ZWQgdG8gc2hhcmUgdGhlIGxpc3Qgb2YgdGVz
dHMgSSBoYXZlCj4+IHRlc3RlZCB0aGUgcGF0Y2ggd2l0aCwKPj4gYm90aCBmb3IgcGVvcGxlIHRv
IHRlc3QgdGhlbXNlbHZlcyBpZiB0aGV5IHdhbnQgdG8gYW5kIGFzIGEgd2F5IHRvIGFzawo+PiBp
ZiB0aGVyZSB3YXMgYW55dGhpbmcgSSBtaXNzZWQKPj4gd2hpbGUgdGVzdGluZyB3aXRoIHRoYXQu
Cj4+IEkgZGlkbid0IHJlYWxseSBrbm93IGhvdyB0byBzaGFyZSB0aGlzLCBzbyBJIGFkZGVkIGl0
IGFzIHBhcnQgb2YgdGhlCj4+IGNvbW1pdCBmb3IgdGhlIFJGQy4gTWF5YmUgaXQgd291bGQKPj4g
Zml0IGJldHRlciBhcyBwYXJ0IG9mIHRoZSBjb3ZlciBsZXR0ZXIgPyBPciBhZnRlciB0aGUgY29t
bWl0IGRlc2NyaXB0aW9uCj4+IHdpdGggdGhlIHNob3J0bG9nID8KPj4gSXQgbWlnaHQgYmUgYmV0
dGVyIHJlbW92ZWQgYWx0b2dldGhlciBhbmQgcGVvcGxlIGNhbiB0ZXN0IHdpdGggYSBsYXJnZXIK
Pj4gc2NvcGUgYW55d2F5ICEKPiBNYXliZSBqdXN0IGEgc2VwYXJhdGUgcGF0Y2ggd2l0aCBbRE8g
Tk9UIE1FUkdFXSBpbiB0aGUgdGl0dGxlPwoKVGhhdCBkb2VzIG1ha2Ugc2Vuc2UsIEkgd2lsbCBz
cGxpdCBpdCBhcyBzdWNoIHdoZW4gc2VuZGluZyB0aGUgbm9uLVJGQyAKdmVyc2lvbi4KClRoYW5r
cyBmb3IgdGhlIGd1aWRhbmNlICEKQmVzdCByZWdhcmRzLApUw6lvIENvdXByaWUgRGlhegoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
