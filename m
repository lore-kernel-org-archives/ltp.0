Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E2BD32D8D
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731417561; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=j9G59QaoTsJDkrRiOnvDcRrfd6CDTWsl6YBBdPG7eyA=;
 b=qvnVlQbijpZjGaKVhShDIlhbZIKQLoUuRSNWCuu6XP/OiX9EHccXADjTESNIq3UgJOW/+
 kXVyt8PX2kvFDR0nsoXRS47oihtxegiV4JDLeVxbRPp1DAE5r1ZbCSKkQMnUkDz4LJdby5Z
 b0iT58MM5pL3RHU97Nii0LFbNCx7AzA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7D4B3D5F0D
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 14:19:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 108133D5EF4
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 14:19:01 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 242FC625B48
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 14:18:59 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so3858148f8f.0
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 05:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731417538; x=1732022338; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l0recQv14qQM4+M5xYc5Z+ryekYrUNHisiOQoKVjbY0=;
 b=YRrc54rrW3Jy7Sens+mTpPXn+gpQMjcnH7WNtjZBmKhPDqswqjiEgLZhcjBu9k//u6
 cfeWffMmjtY9bkkXsZ+sYc4RbSJCzndXh8gqFEcF+JPa110lc5nEyVNBpqYIUR9BLYpU
 F4iIUJ7tGOGX0ys9mOIrh9FVftL+d4O1TeM6eG2DyYCqDGux5jsJMYDKFKfr7YCp6Q5Q
 zAzLq9FtKoDuYMNesu1Z85XZUxvNZ8Ci1u7mf4JmFOrPtsJdf+zeP8LlQ6pGC9CAHO9K
 WrWgJREaHQ7pWu32w5WAn9b7Ftx6Jxwpqf/JtlLhXynoQ2hKPqUSpCi7LxP6ToXULl/e
 SUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731417538; x=1732022338;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0recQv14qQM4+M5xYc5Z+ryekYrUNHisiOQoKVjbY0=;
 b=FAGImt+UqH2qPBXJG4ghrDsSNeM3kiu9jQO8SNUojUDpn+nByQrFa/r8/ioOonSkG6
 lbDDJzx/dpoeR7HVjz/yjfim1vZew6R85k8SIcjCxPUnGakFz+sKtxVD+cOQX6cTc2Xj
 y8fv/e8FL4XiMZ3rRHmKgJ2+0JM3ZdXjzSt3jkQFM4vR/prdu+mcSPhlclh/KtElZB7T
 2S3AI0QSDWUYgret4GhgQwOFtMNLkBS72TBKsuaP/QH38+BG6zFMegtVZ1IkQtBrd/9Y
 dEBKHdQkCB6VXYrcWHXHNaGCF6XDQQOIwVdw7OZ0wUY7zdK8BLjzQkLqQsNcUtHknLv8
 R2ug==
X-Gm-Message-State: AOJu0YxcSpo/F3FrtiIdqDX+fg+yhmU1bj/cPpVX3LuzLTZgQIi+95qe
 JdZTUBYWuSySL8CnN8ptDBB7C9gLnGGXQQGFCshfbZ9CYR3SGYyA1L3d55A6jHE=
X-Google-Smtp-Source: AGHT+IG9q39ZiM7+BQyNA575Vz9bCdb3YXjI0znQtrUyUHP3X38PfCur/3A1uKfBkicgqf0MfjNcNQ==
X-Received: by 2002:a5d:64e5:0:b0:37d:4fb1:4faa with SMTP id
 ffacd0b85a97d-381f188c2famr15357243f8f.50.1731417538459; 
 Tue, 12 Nov 2024 05:18:58 -0800 (PST)
Received: from ?IPV6:2003:ef:2f35:d900:56f9:5d66:c642:55ce?
 (p200300ef2f35d90056f95d66c64255ce.dip0.t-ipconnect.de.
 [2003:ef:2f35:d900:56f9:5d66:c642:55ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04211sm15400003f8f.94.2024.11.12.05.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:18:58 -0800 (PST)
Message-ID: <0620b026-57ae-4ec0-b20d-9e6fb6067e54@suse.com>
Date: Tue, 12 Nov 2024 14:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-2-e61249986a0a@suse.com>
 <ZuMWkXlr5XPzosn3@yuki.lan> <3c6b0382-ca23-4ac0-ae2d-2cf5ca294abf@suse.com>
Content-Language: en-US
In-Reply-To: <3c6b0382-ca23-4ac0-ae2d-2cf5ca294abf@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add process_mrelease01 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGluZyBAQ3lyaWwKCk9uIDEwLzEwLzI0IDE0OjMzLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+
IEhpIQo+Cj4gT24gOS8xMi8yNCAxODoyOCwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+PiBIaSEKPj4+
ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPj4+ICt7Cj4+PiArwqDCoMKgIGludCByZXQ7Cj4+PiAr
wqDCoMKgIGludCBwaWRmZDsKPj4+ICvCoMKgwqAgaW50IHN0YXR1czsKPj4+ICvCoMKgwqAgcGlk
X3QgcGlkOwo+Pj4gK8KgwqDCoCBpbnQgcmVzdGFydDsKPj4+ICsKPj4+ICvCoMKgwqAgZm9yICht
ZW1fc2l6ZSA9IENIVU5LOyBtZW1fc2l6ZSA8IE1BWF9TSVpFX01COyBtZW1fc2l6ZSArPSAKPj4+
IENIVU5LKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmVzdGFydCA9IDA7Cj4+PiArCj4+PiArwqDC
oMKgwqDCoMKgwqAgcGlkID0gU0FGRV9GT1JLKCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFw
aWQpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvX2NoaWxkKG1lbV9zaXplKTsKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4aXQoMCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+
Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIFRTVF9DSEVDS1BPSU5UX1dBSVQoMCk7Cj4+PiArCj4+
PiArwqDCoMKgwqDCoMKgwqAgdHN0X2Rpc2FibGVfb29tX3Byb3RlY3Rpb24ocGlkKTsKPj4+ICsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW1lbW9yeV9pc19tYXBwZWQocGlkLCAqbWVtX2FkZHIs
ICptZW1fYWRkciArIG1lbV9zaXplKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0
X3JlcyhURkFJTCwgIk1lbW9yeSBpcyBub3QgbWFwcGVkIik7Cj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+PiArCj4+PiArwqDCoMKgwqDC
oMKgwqAgcGlkZmQgPSBTQUZFX1BJREZEX09QRU4ocGlkLCAwKTsKPj4+ICsKPj4+ICvCoMKgwqDC
oMKgwqDCoCB0c3RfcmVzKFRJTkZPLCAiUGFyZW50OiBraWxsaW5nIGNoaWxkIHdpdGggUElEPSVk
IiwgcGlkKTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBTQUZFX0tJTEwocGlkLCBTSUdLSUxM
KTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSB0c3Rfc3lzY2FsbChfX05SX3Byb2Nl
c3NfbXJlbGVhc2UsIHBpZGZkLCAwKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0ID09IC0x
KSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJybm8gPT0gRVNSQ0gpIHsKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhUSU5GTywgIlBhcmVudDog
Y2hpbGQgdGVybWluYXRlZCBiZWZvcmUgIgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJwcm9jZXNzX21yZWxlYXNlKCkuIEluY3JlYXNlIG1lbW9yeSBzaXplIGFu
ZCAiCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInJlc3RhcnQg
dGVzdCIpOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXN0YXJ0
ID0gMTsKPj4gRG9lcyB0aGlzIGV2ZW4gaGFwcGVuPyBJIHN1cHBvc2UgdGhhdCB1bnRpbCB0aGUg
Y2hpbGQgaGFzIGJlZW4gd2FpdGVkCj4+IGZvciB5b3Ugc2hvdWxkbid0IGdldCBFU1JDSCBhdCBh
bGwuIFRoZSBtZW1vcnkgbWF5IGJlIGZyZWVkCj4+IGFzeW5jaHJvbm91c2x5IGJ1dCB0aGUgcGlk
ZmQgaXMgdmFsaWQgdW50aWwgd2UgZG8gd2FpdHBpZCwgYXQgbGVhc3QKPj4gdGhhdCdzIHdoYXQg
dGhlIGRlc2NyaXB0aW9uIHNheXM6Cj4+Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1tLzIwMjEwOTAyMjIwMDI5LmJmYXUzWXhOUCUyNWFrcG1AbGludXgtZm91bmRhdGlvbi5vcmcv
IAo+Pgo+Pgo+PiBCdXQgc2VsZnRlc3Qgc2VlbXMgdG8gZG8gdGhlIHNhbWUgbG9vcCBvbiBFU1JD
SCBzbyBlaXRoZXIgdGhlIHRlc3Qgb3IKPj4gdGhlIGRvY3VtZW50YXRpb24gaXMgd3JvbmcuCj4+
Cj4+IE1pY2hhbCBhbnkgaWRlYSB3aGljaCBpcyBjb3JyZWN0Pwo+Pgo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dHN0X3JlcyhURkFJTCB8IFRFUlJOTywgInByb2Nlc3NfbXJlbGVhc2UoJWQsMCkgCj4+PiBlcnJv
ciIsIHBpZGZkKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKg
wqDCoCB9IGVsc2Ugewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IHRpbWVvdXRfbXMg
PSAxMDAwOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhUUEFTUywg
InByb2Nlc3NfbXJlbGVhc2UoJWQsMCkgcGFzc2VkIiwgcGlkZmQpOwo+Pj4gKwo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgKG1lbW9yeV9pc19tYXBwZWQocGlkLCAqbWVtX2FkZHIs
ICptZW1fYWRkciArIAo+Pj4gbWVtX3NpemUpICYmCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHRpbWVvdXRfbXMtLSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdXNsZWVwKDEwMDApOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1l
bW9yeV9pc19tYXBwZWQocGlkLCAqbWVtX2FkZHIsICptZW1fYWRkciArIAo+Pj4gbWVtX3NpemUp
KQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRGQUlMLCAiTWVt
b3J5IGlzIHN0aWxsIG1hcHBlZCBpbnNpZGUgY2hpbGQgCj4+PiBtZW1vcnkiKTsKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdHN0X3JlcyhUUEFTUywgIk1lbW9yeSBoYXMgYmVlbiByZWxlYXNlZCIpOwo+PiBBcyBmYXIg
YXMgSSB1bmRlcnN0YW5kIHRoaXMgdGhpcyB3aWxsIGxpa2VseSBwYXNzIGV2ZW4gd2l0aG91dCB0
aGUKPj4gcHJvY2Vzc19tcmVsZWFzZSgpIGNhbGwgc2luY2UgdGhlIHByb2Nlc3MgYWRkcmVzcyBz
cGFjZSBpcyBiZWluZyB0ZWFyZWQKPj4gZG93biBhbnl3YXlzLiBCdXQgSSBkbyBub3QgaGF2ZSBh
biBpZGVhIGhvdyB0byBtYWtlIHRoaW5ncyBiZXR0ZXIuIEkKPj4gZ3Vlc3MgdGhhdCBpZiB3ZSB3
YW50ZWQgdG8ga25vdyBmb3Igc3VyZSB3ZSB3b3VsZCBoYXZlIHRvIHJ1biBzb21lCj4+IGNvbXBs
ZXggc3RhdGlzdGljcyB3aXRoIGFuZCB3aXRob3V0IHRoZSBzeXNjYWxsIGFuZCBjb21wYXJlIHRo
ZQo+PiB0aW1pbmdzLi4uCj4gSSBkb24ndCBrbm93LCBJIHRyaWVkIHRvIHBvcnQgdGhlIGtzZWxm
dGVzdCB0aGF0IHNlZW1lZCB0byBiZSAKPiByZWFzb25hYmxlLiBMZXQgbWUga25vdyBpZiB0aGlz
IGlzIHN0aWxsIGdvb2QsIG90aGVyd2lzZSB3ZSBuZWVkIHRvIAo+IGNoYW5nZSB0aGUgd2hvbGUg
YWxnb3JpdGhtLiBCdXQgaG9uZXN0bHkgSSBkb24ndCBzZWUgbWFueSBvdGhlciAKPiBvcHRpb25z
IHRoYW4gdGhlIGN1cnJlbnQgb25lLgo+Pgo+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+ICsKPj4+
ICvCoMKgwqDCoMKgwqDCoCBTQUZFX1dBSVRQSUQoLTEsICZzdGF0dXMsIDApOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIFNBRkVfQ0xPU0UocGlkZmQpOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
ICghcmVzdGFydCkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gK8KgwqDC
oCB9Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4+PiArewo+Pj4g
K8KgwqDCoCBtZW1fYWRkciA9IFNBRkVfTU1BUChOVUxMLAo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNp
emVvZih1bnNpZ25lZCBsb25nKSwKPj4+ICvCoMKgwqDCoMKgwqDCoCBQUk9UX1JFQUQgfCBQUk9U
X1dSSVRFLAo+Pj4gK8KgwqDCoMKgwqDCoMKgIE1BUF9TSEFSRUQgfCBNQVBfQU5PTiwKPj4+ICvC
oMKgwqDCoMKgwqDCoCAwLCAwKTsKPj4+ICt9Cj4+PiArCj4+PiArc3RhdGljIHZvaWQgY2xlYW51
cCh2b2lkKQo+Pj4gK3sKPj4+ICvCoMKgwqAgaWYgKG1lbV9hZGRyKQo+Pj4gK8KgwqDCoMKgwqDC
oMKgIFNBRkVfTVVOTUFQKG1lbV9hZGRyLCBzaXplb2YodW5zaWduZWQgbG9uZykpOwo+Pj4gK30K
Pj4+ICsKPj4+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4+PiArwqDCoMKgIC50
ZXN0X2FsbCA9IHJ1biwKPj4+ICvCoMKgwqAgLnNldHVwID0gc2V0dXAsCj4+PiArwqDCoMKgIC5j
bGVhbnVwID0gY2xlYW51cCwKPj4+ICvCoMKgwqAgLm5lZWRzX3Jvb3QgPSAxLAo+Pj4gK8KgwqDC
oCAuZm9ya3NfY2hpbGQgPSAxLAo+Pj4gK8KgwqDCoCAubWluX2t2ZXIgPSAiNS4xNSIsCj4+PiAr
wqDCoMKgIC5uZWVkc19jaGVja3BvaW50cyA9IDEsCj4+PiArfTsKPj4+Cj4+PiAtLSAKPj4+IDIu
NDMuMAo+Pj4KPj4+Cj4+PiAtLSAKPj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+IEFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
