Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EADFC433F5
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 12:00:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 289593C8FF5
	for <ltp@archiver.kernel.org>; Mon,  3 Jan 2022 13:00:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AC2D3C1482
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 13:00:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DB4460082D
 for <ltp@lists.linux.it>; Mon,  3 Jan 2022 13:00:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10F1521100;
 Mon,  3 Jan 2022 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641211245;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAZsZCAJprF2Q2klVbctjrQ6Wg6Pp7Djf+7Ty+Bt4vA=;
 b=supCT1zFzuwUyRWkRwtay8YS/gg1EqLwvf3JOEkWavfnDhwuWh/R94lhE3ELCc2fMTNqy1
 0x3A+Ik2zONZ5UVIoev/e2bQE9S4KLv01a0OJbx50ACdDuxn5I29i8agROv83jSDpHa1Gd
 FOEGO0By1qIlRpyqtDtakaMnP9UCY4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641211245;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAZsZCAJprF2Q2klVbctjrQ6Wg6Pp7Djf+7Ty+Bt4vA=;
 b=Bz2RVbKnGpZxqrzgquFZQ4MYiDLFq/uqLJcEjZcFMX02Rpon24BP+Fon6krex9HtOsRojs
 HggvysccNaUEKbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E446013A9F;
 Mon,  3 Jan 2022 12:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xmUvNmzl0mFHFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jan 2022 12:00:44 +0000
Date: Mon, 3 Jan 2022 13:00:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YdLla2Noq5SZzW/L@pevik>
References: <20211221150918.3987-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221150918.3987-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactoring aio-stress.c using LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKcXVpdGUgYmlnIGNoYW5nZXNldCwgYnV0IGl0IHByb2JhYmx5IGNvdWxkIG5v
dCBiZSBzZXBhcmF0ZWQgaW50byBtb3JlIGNvbW1pdHMgYXMKcnVudGVzdCBmaWxlIGNoYW5nZXMg
YXJlIHJlbGF0ZWQgdG8gTFRQIEFQSSBjaGFuZ2UuCgpHb29kIHdvcmssIExHVE0uCgpUaGlzIGlz
IHdvcnRoIHRvIGJlIGZpeGVkOgo+ICsJCXJldCA9IHB0aHJlYWRfam9pbih0W2ldLnRpZCwgJnJl
dHZhbCk7Cj4gKwkJaWYgKHJldCkKPiArCQkJdHN0X2JyayhUQlJPSywgInB0aHJlYWRfam9pbjog
JXMiLCB0c3Rfc3RyZXJybm8ocmV0KSk7Cj4gKwo+ICsJCXJldCA9ICgoaW50ICopIHJldHZhbCk7
CnJldCA9ICooKGludCAqKSByZXR2YWwpOwoKQm90aCBjb21waWxlciBhbmQgbWFrZSBjaGVjayB3
YXJucyBhYm91dCBpdDoKCmFpby1zdHJlc3MuYzoxMjUyOjIxOiB3YXJuaW5nOiBhc3NpZ25tZW50
IHRvIOKAmGludOKAmSBmcm9tIOKAmGludCAq4oCZIG1ha2VzIGludGVnZXIgZnJvbSBwb2ludGVy
IHdpdGhvdXQgYSBjYXN0IFstV2ludC1jb252ZXJzaW9uXQoKbWFrZSBjaGVjay1haW8tc3RyZXNz
CkNIRUNLIHRlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW8tc3RyZXNzLmMKYWlvLXN0
cmVzcy5jOjEyNTI6MjE6IHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIGFzc2lnbm1lbnQgKGRp
ZmZlcmVudCBiYXNlIHR5cGVzKQphaW8tc3RyZXNzLmM6MTI1MjoyMTogICAgZXhwZWN0ZWQgaW50
IFthc3NpZ25lZF0gcmV0CmFpby1zdHJlc3MuYzoxMjUyOjIxOiAgICBnb3QgaW50ICoKCkl0J2Qg
YmUgZ3JlYXQgaWYgeW91IGNvdWxkIGZpeCBhdCBsZWFzdCBzb21lIG9mIG90aGVyIGNvbXBpbGVy
IHdhcm5pbmdzOgoKYWlvLXN0cmVzcy5jOiBJbiBmdW5jdGlvbiDigJhjaGVja19maW5pc2hlZF9p
b+KAmToKYWlvLXN0cmVzcy5jOjMzODoxMzogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmGxl
bmd0aOKAmSBbLVd1bnVzZWQtdmFyaWFibGVdCiAgMzM4IHwgICAgICAgICBpbnQgbGVuZ3RoOwog
ICAgICB8ICAgICAgICAgICAgIF5+fn5+fgphaW8tc3RyZXNzLmM6IEluIGZ1bmN0aW9uIOKAmGNy
ZWF0ZV9vcGVy4oCZOgphaW8tc3RyZXNzLmM6NjkwOjYzOiB3YXJuaW5nOiB1bnVzZWQgcGFyYW1l
dGVyIOKAmGl0ZXLigJkgWy1XdW51c2VkLXBhcmFtZXRlcl0KICA2OTAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGludCByZWNsZW4sIGludCBkZXB0aCwgaW50IGl0ZXIsCiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH5+fn5efn5+CmFpby1zdHJlc3MuYzogSW4gZnVuY3Rpb24g4oCYb3Blcl9ydW5uYWJs
ZeKAmToKYWlvLXN0cmVzcy5jOjg0ODoxMzogd2FybmluZzogdmFyaWFibGUg4oCYcmV04oCZIHNl
dCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAgODQ4IHwgICAgICAg
ICBpbnQgcmV0OwogICAgICB8ICAgICAgICAgICAgIF5+fgphaW8tc3RyZXNzLmM6IEluIGZ1bmN0
aW9uIOKAmHNldHVwX3NoYXJlZF9tZW3igJk6CmFpby1zdHJlc3MuYzoxMDEzOjM4OiB3YXJuaW5n
OiB1bnVzZWQgcGFyYW1ldGVyIOKAmG1heF9pb19zdWJtaXTigJkgWy1XdW51c2VkLXBhcmFtZXRl
cl0KIDEwMTMgfCAgICAgICAgICAgICAgICAgICAgICBpbnQgcmVjbGVuLCBpbnQgbWF4X2lvX3N1
Ym1pdCkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+Xn5+fn5+
fn5+fn5+fgphaW8tc3RyZXNzLmM6IEluIGZ1bmN0aW9uIOKAmHJ1bl93b3JrZXJz4oCZOgphaW8t
c3RyZXNzLmM6MTI0Mjo1NTogd2FybmluZzogY2FzdCBiZXR3ZWVuIGluY29tcGF0aWJsZSBmdW5j
dGlvbiB0eXBlcyBmcm9tIOKAmGludCAoKikoc3RydWN0IHRocmVhZF9pbmZvICop4oCZIHRvIOKA
mHZvaWQgKiAoKikodm9pZCAqKeKAmSBbLVdjYXN0LWZ1bmN0aW9uLXR5cGVdCiAxMjQyIHwgICAg
ICAgICAgICAgICAgIHJldCA9IHB0aHJlYWRfY3JlYXRlKCZ0W2ldLnRpZCwgTlVMTCwgKHN0YXJ0
X3JvdXRpbmUpIHdvcmtlciwgdCArIGkpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KYWlvLXN0cmVzcy5jOjEyNTI6MjE6IHdh
cm5pbmc6IGFzc2lnbm1lbnQgdG8g4oCYaW504oCZIGZyb20g4oCYaW50ICrigJkgbWFrZXMgaW50
ZWdlciBmcm9tIHBvaW50ZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCiAxMjUy
IHwgICAgICAgICAgICAgICAgIHJldCA9ICgoaW50ICopIHJldHZhbCk7CiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICBeCmFpby1zdHJlc3MuYzogSW4gZnVuY3Rpb24g4oCYc2V0dXDigJk6CmFp
by1zdHJlc3MuYzoxMjY5OjQyOiB3YXJuaW5nOiBpbnRlZ2VyIG92ZXJmbG93IGluIGV4cHJlc3Np
b24gb2YgdHlwZSDigJhpbnTigJkgcmVzdWx0cyBpbiDigJgtMjE0NzQ4MzY0OOKAmSBbLVdvdmVy
Zmxvd10KIDEyNjkgfCAgICAgICAgIGNvbnRleHRfb2Zmc2V0ID0gMiAqIDEwMjQgKiAxMDI0ICog
MTAyNDsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
YWlvLXN0cmVzcy5jOiBJbiBmdW5jdGlvbiDigJhjaGVja19maW5pc2hlZF9pb+KAmToKYWlvLXN0
cmVzcy5jOjM3Mjo0MTogd2FybmluZzogaWdub3JpbmcgcmV0dXJuIHZhbHVlIG9mIOKAmGFzcHJp
bnRm4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIOKAmHdhcm5fdW51c2VkX3Jlc3VsdOKAmSBb
LVd1bnVzZWQtcmVzdWx0XQogIDM3MiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhc3ByaW50ZigmbXNnLCAiJWQ6JWM6JWMgIiwgaSwgaW8tPmJ1ZltpXSwgdmVyaWZ5
X2J1ZltpXSk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgphaW8tc3RyZXNzLmM6IEluIGZ1bmN0aW9uIOKAmHByaW50X2xhdOKAmToKYWlvLXN0cmVzcy5j
OjQ0MToxNzogd2FybmluZzogaWdub3JpbmcgcmV0dXJuIHZhbHVlIG9mIOKAmGFzcHJpbnRm4oCZ
IGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIOKAmHdhcm5fdW51c2VkX3Jlc3VsdOKAmSBbLVd1bnVz
ZWQtcmVzdWx0XQogIDQ0MSB8ICAgICAgICAgICAgICAgICBhc3ByaW50ZigmbXNnLCAiICUuMGYg
PCAlZCIsIGxhdC0+ZGV2aWF0aW9uc1tpXSwgZGV2aWF0aW9uc1tpXSk7CiAgICAgIHwgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fgphaW8tc3RyZXNzLmM6NDQ3OjE3OiB3YXJuaW5nOiBpZ25vcmluZyBy
ZXR1cm4gdmFsdWUgb2Yg4oCYYXNwcmludGbigJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUg4oCY
d2Fybl91bnVzZWRfcmVzdWx04oCZIFstV3VudXNlZC1yZXN1bHRdCiAgNDQ3IHwgICAgICAgICAg
ICAgICAgIGFzcHJpbnRmKCZtc2csICIgPCAlLjBmIiwgbGF0LT50b3RhbF9pbyAtIHRvdGFsX2Nv
dW50ZWQpOwogICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgphaW8tc3RyZXNzLmM6IEluIGZ1bmN0aW9u
IOKAmHJlc3RhcnRfb3BlcuKAmToKYWlvLXN0cmVzcy5jOjgxNzoyMDogd2FybmluZzogdGhpcyBz
dGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCiAgODE3
IHwgICAgICAgICAgICAgICAgIGlmIChzdGFnZXMgJiAoMSA8PCBSRUFEKSkKICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgXgphaW8tc3RyZXNzLmM6ODE5Ojk6IG5vdGU6IGhlcmUKICA4MTkgfCAg
ICAgICAgIGNhc2UgUkVBRDoKICAgICAgfCAgICAgICAgIF5+fn4KYWlvLXN0cmVzcy5jOjgyMDoy
MDogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1m
YWxsdGhyb3VnaD1dCiAgODIwIHwgICAgICAgICAgICAgICAgIGlmICghbmV3X3J3ICYmIHN0YWdl
cyAmICgxIDw8IFJXUklURSkpCiAgICAgIHwgICAgICAgICAgICAgICAgICAgIF4KYWlvLXN0cmVz
cy5jOjgyMjo5OiBub3RlOiBoZXJlCiAgODIyIHwgICAgICAgICBjYXNlIFJXUklURToKICAgICAg
fCAgICAgICAgIF5+fn4KCkknZCBhbHNvIHNvcnQgYWxwaGFiZXRpY2FsbHkgZ2V0b3B0cyBhbmQg
aGVscCwgYnV0IHRoYXQncyBqdXN0IG1lIGxvb2tpbmcgaW50bwp1bmltcG9ydGFudCBkZXRhaWxz
LgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
