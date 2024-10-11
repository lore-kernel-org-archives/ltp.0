Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C93D0EE3F
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728688233; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=odZ4dm40VW0vTrqaDMyuOYjpmr4zmcT/ynhg6H7ANGo=;
 b=F3/fFxYTxpbiVm184iQMdTHiDKLI3HooGEeol5rFZLdkNpA+nnEMqPGZaA9PtnO+hR+Gh
 TwkI1d9jTYNhBf8BOt3iU2OsdpkNgbWxyqEbBl/96ru/LH1GXnZQD+AV3eooOIMx+CzSbXF
 0cRq+5KJpSYH73BG2XgrGUjvi+IvtDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA5723C62AC
	for <ltp@archiver.kernel.org>; Sat, 12 Oct 2024 01:10:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EE5E3C536E
 for <ltp@lists.linux.it>; Sat, 12 Oct 2024 01:10:12 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81075234197
 for <ltp@lists.linux.it>; Sat, 12 Oct 2024 01:10:12 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e32b43e053so36509627b3.1
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 16:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728688211; x=1729293011; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+Qzf1MOXJx6JBxtf4yFagIBpyKkSdBLVxbGbqt3uuJI=;
 b=iIBJqAw09t1LZxL5BioFDhDnflF7J6NqyXOCAtCofIdliijv7QmLVB5b4V3QVe88Dg
 wdbHP4twbSBpldhpL3yEPvHW+2yVmnWm0hTJl/gw2rnX5ermtl1r/2dSdunKestOFmFe
 /4VSqMNUyCol5IjnBZBgyYLsRREbHDyPaTagaHxv1gwmX9J+HO/Yty7jtpELpy91dRaf
 RLrMmWMKe+4WUcPNPhkjvSukkN/0ROKLHarWFZXpIyGD5PjsMlC9rylN5+7K5F6UE4a4
 70IyP4SQJ6j2C78vReM1xjHdPhflV2UDfgXyO0HpJ7Vp5VtIHUF8QbS8oAE8A+Y7Orvl
 PAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728688211; x=1729293011;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Qzf1MOXJx6JBxtf4yFagIBpyKkSdBLVxbGbqt3uuJI=;
 b=bvs5tj26ox04yCK2+vc7rWzBV1smrLKma5KtcmRq9jDuMK8VLdMe4zJdkMSucQw5u9
 WQTLrWyfXIm9P0KKMpCieLlZAPq3trAyYttap3j7Nu3pweqV2+hvgPX1Sb9+L1TfZCdG
 pj2m+ZdNzNa9L5BQWKRypsplt8HFESAuOvrXwdSBnZBHS1WF/MgppieOdTbnoyOLrnRQ
 7IGPKEzs8udCGV3Xf6eXAOEpCDm8A3kO6+aD/+0vLFvu8lDbd78+Jvj7XfBvDGsZSQez
 f120K6vB3iMI/F2+NJaZt8LptqYZpwzEMagQ2AV+O3nzavyiUKvbMu8LVgpH5jpkQx0P
 atbQ==
X-Gm-Message-State: AOJu0YwozN5cr/ZaQYRIjB0lxEdfZryPrafExdUpe4p8sWHaf/xEFOrm
 lG1j0ne59y51uBv0tvMv5Mg8d/zGegKWcypqqr3qm1zxWNH8xQXKOalEd1cxyVkAQIhEZdT9x1X
 YI9U+QZx5uSsVM6RIHp04okCP7J8zILd5tG78CNGNJNx+/Bpz1it+PzL/Ns1EeJJESc/R5gfAKf
 BwNxI6qndUSXbbZt8uYw5EOLg+ydA=
X-Google-Smtp-Source: AGHT+IG57Z+sd77wUESG66T0tu0sP4pe6A1AC1ZFlf9eX7JWexcTbPsuUSP+w4nX5xQ+N/l20fzu8itWUQQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:5c07:b0:6e3:189a:ad66 with SMTP id
 00721157ae682-6e347c52ab6mr365037b3.5.1728688210611; Fri, 11 Oct 2024
 16:10:10 -0700 (PDT)
Date: Fri, 11 Oct 2024 23:10:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011231007.3549892-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] runtest/mm: create TMPFILE in TMPDIR for mmapstress07
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use the TMPDIR path for the temporary file instead of /tmp.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 runtest/mm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/mm b/runtest/mm
index 6a8cd0b9d..d8e62af81 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -47,7 +47,7 @@ mmapstress03 mmapstress03
 mmapstress04 mmapstress04
 mmapstress05 mmapstress05
 mmapstress06 mmapstress06 20
-mmapstress07 TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE
+mmapstress07 TMPFILE=`mktemp $TMPDIR/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE
 mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
-- 
2.47.0.rc1.288.g06298d1525-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
