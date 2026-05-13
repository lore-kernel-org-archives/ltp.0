Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E6CD343F
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 02:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778638266; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=II/KEz5d05Py4fWajhGO1w3FFCEA5caI2bSYiBcbrrs=;
 b=T7Jt7BZYU/OfjjokEMNkz2vBhmjp28+gjO5pk8QTgoAXexnMNvtzUgTlE6cPIix1SRY7u
 askkx2NDbm59AOlfGRPeAnRo5zjJbNEzgfreqYS3dQvo1lv1eV1EkU/lDoG0Dpmed5a81EL
 3zMCwwqV2DnxTD5oig9bTXlcs5fU0Ig=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC3483DA362
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 04:11:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE1423CD09E
 for <ltp@lists.linux.it>; Wed, 13 May 2026 04:10:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E34831400755
 for <ltp@lists.linux.it>; Wed, 13 May 2026 04:10:38 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so26086065e9.3
 for <ltp@lists.linux.it>; Tue, 12 May 2026 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778638238; x=1779243038; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h5YzK6iORD7A0hUN45h+lPC+zKv/5v3CiMn+BOyQcPU=;
 b=gJD6ZEZj0StX8MCXHr6UJOR3JZaOd82DR+Ae7QJalL+ql91m0w6z3Q490V+W1c8OUZ
 A2NLM24bLvevEoLqdoXUt6Ok+u2hF3uUDhynwJoKs3izVpEDRoZ2Lx6R4a+blgdwHt9p
 fCtOY0MtLhC9MEOXm/O+SaKOEAiiLkn+ZdL2WbcZeDZYvYERBzpWyyYamZYE7l+MdwjQ
 Eb8qGLSkCHAYVz0UOZMBoQVkmW8KY3pTZywP03Fazc6dw+NsOUDAWBtNEHmIBUY9+a1l
 2ByA9ktLMFERbNR3/f8er/NnyauyLg/0HpZskwNfQjKFhzE2XW0jhVYSkMmGPVU+qO0C
 cJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778638238; x=1779243038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5YzK6iORD7A0hUN45h+lPC+zKv/5v3CiMn+BOyQcPU=;
 b=KbI/rxMrf83WyBCbW6gIcYBPVbu1Q81jQsB2SAIaTONkOxoivIN29gsZvlP2DZ8D37
 +dN73RMdEdbPkYFfmWNwPQM7un7dKkioIDwny+2MmmA0nNii5Voa41DXn7Ls8MIxL7O9
 BMrdefOU1lOm7ItVLDO2KXbAZgYCjJZGRaRkIh+Xz+Yi5pllCQPjTNvrNBFuUv+e42yN
 fyUOYMjwXy50PIUhSiiRje9mO87SUzb3UvONUt42cxFcdAFDeKBDFyDaBd7OckVJirzj
 layN3UvtyE6uDlqH6Frf7rR25ZNrbS65AZRyb4OwIvbJVNTaM40JtyAn/31Owz/n1i9E
 TXlw==
X-Gm-Message-State: AOJu0YwNhGmqQz1GXms1hn9aeoBIKVhnT3LkNi2yl288NL/ZDL1AoeMK
 +uPNrXcKtff4ZnINk6MAqyQoSAl36R1tjFN9K2eE38HDE8chZR4Ziasg+rxQL0/66Q+tIIYTeE9
 dMMc=
X-Gm-Gg: Acq92OF83zJfTXSjtzWsXTQIcGiq45uoX8KK9wzx+MQ6N1V5hz6Yqh1reqRhULTwyWk
 UlwWe/uo5AFRgmhrmRXBClNyZU7OTF+Ux2wy+LTXX3RMiaRM0x5eDL5qN+YuYd4gC/XRkDWTmB1
 PzATsf+BMmtpVKisWbQQAc3ZNinE3dyePXGJhd07vup/wwyWVAeRIe6YBPITf5dEWuIg96mqeQ/
 E1ubIdvQDXLqralQh5bsQOinpTjJmyk0xJwyjbv9q1bc9zkZKZUwDVASoKTuGRliJxU5/EELjvr
 pmc7cOFXyVpXqE4ze+2FVnxKBr4HNHGzfPhUwR26NEc3GmYDMRUayNGGZIH5frNgOKmYppSUglf
 zXAyoNuy2Uhiq/og6yChfJV4xG4zEDNDSHESgquaTW3snopTU9vhkC69J8edmRKUXlSgrb2x5sr
 G5ymRwrYE7ULE=
X-Received: by 2002:a05:600c:a318:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-48fc9a371e4mr10795205e9.19.1778638238151; 
 Tue, 12 May 2026 19:10:38 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48fce37b18dsm13393325e9.11.2026.05.12.19.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 19:10:37 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 13 May 2026 02:10:33 +0000
Message-ID: <20260513021036.12127-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] nm01: Fix BSD vs POSIX format comparison failure
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
