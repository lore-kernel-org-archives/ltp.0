Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6153BC25B08
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 06:34:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8EE23C9407
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 08:34:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D49633C1BDC
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 08:34:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4939260100C
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 08:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659681250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWueao5oafEDb3+BKpe2SwU/+DhDLFIlgFlf1e9JC8s=;
 b=NmEjtreoYfix9WGb+k01Cm29JVuJu0wlwt2jJsTyOPXTP/k5RcAqI3RuiNTwIWezGzAn34
 kyJtBdzN0lYxKpLlq/tdYysj3m8NMLvJKV7QBuRkDpL8HEmyJ1pmiFic6wGjG24vNBn78T
 zxS6XAx9/Fm6ie0P2alOLMRSNj7BmCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-iNEJhpX7MM66cL9FTJdpig-1; Fri, 05 Aug 2022 02:34:07 -0400
X-MC-Unique: iNEJhpX7MM66cL9FTJdpig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B16F81857F02;
 Fri,  5 Aug 2022 06:34:06 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 786F41415122;
 Fri,  5 Aug 2022 06:34:05 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  5 Aug 2022 14:34:00 +0800
Message-Id: <20220805063401.1647479-2-liwang@redhat.com>
In-Reply-To: <20220805063401.1647479-1-liwang@redhat.com>
References: <20220805063401.1647479-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi/pidfd: adding pidfd header file
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhlIG5ld2VyIEdsaWJjIGFscmVhZHkgcHJvdmlkZWQgd3JhcHBlciBmb3IgdGhlIHNlcmllcyBw
aWRmZCBzeXNjYWxsLApzbyBsZXQncyBpbmNsdWRlIHRoZSBoZWFkZXIgZmlsZSBjb25kaXRpb25h
bGx5LgoKICAjIHJwbSAtcSBnbGliYy1kZXZlbAogIGdsaWJjLWRldmVsLTIuMzUuOTAwMC0zMS5m
YzM3LnBwYzY0bGUKCiAgIyBycG0gLXFsIGdsaWJjLWRldmVsIHwgZ3JlcCBwaWRmZAogIC91c3Iv
aW5jbHVkZS9zeXMvcGlkZmQuaAoKVG8gZ2V0IHJpZCBvZiBjb21waWxpbmcgZXJyb3IgZnJvbSBm
ZWRvcmEtcmF3aGlkZToKCiAgdHN0X3NhZmVfbWFjcm9zLmM6IEluIGZ1bmN0aW9uIOKAmHNhZmVf
cGlkZmRfb3BlbuKAmToKICB0c3Rfc2FmZV9tYWNyb3MuYzoxMzU6MTY6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhwaWRmZF9vcGVu4oCZIFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDEzNSB8ICAgICAgICAgcnZhbCA9IHBpZGZkX29w
ZW4ocGlkLCBmbGFncyk7CiAgICAgIHwgICAgICAgICAgICAgICAgXn5+fn5+fn5+fgoKU2lnbmVk
LW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Ci0tLQogY29uZmlndXJlLmFjICAg
ICAgICAgfCAxICsKIGluY2x1ZGUvbGFwaS9waWRmZC5oIHwgMyArKysKIDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJl
LmFjCmluZGV4IDY5YjE0NWI1Zi4uZDUwZWMxZWE3IDEwMDY0NAotLS0gYS9jb25maWd1cmUuYWMK
KysrIGIvY29uZmlndXJlLmFjCkBAIC03MSw2ICs3MSw3IEBAIEFDX0NIRUNLX0hFQURFUlNfT05D
RShbIFwKICAgICBzeXMvZXBvbGwuaCBcCiAgICAgc3lzL2Zhbm90aWZ5LmggXAogICAgIHN5cy9p
bm90aWZ5LmggXAorICAgIHN5cy9waWRmZC5oCiAgICAgc3lzL3ByY3RsLmggXAogICAgIHN5cy9z
aG0uaCBcCiAgICAgc3lzL3RpbWVyZmQuaCBcCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvcGlk
ZmQuaCBiL2luY2x1ZGUvbGFwaS9waWRmZC5oCmluZGV4IDI0NGQzYWNhZi4uOWNhOGU1YWEyIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2xhcGkvcGlkZmQuaAorKysgYi9pbmNsdWRlL2xhcGkvcGlkZmQu
aApAQCAtOCw2ICs4LDkgQEAKICNkZWZpbmUgTEFQSV9QSURGRF9IX18KIAogI2luY2x1ZGUgPGZj
bnRsLmg+CisjaWZkZWYgSEFWRV9TWVNfUElERkRfSAorIyBpbmNsdWRlIDxzeXMvcGlkZmQuaD4K
KyNlbmRpZgogI2luY2x1ZGUgImNvbmZpZy5oIgogI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIK
IAotLSAKMi4zNS4zCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
