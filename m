Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F7BCAC5BB
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 06:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760078992; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vaX/cQ5S8Tcs2azLZIqCYqi2w96K9CQVafZCC6OYH/g=;
 b=HdQO8r/LxFJKRDJndS+zM251hfX/+z5CKS2047PInuHte5RCnI0J38Gs9VZQ7ta2RSoU+
 k019XPUKpyiqLCSVooz8+gsE4U9I2V0XUEZokCTCwlCVyERlIWOHhfUexpTioLHSlwF/xae
 E2l+7NlBwrFiwDJbje8PIoeLeHApwD4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D623CE995
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 08:49:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB9C23CE97C
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:48:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B2BA1400276
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:48:06 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so11570645e9.1
 for <ltp@lists.linux.it>; Thu, 09 Oct 2025 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760078885; x=1760683685; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHhYdUvi/TB4rDRGnMhI8mN2f5c6IvXk6JbOV3KzmfE=;
 b=UHmdAs1JiDINdhI8cUaPNWzSxm+Q6JbZJhutlHF2Ed/0MA97j9asd+/ZKxc83G2D24
 ghvJyLpqYd1kHgOPgrlliL0/hBw+/VujbvIZBbmvXXJzcB8GYDlqCFyAghRI9pU4q9XH
 pmDA7DbnymFG36u9UFupuPNQsZ/UH9ph/1npfFBV8S09H1DNuXNkTvDBisWWwVciggIZ
 6ujfT3sktcYRuKSml8FOK2ZjpahXLn3k5yjL/CVN77IJMMJXLGrg57A+Vh/z6oLu7tU4
 i0XMCLca33jI/kES2RaZqZ0qXjRiAGF3rC1e6Xzi12KUK05mWrk7kx2dMCmMGi/JmSqo
 cztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078885; x=1760683685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHhYdUvi/TB4rDRGnMhI8mN2f5c6IvXk6JbOV3KzmfE=;
 b=L6zkAZtyKT9pmp1w76/FzoVA7aiBCEcii+Kw1Lh6D6/dVkZWdpL+9OZ/0wj/09/rCJ
 RQOWVbnV3uMZd0FLo7MtJYY7fh3/fFWuejJ4BNb7IY+uC8Mww+1sAt+ZIoFJIbOqJPOJ
 09tWbAZ+uYsTrJE9+3fCz0HMXlBMsNs30vszghc5HAnPfENXc7cLSVaSbNzmsjU68qXl
 un3a/4dyOUqy/zkeyeehvayztemGclLpekZkUx0y6jcX2pDRseu36uhIEC4cDkI9yM0b
 lGyAnWdlUEf72kgrJIvvXhq7+C+5OraD60srMqqeOXf1UOsw3/AssENGQmmUBlCjJaw7
 VlSQ==
X-Gm-Message-State: AOJu0YzJbtcJB8glzqrZGdiZQHCklv08TFHML6P0SrQqlTfTeU9MjcIW
 8KeW++sGPUTuNA0loEwt4qs78e0frTWuYa+OpiMFiJlTuC/AD/n4hVZd0C1Sfpg4DxMj8ANT6Z5
 Q0sY=
X-Gm-Gg: ASbGncuoEzeGUuTahrxelVTG5UQ+5bRPE+c4ZDsIx1zY7E9chzcTD61f1bGgn6r6XRZ
 aiV4aJn3I49tgFg+DCFEtfuq7ay7atNWF7kVPMIJ5pFiFnrN8lhZqgJrZmDQseGacNJvRcc5Ej3
 Mu1vARzVqdgA8VJ+/nb5hp6UsSzYHJtiUEBfxLvWbCRGbuofZMSUtfyQdXyq/7tw6CyjKuk9hr5
 ypLELnQiUkGP2dTjuvGrA2b9Iw9ePF6gn7Jiewc4L4dct/SJyTlFTjOTe5rW/EmecEaRpsMHtVm
 psZlHzmpPTHV/fg/JOpoym4Y89YFsRqEZPPxTLzLPsT5WVV4F6pDfmXujIbKDV+jeeKL+PMIIBL
 toygc8ZWWKyIJpnVMBzcHeoHmqIH93Q==
X-Google-Smtp-Source: AGHT+IEWrqWOfDW286PvavEYNGMxF1K/Y6r6s5oVaeguEj5rIjCnOAmqjSfuQbeh6C6lmF7xiqzJLw==
X-Received: by 2002:a05:600c:3b1f:b0:46e:4340:adf7 with SMTP id
 5b1f17b1804b1-46fa9a8b3c0mr75592305e9.8.1760078885481; 
 Thu, 09 Oct 2025 23:48:05 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-46fb482b9easm32602545e9.1.2025.10.09.23.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:48:05 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 06:45:50 +0000
Message-ID: <20251010064745.31361-5-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010064745.31361-1-wegao@suse.com>
References: <20250928232708.24007-2-wegao@suse.com>
 <20251010064745.31361-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] tst_run_shell.c: Add new function handle new
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
