Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1877BEB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 11:39:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F97F3CC6D4
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 13:39:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BF453CC313
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 13:38:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4BAA1600872
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 13:38:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4546B1F889;
 Wed, 28 Jun 2023 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687952334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaYz0RfWL4tKkVaIfRwi0SkO2qSDidhpLiN6Nrrzd58=;
 b=qJkTySOukwfsUrrcrYV6XJCZIEVqYJTySEk4/dmbSBnharGbGrsKM6RKxYP2Y+Spk5Nxf5
 Raew5mwvfoIlqdaSQqz2xk8wJtJafu5x3er6s5r9jlKnM5JNP1slPelZAh+y1uuvZmgD/M
 AgN2KbULxCY73jMLwYepsEWES0I1WQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687952334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaYz0RfWL4tKkVaIfRwi0SkO2qSDidhpLiN6Nrrzd58=;
 b=B23rf3/dGr8ohdTbWwcEONbM4T+RlbCFDv9efd2JhsLg7t5TXHt8XlSIYJBoyDNEAYGZIu
 3spB9gGbDICBesCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3494B138E8;
 Wed, 28 Jun 2023 11:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yovODM4bnGSSQQAAMHmgww
 (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 11:38:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id BDA7AA0707; Wed, 28 Jun 2023 13:38:53 +0200 (CEST)
Date: Wed, 28 Jun 2023 13:38:53 +0200
From: Jan Kara <jack@suse.cz>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Message-ID: <20230628113853.2b67fic5nvlisx3r@quack3>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/3] fanotify accounting for fs/splice.c
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Chung-Chiang Cheng <cccheng@synology.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8hCgpPbiBUdWUgMjctMDYtMjMgMjI6NTA6NDYsIEFoZWxlbmlhIFppZW1pYcWEc2thIHdy
b3RlOgo+IEFsd2F5cyBnZW5lcmF0ZSBtb2RpZnkgb3V0LCBhY2Nlc3MgaW4gZm9yIHNwbGljZTsK
PiB0aGlzIGdldHMgYXV0b21hdGljYWxseSBtZXJnZWQgd2l0aCBubyB1Z2x5IHNwZWNpYWwgY2Fz
ZXMuCj4gCj4gTm8gY2hhbmdlcyB0byAyLzMgb3IgMy8zLgoKVGhhbmtzIGZvciB0aGUgcGF0Y2hl
cyBBaGVsZW5hISBUaGUgY29kZSBsb29rcyBmaW5lIHRvIG1lIGJ1dCB0byBiZSBob25lc3QKSSBz
dGlsbCBoYXZlIG9uZSB1bnJlc29sdmVkIHF1ZXN0aW9uIHNvIGxldCBtZSB0aGluayBhYm91dCBp
dCBsb3VkIGhlcmUgZm9yCmRvY3VtZW50YXRpb24gcHVycG9zZXMgOikuIERvIHdlIHdhbnQgZnNu
b3RpZnkgKGFueSBmaWxlc3lzdGVtCm5vdGlmaWNhdGlvbiBmcmFtZXdvcmsgbGlrZSBpbm90aWZ5
IG9yIGZhbm90aWZ5KSB0byBhY3R1YWxseSBnZW5lcmF0ZQpldmVudHMgb24gRklGT3M/IEZJRk9z
IGFyZSB2aXJ0dWFsIG9iamVjdHMgYW5kIGFyZSBub3QgcGFydCBvZiB0aGUKZmlsZXN5c3RlbSBh
cyBzdWNoICh3ZWxsLCB0aGUgaW5vZGUgaXRzZWxmIGFuZCB0aGUgbmFtZSBpcyksIGhlbmNlCipm
aWxlc3lzdGVtKiBub3RpZmljYXRpb24gZnJhbWV3b3JrIGRvZXMgbm90IHNlZW0gbGlrZSBhIGdy
ZWF0IGZpdCB0byB3YXRjaApmb3IgY2hhbmdlcyBvciBhY2Nlc3NlcyB0aGVyZS4gQW5kIGlmIHdl
IHNheSAieWVzIiBmb3IgRklGT3MsIHRoZW4gd2h5IG5vdApBRl9VTklYIHNvY2tldHM/IFdoZXJl
IGRvIHdlIGRyYXcgdGhlIGxpbmU/IEFuZCBpcyBpdCBhbGwgd29ydGggdGhlCnRyb3VibGU/CgpJ
IHVuZGVyc3RhbmQgdGhlIGNvbnZlbmllbmNlIG9mIGlub3RpZnkgd29ya2luZyBvbiBGSUZPcyBm
b3IgdGhlICJ0YWlsIC1mIgp1c2VjYXNlIGJ1dCB0aGVuIHdvdWxkbid0IHRoaXMgYmV0dGVyIGJl
IGZpeGVkIGluIHRhaWwoMSkgaXRzZWxmIGJ5IHVzaW5nCmVwb2xsKDcpIGZvciBGSUZPcyB3aGlj
aCwgYXMgSSd2ZSBub3RlZCBpbiBteSBvdGhlciByZXBseSwgZG9lcyBub3QgaGF2ZQp0aGUgcHJv
YmxlbSB0aGF0IHBvbGwoMikgaGFzIHdoZW4gdGhlcmUgYXJlIG5vIHdyaXRlcnM/CgpBbm90aGVy
IGlzc3VlIHdpdGggRklGT3MgaXMgdGhhdCB0aGV5IGRvIG5vdCBoYXZlIGEgY29uY2VwdCBvZiBm
aWxlCnBvc2l0aW9uLiBGb3IgaGllcmFyY2hpY2FsIHN0b3JhZ2UgdXNlY2FzZSB3ZSBhcmUgaW50
cm9kdWNpbmcgZXZlbnRzIHRoYXQKd2lsbCByZXBvcnQgZmlsZSByYW5nZXMgYmVpbmcgbW9kaWZp
ZWQgLyBhY2Nlc3NlZCBhbmQgb2ZmaWNpYWxseSBzdXBwb3J0aW5nCkZJRk9zIGlzIG9uZSBtb3Jl
IHNwZWNpYWwgY2FzZSB0byBkZWFsIHdpdGguCgpXaGF0IGlzIHN1cHBvcnRpbmcgeW91ciBjaGFu
Z2VzIGlzIHRoYXQgZnNub3RpZnkgbW9zdGx5IHdvcmtzIGZvciBGSUZPcwphbHJlYWR5IG5vdyAo
bm9ybWFsIHJlYWRzICYgd3JpdGVzIGdlbmVyYXRlIG5vdGlmaWNhdGlvbikgc28gc3BsaWNlIG5v
dAp3b3JraW5nIGNvdWxkIGJlIHZpZXdlZCBhcyBhbiBpbmNvbnNpc3RlbmN5LiBTb2NrZXRzIChh
bHRob3VnaCB0aGV5IGFyZQp2aXNpYmxlIGluIHRoZSBmaWxlc3lzdGVtKSBjYW5ub3QgYmUgb3Bl
biBzbyBmb3IgdGhlbSB0aGUgaWxsdXNpb24gb2YgYmVpbmcKYSBmaWxlIGlzIGV2ZW4gd2Vha2Vy
LgoKU28gb3ZlcmFsbCBJIGd1ZXNzIEknbSBzbGlnaHRseSBpbiBmYXZvciBvZiBtYWtpbmcgZnNu
b3RpZnkgZ2VuZXJhdGUgZXZlbnRzCm9uIEZJRk9zIGV2ZW4gd2l0aCBzcGxpY2UsIHByb3ZpZGVk
IEFtaXIgZG9lcyBub3Qgc2VlIGEgYmlnIHRyb3VibGUgaW4Kc3VwcG9ydGluZyB0aGlzIHdpdGgg
aGlzIHVwY29taW5nIEhTTSBjaGFuZ2VzLgoKCQkJCQkJCQlIb256YQoKPiBBaGVsZW5pYSBaaWVt
aWHFhHNrYSAoMyk6Cj4gICBzcGxpY2U6IGFsd2F5cyBmc25vdGlmeV9hY2Nlc3MoaW4pLCBmc25v
dGlmeV9tb2RpZnkob3V0KSBvbiBzdWNjZXNzCj4gICBzcGxpY2U6IGZzbm90aWZ5X2FjY2Vzcyhm
ZCkvZnNub3RpZnlfbW9kaWZ5KGZkKSBpbiB2bXNwbGljZQo+ICAgc3BsaWNlOiBmc25vdGlmeV9h
Y2Nlc3MoaW4pLCBmc25vdGlmeV9tb2RpZnkob3V0KSBvbiBzdWNjZXNzIGluIHRlZQo+IAo+ICBm
cy9zcGxpY2UuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiAKPiBJ
bnRlcmRpZmYgYWdhaW5zdCB2MzoKPiBkaWZmIC0tZ2l0IGEvZnMvc3BsaWNlLmMgYi9mcy9zcGxp
Y2UuYwo+IGluZGV4IDJlY2ZjY2JkYTk1Ni4uYmRiYWJjMmViZmZmIDEwMDY0NAo+IC0tLSBhL2Zz
L3NwbGljZS5jCj4gKysrIGIvZnMvc3BsaWNlLmMKPiBAQCAtMTE4NCwxMCArMTE4NCw2IEBAIGxv
bmcgZG9fc3BsaWNlKHN0cnVjdCBmaWxlICppbiwgbG9mZl90ICpvZmZfaW4sIHN0cnVjdCBmaWxl
ICpvdXQsCj4gIAkJCW91dC0+Zl9wb3MgPSBvZmZzZXQ7Cj4gIAkJZWxzZQo+ICAJCQkqb2ZmX291
dCA9IG9mZnNldDsKPiAtCj4gLQkJLy8gc3BsaWNlX3dyaXRlLT4gYWxyZWFkeSBtYXJrZWQgb3V0
Cj4gLQkJLy8gYXMgbW9kaWZpZWQgdmlhIHZmc19pdGVyX3dyaXRlKCkKPiAtCQlnb3RvIG5vYWNj
ZXNzb3V0Owo+ICAJfSBlbHNlIGlmIChvcGlwZSkgewo+ICAJCWlmIChvZmZfb3V0KQo+ICAJCQly
ZXR1cm4gLUVTUElQRTsKPiBAQCAtMTIxMSwxMSArMTIwNywxMCBAQCBsb25nIGRvX3NwbGljZShz
dHJ1Y3QgZmlsZSAqaW4sIGxvZmZfdCAqb2ZmX2luLCBzdHJ1Y3QgZmlsZSAqb3V0LAo+ICAJfSBl
bHNlCj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gIAo+IC0JaWYgKHJldCA+IDApCj4gKwlpZiAocmV0
ID4gMCkgewo+ICAJCWZzbm90aWZ5X21vZGlmeShvdXQpOwo+IC1ub2FjY2Vzc291dDoKPiAtCWlm
IChyZXQgPiAwKQo+ICAJCWZzbm90aWZ5X2FjY2Vzcyhpbik7Cj4gKwl9Cj4gIAo+ICAJcmV0dXJu
IHJldDsKPiAgfQo+IC0tIAo+IDIuMzkuMgoKCi0tIApKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4K
U1VTRSBMYWJzLCBDUgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
