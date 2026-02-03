Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D068E83040
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 02:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770086635; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=JnR+uTRqQtdPOTIRcba3n8MJadxsblsi/wbPk7/AOAQ=;
 b=EIeCuT7IL7jJl7fh6l3V5x4vwierqDU10P/yxgnq9gGnycVppYxPls/Ka7QQe4NI0xOF0
 bkesWL2oYKvtgk5DXFS4GnniE8Z+CYm7YpKJtAs4/cJl08m9HXaSaUBV7ZO2YWvqYwxrZM0
 50bdqCMeJSzs5wxF15Af8Q7oK6FbMsQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E31633CCFB0
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 03:43:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA6ED3CC5F6
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 03:43:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 19C391A00981
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 03:43:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770086608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U6lpNo0MaO7rz0DXNLwUrxgBqcarhXqZrch3lHzsd88=;
 b=HtpJ31FhHYfcJYKgOtrK1Eya8+1Lz6vEEIfJj7lmdNtEnq1bFB/2XV4mmLhbhTVYmIZ/yX
 JckwHdIpPA67l14UPQwMj7gyERhvpiVZ8vxudIaQhvnKAW1t6iHEei/g95m+W2e6vTo01g
 bE8M6eUVSVimgldowFMarNFhcDEJo4o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-uZAdQ0jKN0mEJnHbovKDwg-1; Mon,
 02 Feb 2026 21:43:27 -0500
X-MC-Unique: uZAdQ0jKN0mEJnHbovKDwg-1
X-Mimecast-MFC-AGG-ID: uZAdQ0jKN0mEJnHbovKDwg_1770086606
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6315419560B7
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 02:43:26 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 343701956053
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 02:43:24 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  3 Feb 2026 10:43:19 +0800
Message-ID: <20260203024320.227453-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0GOSf1n8waBwawmCSVRoyqeIcX8I4BQuJq_wKQLpYms_1770086606
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] openat2: define _GNU_SOURCE and include
 <fcntl.h>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRmVkb3JhIFJhd2hpZGUgKGdsaWJjIDIuNDMrKSwgbGliYyBleHBvc2VzIG9wZW5hdDIoKSBh
bmQgc3RydWN0IG9wZW5faG93LApzbyBvdXIgY29uZmlndXJlIHNjcmlwdCBkZWZpbmVzIEhBVkVf
T1BFTkFUMiBhbmQgdGhlIGZhbGxiYWNrIGRlZmluaXRpb24gaW4KbGFwaS9vcGVuYXQyLmggZ2V0
cyBza2lwcGVkLiBCdXQgb3BlbmF0MjAqLmMgbmV2ZXIgaW5jbHVkZWQgPGZjbnRsLmg+IChhbmQK
bGFja2VkIF9HTlVfU09VUkNFKSwgc28gdGhlIGxpYmMtcHJvdmlkZWQgcHJvdG90eXBlIGFuZCBz
dHJ1Y3Qgc3RheWVkIGhpZGRlbiwKc28gY29tcGlsYXRpb24gZmFpbGVkOgoKICAjIHVuYW1lIC1y
CiAgNi4xOC4wLTY1LmZjNDQueDg2XzY0CgogICMgcnBtIC1xZiAvdXNyL2luY2x1ZGUvZmNudGwu
aAogIGdsaWJjLWRldmVsLTIuNDMtMS5mYzQ0Lng4Nl82NAoKICAjIG5tIC1EIC91c3IvbGliNjQv
bGliYy5zby42IHwgZ3JlcCAtdyBvcGVuYXQyCiAgMDAwMDAwMDAwMDBlYjg5MCBXIG9wZW5hdDJA
QEdMSUJDXzIuNDMKCiAgIyBtYWtlIC1DIHRlc3RjYXNlL2tlcm5lbC9zeXNjYWxscy9vcGVuYXQy
CiAgb3BlbmF0MjAxLmM6Mjc6NjI6IGVycm9yOiBpbnZhbGlkIGFwcGxpY2F0aW9uIG9mIOKAmHNp
emVvZuKAmSB0byBpbmNvbXBsZXRlIHR5cGUg4oCYc3RydWN0IG9wZW5faG934oCZCiAgICAyNyB8
ICAgICAgICAgeyZkaXJfZmQsIFRFU1RfRklMRSwgT19SRFdSLCBTX0lSV1hVLCAwLCAmaG93LCBz
aXplb2YoKmhvdyl9LAoKRGVmaW5lIF9HTlVfU09VUkNFIGFuZCBpbmNsdWRlIDxmY250bC5oPiBp
biBvcGVuYXQyIHRlc3RzIHRvIG1ha2UgdGhlCnByb3RvdHlwZSBhdmFpbGFibGUgYW5kIGZpeCB0
aGUgYnVpbGQuCgpTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KLS0t
CiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW5hdDIvb3BlbmF0MjAxLmMgfCAzICsrKwog
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMi5jIHwgMyArKysKIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYyB8IDMgKysrCiAzIGZp
bGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvb3BlbmF0Mi9vcGVuYXQyMDEuYwppbmRleCBlY2Q2M2IxNTAuLjQwYWMyZjZkOSAxMDA2NDQK
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMS5jCisrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDEuYwpAQCAtNCw2ICs0
LDkgQEAKICAqCiAgKiBCYXNpYyBvcGVuYXQyKCkgdGVzdC4KICAqLworI2RlZmluZSBfR05VX1NP
VVJDRQorI2luY2x1ZGUgPGZjbnRsLmg+CisKICNpbmNsdWRlICJ0c3RfdGVzdC5oIgogI2luY2x1
ZGUgImxhcGkvb3BlbmF0Mi5oIgogCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL29wZW5hdDIvb3BlbmF0MjAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW5h
dDIvb3BlbmF0MjAyLmMKaW5kZXggNmQxYjVhNjdjLi4zMjljNmE0YTUgMTAwNjQ0Ci0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDIuYworKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL29wZW5hdDIvb3BlbmF0MjAyLmMKQEAgLTQsNiArNCw5IEBACiAg
KgogICogb3BlbmF0MigpIHRlc3RzIHdpdGggdmFyaW91cyByZXNvbHZlIGZsYWdzLgogICovCisj
ZGVmaW5lIF9HTlVfU09VUkNFCisjaW5jbHVkZSA8ZmNudGwuaD4KKwogI2luY2x1ZGUgInRzdF90
ZXN0LmgiCiAjaW5jbHVkZSAibGFwaS9vcGVuYXQyLmgiCiAKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYwppbmRleCA2YWM0OWVmNGMuLmNkMGMwMGQ3NSAx
MDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuYXQyL29wZW5hdDIwMy5j
CisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3BlbmF0Mi9vcGVuYXQyMDMuYwpAQCAt
NCw2ICs0LDkgQEAKICAqCiAgKiBCYXNpYyBvcGVuYXQyKCkgdGVzdCB0byBjaGVjayB2YXJpb3Vz
IGZhaWx1cmVzLgogICovCisjZGVmaW5lIF9HTlVfU09VUkNFCisjaW5jbHVkZSA8ZmNudGwuaD4K
KwogI2luY2x1ZGUgInRzdF90ZXN0LmgiCiAjaW5jbHVkZSAibGFwaS9vcGVuYXQyLmgiCiAKLS0g
CjIuNTIuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
