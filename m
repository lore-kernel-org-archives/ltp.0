Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F05C61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787669180; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ctvLX+7P8gnrs7qYOT1ikpx9uC7E5SrknNQNqxsGl7o=;
 b=G1kMFpHCTSN1oiDedpnnWqDboHfHDMnRulC34KX4vge1BXdAARBIgmd9HrRYqbXASOSZj
 EXuEKtmsMw2iymRzSdwDcQF/yjSWQbcR3ZYjiW6B7YYY7ZBu0uyWIy08miAKyKfHBiDL+aI
 M9WhNQ1Yr1PNFDe2HOcT9Ib4dBHgfiw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 649343C57AC
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:46:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48C493C2CE3
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 16:45:58 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF788600A2E
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 16:45:57 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so849387866b.2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787669157; x=1788273957; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uMD39ukcAsHWsdo9TontRTjaz9Sn6gpgqpF5/lQTvPQ=;
 b=cj0sgGvaa9sMrqVYjHztIpiy/oTOBaTdu4E+WRgF0w8MMMMDgJfa71gMd4MjsWTm3Y
 Gg/PurbwgRQ4LEnriuEwd7Cq/fY6ljWdJqcbutuLxDShXJBpGJ+m2/jmJ5PLOlnzk9N6
 tsssmjt5X6Jr869MeWZ5YQzWZY9zH9K6nfTl61VzDkkpvqwcUxA7V1MP0LCjvaAx74HB
 vk2gqoW9o7vMgczDwuTaToQrj9qOutyvCYcWPYPEUMkG6dqe6COAIsF9wcTzZH37B5JI
 CESNabCwuK3MXI+X+Mu1Rm7jz35yAjOly1JzyykNewPHJq1SBQFESSNz5PDX16PHO53M
 WrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787669157; x=1788273957;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uMD39ukcAsHWsdo9TontRTjaz9Sn6gpgqpF5/lQTvPQ=;
 b=rOpSGzQ6mQdb30ZqhrBGVv7AJZ2NmTx8I2j4qbBpr/CsMQvgdEalY7sJWkf9HHjzd3
 GXMVC23i1vZ+m0ZF5sAV5PfxVtIwMglKMSbPHvKAGJi2lYh5dPoNuNP3uBXsxmLMrTRj
 mFUsgBwZhwGrf+I6kSsPkJ2Kz7QSdD2mWfa0jnyPJwu7jYpoYD9tDax0q+4VhX+Lt7nk
 De6kZIX7J7AEPoq60oy3/nZsBSaaTC8GlndR/L2UlRyj5krzS+LHvaFFYp1Wgzc2j+ca
 /dS8oQAIS0YD3/eiP1LimqkFxmMwa1ZoA0vR3xlSHlUAmGQwNE052jzrEPe3nZ9ve/om
 TEFg==
X-Gm-Message-State: AFuF++l+OlaSCm3hNncs6GFDoIFt9izAxEKnlcz12+IBwIFt8VUPKwc1
 EKO625tTkPrLyuvmPvA4ndMxCtmOc1hfCIvFt2rmUt744yAEwKPVD721eHc6z3GB1g4pRYJAlqe
 VeSFKGBQ=
X-Gm-Gg: AR+sD13xoY9gypn9ufU2u64qCNEhjuN0PuVJEVhcY/cd6z4MaLMyPTsilZRvAf4MD3M
 5Un4v4jgUiHVbtpcp4ZlZyv8OAV0OXLUI5M1LTI8srvmCTpqwAFL2oA2u8LrBJbTV785QEGs4TP
 iGIZREj2cF8qeIQULRjB3uFRzc8bGD3fTzj1jsPnvO0n0b+P54KYQL6MflYb92PjyX8+OEF8BPa
 Gn2DmCcgmYArcNUH+7Gpc2oRUeSM/XipaG/bTIqLMgP9KuzpRZxus6CRtfSlfGpivLsQ/xjX+AF
 fKUyRKVhXiqT/iKNJ/ddmAKXYS+aSadodYCEbAFz1DdPE8sBfIej15KXz/mKWxAv1HOdNy0K5Me
 0hRR/Sl5t8jIBdg2yile1D17RrXcbBhPRXIVQXlmIum0hGB6VwRX+bAzFtj9/xmF/Y5wFW4lVDu
 sPLhcYEpfwBVHjZDcDezvNT7WODnaNeAeRK3PqBG9v+r32SBfDhrAwrOU3vGl36G4NziiWxk/P5
 HA0RIHqMwcxcitwoSXbUU4Ju+wLVjY4L1Xh
X-Received: by 2002:a17:907:9607:b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c24924b8575mr3176672666b.9.1787669157029; 
 Tue, 25 Aug 2026 07:45:57 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b696sm2052074566b.7.2026.08.25.07.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:45:56 -0700 (PDT)
Message-ID: <6a8daaa4.e9adc614.a6594.5b0f@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260821063248.2208776-1-cyyang772@andestech.com>
Date: Tue, 25 Aug 2026 14:45:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] readahead02: Fall back to the parent disk's BDI
 for partitions
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Victor,

> Partitions (e.g. mmcblk0p3) do not have their own BDI sysfs entry;
> the BDI belongs to the parent disk.
> 
> In sysfs a partition is a subdirectory of its disk, so retry one
> level up. That resolves for every partition naming scheme without
> parsing the device name.
> 
> Without this fix, setup_readahead_length() silently returns the
> default readahead_length, causing lots of readahead() calls per
> test case and a multi-hour runtime on MMC-backed FPGA boards.
> 
> Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index b65213ad0..6707a1c63 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -399,8 +399,14 @@ static void setup_readahead_length(void)
>  	backing_dev = basename(tmp);
>  	sprintf(sys_bdi_ra_path, "/sys/class/block/%s/bdi/read_ahead_kb",
>  		backing_dev);
> -	if (access(sys_bdi_ra_path, F_OK))
> -		return;
> +
> +	if (access(sys_bdi_ra_path, F_OK)) {
> +		/* Partitions use the parent disk's BDI sysfs entry */
> +		snprintf(sys_bdi_ra_path, sizeof(sys_bdi_ra_path),
> +			"/sys/class/block/%s/../bdi/read_ahead_kb", backing_dev);
> +		if (access(sys_bdi_ra_path, F_OK))
> +			return;
> +	}
>  
>  	SAFE_FILE_SCANF(sys_bdi_ra_path, "%d", &orig_bdi_limit);
>  
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

you can handle this by using the internal tst_sys_conf_save()
function:

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index b65213ad0..4f201d65d 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -47,7 +47,6 @@ static unsigned long cached_max;
 static int ovl_mounted;
 static int readahead_length  = 4096;
 static char sys_bdi_ra_path[PATH_MAX];
-static int orig_bdi_limit;
 
 static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
@@ -388,6 +387,11 @@ static void setup_readahead_length(void)
 	struct stat sbuf;
 	char tmp[PATH_MAX], *backing_dev;
 	int ra_new_limit, ra_limit;
+	struct tst_path_val bdi_ra = {
+		.path = sys_bdi_ra_path,
+		.val = NULL,
+		.flags = TST_SR_TBROK
+	};
 
 	/* Find out backing device name */
 	SAFE_LSTAT(tst_device->dev, &sbuf);
@@ -399,10 +403,16 @@ static void setup_readahead_length(void)
 	backing_dev = basename(tmp);
 	sprintf(sys_bdi_ra_path, "/sys/class/block/%s/bdi/read_ahead_kb",
 		backing_dev);
-	if (access(sys_bdi_ra_path, F_OK))
-		return;
 
-	SAFE_FILE_SCANF(sys_bdi_ra_path, "%d", &orig_bdi_limit);
+	if (access(sys_bdi_ra_path, F_OK)) {
+		/* Partitions use the parent disk's BDI sysfs entry */
+		snprintf(sys_bdi_ra_path, sizeof(sys_bdi_ra_path),
+			"/sys/class/block/%s/../bdi/read_ahead_kb", backing_dev);
+		if (access(sys_bdi_ra_path, F_OK))
+			return;
+	}
+
+	tst_sys_conf_save(&bdi_ra);
 
 	/* raise bdi limit as much as kernel allows */
 	ra_new_limit = testfile_size / 1024;
@@ -446,9 +456,6 @@ static void cleanup(void)
 {
 	if (ovl_mounted)
 		SAFE_UMOUNT(OVL_MNT);
-
-	if (orig_bdi_limit)
-		SAFE_FILE_PRINTF(sys_bdi_ra_path, "%d", orig_bdi_limit);
 }
 
 static struct tst_test test = {



--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
