Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9691ACD4938
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 01:13:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F2683CE3E9
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 03:13:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0E13CA6A8
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 03:12:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6C7F6029FB
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 03:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695258768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qVhCZd7V/W4/OOWj/bkMFt3TJstbOMQHWb2xcqE0MRU=;
 b=d9Hpi4nNtczHsKSqDnJZ93BaGxo6vE4Q1ttKW9LV095VJoxoW9K2VOJiiE36jY+Y/j00U8
 KoZPvjbmbaZmd9ozhpQVwJeYBGpO4ewzSUut+feM/xUmK4nk4mf5GGW9ig0GUv9egJybFv
 Ip66nkGTZ0QHf6iZKvKKUVj88CRs9Ig=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-0Wyp6Lw7OeStrADm14QDOQ-1; Wed, 20 Sep 2023 21:12:46 -0400
X-MC-Unique: 0Wyp6Lw7OeStrADm14QDOQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-27497b4ba1fso281010a91.0
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 18:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258766; x=1695863566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVhCZd7V/W4/OOWj/bkMFt3TJstbOMQHWb2xcqE0MRU=;
 b=RRoRPOK+MvA2/b39DOxgI3YuMdBjMjoq7+QN4eomjRjYFplizTKm2ED62FRD1wwsxO
 Ix2Mt02h6zRWQmgaE2CU0Sk+nLWgIBTh8QQLzxf4Ll86gzzvWtp57s/IGuFtTOtb6spS
 G6TSPFCXoouSelPrO8WZgwsV6jPI+dYFP2WfAAVz+VwlqRV8VFSJ+giiafOkk8BxzznN
 +8YYjKSnNsNLA9iewOrqmIBn2EfB/dRbAYyGMx3XhAi84k/0W8+3eYMygc9PAE+4qaZa
 4p/sKBfaCezckbSP18+gK75YJPhjuuQ+0duEpiJtkEp+VxK9cvY5QKlu+GNON7fhebnV
 5GHg==
X-Gm-Message-State: AOJu0YzvagBmRq8n+nGGIDvkAGP/iM0eXQSINmk1YgtWFTq6l0kXzUGR
 EOE30UPcpxaHyCDGTqJFizylPA+3jd8oEgC3qUKYsQrPeqeT/JkLJITYl5x6SFHXTvl8Tu7hpLc
 pgRPHtwPuwGUCWeJNJW0u0/QT4igUAsIijAiVBluKkcOlUJwOxeXHe4RWX+ei0Dm5U1mDGgk=
X-Received: by 2002:a17:90b:30d0:b0:274:bf7a:60ed with SMTP id
 hi16-20020a17090b30d000b00274bf7a60edmr4203195pjb.12.1695258765705; 
 Wed, 20 Sep 2023 18:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKx6Pu2xWjAwZgPXv+PLnapbuD2mRyzxynCyVKWY3viN8dbqtLjb+rFY7Xnui8ejVmC//0sg==
X-Received: by 2002:a17:90b:30d0:b0:274:bf7a:60ed with SMTP id
 hi16-20020a17090b30d000b00274bf7a60edmr4203172pjb.12.1695258764900; 
 Wed, 20 Sep 2023 18:12:44 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a17090a6b0600b00262eb0d141esm178769pjj.28.2023.09.20.18.12.43
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:12:44 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:12:40 +1000
From: Ian Wienand <iwienand@redhat.com>
To: ltp@lists.linux.it
Message-ID: <ZQuYiFMOSq1tMTBs@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230808035641.364676-2-iwienand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] kernel/device-drivers/zram/zram01.sh : fill with
 compressible data
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

Hello,

I have a system (virtualized aarch64, 4.18.0 kernel) that is
consistently failing the zram01.sh test as it tries to divide the
memory stats by zero.  This has been reported before at [1] without
resolution.  f045fd1de6420cc6d7db2bda0cd86fb56ff5b1c1 put a retry loop
around the read of this value; this is essentially reverted here for
the reasons described below.

After some investigation [2] my conclusion is that this zero value
represents the pages allocated for compressed storage in the zram
device, and due to same-page deduplication the extant method of
filling with all-zeros can indeed lead us to not having any compressed
data to measure.

This is visible with the test being unstable with a divide-by-zero
error, but in the bigger picture means this test is not exercising the
compression path as desired.

The approach here is to separate the test into two parts, one that
keeps the existing behaviour but it now targeted explicitly at testing
the page de-deuplication path.  For the reasons described above, there
is no point in asserting the compression ratio of this test, so it is
modified do a sanity check on the count of de-deuplicated pages.

A second test is added that explicitly writes compressible data.  This
also adds the sync, as discussed in prior version [3] to increase the
reliability of testing.  We should not need to wait or re-read this
value, as we have explicitly made data suitable to be stored
compressed.

[1] https://lists.linux.it/pipermail/ltp/2019-July/013028.html
[2] https://lists.linux.it/pipermail/ltp/2023-August/034585.html
[3] https://lists.linux.it/pipermail/ltp/2023-August/034560.html

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
V2 -> V3: separate into two distinct tests

 .../kernel/device-drivers/zram/zram01.sh      | 118 +++++++++++++-----
 1 file changed, 85 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 6bc305f2c..22c5e1927 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -4,9 +4,9 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test creates several zram devices with different filesystems on them.
-# It fills each device with zeros and checks that compression works.
+# It fills each device and checks that compression works.
 
-TST_CNT=7
+TST_CNT=8
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 TST_SETUP="setup"
@@ -105,36 +105,77 @@ zram_mount()
 	tst_res TPASS "mount of zram device(s) succeeded"
 }
 
-read_mem_used_total()
-{
-	echo $(awk '{print $3}' $1)
-}
-
-# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
-check_read_mem_used_total()
+# Fill the filesystem with a file full of zeros.  This is to test the
+# same-page/deduplication path in the kernel.  After filling the file
+# with the same value, we should have a lot of pages recorded as
+# "same_pages"; we arbitrarily test against a small value here to
+# validate pages were deduplicated.
+zram_fill_fs()
 {
-	local file="$1"
-	local mem_used_total
+    local mm_stat same_pages
+    local b i
+
+    for i in $(seq $dev_start $dev_end); do
+	tst_res TINFO "filling zram$i with zero value"
+	b=0
+	while true; do
+	    dd conv=notrunc if=/dev/zero of=zram${i}/file \
+	       oflag=append count=1 bs=1024 status=none \
+	       >/dev/null 2>err.txt || break
+	    b=$(($b + 1))
+	done
+	if [ $b -eq 0 ]; then
+	    [ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
+	    tst_brk TBROK "cannot fill zram with zero value $i"
+	fi
+	rm zram${i}/file
+	tst_res TPASS "zram$i was filled with '$b' KB"
+
+	if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
+	    if [ $i -eq 0 ]; then
+		tst_res TCONF "zram compression ratio test requires zram mm_stat sysfs file"
+	    fi
+	    continue
+	fi
 
-	tst_res TINFO "$file"
-	cat $file >&2
+	mm_stat=$(cat "/sys/block/zram$i/mm_stat")
+	tst_res TINFO "stats for zram$i : $mm_stat"
 
-	mem_used_total=$(read_mem_used_total $file)
-	[ "$mem_used_total" -eq 0 ] && return 1
+	same_pages=`echo $mm_stat | awk '{print $6}'`
+	if [ "$same_pages" -lt 10 ]; then
+	    tst_res TFAIL "insufficient same_pages: $same_pages < 10"
+	fi
+	tst_res TPASS "same_pages: $same_pages"
 
-	return 0
+    done
 }
 
-zram_fill_fs()
+# Fill a file with compressible data.  The same-page deduplication
+# works on matching a single (unsigned long) value in a page, so by
+# splitting this up into (smaller than page size) 1KiB of alternating
+# 0x00 and 0xFF we avoid this, but make something that should be
+# highly compressible.  We check the stats after filling the file to
+# ensure that we see a high compression ratio.
+#
+# TODO: fio has an option to create binary data with a given level of
+#   compressibility.  For now we use a static value to avoid growing
+#   dependencies, but might be useful in the future to validate the
+#   compression behaviour more thoroughly.
+zram_fill_fs_compress()
 {
-	local mem_used_total
-	local b i r v
+	local mm_stat mem_used_total same_pages
+	local b f i r v
+
+	# convert all the 0x00's to 0xFF's.
+	dd if=/dev/zero count=1 bs=512 count=1 2>err.txt | tr "\000" "\377" > compressible
+	dd if=/dev/zero count=1 bs=512 count=1 >> compressible 2>err.txt
 
 	for i in $(seq $dev_start $dev_end); do
-		tst_res TINFO "filling zram$i (it can take long time)"
+		f='/dev/zero'
+		tst_res TINFO "filling zram$i with compressible data"
 		b=0
 		while true; do
-			dd conv=notrunc if=/dev/zero of=zram${i}/file \
+			dd conv=notrunc if=compressible of=zram${i}/file \
 				oflag=append count=1 bs=1024 status=none \
 				>/dev/null 2>err.txt || break
 			b=$(($b + 1))
@@ -145,18 +186,28 @@ zram_fill_fs()
 		fi
 		tst_res TPASS "zram$i was filled with '$b' KB"
 
-		if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
-			if [ $i -eq 0 ]; then
-				tst_res TCONF "zram compression ratio test requires zram mm_stat sysfs file"
-			fi
-
-			continue
+		# The compression needs time to catch up so we get
+		# useful stats
+		sync
+
+		mm_stat=$(cat "/sys/block/zram$i/mm_stat")
+		tst_res TINFO "stats for zram$i : $mm_stat"
+
+		# This should not happen.  mem_used_total is the
+		# number of pages in the zsmalloc pool asssigned to
+		# this device.  If pages are active, they won't be
+		# stored compressed in this pool; so this might be
+		# zero if, for example, you have a single file of the
+		# same value that is mostly de-deuplicated, and you
+		# have the FS metadata active.  This testing path is
+		# deliberately making data that should be compressed
+		# and stored in the zsmalloc pool, however, so we do
+		# not expect to hit this case.
+		mem_used_total=`echo $mm_stat | awk '{print $3}'`
+		if [ $mem_used_total -eq 0 ]; then
+			test_res FAIL "/sys/block/zram$i/mm_stat reports 0 size : $(cat /sys/block/zram$i/mm_stat)"
+			return
 		fi
-
-		TST_RETRY_FUNC "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0
-		mem_used_total=$(read_mem_used_total /sys/block/zram$i/mm_stat)
-		tst_res TINFO "mem_used_total: $mem_used_total"
-
 		v=$((100 * 1024 * $b / $mem_used_total))
 		r=$(echo "scale=2; $v / 100 " | bc)
 
@@ -164,9 +215,9 @@ zram_fill_fs()
 			tst_res TFAIL "compression ratio: $r:1"
 			break
 		fi
-
 		tst_res TPASS "compression ratio: $r:1"
 	done
+	rm compressible
 }
 
 do_test()
@@ -179,6 +230,7 @@ do_test()
 	 5) zram_makefs;;
 	 6) zram_mount;;
 	 7) zram_fill_fs;;
+	 8) zram_fill_fs_compress;;
 	esac
 }
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
