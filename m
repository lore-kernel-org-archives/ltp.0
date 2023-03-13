Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68936C6FD1F
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 01:14:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9406A3C4D9A
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 02:14:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27D273C0277
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 02:14:24 +0100 (CET)
Received: from m15221.mail.126.com (m15221.mail.126.com [220.181.15.221])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id A708360054C
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 02:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=bnsmK52iLWkBQRGUegIyEzSjZPvxIiUVNCFcfMpEaC4=; b=V
 OLFm2LPXDuJCEPFSiLuaCfdkrmjTcB6BVOL8eaSBBnaO8KghrtY/QvBpwMu1UYJE
 gaJZArSM//odqARxB6Lmt0oXrwV1iaYr8tpnd17cYs8YAvHlpj/GYsNmNinbsb2v
 Ibc96DKIApP7A4KyyqLW+MKB6cU0O2gtOaLtm1pt9Y=
Received: from gehao618$163.com ( [240e:468:612:a708:6432:7548:1917:2b41] )
 by ajax-webmail-wmsvr208 (Coremail) ; Mon, 13 Mar 2023 09:14:18 +0800
 (GMT+08:00)
X-Originating-IP: [240e:468:612:a708:6432:7548:1917:2b41]
Date: Mon, 13 Mar 2023 09:14:18 +0800 (GMT+08:00)
From: gehao618 <gehao618@163.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 MailMasterIOS/7.12.5.1913_(15.6.1) Copyright (c) 2002-2023 www.mailtech.cn
 163com
In-Reply-To: <20230309091655.225444-1-gehao@kylinos.cn>
References: <20230309031517.198523-1-gehao@kylinos.cn>
 <20230309091655.225444-1-gehao@kylinos.cn>
X-CM-CTRLMSGS: 4e+Ppg==
X-NTES-SC: AL_QuycCvqcv0gu7iCcbOkXm08Qg+Y5UMq4uPQu1YBTN5E0mCDM1CABX1ZRMVvf0saqNQW3mTGuXwZL9vxhQ494ZYQngVx6bQx1H9jwfNHZsOSs
MIME-Version: 1.0
Message-ID: <5fef334e.8e6.186d8885244.Coremail.gehao618@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: j8eowAAnQIjqeA5kzt8bAA--.43726W
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/1tbiEwEwFmE16mpJrwABsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: gehao <gehao@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGFscwoKCiAgICBDYW4geW91IGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2ggPyBPciBoYXZl
IGFueSBzdWdnZXN0aW9ucyA/CgoKVGhhbmtzCkJlc3QgUmVnYXJkcwpIYW8KLS0tLSBSZXBsaWVk
IE1lc3NhZ2UgLS0tLQp8IEZyb20gfCBIYW8gR2U8Z2VoYW9Aa3lsaW5vcy5jbj4gfAp8IERhdGUg
fCAwMy8wOS8yMDIzIDE3OjE2IHwKfCBUbyB8IGx0cDxsdHBAbGlzdHMubGludXguaXQ+IHwKfCBD
YyB8IEhhbyBHZTxnZWhhb0BreWxpbm9zLmNuPiB8CnwgU3ViamVjdCB8IFtMVFBdIFtQQVRDSCBW
Ml0gbWVtY2dfc3RyZXNzX3Rlc3Quc2g6IEZpeCByZXNlcnZlZCBtZW0gY2FsY3VsYXRlIHwKV2hl
biBydW5uaW5nIHRoaXMgdGVzdCBjYXNlIG9uIGEgbWFjaGluZSB3aXRoIGxhcmdlIG1lbW9yeSwK
YW5kIHdpdGhvdXQgc3dhcCBvciBzd2FwIGlzIHRvbyBzbWFsbCxleGlzdGluZyByZXNlcnZlZApt
ZW1vcnkgaXMgdG9vIHNtYWxsIGZvciBhIG1hY2hpbmUgd2l0aCBsYXJnZSBtZW1vcnksYW5kCndp
bGwgY2F1c2UgZm9ya2luZyBhIHN1YnByb2Nlc3MgdG8gcnVuIGEgY29tbWFuZCB3aWxsIGZhaWwK
ZHVlIHRvIG1lbW9yeSBpcyBleGhhdXN0ZWQsc28gb3B0aW1pemUgcmVzZXJ2ZWQgbWVtb3J5CmNh
bGN1bGF0ZSB0byB0ZW4gcGVyY2VudCBvZiBmcmVlIG1lbW9yeS4KCkhlcmUgaXMgYW4gZXhhbXBs
ZToKCmZyZWUgLW0KICAgICAgICAgICAgIHRvdGFsICAgICAgICB1c2VkICAgICAgICBmcmVlICAg
ICAgc2hhcmVkICBidWZmL2NhY2hlICAgYXZhaWxhYmxlCk1lbTogICAgICAgICAyNjAxODQgICAg
ICAgIDI5NTkgICAgICAyNTU4NTQgICAgICAgICAgNjIgICAgICAgIDEzNzAgICAgICAyMzYzNDYK
U3dhcDogICAgICAgICAgNDA5NSAgICAgICAgICAgMCAgICAgICAgNDA5NQoKd2hlbiB5b3UgcnVu
IHRoaXMgdGVzdGNhc2UsY29uc29sZSB3aWxsIHJlcG9ydApmb3Jr77yaQ2Fubm90IGFsbG9jYXRl
IG1lbW9yeQoKU2lnbmVkLW9mZi1ieTogSGFvIEdlIDxnZWhhb0BreWxpbm9zLmNuPgotLS0KLi4u
L2tlcm5lbC9jb250cm9sbGVycy9tZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2ggICAg
fCA2ICsrKy0tLQoxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvc3RyZXNz
L21lbWNnX3N0cmVzc190ZXN0LnNoIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1j
Zy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2gKaW5kZXggY2I1Mjg0MGQ3Li5mMjZhOWY3MmEg
MTAwNzU1Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvc3RyZXNzL21l
bWNnX3N0cmVzc190ZXN0LnNoCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVt
Y2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCkBAIC00MCw3ICs0MCw3IEBAIHNldHVwKCkK
ICAgTUVNPSQoKCAkbWVtX2ZyZWUgKyAkc3dhcF9mcmVlIC8gMiApKQogICBNRU09JCgoICRNRU0g
LyAxMDI0ICkpCiAgIFJVTl9USU1FPSQoKCAxNSAqIDYwICkpCi0gICAgWyAiJHBnc2l6ZSIgPSAi
NDA5NiIgXSAmJiBUSFJFQURfU1BBUkVfTUI9MSB8fCBUSFJFQURfU1BBUkVfTUI9OAorICAgIFJF
U0VSVkVEX01FTU9SWT0kKCggJE1FTSAqIDEwLzEwMCApKQoKICAgdHN0X3JlcyBUSU5GTyAiQ2Fs
Y3VsYXRlZCBhdmFpbGFibGUgbWVtb3J5ICRNRU0gTUIiCn0KQEAgLTkzLDEyICs5MywxMiBAQCBy
dW5fc3RyZXNzKCkKCnRlc3QxKCkKewotICAgIHJ1bl9zdHJlc3MgMTUwICQoKCAoJE1FTSAtIDE1
MCAqICRUSFJFQURfU1BBUkVfTUIpIC8gMTUwICkpIDUgJFJVTl9USU1FCisgICAgcnVuX3N0cmVz
cyAxNTAgJCgoICgkTUVNIC0gJFJFU0VSVkVEX01FTU9SWSkgLyAxNTAgKSkgNSAkUlVOX1RJTUUK
fQoKdGVzdDIoKQp7Ci0gICAgcnVuX3N0cmVzcyAxICQoKCAkTUVNIC0gJFRIUkVBRF9TUEFSRV9N
QikpIDUgJFJVTl9USU1FCisgICAgcnVuX3N0cmVzcyAxICQoKCAkTUVNIC0gJFJFU0VSVkVEX01F
TU9SWSkpIDUgJFJVTl9USU1FCn0KCi4gY2dyb3VwX2xpYi5zaAotLQoyLjI1LjEKCgotLQpNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
