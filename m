Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B0E94625
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770680708; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=SnbG+kUpLdD/hZUrp/5tHBGHEgGfoj+hsUOyWPPK7xQ=;
 b=LX0/W/BNWNdclZFV8QGBrDyeBBrIwa0r4bc3pGUMgYXwmlkh49JwE9Cl4ECpavfV/EV8L
 xa4cE786/HZgbatQLV0R+gIjnNqTkspC6cq44l+nSbXHxQ+HrgS8mu41BVG4/Oa7xH+aAvR
 /qNyN8GmkLGA8meHgooaaONoGl1oC7Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05D693CBC6B
	for <ltp@archiver.kernel.org>; Tue, 10 Feb 2026 00:45:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD4873C98BE
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 00:44:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4B0D600733
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 00:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770680682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UJtH6DK7fNYIEF0ssRFkQbGlb1N/uhamtBmiZD62dFE=;
 b=Vg0WVpI0UxUrzecF4rOr5Z2nJ9vCeSYZrUI1gSqiE/eIeesXzxDTsYiPqzFxXzz55cDXlV
 BhXEIofYTqOKadWLgMDHp+30aiLJV12rkYd3Qc7E6eE3Y0MDB3eOZbOKzy1ab86c8HjgjV
 c+KKUD1aYPfbVyv3JsNg/R+0JMb5bU4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-9RTRqYykP-WGzT3I5Xp1vg-1; Mon, 09 Feb 2026 18:44:40 -0500
X-MC-Unique: 9RTRqYykP-WGzT3I5Xp1vg-1
X-Mimecast-MFC-AGG-ID: 9RTRqYykP-WGzT3I5Xp1vg_1770680680
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50340e2b4dfso229878351cf.3
 for <ltp@lists.linux.it>; Mon, 09 Feb 2026 15:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770680680; x=1771285480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJtH6DK7fNYIEF0ssRFkQbGlb1N/uhamtBmiZD62dFE=;
 b=td6JvtjKMLSpcet1BMHgbUq0z7cWeTrjoLmMfFRYlWshTg8qq/rb558TP3qPquumZt
 yUYFhoQO5UnyaFCyYsmrFb0CZJrQ0/QccgCJzEDHxdASKq4uqkmngcNgXPh1HA5wUKvn
 zAGXiI6Y6RYsPtl2HAaBuzdiFMk3AYNlYr7Prv0NGfnEbt2csLYgxSa78phx4L7JoaY8
 tJ9Hd7kE4kkYRk8ivFDJNLqsZSVISXhDdVDn4tSVEgljoHVxmonhMWSW4sfIYaDitLFH
 NzUEx+vJW4r4n7z9JXyt4nGP0fZX1S2AP/TXsMtVTgyj04ufqX4+2TMj+5oaFtOkKLy8
 sUAw==
X-Gm-Message-State: AOJu0YwOqGqr04Jh/GqtFHYL+h828xbq2hBHt4OZNutBp0P5KurvMxMO
 cFmkIHUPFO+ZAcn5Ss0eG+rBdluI1fnKbfV+SzG3NSITHxa6U4KvsL+On/votVQuQh9PTKzJtq3
 WyKfFs2fPtSkj1q4xC80d+trlMp3mRabN1aSncvS5ainMUMAPA/sYnq9Hr6KHjAS2OqgO7W03Hj
 RZLD5VprPJA5I5iti7RlaM/JPCW6gB4gwUTzn3
X-Gm-Gg: AZuq6aLjEJ/wl45fjGaZSFpYflAFo1yVLtrTk6MZH6KCE2HF8+F5T9NypkosHryqQQ3
 U9SFVXUBDOsSboMFQB6Qlc4Wg+FUoHFO+hQOo4ZXBuBA/HMl5MAeonoxyopJu/D82G+G112Vc2Z
 ANE4jbB7ZMRCXjewaq0Linz1S14062KkdaopTRMj84DWKDKIQmJvTKowqIU/Rop4tLCh17EuoRe
 8+ijtTR+UUdgxh7bEmj4qUCAIZtvXIXkpU4ZQqVvkJwrppIH0hfP3mJCUTF8ElfPbNdLg5FHmDt
 yrs10DZelCYNNEGrjWuJpH3nGcIdYjJuQxk/XWvAg/d7ArYHnJgnMUN733lBBbu4XEAsJbs4ipp
 hEirUajlLXVIQmUuzvBjUYhIlfCDRdaYik7I=
X-Received: by 2002:a05:622a:647:b0:4ef:db28:1f3b with SMTP id
 d75a77b69052e-506398477a6mr175301141cf.16.1770680680214; 
 Mon, 09 Feb 2026 15:44:40 -0800 (PST)
X-Received: by 2002:a05:622a:647:b0:4ef:db28:1f3b with SMTP id
 d75a77b69052e-506398477a6mr175301011cf.16.1770680679880; 
 Mon, 09 Feb 2026 15:44:39 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf3814csm86230196d6.2.2026.02.09.15.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 15:44:39 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  9 Feb 2026 18:44:05 -0500
Message-ID: <20260209234418.2810671-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aXUrrTnncveAqObOhCF8KzNU9Baj9qsh_YPBQAjBh-8_1770680680
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mq_timedreceive01: fails sometimes with EEXIST.
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

When run in parallel you can sometimes get the following error:
TBROK: mq_open(/test_mqueue,194,0700,(nil)) failed: EEXIST (17)

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
