Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96F7D0E6CD
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729499638; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=caF9j7jiWGokBfK6bK8Os4UL7637dvOKWMa5bzARG7E=;
 b=RQZZG2cTpeFAF2ZwtHCvD/3/n3rbgzk8L0GOrBTBbjHTNAG0Bu08375Rg0UIhBzSpRvXE
 NNycDeqYAgym0f7cXN74i5Pz3O1c/XO39flPMuZD6s2cqoQy37hG9O1Rx86AKanVqHbr9MU
 eOpfyDsFuGHWy1ReTBPeZYjauSdgxIY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 991E83C6EC7
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 10:33:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AEE63C0299
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 20:34:26 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9CAF61D9A7
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 20:34:25 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso1768703f8f.2
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729276465; x=1729881265; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L5PL6NLGflXMWQE4qeGQ8lBHCNdtU0hQGMERKgrsMPM=;
 b=V9ct7rPKcuPO3gkY2M0TKyATpkwrAqvZoJW2shDz4WJEQ3uonZmUAGb/GplZFfmdx7
 KZfubHl8qWzhOoa6wnv70roL/ZMEZSoYIDL4Ms+QK+qvs9ElDBBtea72tAau7DNgwrOC
 wdk45sr7cFKJkgZrhzNLm0r7JXxceHDJTcjNd2uV9vOdRyuq2XoJ8Bdgx7Ql+/XGeEOt
 N9dp3yQFBYmyTuHYTp7GtSYdHAU2MLiFvltasUdaEfC/k9MzQrrLBA6IfM7Vl4/8gBqi
 yF0rDGnUwIMTrsepSYWQQYaZ4CJdOeLiTj7OqlBwizEYm4Y5rFCnKDDdD6gyH74A9/0W
 L2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276465; x=1729881265;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L5PL6NLGflXMWQE4qeGQ8lBHCNdtU0hQGMERKgrsMPM=;
 b=r6H375qGU/kgvacGNqO7tsDCscSm39D1iRa/CkX1JGi4Gd/iRR1QnKG0wIzWDWT1zq
 6VrV9yZHXoINlhqijYW3kyYkqZKsK2jqjubZcoa+uEBp++F5o4hdzD7WGj79o3C5CkPm
 181NaFSuPwwkkUlPncX1X0Z3JkBYTIutbJxhvzQYTLulWLCvJodkLhO8ny3F5D/Set8c
 IWZRK5F4Fuq0lITCa4cGfRDEDMBWuJEJgV8E5KVtjlwox0xegSaoSlUqT9fBVqam8lze
 tOQdTKIdmHMHmD9EKAXYZBqdDWdQm1GoPSNn8CfCGobEXHs058lGivjFYRlO9W3jQclm
 1hZw==
X-Gm-Message-State: AOJu0YwmxdNgqqfh/loqC5SmCjGhb1oOuDXkvZlKBG6pYQ/ls17ZxSy9
 ApmIIFP5r2mX5r8+zOmb+duAFlaiQkZ76C7CRq1IXZ4X0ZckPix1aXDO4Yz79Vnqy0MEzC+07WC
 M
X-Google-Smtp-Source: AGHT+IGZQz8sx/MJ+gmeNEhrnQ4w742kqiQsHH+1vPCSrfOi6QhsUO0EjWXxTlDBla85XK1rklgCyQ==
X-Received: by 2002:a5d:6d0d:0:b0:37d:4f1b:35b with SMTP id
 ffacd0b85a97d-37eab71038amr2826639f8f.34.1729276465011; 
 Fri, 18 Oct 2024 11:34:25 -0700 (PDT)
Received: from localhost ([187.91.207.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ea333e94fsm1782288b3a.69.2024.10.18.11.34.23
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:34:24 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:33:56 -0300
MIME-Version: 1.0
Message-Id: <20241018-block_dev-v1-1-f1f98dfebb6d@suse.com>
X-B4-Tracking: v=1; b=H4sIABOqEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ML3aSc/OTs+JTUMt1kYyMjQ1OjVAPjxBQloPqCotS0zAqwWdGxtbU
 Alrll81sAAAA=
X-Change-ID: 20241018-block_dev-c322152e03ad
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4179; i=rbm@suse.com;
 h=from:subject:message-id; bh=YgpjO8M1+npOCGOiuqL12MkHmJ4X5Hj13SlAS1cwIUU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnEqotePDRYvktokIhRZacsBHNf6fyGFDJ9fLkh
 HtQz6pnt4uJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZxKqLQAKCRDJC4p8Y4ZY
 pqlOD/9Gfp+FFNSNOtpYK6/SaHvI8V5l/tKE26lnxNxxzMhcvu32oHVQELYJKZb8bsW1ble9PI7
 FsPfC9HIKHDr13z6A9o46a9cpLIhc0fYwctsw8j20Xnj7+az/z8QVJKf1uUxnE5BLes8BepFxQV
 CQ8HUpjReKKCtYBeCubBV1ohiJBpvtEpNuQo402qgSoLM+CdJg0hAFcRoG2PEFUB7n17awvchnf
 OmMOUqNjcbXTUsiptTU3kxVogndZPZY6v/o/l0hghiH8KhRBcxYx1vwH7RIC6XT/8ZEbonZlh0X
 +qgZGzdtxzPBIcxa6/3Y66nUCLosfpsVxb+J4oz9xrqMmxiu6y5Qx8dtfTeOj0cJNluPAgNH6aA
 LVXaPWShC27V+TvbITpAJcnjweYZ8ODc9XwZ/67LgoaV318pycopt4p7S+v+oFrmJAziXoeKpDn
 TFgyUv24oEqi5eIrHgtzEfB6/Gr7KBtd+HjVeDmiRb4z9M+yQCvV+sUAWZTv3pRlpCXJSWwLihm
 0HTQt0IY5GIA6VKAmW0Zyyj/XFG24fg/FpDfEHeTkMY1BylnKZdpL9e4QnhF5rgwMaY5Q0weu+V
 xhLkfO4olOTCocQisxRLonOeN/J373LorcfMkuVX7Tqq2RwpU+mXe7pthHWgjmAaKdPeUPdlOiG
 DSiKa4BPm4asXOg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 21 Oct 2024 10:33:34 +0200
Subject: [LTP] [PATCH] block_dev: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsaWVyZSA8cmJtQHN1c2UuY29tPgotLS0KVGVz
dGVkIGFnYWluc3QgdjYuMTEKLS0tCiAuLi4vYmxvY2svYmxvY2tfZGV2X2tlcm5lbC9sdHBfYmxv
Y2tfZGV2LmMgICAgICAgICB8ICAxIC0KIC4uLi9ibG9jay9ibG9ja19kZXZfdXNlci9ibG9ja19k
ZXYuYyAgICAgICAgICAgICAgIHwgNzggKysrKysrKysrLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBj
aGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA0NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL2Jsb2NrL2Jsb2NrX2Rldl9rZXJuZWwvbHRw
X2Jsb2NrX2Rldi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ibG9jay9ibG9j
a19kZXZfa2VybmVsL2x0cF9ibG9ja19kZXYuYwppbmRleCAxNzA0N2MwZDVhZTNmNjU1NmYzZmE0
YjBlYjJhMTdhODZlNWYwNWE2Li44YTNlZTRmZjBiYWM2ZWQ0NmM3YzA5YzU3NTJiNmZlYzNlZjAx
YTQwIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL2Jsb2NrL2Js
b2NrX2Rldl9rZXJuZWwvbHRwX2Jsb2NrX2Rldi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZGV2
aWNlLWRyaXZlcnMvYmxvY2svYmxvY2tfZGV2X2tlcm5lbC9sdHBfYmxvY2tfZGV2LmMKQEAgLTEy
LDcgKzEyLDYgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9k
ZXZpY2UuaD4KICNpbmNsdWRlIDxsaW51eC9mcy5oPgotI2luY2x1ZGUgPGxpbnV4L2dlbmhkLmg+
CiAjaW5jbHVkZSA8bGludXgvYmxrZGV2Lmg+CiAKIE1PRFVMRV9BVVRIT1IoIk3DoXJ0b24gTsOp
bWV0aCA8bm0xMjdAZnJlZW1haWwuaHU+Iik7CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L2RldmljZS1kcml2ZXJzL2Jsb2NrL2Jsb2NrX2Rldl91c2VyL2Jsb2NrX2Rldi5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ibG9jay9ibG9ja19kZXZfdXNlci9ibG9ja19kZXYu
YwppbmRleCA1NDNjMzY3OTVjYzNiMjc3NmM1OTE0MTAyM2UwM2ZmMmM1OGJkMzZhLi5mNzk1ZmIw
NWI5YWY3MWY2YTNjNzQ4OTM2YTE1YWMzYTY1MmRiNWUzIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL2RldmljZS1kcml2ZXJzL2Jsb2NrL2Jsb2NrX2Rldl91c2VyL2Jsb2NrX2Rldi5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvYmxvY2svYmxvY2tfZGV2X3VzZXIv
YmxvY2tfZGV2LmMKQEAgLTEsMyArMSw0IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcgogLyoKICAqIENvcHlyaWdodCAoYykgMjAxMyBPcmFjbGUgYW5kL29y
IGl0cyBhZmZpbGlhdGVzLiBBbGwgUmlnaHRzIFJlc2VydmVkLgogICoKQEAgLTI2LDc0ICsyNyw1
OSBAQAogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgogCi0jaW5jbHVk
ZSAidGVzdC5oIgotI2luY2x1ZGUgInNhZmVfbWFjcm9zLmgiCi0jaW5jbHVkZSAib2xkX21vZHVs
ZS5oIgorI2luY2x1ZGUgInRzdF90ZXN0LmgiCisjaW5jbHVkZSAidHN0X21vZHVsZS5oIgorCisj
ZGVmaW5lIE1PRFVMRV9OQU1FICJsdHBfYmxvY2tfZGV2IgorI2RlZmluZSBNT0RVTEVfTkFNRV9L
TwlNT0RVTEVfTkFNRSAiLmtvIgogCiBjaGFyICpUQ0lEID0gImJsb2NrX2RldiI7Ci1pbnQgVFNU
X1RPVEFMID0gOTsKIAotc3RhdGljIGNvbnN0IGNoYXIgbW9kdWxlX25hbWVbXQk9ICJsdHBfYmxv
Y2tfZGV2LmtvIjsKIHN0YXRpYyBjb25zdCBjaGFyIGRldl9yZXN1bHRbXQk9ICIvc3lzL2Rldmlj
ZXMvbHRwX2Jsb2NrX2Rldi9yZXN1bHQiOwogc3RhdGljIGNvbnN0IGNoYXIgZGV2X3RjYXNlW10J
PSAiL3N5cy9kZXZpY2VzL2x0cF9ibG9ja19kZXYvdGNhc2UiOwotc3RhdGljIGludCBtb2R1bGVf
bG9hZGVkOwogCi1zdGF0aWMgaW50IHJ1bl9hbGxfdGVzdGNhc2VzOwotc3RhdGljIGNvbnN0IG9w
dGlvbl90IG9wdGlvbnNbXSA9IHsKLQl7ImEiLCAmcnVuX2FsbF90ZXN0Y2FzZXMsIE5VTEx9LAor
c3RhdGljIGludCBtb2R1bGVfbG9hZGVkOworc3RhdGljIGNoYXIqIHJ1bl9hbGxfdGVzdGNhc2Vz
Oworc3RhdGljIHN0cnVjdCB0c3Rfb3B0aW9uIG9wdGlvbnNbXSA9IHsKKwl7ImEiLCAgJnJ1bl9h
bGxfdGVzdGNhc2VzLCAiLWFcdFJ1biBhbGwgdGVzdC1jYXNlcyAoY2FuIGNyYXNoIHRoZSBrZXJu
ZWwpIn0sCiAJe05VTEwsIE5VTEwsIE5VTEx9CiB9OwogCiBzdGF0aWMgdm9pZCBjbGVhbnVwKHZv
aWQpCiB7CiAJaWYgKG1vZHVsZV9sb2FkZWQpCi0JCXRzdF9tb2R1bGVfdW5sb2FkKE5VTEwsIG1v
ZHVsZV9uYW1lKTsKLX0KLQotc3RhdGljIHZvaWQgaGVscCh2b2lkKQotewotCXByaW50ZigiICAt
YSAgICAgIFJ1biBhbGwgdGVzdC1jYXNlcyAoY2FuIGNyYXNoIHRoZSBrZXJuZWwpXG4iKTsKLX0K
LQotdm9pZCBzZXR1cChpbnQgYXJnYywgY2hhciAqYXJndltdKQotewotCXRzdF9wYXJzZV9vcHRz
KGFyZ2MsIGFyZ3YsIG9wdGlvbnMsIGhlbHApOwotCi0JdHN0X3JlcXVpcmVfcm9vdCgpOwotCi0J
dHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CisJCXRzdF9tb2R1bGVfdW5sb2Fk
KE1PRFVMRV9OQU1FX0tPKTsKIH0KIAotc3RhdGljIHZvaWQgdGVzdF9ydW4odm9pZCkKK3N0YXRp
YyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKIHsKLQlpbnQgb2ZmID0gMDsKIAkvKgogCSAqIHRl
c3QtY2FzZXMgIzggYW5kICM5IGNhbiBjcmFzaCB0aGUga2VybmVsLgogCSAqIFdlIGhhdmUgdG8g
d2FpdCBmb3Iga2VybmVsIGZpeCB3aGVyZSByZWdpc3Rlcl9ibGtkZXYoKSAmCiAJICogdW5yZWdp
c3Rlcl9ibGtkZXYoKSBjaGVja3MgdGhlIGlucHV0IGRldmljZSBuYW1lIHBhcmFtZXRlcgogCSAq
IGFnYWluc3QgTlVMTCBwb2ludGVyLgogCSAqLwotCWlmICghcnVuX2FsbF90ZXN0Y2FzZXMpCi0J
CW9mZiA9IDI7Ci0KLQl0c3RfbW9kdWxlX2xvYWQoY2xlYW51cCwgbW9kdWxlX25hbWUsIE5VTEwp
OwotCW1vZHVsZV9sb2FkZWQgPSAxOwotCi0JaW50IGksIHBhc3MgPSAwOwotCWZvciAoaSA9IDA7
IGkgPCBUU1RfVE9UQUwgLSBvZmY7ICsraSkgewotCQlTQUZFX0ZJTEVfUFJJTlRGKGNsZWFudXAs
IGRldl90Y2FzZSwgIiVkIiwgaSArIDEpOwotCQlTQUZFX0ZJTEVfU0NBTkYoY2xlYW51cCwgZGV2
X3Jlc3VsdCwgIiVkIiwgJnBhc3MpOwotCQl0c3RfcmVzbSgocGFzcykgPyBUUEFTUyA6IFRGQUlM
LCAiVGVzdC1jYXNlICclZCciLCBpICsgMSk7CisJbisrOworCWlmICghcnVuX2FsbF90ZXN0Y2Fz
ZXMgJiYgKG4gPT0gOCB8fCBuID09IDkpKSB7CisJCXRzdF9yZXMoVENPTkYsICJTa2lwcGVkIG4g
PSAlZCIsIG4pOworCQlyZXR1cm47CiAJfQotfQotCi1pbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQotewotCXNldHVwKGFyZ2MsIGFyZ3YpOwotCi0JdGVzdF9ydW4oKTsKIAotCWNsZWFu
dXAoKTsKKwlpZiAoIW1vZHVsZV9sb2FkZWQpIHsKKwkJdHN0X21vZHVsZV9sb2FkKE1PRFVMRV9O
QU1FX0tPLCBOVUxMKTsKKwkJbW9kdWxlX2xvYWRlZCA9IDE7CisJfQogCi0JdHN0X2V4aXQoKTsK
KwlpbnQgcGFzcyA9IDA7CisJU0FGRV9GSUxFX1BSSU5URihkZXZfdGNhc2UsICIlZCIsIG4pOwor
CVNBRkVfRklMRV9TQ0FORihkZXZfcmVzdWx0LCAiJWQiLCAmcGFzcyk7CisJdHN0X3JlcygocGFz
cykgPyBUUEFTUyA6IFRGQUlMLCAiVGVzdC1jYXNlICclZCciLCBuKTsKIH0KKworc3RhdGljIHN0
cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS5uZWVkc19yb290ID0gMSwKKwkuY2xlYW51cCA9IGNs
ZWFudXAsCisJLnRlc3QgPSBydW4sCisJLnRjbnQgPSA5LAorCS5vcHRpb25zID0gb3B0aW9ucywK
K307CgotLS0KYmFzZS1jb21taXQ6IDQ3YWZmNGRlY2M4MWFjODM3ZmQ3NDUyNzhkZWY2ODgzZmMy
ZjE5N2IKY2hhbmdlLWlkOiAyMDI0MTAxOC1ibG9ja19kZXYtYzMyMjE1MmUwM2FkCgpCZXN0IHJl
Z2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpZXJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
