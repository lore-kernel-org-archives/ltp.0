Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF69606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=CpDUZItU;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=TRKo2vfS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793069412; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Z0dLDF8yVkrHCV2nT+2ZgEvCp14BEBmSYqanrUFl+dk=;
 b=CpDUZItUGu2btez+EG0q8ziqGQ3CcnfLFQEDrEAQvR5qs0O4PvWsbknUpr3lOQ4sDXweM
 n8uU2fcbFDBctfezMVaZkNTueBGpCyDXwvNUXukmT0ecGxEfN0aSNAhKng1v8h0aSZYUB/R
 0N7Y7brWzXcsLepRrOuxyDSzgUEibo4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C763EA3F1
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 03:50:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4843E9B3B
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:18 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 126841000435
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:18 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so5004095e9.0
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793069357; x=1793674157; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=At3tUWeAqtpAnQzPUCulV96iNlcZ0UAP98HAm8LAhX8=;
 b=TRKo2vfSlPY0g4SWDkYoiivK0hcxSyacS9FsDmatNcKbkuwJfZUlHzwm9RLFP/1GuY
 0rT7ddlWThvF3NhLfm4phV14iXVbjfdWMAHIUuwQVRarsO8p9otUSu/3oA7brxr93B61
 Nw7H0gqY3pCTRjNfKVJvHbVH+CRUz8kpqzaehsS6lC54nQKQjyhKOrD2PUrWgzh2Gk46
 StnbUGOsfin2lsxljXTmW4Av8356E1n+ZhQjL47gajK7pc3Ywid3v0btpl6eBIk6gNcJ
 /iRurSHVDgZudmyo422yHcFiYWECCq1Dib1pOKLD6zlQ8yKfQR+orUqEBCDVhnHJyzb0
 2BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793069357; x=1793674157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=At3tUWeAqtpAnQzPUCulV96iNlcZ0UAP98HAm8LAhX8=;
 b=a0zG40P069xXJqvLiFwb3viIaBLwsENfHPhwxr7CPU6Uy70iWGtEb/3/MOahDL6P8m
 2WfwAcGXsWXsSE0WHSyS3vztH/Kn54Y4P1MotBxYHZmJh88xtLsKqKFC6SSpBY1yFbE9
 YQiXk2EMGcd4hFw2Qh2XWVTzKe3jx3xsiXtAOh2dKQCrgzAuwiJqKXbminAQX5XK8pz8
 ZoEOFTHiv6K9InA5qRNhX/C0YuGvUkSr70Y1RzN7tkaP5ZXKXGnP8yJTvDVk6wywChnt
 tvxvV/Gt/+FiHHVOtUAknIAgtjr+iPDFU8jrMaQ5+xCFWsUxmMvqKj3J5AFn4KejZZ2N
 aeRA==
X-Gm-Message-State: AFq9FYLWBgDO+I9M9Ugaa7XIWOEEMPDIg27fNJEKsUASgqDfGzEW+SS4
 yn4C+r//DktCOGs6jqLWl9eEByn6jrrG8jxJh0AW6YUj97Qg5eq7J0ehNLIYZNbW2jSFpSJbbXA
 r+Oo=
X-Gm-Gg: AYBFou2d/YdYQVYE4zBr8oXttvNNt4Zsa+8rsqToopr7Wy8pyi4b0PYMjl1CqXCosx/
 S/OMzoFPdmdXGHKLHUwrCFNy6SDMp+a2MmX1f04KrviOmEpJEUa9UhCRbC8E5t9bbQ+b8FeG9Ey
 mi08GJfP6qcal+Uyn1GCnQDuyYVO/6Nik8yaSxGx3huDshzLfIp6+cLZ8buqzz68r1K6wYh99df
 q5FjeoGBQARPbrDtN2QQhKcwxT7f/z/Qa1U/lF9bQMqbTDRZICOe78rnREfENm9ua5bNLvr5JZD
 sA6Hjjqdq54k1eSgG6No4eUzSx5baYl70t0rGHPvtOGGA2HD9v39FhvyPNnV0KHqQIRIsFtDXC0
 gicHUVdG99Fl4W3NezOsX9bdxLluPWwn2CJnvnb4AmkCHPTnGFxT0kDHLuqNCrfrYDHtCbqc3vb
 3WWC2ftJqPUE9elXyavkUwIWXHHVHAlfu0HreNPN4aLMABCQlsXZNS2lWz6GE3MGciLQRNBc9TP
 C+bYHgfnyQbxF6G7nIjfcKIC10X2Zglua0dRm9pTt2JoIS/tZ8Q3fFzjZ1+ZggJbVhYERiJZ5MV
 ZncNeUbf1hjWQbSaUcon9/G3
X-Received: by 2002:a05:600c:3f0d:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4a7c18afbdemr27239665e9.14.1793069357492; 
 Mon, 26 Oct 2026 19:49:17 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a5ea0df763sm149253625e9.3.2026.10.26.19.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 19:49:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 02:49:00 +0000
Message-ID: <20261027024906.31789-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027024906.31789-1-wegao@suse.com>
References: <20261027024906.31789-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 2/3] lib: Add PATH_FS_PROTECTED_REGULAR and
 PATH_FS_PROTECTED_FIFOS
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add /proc/sys/fs/protected_regular and /proc/sys/fs/protected_fifos path
definitions to tst_path_defs.h for sysctl configuration.

These sysctls control protections against spoofing attacks when opening
regular files and FIFOs in sticky directories, and will be used by tests
verifying this behavior.

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
v16->v17:
- New patch in v17: split PATH_FS_PROTECTED_* definitions from open16
  into a separate commit.

 include/tst_path_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index ecee8d426..a0ac978e1 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -47,6 +47,8 @@
 #define PATH_FS_PIPE_MAX_PAGES			"/proc/sys/fs/pipe-max-pages"
 #define PATH_FS_MAX_USER_GROUPS			"/proc/sys/fs/fanotify/max_user_groups"
 #define PATH_FS_MAX_USER_MARKS			"/proc/sys/fs/fanotify/max_user_marks"
+#define PATH_FS_PROTECTED_REGULAR		"/proc/sys/fs/protected_regular"
+#define PATH_FS_PROTECTED_FIFOS			"/proc/sys/fs/protected_fifos"
 
 /* VM */
 #define PATH_VM_DROP_CACHES			"/proc/sys/vm/drop_caches"
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
