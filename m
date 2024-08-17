Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C60BC52D7F
	for <ltp@archiver.kernel.org>; Sat, 17 Aug 2024 04:43:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 417773D222A
	for <ltp@archiver.kernel.org>; Sat, 17 Aug 2024 06:43:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 907E33C71B0
 for <ltp@lists.linux.it>; Sat, 17 Aug 2024 06:43:26 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id D836C1400C5F
 for <ltp@lists.linux.it>; Sat, 17 Aug 2024 06:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=OfLNJPs1mk9zeuFoy5j8r4Jb3ILr6tgcUPaHmKv2VcI=; b=Q
 VM/+fuA6o9esxA0GNKeQ+ZEceeN7qg8aYHQd+l/3304Y4j+wrK5L9b6Tf3T7CZZP
 EjN67vOhRNqhw7q2owXvIROKixWAKLeFfGqJbSYsvIhuX+yur/dPpw0D17EcPBtH
 zMkzr1ePveI27vuS7qMVzEkgFzAUJ0FgriHZaDzAaM=
Received: from ice_yangxiao$163.com ( [160.86.227.245] ) by
 ajax-webmail-wmsvr-40-131 (Coremail) ; Sat, 17 Aug 2024 12:43:10 +0800
 (CST)
X-Originating-IP: [160.86.227.245]
Date: Sat, 17 Aug 2024 12:43:10 +0800 (CST)
From: =?UTF-8?B?5p2o5pmT?= <ice_yangxiao@163.com>
To: "Li Wang" <liwang@redhat.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAEemH2fg9-Su=nXY=_gyZ_gK9hDNx=0s-TD8JpoZWmT4LfQmcg@mail.gmail.com>
References: <20240816045342.185737-1-ice_yangxiao@163.com>
 <CAEemH2fg9-Su=nXY=_gyZ_gK9hDNx=0s-TD8JpoZWmT4LfQmcg@mail.gmail.com>
X-NTES-SC: AL_Qu2ZAfSdtk8i5iScYukfmkwaj+w9XcqwuPsm24BUOpp+jA/o/RodT3lnOVb69PuyMw+KuTyzbiZK9elLWblIQYQL7PWQ49U/ce/pni241Ijs5Q==
MIME-Version: 1.0
Message-ID: <240c056e.1401.1915ea580f9.Coremail.ice_yangxiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3_3peKsBmkfEeAA--.48230W
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0gU+XmWXzw10EQABsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] syscalls/landlock05.c: Remove useless tags
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgoKSGkgTGksCgoKCgpQdXNoZWQuIFRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgoKCgoKQmVzdCBS
ZWdhcmRzLAoKWGlhbyBZYW5nCgoKCgoKT24gMjAyNC0wOC0xNiAxNTowMToyOO+8jCJMaSBXYW5n
IiA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3Rl77yaCgoKCgoKT24gRnJpLCBBdWcgMTYsIDIwMjQg
YXQgMTI6NTTigK9QTSBYaWFvIFlhbmcgPGljZV95YW5neGlhb0AxNjMuY29tPiB3cm90ZToKCkZp
eCB0aGUgZm9sbG93aW5nIHdhcm5pbmdzIGZyb20gbWV0YWRhdGEvbWV0YXBhcnNlOgp0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDUuYzogdXNlbGVzcyB0YWc6IGZv
cm1hdF9kZXZpY2UKdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA1
LmM6IHVzZWxlc3MgdGFnOiBuZWVkc190bXBkaXIKClNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8
aWNlX3lhbmd4aWFvQDE2My5jb20+CgogClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KIAotLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxv
Y2swNS5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA1LmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDUuYwppbmRleCA2ODk5ZGQx
ZjEuLjcwM2Y3ZDgxYyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5k
bG9jay9sYW5kbG9jazA1LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9j
ay9sYW5kbG9jazA1LmMKQEAgLTkwLDcgKzkwLDYgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkK
IHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKICAgICAgICAudGVzdF9hbGwgPSBydW4s
CiAgICAgICAgLnNldHVwID0gc2V0dXAsCi0gICAgICAgLm5lZWRzX3RtcGRpciA9IDEsCiAgICAg
ICAgLm5lZWRzX3Jvb3QgPSAxLAogICAgICAgIC5mb3Jrc19jaGlsZCA9IDEsCiAgICAgICAgLmJ1
ZnMgPSAoc3RydWN0IHRzdF9idWZmZXJzIFtdKSB7CkBAIC0xMDIsNyArMTAxLDYgQEAgc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewogICAgICAgICAgICAgICAgVFNUX0NBUChUU1RfQ0FQ
X1JFUSwgQ0FQX1NZU19BRE1JTiksCiAgICAgICAgICAgICAgICB7fQogICAgICAgIH0sCi0gICAg
ICAgLmZvcm1hdF9kZXZpY2UgPSAxLAogICAgICAgIC5tb3VudF9kZXZpY2UgPSAxLAogICAgICAg
IC5tbnRwb2ludCA9IE1OVFBPSU5ULAogICAgICAgIC5hbGxfZmlsZXN5c3RlbXMgPSAxLAotLQoy
LjQ1LjIKCgotLQpNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAKCgoKCgoKLS0KClJlZ2FyZHMsCgpMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
