Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D51C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 04:54:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89463D1FAD
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 06:54:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1C8E3D218E
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 06:53:57 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 0DDD810008FF
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 06:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=iQOflL4OK+sOH48UNw09j6eXtTIHOK1SEd65nKxAUo4=;
 b=m4dRGdnZggoZEaXnls4PhJGG8BT7ekFX0/q8UuBuaWQv96HfLOGmuvXID+fpFJ
 M8N40uZn4PoTdPvj49boEx/DWZXZ+8UATcpmsx2aDn7+pFixR570Sdcj7+FknlWd
 ZjLCjZ2R9AES2vUlp2v8xNTZV2o/OqHAOpSseI012xIIQ=
Received: from fedora-40.. (unknown [106.146.87.91])
 by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wBH5hNZ275m0MfLHg--.35575S3;
 Fri, 16 Aug 2024 12:53:50 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: ltp@lists.linux.it
Date: Fri, 16 Aug 2024 13:53:27 +0900
Message-ID: <20240816045342.185737-2-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816045342.185737-1-ice_yangxiao@163.com>
References: <20240816045342.185737-1-ice_yangxiao@163.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wBH5hNZ275m0MfLHg--.35575S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4fKrW5XF4fKrW5uF48WFg_yoWDurg_WF
 15G3WkKr4UAFW7G3yYyr43Zr45tryYkFsYv3ZrKrWrGayfZw1DWFZ3CFW5J3Z5ur1vgF9I
 9r4Fgrn2qw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUb1rWUUUUUU==
X-Originating-IP: [106.146.87.91]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqQc9XmVOCPDoNQABsC
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/mseal01.c: Use the correct "'" for JSON
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

Rml4IHRoZSBmb2xsb3dpbmcgd2FybmluZ3MgZnJvbSBtZXRhZGF0YS9tZXRhcGFyc2U6CmRhdGFf
c3RvcmFnZS5oOjMyNTogV0FSTklORzogaW52YWxpZCBjaGFyYWN0ZXIgZm9yIEpTT046IGZmZmZm
ZmUyCmRhdGFfc3RvcmFnZS5oOjMyNTogV0FSTklORzogaW52YWxpZCBjaGFyYWN0ZXIgZm9yIEpT
T046IGZmZmZmZjgwCmRhdGFfc3RvcmFnZS5oOjMyNTogV0FSTklORzogaW52YWxpZCBjaGFyYWN0
ZXIgZm9yIEpTT046IGZmZmZmZjk5CgpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPGljZV95YW5n
eGlhb0AxNjMuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWww
MS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2VhbDAxLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEuYwppbmRleCA2MmNmZGQ2
YTYuLjAwNDU0YTc2NiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2Vh
bC9tc2VhbDAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2VhbDAx
LmMKQEAgLTE2LDcgKzE2LDcgQEAKICAqIC0gbW9kaWZ5aW5nIGEgVk1BIHZpYSBtbWFwKE1BUF9G
SVhFRCkKICAqIC0gbXByb3RlY3QoKSBhbmQgcGtleV9tcHJvdGVjdCgpCiAgKiAtIGRlc3RydWN0
aXZlIG1hZHZpY2UoKSBiZWhhdmlvcnMgKGUuZy4gTUFEVl9ET05UTkVFRCkgZm9yIGFub255bW91
cyBtZW1vcnksCi0gKiAgIHdoZW4gdXNlcnMgZG9u4oCZdCBoYXZlIHdyaXRlIHBlcm1pc3Npb24g
dG8gdGhlIG1lbW9yeQorICogICB3aGVuIHVzZXJzIGRvbid0IGhhdmUgd3JpdGUgcGVybWlzc2lv
biB0byB0aGUgbWVtb3J5CiAgKgogICogQW55IG9mIHRoZSBkZXNjcmliZWQgYWN0aW9ucyBpcyBy
ZWNvZ25pemVkIHZpYSBFUEVSTSBlcnJuby4KICAqCi0tIAoyLjQ1LjIKCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
