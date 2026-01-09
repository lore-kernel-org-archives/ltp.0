Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF204D232E2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 06:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767939487; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tRF6jgLEurzm1JlgYK37yqrCQBk7f58DSckKY36YBsQ=;
 b=OheZ7w7+QsCxhhDD0iKcN+v8ma+6Vue81mdyF3A4734y5qxeo7NwigP1FDsy1ToNCPSXL
 1KHUBMvd1YtAuifZ/I3ehr0Tt94mpVPst4KlHmi4xUuAfWUZkJXABvIrljXtZ8fHSf5HNL0
 EMsi8m6ZnJ1IV/ahp5cPHFLj1eG0syE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 345433C6943
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 07:18:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2A0B3C54E7
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:22 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 804AB1A00367
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:22 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1761441f8f.1
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 22:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767939442; x=1768544242; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2I30Cr8rI9adUIR5c0rGaUcV5NVXxdz2l41Av4wwVw=;
 b=B9Dm3TInbFuHyZWOb4Ot3XnaEBIoiTmBb89lroMgcq2WFwRLyr/HCMqiYrbhgKi0s1
 pqjwhYBC7NrS3c1w4KHkY31Qna1S9s27FzpZQLp5+k2kxIk6agvybqv0TZ30ZG2b+yGd
 geXsI5Y4zUUb5S4D1M3yvpaamW2PSpVxIoDTMBbargrVPh4OVv+Y/AfZ5F7LTW9rtjH/
 GwrPxrhdFVpTizbZYO23SzAy/genRGXe7wBxoobHeQ5eKo1lAd7n5MGlBw8FAS0Ktxys
 rzd+7wVu+5X2uvpFH4MB8OFq2x8cESepH4zkLNV1dfmLgDxZz1csFfCSJp1q/hYrenE7
 kx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767939442; x=1768544242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F2I30Cr8rI9adUIR5c0rGaUcV5NVXxdz2l41Av4wwVw=;
 b=SQ59NkawyuHbBqjCwobjmglY2PjI+ttZ9lLR2c/rOFIBv5eqtvm/VRQnJl95dJ6D+C
 4r8E8HMLFl26AoxVi/E27NZTyGR39rqIV7/TCcqvv1hM6ZH0hUe0tjVpzCVy3bFrKY+b
 5Szv2gm+gvMBKhEOMxjJrXx7wJDfZMORyosyXqM25+2U1Q/qZaECD3elXusoiyNjihwI
 nluxbV182zkaKFGBC+jFRDOrBznFnIO2LtOisjSGeWHZGoPJyBzZhMf7L0rDBlUjzjOY
 G5FePIcHsvoAlWDGaIx/bMcM7e2KzZXSznjiEfnFhCdZBisHszvwDPe/Wrvy28kSguPu
 fqXA==
X-Gm-Message-State: AOJu0YzKWVjUQy3pkwL6JavCYUBOE+AXu2a3xXnXN43Gc5YIt/mdQUWj
 l+AEdI9zcGanMjDuV2fP/TyBFj+VSjtMmB3Ewc2pXsDdeKeHC2kKdTS8kPLAhHYEMqN35ZY+gYd
 kEbs=
X-Gm-Gg: AY/fxX46lVhDPNKw/bTOQPIY288FBU7eUpi50YyfR6tz8g+vN7hdni/Cycrk3jsiY9M
 512ilSekTXyGz5OgOspt49E93Npi1r4FGDCWXHFkYrObpMhGpA6TdU+1LxZKpNsWcqc0tFRWClb
 wAFzcKRHppL2bvCRSJnCdjDWqF/MuvVsKXjbyuqhlXj/is6g/Ez3C1r3NGZ5/mv3RAVVdfHurUr
 uzPSmWzgUl0PYMz8MKoynh7bGL9IMjfLLNHISNvPj4ekLNU1yjGUa+J3RUUundw2bHFcc5kK+ze
 q7oj/BfuvykBCPTv69Cng2STnojlEqZj//YxvFftjgjcQ/QZTq1RLBz65U/UHM9O1KTKrWgO3R2
 O57hIcaKaER8XdvFvlbE/Bcbtrk1mNOJpzNZR7iTyr4CnTjbfg714O3OC71t66gR5NsXSXwWsG0
 s=
X-Google-Smtp-Source: AGHT+IFwIgvWQw8XnJHfWHR0gd1X4YtjffzKsjjNVx+QtRo1mhT9sY8O6qZH/0KM1hChW+DqrGMw6w==
X-Received: by 2002:a05:6000:3104:b0:432:857d:e420 with SMTP id
 ffacd0b85a97d-432c37759a6mr8444060f8f.55.1767939441689; 
 Thu, 08 Jan 2026 22:17:21 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-432d286cdecsm6752480f8f.7.2026.01.08.22.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:17:21 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 06:16:31 +0000
Message-ID: <20260109061716.20258-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109061716.20258-1-wegao@suse.com>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 12 ++++++++++++
 lib/tst_test.c     | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index dc2e9a397..d15bf87fd 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -726,6 +726,18 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
  */
 const char *tst_get_tmpdir_root(void);
 
+/**
+ * tst_cmd_present() - Check if a command is present
+ * @cmd: The name of the command to check for.
+ *
+ * This function iterates through the &tst_test->needs_cmds array. It compares
+ * the given command name with each entry in the array and returns the
+ * &tst_cmd->present flag for the matching command.
+ *
+ * Return: `true` if the command is present, `false` otherwise.
+ */
+bool tst_cmd_present(const char *cmd);
+
 /*
  * Validates exit status of child processes
  */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 09aa7fce2..0c2bbbbd6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1375,6 +1375,24 @@ static const char *default_fs_type(void)
 	return tst_dev_fs_type();
 }
 
+bool tst_cmd_present(const char *cmd)
+{
+	struct tst_cmd *pcmd = tst_test->needs_cmds;
+
+	if (!cmd || cmd[0] == '\0')
+		tst_brk(TBROK, "Invalid cmd");
+
+	while (pcmd->cmd) {
+		if (!strcmp(pcmd->cmd, cmd))
+			return pcmd->present;
+
+		pcmd++;
+	}
+
+	tst_brk(TBROK, "'%s' not checked", cmd);
+	return false;
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
