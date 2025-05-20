Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3232C54E65
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747816162; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=PauY9pGHkrWw/d5caSzbPllcw3etaZpyF+au4kptcUI=;
 b=BTgpuT7nOKw377t51WCq4eCWnwnjlpKW6ydnS1HJ2hB1AFmKyuN9VF7e5nFX/oVQ790/E
 yfS4hmu1iJPMwPQA7pGOTXSWl17tzt1hHVjisRK2yRCc3/YxUQjPOegxMtblcZwcRGZccl4
 knrT9BaJnQaZgmakFBIEqg77hEaWFC4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C97213CC7C0
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 10:29:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 055113CC772
 for <ltp@lists.linux.it>; Tue, 20 May 2025 22:24:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F23AB1A01096
 for <ltp@lists.linux.it>; Tue, 20 May 2025 22:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747772690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nri0cTkx1f2VEu4zYbiyLnc3whGLAim1j0hDUtur0gE=;
 b=Soq+OtNlAwxyiM9PzvOUdoeanOFk+Wht9kPQhFth7RX0BrtzZiCB6cTYUT1mUMgMn2+D3I
 Y8ke7iPQhLvkNrX8dRot6EGZySlPwlWxUwpbAiYt3S75iukQhu5XAJ8Gr2pRMAd0DI9OGk
 5xDdVGRbZ2RdxC62mMoBeojXz+Op+2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-9EmgJM3nO3OUMmnYMb_psg-1; Tue,
 20 May 2025 16:24:49 -0400
X-MC-Unique: 9EmgJM3nO3OUMmnYMb_psg-1
X-Mimecast-MFC-AGG-ID: 9EmgJM3nO3OUMmnYMb_psg_1747772689
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 400061800446
 for <ltp@lists.linux.it>; Tue, 20 May 2025 20:24:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A46C719560AD
 for <ltp@lists.linux.it>; Tue, 20 May 2025 20:24:47 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 20 May 2025 16:24:29 -0400
Message-ID: <20250520202429.577890-1-luizcap@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QBKnU4J1R4gwW5Pv_msDaorWz6-UpSJA4Vtcaf_1mrw_1747772689
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 21 May 2025 10:29:00 +0200
Subject: [LTP] [PATCH] ksm: fix segfault on s390
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
From: Luiz Capitulino via ltp <ltp@lists.linux.it>
Reply-To: Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Recently, we started seeing the following segfault when running ksm01
and ksm02 tests on an s390 KSM guest:

"""
[  119.302817] User process fault: interruption code 0011 ilc:3 in libc.so.6[b14ae,3ff91500000+1c9000]
[  119.302824] Failing address: 000003ff91400000 TEID: 000003ff91400800
[  119.302826] Fault in primary space mode while using user ASCE.
[  119.302828] AS:0000000084bec1c7 R3:00000000824cc007 S:0000000081a28001 P:0000000000000400
[  119.302833] CPU: 0 UID: 0 PID: 5578 Comm: ksm01 Kdump: loaded Not tainted 6.15.0-rc6+ #8 NONE
[  119.302837] Hardware name: IBM 3931 LA1 400 (KVM/Linux)
[  119.302839] User PSW : 0705200180000000 000003ff915b14ae
[  119.302841]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:3
[  119.302843] User GPRS: cccccccccccccccd 000000000007efff 000003ff91400000 000003ff814ff010
[  119.302845]            0000000007ffffff 0000000000000000 0000000000000000 000003ff00000000
[  119.302847]            0000000000000063 0000000000100000 00000000023db500 0000000008000000
[  119.302848]            0000000000000063 0000000000000080 00000000010066da 000003ffd7777e20
[  119.302855] User Code: 000003ff915b149e: a784ffee            brc     8,000003ff915b147a
                          000003ff915b14a2: e31032000036        pfd     1,512(%r3)
                         #000003ff915b14a8: e31022000036        pfd     1,512(%r2)
                         >000003ff915b14ae: d5ff30002000        clc     0(256,%r3),0(%r2)
                          000003ff915b14b4: a784ffef            brc     8,000003ff915b1492
                          000003ff915b14b8: b2220020            ipm     %r2
                          000003ff915b14bc: eb220022000d        sllg    %r2,%r2,34
                          000003ff915b14c2: eb22003e000a        srag    %r2,%r2,62
[  119.302867] Last Breaking-Event-Address:
[  119.302868]  [<000003ff915b14b4>] libc.so.6[b14b4,3ff91500000+1c9000]
"""

This segfault is triggered by the memcmp() call in verify():

"""
memcmp(memory[start], s, (end - start) * (end2 - start2)
"""

In the default case, this call checks if the memory area starting in
memory[0] (since start=0 by default) matches 's' for 128MB. IOW, this
assumes that the memory areas in memory[] are contiguous. This is wrong,
since create_ksm_child() allocates 128 individual areas of 1MB each. As,
in this particular case, memory[0] happens to be the last 1MB area in
the VMA created by the kernel, we hit a segault at the first byte beyond
memory[0].

Now, the question is how this has worked for so long and why it may still
work on arm64 and x86 (even on s390 it ocassionaly works).

For the s390 case, the reason is upstream kernel commit efa7df3e3bb5
("mm: align larger anonymous mappings on THP boundaries"). Before this
commit, the kernel would always map a library right after the memory[0]
area in the process address space. This causes memcmp() to return
non-zero when reading the first byte beyond memory[0], which in turn
causes the nested loop in verify() to execute. The nested loop is correct
(ie. it doesn't assume the memory areas in memory[] are contiguous) so
the test doesn't fail. The mentioned upstream commit causes the first byte
beyond memory[0] not to be mapped most of the time on s390, which may
result in a segfault.

Now, as it turns out on arm64 and x86 the kernel still maps a library right
after memory[0] which causes the test to suceed as explained above (this
can be easily verified by printing the return value for memcmp()).

This commit fixes verify() to do a byte-by-byte check on each individual
memory area. This also simplifies verify() a lot, which is what we want
to avoid this kind of issue in the future.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 testcases/kernel/mem/ksm/ksm_test.h | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm_test.h b/testcases/kernel/mem/ksm/ksm_test.h
index 0db759d5a..cbad147d4 100644
--- a/testcases/kernel/mem/ksm/ksm_test.h
+++ b/testcases/kernel/mem/ksm/ksm_test.h
@@ -74,22 +74,15 @@ static inline void verify(char **memory, char value, int proc,
 		    int start, int end, int start2, int end2)
 {
 	int i, j;
-	void *s = NULL;
-
-	s = SAFE_MALLOC((end - start) * (end2 - start2));
 
 	tst_res(TINFO, "child %d verifies memory content.", proc);
-	memset(s, value, (end - start) * (end2 - start2));
-	if (memcmp(memory[start], s, (end - start) * (end2 - start2))
-	    != 0)
-		for (j = start; j < end; j++)
-			for (i = start2; i < end2; i++)
-				if (memory[j][i] != value)
-					tst_res(TFAIL, "child %d has %c at "
-						 "%d,%d,%d.",
-						 proc, memory[j][i], proc,
-						 j, i);
-	free(s);
+
+	for (j = start; j < end; j++)
+		for (i = start2; i < end2; i++)
+			if (memory[j][i] != value)
+				tst_res(TFAIL, "child %d has %c at "
+					"%d,%d,%d.",
+					proc, memory[j][i], proc, j, i);
 }
 
 struct ksm_merge_data {
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
