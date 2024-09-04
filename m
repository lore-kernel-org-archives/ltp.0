Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96B4CD3431
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725435291; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=3C5SuFdCATd1Jd2MLXhqj9oT8Hnv1Qh/FeTzYm3CWdQ=;
 b=Od23pD4AC3c7ux23vM32fGvUDq2B28VlFx5QORjLVipYwcB2u/FfI6hr59dFz7NdZuPfv
 MgP1u7zSeNJSRrz8hv9jRPLoj+Is+Ql7wK6CJIGz2GPlFjRmAl1nCAyBnN89++P6yc/GnNp
 GdKpno7zsxdBS+ofOJJOjqH9EXCe/50=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 216F23C1A19
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 09:34:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 783203C006F
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 09:34:23 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=wozizhi@huawei.com; receiver=lists.linux.it)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9706514098D2
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 09:34:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzDgF304Fz1HFm4
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 15:30:49 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
 by mail.maildlp.com (Postfix) with ESMTPS id B708F18002B
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 15:34:16 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 15:34:16 +0800
Message-ID: <aae4c325-f2c6-4495-94e0-e4b4a4a8b6c7@huawei.com>
Date: Wed, 4 Sep 2024 15:34:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240830130003.3245531-1-wozizhi@huawei.com>
 <20240903140807.GA762653@pevik>
In-Reply-To: <20240903140807.GA762653@pevik>
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10: Calling drop_cache twice to ensure
 the inode is evicted
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
From: Zizhi Wo via ltp <ltp@lists.linux.it>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, jack@suse.cz, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgrlnKggMjAyNC85LzMgMjI6MDgsIFBldHIgVm9yZWwg5YaZ6YGTOgo+IEhpIGFsbCwKPiAKPj4g
SW4gdGhpcyB0ZXN0IGNhc2UsIHNvbWUgc2NlbmFyaW9zIGFyZSBkZXNpZ25lZCB0byB2ZXJpZnkg
d2hldGhlciB0aGUKPj4gRkFOT1RJRllfRVZJQ1RBQkxFIGZsYWcgdGFrZXMgZWZmZWN0OiBieSB2
ZXJpZnlpbmcgdGhhdCBpbmZvcm1hdGlvbiBjYW5ub3QKPj4gYmUgb2J0YWluZWQgZnJvbSB0aGUg
Y29ycmVzcG9uZGluZyBpbm9kZSBhZnRlciBkcm9wX2NhY2hlLCBhcyB0aGlzIGZsYWcKPj4gZG9l
cyBub3QgcGluZyB0aGUgaW5vZGUuCj4gCj4+IEhvd2V2ZXIsIGRyb3BfY2FjaGUgaXMgb25seSBw
ZXJmb3JtZWQgb25jZSBoZXJlLCB3aGljaCBtYXkgcmVzdWx0IGluIHRoZQo+PiBpbm9kZSBub3Qg
YmVpbmcgcmVsZWFzZWQgaW4gTlVNQSBzY2VuYXJpb3MuIFN1cHBvc2UgdGhlIGlub2RlIGlzIGxv
Y2F0ZWQKPj4gb24gTlVNQTAgYW5kIHRoZSBkZW50cnkgaXMgbG9jYXRlZCBvbiBOVU1BMTsgdGhl
IGZpcnN0IGRyb3BfY2FjaGUgY2FuIG9ubHkKPj4gZW5zdXJlIHRoYXQgdGhlIGlub2RlIGlzIGFk
ZGVkIHRvIHRoZSBMUlUgbGlzdCwgYnV0IGRvZXMgbm90IGd1YXJhbnRlZSB0aGF0Cj4+IGV2aWN0
KCkgY2FuIGJlZW4gY2FsbGVkIGJlY2F1c2UgZGlzcG9zZV9saXN0IGRvZXMgbm90IHlldCBpbmNs
dWRlIHRoaXMKPj4gaW5vZGUgd2hlbiB0cmF2ZXJzaW5nIE5VTUEwLCB3aGljaCBjYXVzZXMgdGhl
IHRlc3RjYXNlIGV4ZWN1dGlvbiBmYWlsLgo+IAo+IEkgd29uZGVyIGlmIHRoZXJlIGNhbiBiZSBz
b21lIGRldGVjdGlvbiB0aGF0IGlub2RlIGlzIGV2aWN0ZWQuCj4gT3IsIGNhbiBpdCBoYXBwZW4g
dGhhdCBldmVuIDJ4IGRyb3AgaXMgbm90IGVub3VnaD8KCkluIHRoaXMgdGVzdGNhc2Ugc2NlbmFy
aW8sIHRoZXJlIGlzIG9ubHkgYSBzaW5nbGUgbGF5ZXIgb2YgZGVudHJ5LCBhbmQKdGhlcmUgYXJl
IG5vIGludGVyZGVwZW5kZW5jaWVzIGJldHdlZW4gdGhlIGRlbnRyaWVzLiBUaGVyZWZvcmUsIHRo
ZQpkZXBlbmRlbmN5IGNoYWluIG9ubHkgY29uc2lzdHMgb2YgZGVudHJ5LT5pbm9kZS4gU28gaW4g
bXkgb3BpbmlvbiwgCnBlcmZvcm1pbmcgZHJvcF9jYWNoZSB0d2ljZSBlbnN1cmVzIHRoYXQgdGhl
IGlub2RlIGlzIGV2aWN0ZWQ/CgpJIGhhdmVuJ3QgYmVlbiBhYmxlIHRvIGNvbWUgdXAgd2l0aCBh
IGdvb2Qgc29sdXRpb24gZm9yIGRldGVjdGluZwp3aGV0aGVyIGFuIGlub2RlIGhhcyBiZWVuIGV2
aWN0ZWQuIEkgd291bGQgYXBwcmVjaWF0ZSBoZWFyaW5nIGV2ZXJ5b25lJ3MKdGhvdWdodHMgYW5k
IHN1Z2dlc3Rpb25zIG9uIHRoaXMgbWF0dGVyLiBUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2Uu
CgpUaGFua3MsClppemhpIFdvCgo+IAo+PiBGb3IgdGhlIHNpbmdsZS1maWxlIHNjZW5hcmlvIGlu
IHRoaXMgdGVzdGNhc2UsIGV4ZWN1dGluZyBkcm9wX2NhY2hlIHR3aWNlCj4+IGlzIG5lY2Vzc2Fy
eSB0byBlbnN1cmUgdGhlIGlub2RlIGlzIGV2aWN0ZWQsIHRodXMgYWxsb3dpbmcgdGhlIHRlc3Rj
YXNlIHRvCj4+IHBhc3MuCj4gCj4gQWNrZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+IAo+IEBBbWlyLCBKYW4sIGNvdWxkIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2s/Cj4gCj4gS2lu
ZCByZWdhcmRzLAo+IFBldHIKPiAKPj4gU2lnbmVkLW9mZi1ieTogWml6aGkgV28gPHdveml6aGlA
aHVhd2VpLmNvbT4KPj4gLS0tCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTEwLmMgfCAyICsrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+IAo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTEwLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5
MTAuYwo+PiBpbmRleCBjNmQ4ZWM5MjIuLjQyMDE4ZGUwZCAxMDA2NDQKPj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEwLmMKPj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEwLmMKPj4gQEAgLTUxNSw2ICs1
MTUsOCBAQCBzdGF0aWMgdm9pZCBkcm9wX2NhY2hlcyh2b2lkKQo+PiAgIAlpZiAoc3luY2ZzKGZk
X3N5bmNmcykgPCAwKQo+PiAgIAkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgIlVuZXhwZWN0ZWQg
ZXJyb3Igd2hlbiBzeW5jaW5nIGZpbGVzeXN0ZW0iKTsKPiAKPj4gKwkvKiBOZWVkIHRvIGRyb3Ag
dHdpY2UgdG8gZW5zdXJlIHRoZSBpbm9kZSBpcyBldmljdGVkLiAqLwo+PiArCVNBRkVfRklMRV9Q
UklOVEYoRFJPUF9DQUNIRVNfRklMRSwgIjMiKTsKPj4gICAJU0FGRV9GSUxFX1BSSU5URihEUk9Q
X0NBQ0hFU19GSUxFLCAiMyIpOwo+PiAgIH0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
