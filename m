Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8E0C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743085877; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yAkcnQ7tbQREKMojYWNH3erMYl2UaybBrwtMflhAu8o=;
 b=PRV032APqlRGsIH34mhQdobYgupukAb/YJ3AltTGhFkjPZ89ULlfl/ftWyO9/Uxh8Au7T
 F57oGmsxJQFHKUyREG5+e61RRjLRSSBTcSIq0Ha7lXH7080nFwCBT8zCdh226h7Il1m22hC
 N8jWOHsDfZukF5KEvVoKINSkNlfyevw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54AD83C726B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 15:31:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FB513C9F97
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:28:58 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E6BCF1A00CD8
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:28:57 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso10954475e9.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743085737; x=1743690537; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZXr6CGYCeoIJGgSEbn59z83DfyliHNaXvWo2t76LPRM=;
 b=Ql2QDMHYY+QtMPIFFW0rceMHD8WX80B6/SLOqa8uXMTi4LIPZXIfZce2ZSk1Gn1kef
 28QBR+3N87iR//fXmuHC3LxXy0uOOcI6qzoJ5+zbqgam5+U60M5Jbq0LrpCX90ohYmvJ
 Aes++uNQ75j228xe2I6396EEA2p/QKtGV/D2YiafoxLOe/slD85+YG4x6Awww6HcU9bS
 J13qZgaH0s1El2GR+YDMa7slZHomZ7qm5g9bTVuWUmXumM4PmVxLIe2kDrzcsn98q11U
 1M8hee3r77JuD9mjsy6yMK3xDrTUBXElCk8FalR5yf0E6lQt9cd8vjtTgicFKRLoapWP
 7Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085737; x=1743690537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXr6CGYCeoIJGgSEbn59z83DfyliHNaXvWo2t76LPRM=;
 b=CGotoUM5rHPLpFN0QcTxmIIldMPyGxy9ROjixns9VHtVcJBlPBsw6TyqqV8VXpunGL
 JR5tUvVpzAT+++hAcE8qd+sUJPJSLI1IUBT/H2fXF0308lufmU9c/fgSrAsUfyi3FiEA
 d5RlauLfthsIhXWjhnb9qHWNa7MmpRg8VbyydzS4vJFxSSRFL1AiFugSPUvsQhsv1rfx
 GrJLu1MsejBnyPS8j0//XZ9n25hOGOpoHbPcjDitfcO7WQiSx3YzXXcUfOMkIusPOPLV
 8why3gls4jBl+J6AXw5w0wb3mhpvfF72hqE1DNVnChEm2DdEGzZkxVsFA77i1/qK0yJU
 pKDw==
X-Gm-Message-State: AOJu0Yx6N7WQma3eZDCuPrCzQBCNdm4eO5kEJSPm9SjwZu4jd2T/lfz0
 70XqQ3vCozWOH4tpt7MiyyKNyNyrnAde5bsLrkMeSzvI+gWe4ti9mFhuocoGksxaVQTsIkdMI40
 C
X-Gm-Gg: ASbGncu3lSUF9QGLhrnVmNHt73aVzVzE2DrCSq18twhk0BKQuPPyf1/XlWEmfbwcnaS
 /aDuYzChPsRLrGcr04OaPsz0WKmjR6CSP1hEW4W+e1tvZrKmstkc3tQxLT885+kIXYElZmuDb4w
 LEKe75/WQLQ7V/SDMC65tM6RVtdfow5Xa3zdr7pzNziXTlBuTv3VLAwstVb38DjOl+BujqmHzhl
 OK9dX5ETSrr0LQMH0F8qKtTbrw0IFCe2BNDTIM1GcxZUqSxfyuIJjMpeVvotLDANJk/c4OIePOF
 a1rT+6G6/UDZa7gCH6/u2S75yCGD72cgDg==
X-Google-Smtp-Source: AGHT+IFVWVOq/+PBNCVlQ8m52IhnPA6Q3L4W6skOuoRnVcu06qdlMXcxMzCZeAnDKPWbV0wGMAZplA==
X-Received: by 2002:a5d:5989:0:b0:390:dfa1:3448 with SMTP id
 ffacd0b85a97d-39ad17940bbmr3785314f8f.43.1743085737360; 
 Thu, 27 Mar 2025 07:28:57 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-227811f0cb2sm129704045ad.212.2025.03.27.07.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:28:56 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:28:28 -0300
MIME-Version: 1.0
Message-Id: <20250327-conversions-modify_ldt-v2-5-2907d4d3f6c0@suse.com>
References: <20250327-conversions-modify_ldt-v2-0-2907d4d3f6c0@suse.com>
In-Reply-To: <20250327-conversions-modify_ldt-v2-0-2907d4d3f6c0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3374; i=rbm@suse.com;
 h=from:subject:message-id; bh=XRQV9DUjc1pwPHUyRiZ+xOQoxm5ReIXkw+mc7l7w60k=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn5WCXk7BnmL9X79Cfs5rL5RcDteWP9T2UImizJ
 +cMUd/8juSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+VglwAKCRDJC4p8Y4ZY
 pq+RD/490sjqRFj5d+MKI5z50V64/Yi9RTnjtg7R2N11F1F1wTTFudIMGtaH34sbZnMGIjAyTKT
 b42C8P+IJfPnBJPU50/a+VpleXtFFeD9c6iKM03QIvZbmhGnI+rW7SligVjpS9rIVQbTTVyQYD3
 /fnsJDnJyH96e5vKtqUqf6k8EA7kLttOKBKfgIOmmRqmBN65LTHPCK0I4rEoH4yxY2xq+G3Wu3Z
 rDKjAFGa7xF//cx5858MgsqsXkL6ISTikW8LDMstNhklirnNXNgyc7nS0Xur0088JETEyd5Jl1/
 CCkNoGn2OSsO54rFvPA7E6Aceiv8eXYQtOzVK+YvPBL3EMKm9OJ6uG8zRKMKqIK2jFPFAcLeFWN
 EIyuBE6kOoJaodFfJH9sr2d5FiOhkrakseXJE37869jTpUwRnr8VMfyJOdGmysnLzwrkzgWsm/3
 WyRqSikyFkRr/ArJKPGVBlHJ8kJeT0Cx2PhYQl+jZ2JTF7CglT6y1+q9/pgFTCm+B3Kku2X8vDj
 UyCQokwUqIcMDhSTPrwdYEcxqa1TlI9REC4+6wP6mzmOYYM9gTufqA078KB/PkRZ2MlPwVhYQvc
 VYnFWol/ln0lhXX7YHs7n02Dgq2VWfe0GLxwF7/l63tldBKzgESvgidkwVj72kbV781mq1sc6qp
 kGF2C3XJgtlZ7iA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] syscalls/modify_ldt03: Merge into modify_ldt01
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
Reply-To: rbm@suse.com
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9tb2RpZnlfbGR0Ly5naXRpZ25vcmUgICAgfCAgNSArKy0tCiAuLi4va2VybmVs
L3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAxLmMgICAgICB8IDIwICsrKysrKysrLS0t
LS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDMuYyAgICAgIHwg
MzUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCA0NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21vZGlmeV9sZHQvLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9k
aWZ5X2xkdC8uZ2l0aWdub3JlCmluZGV4IGMwYjhiYmY1ODc1YWY0NTNiNDg4MGVmNGI3MTdmZGI0
MGQxMDllZTcuLmM4ODE3YjJjM2E4MTFhZmRmNDA4NDFkYzFiODFlNGIyYzAzNGU3ZDggMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0aWdub3JlCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0aWdub3JlCkBAIC0x
LDMgKzEsMiBAQAotL21vZGlmeV9sZHQwMQotL21vZGlmeV9sZHQwMgotL21vZGlmeV9sZHQwMwor
bW9kaWZ5X2xkdDAxCittb2RpZnlfbGR0MDIKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDEuYwppbmRleCBkOTNhMjgxNWY5ODBjMTdlOTQ5
MGQwMjg1YzYzZDc2YzY5ZTg4ZDAyLi4yMTVlZjQ4ZDljM2VmMDk1YjUwMzViOThiYWMwMDliNjFi
ZGQ2ZDZlIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQv
bW9kaWZ5X2xkdDAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0
L21vZGlmeV9sZHQwMS5jCkBAIC02LDEwICs2LDExIEBACiAgKi8KIAogLypcCi0gKiBWZXJpZnkg
dGhhdCBtb2RpZnlfbGR0KCkgY2FsbCBmYWlscyB3aXRoIGVycm5vOgorICogVmVyaWZ5IHRoYXQg
bW9kaWZ5X2xkdCgpIGNhbGxzOgogICoKLSAqIC0gRUlOVkFMLCB3aGVuIHdyaXRpbmcgKGZ1bmM9
MSkgdG8gYW4gaW52YWxpZCBwb2ludGVyCi0gKiAtIEVGQVVMVCwgd2hlbiByZWFkaW5nIChmdW5j
PTApIGZyb20gYW4gaW52YWxpZCBwb2ludGVyCisgKiAtIEZhaWxzIHdpdGggRUlOVkFMLCB3aGVu
IHdyaXRpbmcgKGZ1bmM9MSkgdG8gYW4gaW52YWxpZCBwb2ludGVyCisgKiAtIEZhaWxzIHdpdGgg
RUZBVUxULCB3aGVuIHJlYWRpbmcgKGZ1bmM9MCkgZnJvbSBhbiBpbnZhbGlkIHBvaW50ZXIKKyAq
IC0gUGFzc2VzIHdoZW4gcmVhZGluZyAoZnVuYz0wKSBmcm9tIGEgdmFsaWQgcG9pbnRlcgogICov
CiAKICNpbmNsdWRlICJ0c3RfdGVzdC5oIgpAQCAtMjYsMTcgKzI3LDIwIEBAIHN0YXRpYyBzdHJ1
Y3QgdHN0X2Nhc2UgewogCXVuc2lnbmVkIGxvbmcgYnl0ZWNvdW50OwogCWludCBleHBfZXJybm87
CiB9IHRzdF9jYXNlc1tdID0gewotCS8qIHsgMTAwLCAmYnVmLCBzaXplb2YoYnVmKSwgRU5PU1lT
IH0sICAvLyAwMSBibG9jazEgKi8KLQl7IDEsICh2b2lkICopMCwgMCwgRUlOVkFMIH0sIC8vIDAx
IGJsb2NrMgotCXsgMCwgJnB0ciwgc2l6ZW9mKHB0ciksIEVGQVVMVCB9LCAvLyAwMSBibG9jazMK
Kwl7IDEsICh2b2lkICopMCwgMCwgRUlOVkFMIH0sCisJeyAwLCAmcHRyLCBzaXplb2YocHRyKSwg
RUZBVUxUIH0sCisJeyAwLCAmYnVmLCBzaXplb2YoYnVmKSwgMCB9LAogfTsKIAogdm9pZCBydW4o
dW5zaWduZWQgaW50IGkpCiB7CiAJc3RydWN0IHRzdF9jYXNlICp0YyA9ICZ0c3RfY2FzZXNbaV07
CiAKLQlUU1RfRVhQX0ZBSUwobW9kaWZ5X2xkdCh0Yy0+dGZ1bmMsIHRjLT5wdHIsIHRjLT5ieXRl
Y291bnQpLAotCQkgICAgIHRjLT5leHBfZXJybm8pOworCWlmICh0Yy0+ZXhwX2Vycm5vKQorCQlU
U1RfRVhQX0ZBSUwobW9kaWZ5X2xkdCh0Yy0+dGZ1bmMsIHRjLT5wdHIsIHRjLT5ieXRlY291bnQp
LAorCQkJICAgICB0Yy0+ZXhwX2Vycm5vKTsKKwllbHNlCisJCVRTVF9FWFBfUE9TSVRJVkUobW9k
aWZ5X2xkdCh0Yy0+dGZ1bmMsIHRjLT5wdHIsIHRjLT5ieXRlY291bnQpKTsKIH0KIAogdm9pZCBz
ZXR1cCh2b2lkKQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlf
bGR0L21vZGlmeV9sZHQwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0
L21vZGlmeV9sZHQwMy5jCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAppbmRleCBhZGRjN2QwZTBj
MmVhZWM0NTY0YjlhMjBiZTA1ZThmMDYzOGJkMTc1Li4wMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xk
dC9tb2RpZnlfbGR0MDMuYworKysgL2Rldi9udWxsCkBAIC0xLDM1ICswLDAgQEAKLS8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCi0KLS8qCi0gKiBDb3B5cmlnaHQg
KGMpIDIwMTQgRnVqaXRzdSBMdGQuIFplbmcgTGluZ2dhbmcgPHplbmdsZy5qeUBjbi5mdWppdHN1
LmNvbT4KLSAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgotICovCi0KLS8qXAotICogVmVyaWZ5IHRoYXQgYSBzaW1wbGUgcmVh
ZCAoZnVuYz0wKSB3b3JrcyB3aGVuIGNhbGxpbmcgbW9kaWZ5X2xkdC4KLSAqLwotCi0jaW5jbHVk
ZSAidHN0X3Rlc3QuaCIKLQotI2lmZGVmIF9faTM4Nl9fCi0jaW5jbHVkZSAibGFwaS9sZHQuaCIK
LQotc3RhdGljIGNoYXIgKmJ1ZjsKLQotdm9pZCBydW4odm9pZCkKLXsKLQlUU1RfRVhQX1BPU0lU
SVZFKG1vZGlmeV9sZHQoMCwgYnVmLCBzaXplb2YoYnVmKSkpOwotfQotCi1zdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7Ci0JLnRlc3RfYWxsID0gcnVuLAotCS5idWZzID0KLQkJKHN0cnVj
dCB0c3RfYnVmZmVyc1tdKXsKLQkJCXsgJmJ1ZiwgLnNpemUgPSBzaXplb2Yoc3RydWN0IHVzZXJf
ZGVzYykgfSwKLQkJCXt9LAotCQl9LAotfTsKLQotI2Vsc2UKLVRTVF9URVNUX1RDT05GKCJUZXN0
IHN1cHBvcnRlZCBvbmx5IG9uIGkzODYiKTsKLSNlbmRpZiAvKiBfX2kzODZfXyAqLwoKLS0gCjIu
NDkuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
