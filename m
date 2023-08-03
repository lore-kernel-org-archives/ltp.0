Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70ADC001DE
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 01:52:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 460C23CDB70
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 03:52:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CA343CBCA8
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 03:52:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 75A2C200B37
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 03:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691027518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pgf7jfIxuyStaKFWu11wz9E86U/RabEUR0Em0xwn9ic=;
 b=Ri7b3lMb8twZKm6zMnqipnKD5hUCvPLhWl0T5IsfAqSUx/ddxIreigvkTLgeC3WrP/PnrW
 9OcVoTXr3Ays7gadRHtMf5c5VM9IaCLGxsrdJ/tHgS5W2VrHDHFTm52EevvJjVZRetwvqd
 SnlIHl0DKcaXyCyAknXqmlFHCshPB8s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-VCSlVUs0NHeVyWe9A2A5Pw-1; Wed, 02 Aug 2023 21:51:57 -0400
X-MC-Unique: VCSlVUs0NHeVyWe9A2A5Pw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-56336f5dc6cso279790a12.0
 for <ltp@lists.linux.it>; Wed, 02 Aug 2023 18:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027516; x=1691632316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pgf7jfIxuyStaKFWu11wz9E86U/RabEUR0Em0xwn9ic=;
 b=B9oNMTDNM4L03Z93FDD7cNyJOxk297iA/+48RKq60s1uJaF2BzBZlEDFqO5KvYanF6
 z/jttEVrKSjOGd+W536GSL0p9cWouGuGv29gdiIYZ0Ls9kHAXyEe8DKDIwVJKjLQmOXx
 osVowJOtrMGCXDLekp4Gv+ZfoAKD+GTf4IPaW5rPt9jXiOkHhbPaw/MrM4DJ1m8ltnhY
 MBghfEqxVQYdVOvcGj+4BD21Zi/LlYIsBSzneZs8ndhh5t3H2J0lwHcOLcPahekGeTWw
 I10OTZ2JYw5UdpfOd4O1U1tGXSQWAajQQYTQRWbab1VIzNEv8jJyEHSeTudGQq8ZXlPF
 R+pA==
X-Gm-Message-State: ABy/qLb/PoOWwYwC5CaijNROsTevomxs/Q/gEXvgbWLgJGN5TeZbbhEW
 FN8p9peM6m1Lwec56ibythKmcY13/LAB1+4rCo5iyMwTPkZCNMvzLP99iQhwXmNs1Scgh3T7FYq
 qcT434WDfLmHoiEgWOh7vsgswUQHJXA1QFGrVoWEGFnDSGwNWNI9AlpSpEEGsqZK8OncygPc=
X-Received: by 2002:a05:6300:808d:b0:138:1980:1375 with SMTP id
 ap13-20020a056300808d00b0013819801375mr15899858pzc.25.1691027516304; 
 Wed, 02 Aug 2023 18:51:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNL3fELXTFCZOkTqiRywUHWeronJWdSlAfLeA/RP1PNy40fyvBkya+3lXiW2AwVkuxhO/znA==
X-Received: by 2002:a05:6300:808d:b0:138:1980:1375 with SMTP id
 ap13-20020a056300808d00b0013819801375mr15899851pzc.25.1691027515872; 
 Wed, 02 Aug 2023 18:51:55 -0700 (PDT)
Received: from fedora19.redhat.com ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a170903018100b001b9df74bac6sm13076085plg.260.2023.08.02.18.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:51:55 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  3 Aug 2023 11:51:49 +1000
Message-ID: <20230803015149.69906-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kernel/device-drivers/zram/zram01.sh : add a sync
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I have a system (virtualized aarch64, 4.18.0 kernel) that is
consistently failing the zram01.sh test as it tries to divide the
memory stats by zero.  It seems like I'm not the only one, this has
been reported before at [1] without resolution.

This test does a lot of 1k writes into zram devices of size 25, 25,
25, 300 and 25 mb.  On this particular system, I consistently see the
final 25mb testing fail as it examines /sys/block/zramX/mm_stat and
finds the mem_used_total as zero.

For example, I instrumented the test to put a "sync" call in between
examining the mm_stat value if it was zero; before and after it looks
like:

 zram01 7 TINFO: /sys/block/zram34/mm_stat is zero : 10092544        0        0 26214400   196608      154        0        0
 <sync>
 zram01 7 TINFO: /sys/block/zram34/mm_stat is zero (post sync) : 26214400     2841    65536 26214400   196608      399        0        0

This is an otherwise quiet system and nothing else seems out of order
(weird logs, load average, etc.).  I think that given the 300mb worth
of writes from the prior step, the system just needs a little time to
catch up on the compression to make this test more reliable.

I considered checking if the value is zero and arbitrarily just
waiting a few seconds which did work.  I then replaced this with a
sync which also worked.  Rather than worrying about checking for zero
values, it seems more reliable and simpler to just sync after the
writes in all cases.  I could not replicate this issue with the sync
as proposed in this patch.

Additionally this does a check for a zero value to hopefully provide a
more structured message if the test fails in the same way.

[1] https://lists.linux.it/pipermail/ltp/2019-July/013028.html

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 58d233f91..5f3964f6c 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -119,6 +119,9 @@ zram_fill_fs()
 				>/dev/null 2>err.txt || break
 			b=$(($b + 1))
 		done
+                # Give the system time to catch up, otherwise the mm_stat
+                # checking below can give a false negative
+		sync
 		if [ $b -eq 0 ]; then
 			[ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
 			tst_brk TBROK "cannot fill zram $i"
@@ -134,6 +137,9 @@ zram_fill_fs()
 		fi
 
 		mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		if [ $mem_used_total -eq 0 ]; then
+			test_res FAIL "/sys/block/zram$i/mm_stat reports 0 size : $(cat /sys/block/zram$i/mm_stat)"
+		fi
 		v=$((100 * 1024 * $b / $mem_used_total))
 		r=`echo "scale=2; $v / 100 " | bc`
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
