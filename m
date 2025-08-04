Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A9CC87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754338333; h=date : to :
 message-id : mime-version : content-type : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : sender : from;
 bh=Ff/Ah/Qy60KCal2bTJkS1B3R6B6stws7Nb0cQ7sQWnI=;
 b=kpiNl2oE6DFE2eG6UWlOklmKnJTdpF9gnAsQJvJa3Yrcpp3FLSlS8iKMCoxNBExmv0WfU
 U9iXOg/BKBUq40tBAzCobH5BpcsrQPKE9JS8tfRx2EtDIr4rqhcaU7V5MGeEGJx4jSGWhf9
 1aePe3WGaAur8tFp2HmNScj1MLa+SYg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69EAB3C209C
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51C263C028F
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 22:11:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 620D614004E5
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 22:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754338309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=cL9nhX1ePalSd9hAo5fwiHgREguJRRz2+iRgjXW743c=;
 b=H8oa4mxRt84pjSHihlYycvyjtRaAULyr+r5GkOPHPC5dBav51Vbf4fWmggnazyfByskcRr
 dP2f4lVryNVL+c1+PUv5BzgsJeMQGRj8xgx+TKXEWDK8XqfiEY4u7eI1YqSF932AdoX9qE
 lIOgl0wRRorHPhwMca8DiRjH2ws8E5g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-n4zfgsncPJi8zP1TxeEfZw-1; Mon, 04 Aug 2025 16:11:46 -0400
X-MC-Unique: n4zfgsncPJi8zP1TxeEfZw-1
X-Mimecast-MFC-AGG-ID: n4zfgsncPJi8zP1TxeEfZw_1754338305
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70732006280so66026576d6.3
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 13:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754338305; x=1754943105;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZgQfNQE8PXQumQXJNHyVkNGmTX/tpqIRRCwz/YbJmlk=;
 b=L5CwZMF86tS3ghY47al5nAjgBJwq/DW1X+2fDDJyOPposmekDOaC+FQXAChoMqayGi
 9jZn/KYRKV+8F81LUwfB0YlCEUi42u9mzB4VwZ2JZAkXoxEoL699kX5VpvqBzvwHExiV
 FNpeASYKWH8qqB3VtIRuqHUmS9GMOO5a1AxfRgSemHkz62lyAWInz03UYKnysaB/UDd3
 QKbc/qPEBMAqzKO9wBOu+jaeG2X5dgQc8TSYTxDNrMJy+S5vl13nO6d9dgJzihhvwTAt
 IkCfzumFSqWgRkhaJkxEoo6OCBBlWJ7NzAIZUjiNyu2pAF1CvTgZTeKaENtcrb1UqzwY
 /ryw==
X-Gm-Message-State: AOJu0YxpLyGlH1mruP+xHH1wZ7Dew4iIgGN2ORfsXbtnzOpEN3OlUu/q
 8rKJtP+vROZvtSd/z6Sqh5JUjkR2e/djEPyR7Vzqfnf7rBvf8rUhRS10J9s/6ZoJwNRyRLtTLe5
 sB3J8nJfInzGEBJZ9BQi5qrub6rIc8lNAci2oVGo3VJSeA32iobZkUqxLKDhM9s1mz+PRTBm8aG
 bN7ZvHIWZHjFROfl3x1y1oyefZTpm6IM29DHE=
X-Gm-Gg: ASbGncvog3aGgphDD9t/P7Qe9RTCJmgXMxJb7L1hrFqHpW5AJ8DPAg7G1vhsteJol57
 zCtf74hl7BBD3v3BmlsnE4/81Udc60SP+bOvuuqs5hq8Wq2NZ4LI2J6Yi1nVzIVP0+Rnv7bH53e
 N/qbEngnK2xDsiQW0mCBXhq50Im5aacTxwAylmFcuvSUFDBNjXRe9sF3EygaCFHQ9xhH1Jx23Q4
 HtqOcuMLa/Ckzs6Jyz6rhoTFvO+Vu3FVmqC5trwyC0Oo6Tg7FIjKXaCvoRnrAG9uumtV1ssQ7yW
 b0Js60m2RqFQtD3VKpPsQZ3It95Cxtte0ztzO62acoCBExInR7KUglc2rg==
X-Received: by 2002:a05:6214:19e5:b0:707:76a8:ee9d with SMTP id
 6a1803df08f44-7093636737dmr152563876d6.51.1754338305474; 
 Mon, 04 Aug 2025 13:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDMpLubUuDHoIPHCCRLdIQjdiud8ToNyZ38VVlnwGhqxEjNFSLRFzS6WOyud4/f0vCXoG7Xw==
X-Received: by 2002:a05:6214:19e5:b0:707:76a8:ee9d with SMTP id
 6a1803df08f44-7093636737dmr152563536d6.51.1754338304940; 
 Mon, 04 Aug 2025 13:11:44 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca464acsm62681726d6.36.2025.08.04.13.11.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Aug 2025 13:11:44 -0700 (PDT)
Date: Mon, 4 Aug 2025 22:11:41 +0200
To: ltp@lists.linux.it
Message-ID: <20250804201141.y5pncvmjhqv7mpjz@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKAiKDZylKamgfzlSCaaIvqCOU0Ms29QmHEQCBoKZj0_1754338305
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="lyruc4oydlekwbpa"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Make sure 32-bit powerpc syscall defs don't leak to 64-bit
 powerpc systems
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: mjw@redhat.com
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--lyruc4oydlekwbpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello folks,

I think I see a problem in how generate_syscalls.sh generates the
syscalls.h header on 64-bit powerpc systems.  I've filed [1] to
cover this.  But folks seem to prefer the mailing list patch
submission, so let me try :)  Please review the attached patch.

Thanks,
Martin


---------------
[1] https://github.com/linux-test-project/ltp/issues/1251


--lyruc4oydlekwbpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Make-sure-32-bit-powerpc-syscall-defs-don-t-leak-to-.patch"

From a90b2aac69028bd6b9e0fcc1e36760639b937b99 Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Mon, 4 Aug 2025 21:46:52 +0200
Subject: [PATCH] Make sure 32-bit powerpc syscall defs don't leak to 64-bit
 powerpc systems

generate_syscalls.sh generates the syscalls.h header at the configure
time.  At the moment, that header has a set of 32-bit syscalls defined
with the __powerpc__ gate, plus another set of 64-bit syscalls defined
with the __powerpc64__ gate.  For 32-bit powerpc systems that's fine.
But for a 64-bit powerpc system this means that both sets of syscalls
become defined, which isn't right.

Thing is that on a 64-bit powerpc system, both __powerpc__ and
__powerpc64__ are defined compiler macros, while on a 32-bit powerpc
system, only the former is defined while the latter is not.

That said, the correct gate for a 32-bit only powerpc code is:
  #if defined(__powerpc__) && !defined(__powerpc64__)

Without this patch, e.g. __NR_clock_gettime64 def leaks to
64-bit powerpc systems, which is wrong.  This patch fixes it.
---
 include/lapi/syscalls/generate_syscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
index b17c72ddf..19f280dfb 100755
--- a/include/lapi/syscalls/generate_syscalls.sh
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -78,6 +78,7 @@ while IFS= read -r arch; do
 		parisc) echo "#ifdef __hppa__" ;;
 		loongarch64) echo "#ifdef __loongarch__" ;;
 		arm64) echo "#ifdef __aarch64__" ;;
+		powerpc) echo "#if defined(__powerpc__) && !defined(__powerpc64__)" ;;
 		*) echo "#ifdef __${arch}__" ;;
 		esac
 
-- 
2.48.1


--lyruc4oydlekwbpa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--lyruc4oydlekwbpa--

