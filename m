Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5236BCCFA0D
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762339948; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=mShCdVp6PBwYbF07ruyT8Six9kg8sX64tDfhbCr1vbM=;
 b=lhF4U0wBjxUBIlix7ZkjOqOIHYMbBZXsE2kqBlFuCH2nhVXBna8k/10Smfwt2wnYbE8hl
 DkebO5AhDlWA1g6w4iq9V+tXVsNG1H2QfdBKMvNTk86g+U4fUKj9Ha5PT5/p+h+fgwQOSMr
 NNdpo/yU2/sdLYjumvHxMwjWySnETrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C47593CE436
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 11:52:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A9893CE1A4
 for <ltp@lists.linux.it>; Tue,  4 Nov 2025 20:39:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68B47600197
 for <ltp@lists.linux.it>; Tue,  4 Nov 2025 20:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762285190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GCmlhMaf10pHSqZzUdn6i9UYT0SAVRYH0KCcKCV/lyc=;
 b=LqmEXFiXHslQLO47lC4qfIB7vTEFghcXMtGOUMOREDEVn4PV+VSwv/hpJ4uqaBp22ZAeCL
 Evjvvi+ULUAzX0RrFvGzhsL5FMikxLktktDgfTrf6wJVEr29H4wwkFx6Y0Cq6RU3SAxM9Z
 hsophlicPE4mSKRLH42ezGgsyb6xfG0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-jJYm_MjSPPqYt_6Vj2TSGw-1; Tue, 04 Nov 2025 14:39:47 -0500
X-MC-Unique: jJYm_MjSPPqYt_6Vj2TSGw-1
X-Mimecast-MFC-AGG-ID: jJYm_MjSPPqYt_6Vj2TSGw_1762285187
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8803b5dc9b8so181646906d6.1
 for <ltp@lists.linux.it>; Tue, 04 Nov 2025 11:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762285186; x=1762889986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GCmlhMaf10pHSqZzUdn6i9UYT0SAVRYH0KCcKCV/lyc=;
 b=ljP8AWVuQY/Knmp4rxkYOdy/IBgD7JKZf6w+4D9JWRsvUWrOieiMOGwsimqE3dEPay
 v5+sBBvx36rYkbuX5VCk3IZBE1W3rgpYrDiYfzez37CcP+OmvDt2v5vfWir3CT/OQEH8
 6cWmD8nuHrUGb8mgP4Ow9rrAcVPfimHmUHwGdzX+WE7oYq2zXRKRyt8kvAsRqqnUSjYO
 M2CAbijP7ig3ZfZRAFIGyVOIPOP1k5xc9XsG01Ai+j7P+Zy/UqLu30fNjBjHESZ2wbIM
 2TwyngQAoBg3AdPVaeMD5riBvwu1c8JU+Y7l3MhDrqHxpq8urqikZ8ifl4G7lgJrTK/k
 QyYg==
X-Gm-Message-State: AOJu0YwXVDXPbr8RWJH0TCD87JiLAIm4vL0YQ4bbuPIn4ry+W2Tyt10q
 Pu3+1k8Wg6k3hTqar3HflMEC+OB0XUpw6EXXYDWWRV4Rvx/K2gNr1xZJQsGRwX1v9nJmNcTBUKM
 GExn6zRGO0Vl7bXakvJQeaUPtSbN0lYG/Bkx08xYTNH7hXEINKBv167C/nkQN9wjJb2UHANK0FD
 kDNYd1+QWr5SsEeOF1a8da1+L8f/n4E+PuTuf9
X-Gm-Gg: ASbGncsam7CfE3LctxvaOEL580Bl132Nt9WodwMA4Dlnn9xNr7Z3l6wKmk8cE+pH1Ce
 KmHuVWHVqbY7FthsewgpPi4Ztyitc+o5lgTYZF/ULwxB+gv4x3qxjaPkJi35UtiWiRTIqaJKNCy
 YAGO/MnOd6aD6p25oQvnxmV+KWA922IDysCbA4UUd9oacrvtHGGMp4DvQp7V/GiDInh5dg103UV
 IQFehRhylRGrSNb8Pvo0vRhoGVgAnL+9tdqDZO1/7flNLPIlTN3kfKMukNK2X6HF2wmx8VGrLpy
 lwFMt7F+xfRZ1bZ6SXWYWbSFSu22Q9kZYo9SyM0ostURsl9wBPf7wbXNF3ntzWd/rDCsIaGQZsd
 U5h+voQ1TD+8Vrs4+ryBieJz2
X-Received: by 2002:a05:6214:250a:b0:880:6539:2b27 with SMTP id
 6a1803df08f44-8807112a2a8mr11387736d6.4.1762285186704; 
 Tue, 04 Nov 2025 11:39:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYKT3m660fDGuka9TIlI2D90gECcfAdqeUziZDZcScXsbBznqFBdoaburgmJ1LqMCwkHkQLQ==
X-Received: by 2002:a05:6214:250a:b0:880:6539:2b27 with SMTP id
 6a1803df08f44-8807112a2a8mr11387496d6.4.1762285186290; 
 Tue, 04 Nov 2025 11:39:46 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([144.121.52.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88060dedb3fsm26324956d6.23.2025.11.04.11.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 11:39:46 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue,  4 Nov 2025 14:39:40 -0500
Message-ID: <20251104193942.4080083-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5EPJT81VJc_tSSX2HfcSSelR01GoKkNuq3qZD-ldjaY_1762285187
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 05 Nov 2025 11:52:07 +0100
Subject: [LTP] [PATCH v1] Add config check for systems that do not support
 CONFIG_XFS_FS.
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

---
 testcases/kernel/syscalls/file_attr/file_attr02.c | 4 ++++
 testcases/kernel/syscalls/file_attr/file_attr03.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
index f6625985a..a1c459d30 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr02.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
@@ -102,6 +102,10 @@ static struct tst_test test = {
 		},
 		{}
 	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_XFS_FS",
+		NULL
+	},
 	.bufs = (struct tst_buffers []) {
 		{&attr, .size = sizeof(struct file_attr)},
 		{}
diff --git a/testcases/kernel/syscalls/file_attr/file_attr03.c b/testcases/kernel/syscalls/file_attr/file_attr03.c
index 9ad779041..19a8e298d 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr03.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr03.c
@@ -69,6 +69,10 @@ static struct tst_test test = {
 		{.type = "xfs"},
 		{}
 	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_XFS_FS",
+		NULL
+	},
 	.bufs = (struct tst_buffers []) {
 		{&attr, .size = sizeof(struct file_attr)},
 		{}
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
