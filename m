Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBF1E94623
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770680252; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=vF9uoGu/rwdS8ID7eOr9xchSMAY/NN8jV8wPnYYkgAk=;
 b=lER+CmpzEVyOKjfS9kmZ9Ws6JYgeCspIvUpWbpiTDTdCTtqtiyzoc5udFcbnVqu5wTm4C
 UUFdmTHHg+Lfh/YyA8+ufJ9XCZu/dvx+ghnHTc575GaDunHquJV6NF2ZdDNhnhqjcjLQZh7
 sV40iAAg0buKPFzFtyrX1Kbrfb+HEGY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAD613CBC35
	for <ltp@archiver.kernel.org>; Tue, 10 Feb 2026 00:37:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A38D3C98BE
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 00:37:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C16F62000F3
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 00:37:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770680226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j5sAxU5+Jqvksjnq/jl06lficPQjyS8hcLrca1MhTf8=;
 b=eiipwsR6K7oq4MDU57wD2qP7z9TAICHdxaVsy5mL0xG+Y6CvmXPsXdCgbOMccjvng7sY25
 Iav9ZLqr/3ArFp7RWXBhz8d21QEdcH+Mi3Oe9fYMQRtGF47zLuCwQyWvhqw2USmuqrUH4a
 ERS8wvu4QzLmBG/KuHpPnjUywVDG7uo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--G4jeJ89MGm0-jF7sf6qDA-1; Mon, 09 Feb 2026 18:37:04 -0500
X-MC-Unique: -G4jeJ89MGm0-jF7sf6qDA-1
X-Mimecast-MFC-AGG-ID: -G4jeJ89MGm0-jF7sf6qDA_1770680224
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-502a341e0e3so178804471cf.3
 for <ltp@lists.linux.it>; Mon, 09 Feb 2026 15:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770680224; x=1771285024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5sAxU5+Jqvksjnq/jl06lficPQjyS8hcLrca1MhTf8=;
 b=tJKc8O60yJ1cEVYbd3ni6DmHCZrA3AbJpSd8pw7SwAgamJEjdNZxZJFmAvV/qLOH1w
 u1/nf1jJ59cETH/JvjvKvvJ1xA6pm1aCXoZ3HXqfaMaJ/hxP2cIjMmm5UQzP4s6iBRak
 P0oSKzbho22BCjIMNK9gUr3Q9MDVpDsU+dc9Rip9U/kB2MCnMVk2uhEVPxQHB2XnP7mI
 8WgR02I7f9lo2z4GlkgUqg6js3kxClHkpPQpwuAu1AlgOVvYmjK45Bl5eJ23th4aGQw4
 HWVzuQ9dzS6dwUz7l/8y8wmJB5ELjV8yMYGk2youXDyn+Oi/C2KOkOmgafhD9t/Q6UkG
 xMJg==
X-Gm-Message-State: AOJu0YxHhFy3k/gS8LRL4ohsew/IZyyaWi8d8mBnwwoBXrimAM1OKeQh
 6f+vMRL7C/WqkL03dRRjke2W/saEL4JFSz9A9F/XSM0EdJo+nFFI/3o3FNl66PPMSaSXIfoYrDn
 f9uIaiwfuJefGkAFXgdF8/uJOD3XdV9LBx7jKpnTXr92UAsgOG57xAx8PRSMhtcVOPdN/AkEtP2
 KQVdfJiXQMNb+4zONmq2PW4WpBT8GT8gaLs4JI
X-Gm-Gg: AZuq6aJnFv1mqLRa+PymztRpjTNR21LBT2thNcHfH8d683xV9AUXUAhTpwdLb/Z1zKS
 UPATGmsJIu4O1kzO1w0ygE8E1qAvFLNgADVHGLYOlQsHKzaZ8SaHN7p8OfegY3aMIhzniXUcNrZ
 dV2qHzfEMtmA9vf9ofhTOMQ4u/9rMwS5EPntU+ZwfQ86/BmIZ1HPoWmvhJoiJwWPMvjZ8hzihJn
 wvOdj1TjG9VaGlkHTMCVDaWzOql3957cTFU0SvbQnDEL5O0iHWDoMAnHXwj+IMhqpPBm1MFu5te
 G9rLK8z4CGq57Q7nvLyyamFtbCGcnDfym2kr8I8DdxLdzVwLYRCKymci+xwYBUuNwW7kOs3iPUC
 kv3fTEJ4mFXgZhG8bn3EPsJ9cip1UnZDmApwhhUzw5iD3n+I=
X-Received: by 2002:a05:622a:198d:b0:501:4701:e9f9 with SMTP id
 d75a77b69052e-50673d211e1mr1981581cf.26.1770680223945; 
 Mon, 09 Feb 2026 15:37:03 -0800 (PST)
X-Received: by 2002:a05:622a:198d:b0:501:4701:e9f9 with SMTP id
 d75a77b69052e-50673d211e1mr1981401cf.26.1770680223506; 
 Mon, 09 Feb 2026 15:37:03 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5064e7825d9sm58208501cf.23.2026.02.09.15.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 15:37:03 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  9 Feb 2026 18:36:52 -0500
Message-ID: <20260209233657.2809468-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -wQAD7bNVSQplub5kA72Og_bkWnlrpZnjYHstLgFiHw_1770680224
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mq_timedreceive01: fails sometimes with EEXIST.
 When run in parallel you can sometimes get the following error: TBROK:
 mq_open(/test_mqueue, 194, 0700, (nil)) failed: EEXIST (17)
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

This change allows for unique queue names per
process, when executed in parallel with -w #.
---
 testcases/kernel/syscalls/utils/mq.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/utils/mq.h b/testcases/kernel/syscalls/utils/mq.h
index da45d2daf..eb66328d5 100644
--- a/testcases/kernel/syscalls/utils/mq.h
+++ b/testcases/kernel/syscalls/utils/mq.h
@@ -12,9 +12,9 @@
 
 #define MAX_MSGSIZE	8192
 #define MSG_LENGTH	10
-#define QUEUE_NAME	"/test_mqueue"
-#define QUEUE_NAME_NONBLOCK	"/test_mqueue_nonblock"
 
+static char queue_name[64];
+static char queue_name_nonblock[64];
 static char smsg[MAX_MSGSIZE];
 static struct sigaction act;
 
@@ -29,8 +29,8 @@ static void cleanup_common(void)
 	if (fd_nonblock > 0)
 		SAFE_CLOSE(fd_nonblock);
 
-	mq_unlink(QUEUE_NAME);
-	mq_unlink(QUEUE_NAME_NONBLOCK);
+	mq_unlink(queue_name);
+	mq_unlink(queue_name_nonblock);
 }
 
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED) { }
@@ -39,14 +39,17 @@ static void setup_common(void)
 {
 	int i;
 
+	snprintf(queue_name, sizeof(queue_name), "/test_mqueue_%d", getpid());
+	snprintf(queue_name_nonblock, sizeof(queue_name_nonblock), "/test_mqueue_nonblock_%d", getpid());
+
 	act.sa_handler = sighandler;
 	sigaction(SIGINT, &act, NULL);
 
 	cleanup_common();
 
 	fd_root = SAFE_OPEN("/", O_RDONLY);
-	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, 0700, NULL);
-	fd_nonblock = SAFE_MQ_OPEN(QUEUE_NAME_NONBLOCK, O_CREAT | O_EXCL | O_RDWR |
+	fd = SAFE_MQ_OPEN(queue_name, O_CREAT | O_EXCL | O_RDWR, 0700, NULL);
+	fd_nonblock = SAFE_MQ_OPEN(queue_name_nonblock, O_CREAT | O_EXCL | O_RDWR |
 		O_NONBLOCK, 0700, NULL);
 
 	for (i = 0; i < MAX_MSGSIZE; i++)
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
