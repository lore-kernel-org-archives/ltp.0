Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343ACD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778662315; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mID3NOBIn6ys6Rr87IDKjNTHLCewPYhHbL8isdadcNE=;
 b=WmCBL/SLowpT6IJ7N5DIiIR78jck3ir7xw+F47pMa0GEKVoRP+rJLlmoGkjKrPuQWMg86
 e1wFMe+69lroB3mar00O5ZN+fn67Gz+eONyOixm4ymylAXmbfEkGJzdBAdaFRnGzRlXZ7QF
 TWbk1w4ladf7wJyUEmrcVMN1KQgE7gk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09EAE3DF184
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 10:51:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B59B93CCB37
 for <ltp@lists.linux.it>; Wed, 13 May 2026 10:51:32 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1598D6009DB
 for <ltp@lists.linux.it>; Wed, 13 May 2026 10:51:32 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so109020055e9.2
 for <ltp@lists.linux.it>; Wed, 13 May 2026 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778662291; x=1779267091; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wzTSiRBVgBjWB4scJ0rjkNZyiJwyPFumK16Qdoxrm8=;
 b=OddPl7k02zi2yN1oYOpYjMt4Hj5wy6+gmKWjmlVex+XQ8vLttZKzl31uta2EY6U41D
 lis4ayuUvW7l/9OejNlntfJ51IpqvrA07mjBQtx0OvUpICFSh+qgBpXtAdgbjJCL3dQ/
 u9vzLcEOjReEAXj/jX9WTZ8/hjQcaeEUVjBpsoDt5iDmbbQOvuf5F/xqk6vOfv2yTyDy
 ClFYdEKQoWtD9rnE8pqTqasLeaCqFGcoik2PYgsGaMSu0FqCbAJEDCT8uyrzx5L3YfJo
 R4kvpfLb6mCm7x12eTLabkej7PtttcIFPTvTOmWdG6MiOYrQOpVNCk27L/xuHJf3zkO9
 i8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778662291; x=1779267091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3wzTSiRBVgBjWB4scJ0rjkNZyiJwyPFumK16Qdoxrm8=;
 b=oyidnSGVpFmTzBVH1hNzGu4ud5Z+rybVsQbFdrc6Rm6Oh/sgcdfykJvCHl67KrGOBu
 gepCA3i+y8wz70drcZfJAaAmEVBBGRQWUzUp3I+1Rqsb7/BK3IvtGXDkICeEqjKtRZcJ
 iaht3PmS/WUFuqPAyYFMnAuYVf57myyH69XoXEyTWcd0fzdeeA22bIWUoeQNrIPgJMCd
 6O5zpgnt43HqrvZSd7QtHw5DPDpH4+V05ChmLxulv3VUmqGqZIZjBJfnlK2ml4QT0uzR
 1Or2xEGtyAbZeW457i5PaDJV5C0EH/oSe12HsBNylna/JWj/VNZWxvgZ7rs9wrpuPeNF
 oWng==
X-Gm-Message-State: AOJu0Yy17jD//cKKtAKnmbX9eHYwcEqhOD3vqlIrXWBxj0cLQ+uWmiSj
 YvJHHM40N5C5+R5pRDMqi5g3ovRO0U2kD59RAEMzND4lpr4Qnr1lMpa9F8hEgpgb0n/uzARX0yz
 GRyI=
X-Gm-Gg: Acq92OH2WEaHbKA/Vfl4OrDrQsziV3I4s18R5ucBj3XqEAJvEwqEa9J+JdfjSIos9Vw
 fTufZnQGIbEnr1vHE6aGtudlN8oNWwZYCaB/cGFhbzc5SZ23OkJv07aV1lvHWu9kOZjJ96BpCHO
 ebqEbPWSE1/uDmTnhUKOk7PkaUs7ahEMz6Of88uOkD9HgIl7ycYpL5PU+myazkdHjJz4dhCAhAP
 CnPtCG7IGPqudTOSIlSyrL1wDTChWWs/j4jvYNlzMj+AyTp6CoyEFUleEub/kpd8QF/w+VUoRFX
 UeOXiu1GiNcZU8d9ehR478e3RADilGArAPp0wevChRrN7QgZe1D9ZI0uhj85RKdPfdG4+rhhBxq
 1CaItHRqI2HrUCrC9jPbJWlKzI+16jS5Xb9dTvO6dqC5duGeHiQS0lG4SXipDPh1xOAMSQGlbBq
 lI0eBGb0IRbo45tc+1hMv7Mg==
X-Received: by 2002:a05:600c:5246:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48fce9cf9a5mr26900905e9.11.1778662291202; 
 Wed, 13 May 2026 01:51:31 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm47627115e9.13.2026.05.13.01.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 01:51:30 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 13 May 2026 08:51:13 +0000
Message-ID: <20260513085124.12324-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513021036.12127-1-wegao@suse.com>
References: <20260513021036.12127-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] nm01: Fix BSD vs POSIX format comparison failure
 on Power
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Power architecture, symbol names can contain hex-like prefixes such
as "0000003e.plt_call.__gmon_start__".

In our openqa specific power system, the gensub seems has some
compatible issue which you can see following trace, the BSD format's
symbol name was incorrectly trimmed to ".plt_call.__gmon_start__"
(losing the "3e"), while the POSIX format kept it as
"3e.plt_call.__gmon_start__".

Example failure from a Power machine:
 --- DEBUG nm01_sh ---
 --- RAW BSD ---
 00000000000005e0 t 0000003e.plt_call.__gmon_start__
 --- RAW POSIX ---
 0000003e.plt_call.__gmon_start__ t 5e0
 --- REPRO LTP LOGIC ---
 --- TRIMMED BSD ---
 5e0 t .plt_call.__gmon_start__
 --- TRIMMED POSIX ---
 3e.plt_call.__gmon_start__ t 5e0
 --- REORDERED BSD (nm1) ---
 .plt_call.__gmon_start__t5e0
 --- REORDERED POSIX (nm2) ---
 3e.plt_call.__gmon_start__t5e0
 --- DIFF RESULT ---
 --- /tmp/dbg_nm1	2026-05-11 22:33:54.754648941 -0400
 +++ /tmp/dbg_nm2	2026-05-11 22:33:54.761924742 -0400
 @@ -1,7 +1,7 @@
 -.plt_call.__gmon_start__t5e0
 +3e.plt_call.__gmon_start__t5e0
 --- END DEBUG ---

Replace the global gensub to simple sub approach with targeted field processing in awk
can fix the issue.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v1->v2:
Update commit message to fix patch apply error

 testcases/commands/nm/nm01.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/testcases/commands/nm/nm01.sh b/testcases/commands/nm/nm01.sh
index c795d47ff..2ca73c4ea 100755
--- a/testcases/commands/nm/nm01.sh
+++ b/testcases/commands/nm/nm01.sh
@@ -83,17 +83,28 @@ test5()
 	EXPECT_PASS $NM -f bsd $TST_DATAROOT/f1 \> nm_bsd.out
 	EXPECT_PASS $NM -f posix $TST_DATAROOT/f1 \> nm_posix.out
 
-	ROD awk '{print gensub(/\y(0+)([0-9a-fA-F]+)\y/, "\\2", "g")}' nm_bsd.out \> trimmed_nm_bsd.out
-	ROD awk '{print gensub(/\y(0+)([0-9a-fA-F]+)\y/, "\\2", "g")}' nm_posix.out \> trimmed_nm_posix.out
-
-	ROD awk '{print $3 $2 $1}' trimmed_nm_bsd.out \> nm1.out
-	ROD awk '{print $1 $2 $3}' trimmed_nm_posix.out \> nm2.out
+	ROD awk '{
+		if (NF == 2) { val = "0"; type = $1; name = $2; }
+		else { val = $1; type = $2; name = $3; }
+		sub(/^0+/, "", val); if (val == "") val = "0";
+		sub(/^0+/, "", name);
+		print name type val
+	}' nm_bsd.out \> nm1.out
+
+	ROD awk '{
+		val = $3; type = $2; name = $1;
+		sub(/^0+/, "", val); if (val == "") val = "0";
+		sub(/^0+/, "", name);
+		print name type val
+	}' nm_posix.out \> nm2.out
 
 	if diff nm1.out nm2.out > /dev/null; then
 		tst_res TPASS "Got BSD format with -f bsd"
 	else
 		tst_res TFAIL "Got wrong format with -f bsd"
 		cat nm_bsd.out
+		cat nm_posix.out
+		diff -u nm1.out nm2.out
 	fi
 }
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
