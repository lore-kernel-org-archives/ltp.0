Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7080C001B0
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 03:57:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D01A3CE1EF
	for <ltp@archiver.kernel.org>; Tue,  8 Aug 2023 05:57:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C84153C62DA
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 05:57:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7DC461A002EE
 for <ltp@lists.linux.it>; Tue,  8 Aug 2023 05:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691467045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETVGogvMz7x8rz9INkfcpfUtIaM1M8QcNmSRirtAjSc=;
 b=NpqzRsjfA6DWJP8xhCxbeNVl2izoSOtfpdI91Bm0FD0NcW1e5xNMIzrfXo+1mAwx5sezM0
 Z1EL4Wkc0w7p6zo2JvZ+x6wSnPFx2gDkO2FvqYQRnnqbC0NWw5kFc3UYvIbvAXwPRGqfmb
 B/DjEsFjD9jZHbw+sH1Oj5LDqbmFG+Q=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Itj8gEFgNoeBXoBvqnzSDg-1; Mon, 07 Aug 2023 23:57:24 -0400
X-MC-Unique: Itj8gEFgNoeBXoBvqnzSDg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3a426e70577so8483362b6e.2
 for <ltp@lists.linux.it>; Mon, 07 Aug 2023 20:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691467043; x=1692071843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETVGogvMz7x8rz9INkfcpfUtIaM1M8QcNmSRirtAjSc=;
 b=eFbeKTGEng3KNhXqOXEabJ5xakfnSgPIv1/VdWL4a+pw3bM2xOm1A/DIeyiMiZWjhS
 zY++Us+db8zyvnGfQ5yQ5Wl2dPmgQ4w0soE9XaKQ7WjSBvZh/2naYsZ40Eeonli52syh
 iu8TLF9XsQaLIn8pTHGB4dvlSlExA2mSIJSqHGF4PgQVVkK+BbzWqpsQ0uvTw+Uj1XTb
 KgkiStknyCQ3OJcLWPXTtdvzDmUK0bZZ+Ul0wmmmIP/ypQEW/1KBwt+I+LEqoI6ubny+
 vP27W8FYqHEx1uyzZp03BxjHA0PMGYIQe6gGW9TTMrFM2XiRqxHVno3aDB+QhNpV9FxB
 vwIw==
X-Gm-Message-State: AOJu0Yw7V5KiAyjRe4BNIhSC1nPYG+4NMFWppRzR43aBfC1PMEGPJc+N
 EssA5F5Jqrop2vO0hS5Ie6CtSDBhjBhENfrLzh30UiKFcYk0QLZwNzwcru1JMAQpmSZokb8ndZz
 TJk4zks49w55TNpg3P6z+BE6N+4E/kqhN/Mj2XRyxJmXP/yHB5fn3PYAE0aOEKfOZ2L20ksnDMA
 ==
X-Received: by 2002:a05:6808:2a6b:b0:3a7:5d6e:dce9 with SMTP id
 fu11-20020a0568082a6b00b003a75d6edce9mr11326143oib.23.1691467042819; 
 Mon, 07 Aug 2023 20:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3g0ay2kCL5JR53wlBVW2uKE0DiYu8nc2u9kKrFim1ThEP0BHiy0zUQJvG9lTfVZ85TmMOGQ==
X-Received: by 2002:a05:6808:2a6b:b0:3a7:5d6e:dce9 with SMTP id
 fu11-20020a0568082a6b00b003a75d6edce9mr11326117oib.23.1691467042283; 
 Mon, 07 Aug 2023 20:57:22 -0700 (PDT)
Received: from fedora19.redhat.com ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 4-20020aa79104000000b00686bf824b3bsm6901159pfh.136.2023.08.07.20.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:57:21 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Aug 2023 13:56:42 +1000
Message-ID: <20230808035641.364676-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803015149.69906-1-iwienand@redhat.com>
References: <20230803015149.69906-1-iwienand@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't fill
 from /dev/zero
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
memory stats by zero.  This has been reported before at [1] without
resolution.

After some investigation [2] my conclusion is that this zero value
represents the pages allocated for compressed storage in the zram
device, and due to same-page deduplication the extant method of
filling with all-zeros can indeed lead us to not having any compressed
data to measure.

This is visible in the occasional divide-by-zero error, but in the
bigger picture means this test is not exercising the compression path
as desired.

The approach here is to mix the write values to make something
compressible but avoid the same-page deduplication.  However, to cover
both paths, as described inline, we write out a few pages worth and
double-check the stats reflect deduplicated pages.

This also adds the sync, as discussed in prior version [3] to increase
the reliability of testing.

[1] https://lists.linux.it/pipermail/ltp/2019-July/013028.html
[2] https://lists.linux.it/pipermail/ltp/2023-August/034585.html
[3] https://lists.linux.it/pipermail/ltp/2023-August/034560.html

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 .../kernel/device-drivers/zram/zram01.sh      | 56 ++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 58d233f91..619d47f93 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -4,7 +4,7 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test creates several zram devices with different filesystems on them.
-# It fills each device with zeros and checks that compression works.
+# It fills each device and checks that compression works.
 
 TST_CNT=7
 TST_TESTFUNC="do_test"
@@ -107,14 +107,39 @@ zram_mount()
 
 zram_fill_fs()
 {
-	local mem_used_total
-	local b i r v
+	local mm_stat mem_used_total same_pages
+	local b f i r v
+
+	# zram has "same page" detection that will flag pages filled
+	# with the same value.  These pages are not compressed; there
+	# is just a record left in the allocation table "page full of
+	# <x>".  mem_used_total is the number of pages held by the
+	# allocator to store store compressed data.  If we write a
+	# consistent value in the dd loop below (e.g. just /dev/zero)
+	# the only data to compress is the filesystem metadata.  It is
+	# possible the fs is not quiescent, thus this metadata is in
+	# memory (i.e. not compressed).  Consequently we could have no
+	# compressed data stored and the ratio (data/pages held for
+	# compressed data) would be a divide by zero.
+	#
+	# To make sure we are actually testing both the same-page and
+	# compression paths, we first pad with zeros but then fill
+	# with a compressible series of alternatiting 0x00 and 0xFF.
+	# This should assure we stress the compression path and can
+	# calculate the compression level reliabily.
+	dd if=/dev/zero count=1 bs=512 count=1 2>err.txt | tr "\000" "\377" > compressible
+	dd if=/dev/zero count=1 bs=512 count=1 >> compressible 2>err.txt
 
 	for i in $(seq $dev_start $dev_end); do
-		tst_res TINFO "filling zram$i (it can take long time)"
+		f='/dev/zero'
+		tst_res TINFO "zero filling zram$i"
 		b=0
 		while true; do
-			dd conv=notrunc if=/dev/zero of=zram${i}/file \
+			if [ $b == 1024 ]; then
+				f='compressible'
+				tst_res TINFO "filling zram$i with compressible data (this may take a while)"
+			fi
+			dd conv=notrunc if=$f of=zram${i}/file \
 				oflag=append count=1 bs=1024 status=none \
 				>/dev/null 2>err.txt || break
 			b=$(($b + 1))
@@ -133,7 +158,18 @@ zram_fill_fs()
 			continue
 		fi
 
-		mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		# The compression needs time to catch up so we get
+		# useful stats
+		sync
+
+		mm_stat=$(cat "/sys/block/zram$i/mm_stat")
+		tst_res TINFO "stats for zram$i : $mm_stat"
+
+		mem_used_total=`echo $mm_stat | awk '{print $3}'`
+		if [ $mem_used_total -eq 0 ]; then
+			test_res FAIL "/sys/block/zram$i/mm_stat reports 0 size : $(cat /sys/block/zram$i/mm_stat)"
+			return
+		fi
 		v=$((100 * 1024 * $b / $mem_used_total))
 		r=`echo "scale=2; $v / 100 " | bc`
 
@@ -141,9 +177,15 @@ zram_fill_fs()
 			tst_res TFAIL "compression ratio: $r:1"
 			break
 		fi
-
 		tst_res TPASS "compression ratio: $r:1"
+
+		same_pages=`echo $mm_stat | awk '{print $6}'`
+		if [ "$same_pages" -lt 10 ]; then
+		    tst_res TFAIL "insufficient same_pages: $same_pages < 10"
+		fi
+		tst_res TPASS "same_pages: $same_pages"
 	done
+	rm compressible
 }
 
 do_test()
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
