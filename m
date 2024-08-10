Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B749C52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DD9D3D2116
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:22:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64DFD3D20DB
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:01:00 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=cel@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B88321401100
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 22:00:58 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5824C60C6D;
 Sat, 10 Aug 2024 20:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A309C4AF0C;
 Sat, 10 Aug 2024 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723320057;
 bh=fjM7Ja8K79kwkQ2MC6WZl8VEdzyTtr5c7wks7Z7H1jQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DsqvoY2YvfN3xaILraIy1FmVbfteZ3zeIHWDQ/FBHaz7F8J00lkDgQ4BN0alX+eCO
 EPxBy/f0+wNtJCLNjhz8WB4I3NtDcUzf5xtlyu4HTJslKgU1fspMND3IRealn5g3EV
 y7zKT/6DT9v6m8LNqLwa+yzznjSbi3cfyiYCNkMqj+aLvepIFWDBdChL7kMa/VuZjq
 cvtkm8Y1AbOnFq26VU06e6afDbHlGgH0LC1OGZGTs4OjD8ooZuDC6dsvl5CY8wGDqr
 fdvPQqTTQhRu6lsxYhaktM5YgmXUnwRAnzBycSnctcIaiwHfaH33E70pJtyxWxwbuU
 35w71opAmIT9w==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Date: Sat, 10 Aug 2024 15:59:58 -0400
Message-ID: <20240810200009.9882-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:43 +0200
Subject: [LTP] [PATCH 6.1.y 07/18] NFSD: Rewrite synopsis of
 nfsd_percpu_counters_init()
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
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 sherry.yang@oracle.com, Chuck Lever <chuck.lever@oracle.com>,
 calum.mackay@oracle.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+CgpbIFVwc3RyZWFtIGNv
bW1pdCA1ZWMzOTk0NGY4NzRlMWVjYzA5ZjYyNGE3MGRmYWE4YWMzYmY5ZDA4IF0KCkluIGZ1bmN0
aW9uIOKAmGV4cG9ydF9zdGF0c19pbml04oCZLAogICAgaW5saW5lZCBmcm9tIOKAmHN2Y19leHBv
cnRfYWxsb2PigJkgYXQgZnMvbmZzZC9leHBvcnQuYzo4NjY6NjoKZnMvbmZzZC9leHBvcnQuYzoz
Mzc6MTY6IHdhcm5pbmc6IOKAmG5mc2RfcGVyY3B1X2NvdW50ZXJzX2luaXTigJkgYWNjZXNzaW5n
IDQwIGJ5dGVzIGluIGEgcmVnaW9uIG9mIHNpemUgMCBbLVdzdHJpbmdvcC1vdmVyZmxvdz1dCiAg
MzM3IHwgICAgICAgICByZXR1cm4gbmZzZF9wZXJjcHVfY291bnRlcnNfaW5pdCgmc3RhdHMtPmNv
dW50ZXIsIEVYUF9TVEFUU19DT1VOVEVSU19OVU0pOwogICAgICB8ICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fgpmcy9uZnNkL2V4cG9ydC5jOjMzNzoxNjogbm90ZTogcmVmZXJlbmNpbmcgYXJndW1l
bnQgMSBvZiB0eXBlIOKAmHN0cnVjdCBwZXJjcHVfY291bnRlclswXeKAmQpmcy9uZnNkL3N0YXRz
Lmg6IEluIGZ1bmN0aW9uIOKAmHN2Y19leHBvcnRfYWxsb2PigJk6CmZzL25mc2Qvc3RhdHMuaDo0
MDo1OiBub3RlOiBpbiBhIGNhbGwgdG8gZnVuY3Rpb24g4oCYbmZzZF9wZXJjcHVfY291bnRlcnNf
aW5pdOKAmQogICA0MCB8IGludCBuZnNkX3BlcmNwdV9jb3VudGVyc19pbml0KHN0cnVjdCBwZXJj
cHVfY291bnRlciBjb3VudGVyc1tdLCBpbnQgbnVtKTsKICAgICAgfCAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgoKQ2M6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+ClJl
dmlld2VkLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpTdGFibGUtZGVwLW9m
OiA5MzQ4M2FjNWZlYzYgKCJuZnNkOiBleHBvc2UgL3Byb2MvbmV0L3N1bnJwYy9uZnNkIGluIG5l
dCBuYW1lc3BhY2VzIikKU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+Ci0tLQogZnMvbmZzZC9zdGF0cy5jIHwgMiArLQogZnMvbmZzZC9zdGF0cy5oIHwg
NiArKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2ZzL25mc2Qvc3RhdHMuYyBiL2ZzL25mc2Qvc3RhdHMuYwppbmRleCA3
NzdlMjRlNWRhMzMuLjFmZTY0ODhhMWNmOSAxMDA2NDQKLS0tIGEvZnMvbmZzZC9zdGF0cy5jCisr
KyBiL2ZzL25mc2Qvc3RhdHMuYwpAQCAtNzQsNyArNzQsNyBAQCBzdGF0aWMgaW50IG5mc2Rfc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKIAogREVGSU5FX1BST0NfU0hPV19BVFRS
SUJVVEUobmZzZCk7CiAKLWludCBuZnNkX3BlcmNwdV9jb3VudGVyc19pbml0KHN0cnVjdCBwZXJj
cHVfY291bnRlciBjb3VudGVyc1tdLCBpbnQgbnVtKQoraW50IG5mc2RfcGVyY3B1X2NvdW50ZXJz
X2luaXQoc3RydWN0IHBlcmNwdV9jb3VudGVyICpjb3VudGVycywgaW50IG51bSkKIHsKIAlpbnQg
aSwgZXJyID0gMDsKIApkaWZmIC0tZ2l0IGEvZnMvbmZzZC9zdGF0cy5oIGIvZnMvbmZzZC9zdGF0
cy5oCmluZGV4IDliNDNkYzNkOTk5MS4uYzNhYmUxODMwZGE1IDEwMDY0NAotLS0gYS9mcy9uZnNk
L3N0YXRzLmgKKysrIGIvZnMvbmZzZC9zdGF0cy5oCkBAIC0zNiw5ICszNiw5IEBAIGV4dGVybiBz
dHJ1Y3QgbmZzZF9zdGF0cwluZnNkc3RhdHM7CiAKIGV4dGVybiBzdHJ1Y3Qgc3ZjX3N0YXQJCW5m
c2Rfc3Zjc3RhdHM7CiAKLWludCBuZnNkX3BlcmNwdV9jb3VudGVyc19pbml0KHN0cnVjdCBwZXJj
cHVfY291bnRlciBjb3VudGVyc1tdLCBpbnQgbnVtKTsKLXZvaWQgbmZzZF9wZXJjcHVfY291bnRl
cnNfcmVzZXQoc3RydWN0IHBlcmNwdV9jb3VudGVyIGNvdW50ZXJzW10sIGludCBudW0pOwotdm9p
ZCBuZnNkX3BlcmNwdV9jb3VudGVyc19kZXN0cm95KHN0cnVjdCBwZXJjcHVfY291bnRlciBjb3Vu
dGVyc1tdLCBpbnQgbnVtKTsKK2ludCBuZnNkX3BlcmNwdV9jb3VudGVyc19pbml0KHN0cnVjdCBw
ZXJjcHVfY291bnRlciAqY291bnRlcnMsIGludCBudW0pOwordm9pZCBuZnNkX3BlcmNwdV9jb3Vu
dGVyc19yZXNldChzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmNvdW50ZXJzLCBpbnQgbnVtKTsKK3Zv
aWQgbmZzZF9wZXJjcHVfY291bnRlcnNfZGVzdHJveShzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmNv
dW50ZXJzLCBpbnQgbnVtKTsKIGludCBuZnNkX3N0YXRfaW5pdCh2b2lkKTsKIHZvaWQgbmZzZF9z
dGF0X3NodXRkb3duKHZvaWQpOwogCi0tIAoyLjQ1LjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
