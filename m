Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6131CCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760695909; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vaX/cQ5S8Tcs2azLZIqCYqi2w96K9CQVafZCC6OYH/g=;
 b=SFICiPLgJJIvYr6qxN6ZOCaYShSve1KarejVPvaXGtuiIEVVa6bEByqRkFQPADsiqYl8+
 Fra5mgwQPy0Qf7jh7xmRmGx9gU4nBj/P/A67kYr9JnKHcoeOjBKjt9GbdLRNlcQh6Zsy7FO
 4A4kW80q50m+h8xaE+7giwqqZzMrfn4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 693CA3CEE53
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 12:11:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ED463CEE6B
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:23 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C877A200C9F
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:22 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso1040321f8f.2
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760695822; x=1761300622; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHhYdUvi/TB4rDRGnMhI8mN2f5c6IvXk6JbOV3KzmfE=;
 b=AIqv/nCeA5DGSvcNrfr6dhxwWmEzf2cMAvyV6/cJLxD2VHHanRBuvmo2NsXrkwk54l
 GO1ik49DUSNRlCRZqNaQUzCmiZAtK1OW5khr1fGXVLWDf0qFlzq52PzdCqk/I1ebT99Q
 z3UUDoOiqILErCRMJIyzROEQzt+L2+reL43J3s+MCs2i7mBb+RUiyiMVY0vz+F0oZ5KJ
 Efmdrpiu2iL8IS3XRetJB+xgeFl68E1Errn+pv5V1p8327ZIUXz7PS53wxC04WS/TYGu
 ZTdqssOKqtRr1NYYwKFNpPtfZNWbnYXVhlDwLBAHi7DxjfLWxsQ8eY4CCZnPL/5zOQkc
 buRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760695822; x=1761300622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHhYdUvi/TB4rDRGnMhI8mN2f5c6IvXk6JbOV3KzmfE=;
 b=e5PqU/jY+STbd18gs7+aD0vDryGk87TwsC9YZoj8/ZT6XNgsRYKPzVp/Gutw4tIeGr
 7VDhzwxyHFwvF5N91FarxdK1WJRYxHxS8gdQf/2aMPmt5m/dRZLpTglmK9W8SDFDyUcp
 WjkTWqMTfIvVkdDiyhw8ofLwvKskYQuGlSbE1G6imVnCkVBs0WeS2xkwj2kZ84ywNJL3
 ffpfvG6DEVHBHl7HEyQvUrlFmG/J/W3k0A4GCf7ZfV5iA39xIIQ3+cyu2QMmmR3eQQZ8
 xnPpQOxCFArm1V/hf+AJsmFnoUyZ7y+zvFp+UvT0TsH1icgGFhd7AzCuZjvg7X1OdpNt
 qF9w==
X-Gm-Message-State: AOJu0YwzWCoXFkHHhTN2xuwjt7yQktIFWXf7PaLIvNWTPkcvPrhaOXBs
 L8kAW5rPuRD7b454UthnqYxWW0581hpPzgMiCtqUoJS3VcaEk0y0yyUaNBpnPT8P/UEuE5dD8mW
 X3Ds=
X-Gm-Gg: ASbGncsCTRKE0M9sxd/Jpgcus+60yuisO4IdW5MkmIsuk1vHfFNeIP+aj6QTbQ0b/J0
 IUMIPQD2ukiv9FDuo/4w26iRjEwpoK6IHS/sX8m488ti0bRawhrURyIhhFA8aBv2RStf4rn3+Pv
 hKBmll4m1BL7e7m2SntDfAVXO3t+NEYMdgAokBW3cN2OVo5FhfulrbEJuAAStyRUi5BoSq3IVPI
 27DHlbhMhZlbcpr+MEDOeb8JNiP1sexIwALthrE9Hmfdu7d8e2o3geBgT7v3FdcW3WxqrY7xUeS
 3GdgyBBINqxraDHnDqhIVJXY3NP35ECLv02cAYTLcdpnDyzcLdblzjkIRvvIlEA8WaD4WuZZT+H
 /0YQRXTefrBinhY2vwccezslZiWTWLRTQGM6rATl1/rADJrUvwyaP3dWaPYIFBG6Y
X-Google-Smtp-Source: AGHT+IEirAxMhCL76Yz8XLfoHKO/a+UHoIKsBMOPg3CEQz3Obsoa3iVJ9uBAAIeQr7BgQ2pMC70eFA==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:e276:5f43 with SMTP id
 ffacd0b85a97d-42704da64e0mr1856290f8f.18.1760695821954; 
 Fri, 17 Oct 2025 03:10:21 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-427069a5a25sm3421525f8f.47.2025.10.17.03.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 03:10:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Oct 2025 10:09:58 +0000
Message-ID: <20251017101011.3811-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017101011.3811-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] tst_run_shell.c: Add new function handle new
 needs_cmds
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/lib/tst_run_shell.c | 61 ++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 7a446e004..a6e0d1d29 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -175,6 +175,23 @@ static ujson_obj fs_obj = {
 	.attr_cnt = UJSON_ARRAY_SIZE(fs_attrs),
 };
 
+enum cmd_ids {
+	CMD,
+	OPTIONAL,
+	PRESENT,
+};
+
+static ujson_obj_attr cmd_attrs[] = {
+	UJSON_OBJ_ATTR_IDX(CMD, "cmd", UJSON_STR),
+	UJSON_OBJ_ATTR_IDX(OPTIONAL, "optional", UJSON_INT),
+	UJSON_OBJ_ATTR_IDX(PRESENT, "present", UJSON_INT),
+};
+
+static ujson_obj cmd_obj = {
+	.attrs = cmd_attrs,
+	.attr_cnt = UJSON_ARRAY_SIZE(cmd_attrs),
+};
+
 static int parse_mnt_flags(ujson_reader *reader, ujson_val *val)
 {
 	int ret = 0;
@@ -252,6 +269,48 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
 	return ret;
 }
 
+static struct tst_cmd *parse_cmds(ujson_reader *reader, ujson_val *val)
+{
+	unsigned int i = 0, cnt = 0;
+	struct tst_cmd *ret;
+
+	ujson_reader_state state = ujson_reader_state_save(reader);
+
+	UJSON_ARR_FOREACH(reader, val) {
+		if (val->type != UJSON_ARR) {
+			ujson_err(reader, "Expected array!");
+			return NULL;
+		}
+		ujson_arr_skip(reader);
+		cnt++;
+	}
+
+	ujson_reader_state_load(reader, state);
+
+	ret = SAFE_MALLOC(sizeof(struct tst_cmd) * (cnt + 1));
+	memset(&ret[cnt], 0, sizeof(ret[cnt]));
+
+	UJSON_ARR_FOREACH(reader, val) {
+		UJSON_OBJ_FOREACH_FILTER(reader, val, &cmd_obj, ujson_empty_obj) {
+			switch ((enum cmd_ids)val->idx) {
+			case CMD:
+				ret[i].cmd = strdup(val->val_str);
+			break;
+			case OPTIONAL:
+				ret[i].optional = val->val_int;
+			break;
+			case MKFS_VER:
+				ret[i].present = val->val_int;
+			break;
+			}
+		}
+
+		i++;
+	}
+
+	return ret;
+}
+
 static struct tst_tag *parse_tags(ujson_reader *reader, ujson_val *val)
 {
 	unsigned int i = 0, cnt = 0;
@@ -440,7 +499,7 @@ static void parse_metadata(void)
 				ujson_err(&reader, "ABI bits must be 32 or 64");
 		break;
 		case NEEDS_CMDS:
-			test.needs_cmds = parse_strarr(&reader, &val);
+			test.needs_cmds = parse_cmds(&reader, &val);
 		break;
 		case NEEDS_DEVFS:
 			test.needs_devfs = val.val_bool;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
