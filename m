Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4620C19F32
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740679538; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=mvmZLDlghnMv102p/iBNHQFRrKCUEw1DwQ9Y08ozv90=;
 b=kjwD2szW6po20GWfq3jip9S/TCdsfxtkq88SG3nLW9+BzPP8KiVd2iFolf3JbGLXuh+G/
 OHtBk+i7Zi/Q+6pnMKcqh1/U981ron+iFFbO0wa9QPETjeRETrKfict9gbcIzKuYuY0siG8
 gpwjI2mO4C++KpdTe1BmcSin1EsZcz8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CEF73C9E3B
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 19:05:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5857E3C280D
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:05:17 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E596F65E7D3
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:05:16 +0100 (CET)
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2f816a85facso2665721a91.3
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740679515; x=1741284315; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QRV6WLUstD3otpjMnapSlQ/O8FnEb+tq8jdA4Qn1P78=;
 b=fQlB9TZrMLmgYpAgBS3y05o7POJ68Ly9Hi8XFDFCNA7lBxfnrMfHORzf8fI/CLeRNQ
 OmftjfK4iYcdRF2RU1qjFYr8zUfEb2lGQnPnJWY9/eTicBz3kA6aRwnRLl8yjJCPNwCg
 Lr/pYFDlITT1Rof4zmPvOx+ewZexarNFTqNz8FiUfLeWaHCtD/VBLPoqp8kDBQrVUnCY
 Y1Cg2vPUojYfv6gQVe9Qjr6BrKk7uplcIPvaYUnhjwm0xgbNqe4eKp7+8TlIcHF2ISoA
 f1FC1KUsMBPxLFfKZexqhOFZMACosESsKXya4fVA9yKE8Txi7oc1JY3xLMBSlJQuDXvV
 mUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679515; x=1741284315;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QRV6WLUstD3otpjMnapSlQ/O8FnEb+tq8jdA4Qn1P78=;
 b=Ba/1NOTSKt4lcK4SlyGeRBl+DHUqnweNaesgEA82DVcYnlPHe31TfyI1KUvSRty3wc
 65dv9OD8WtimLpjvtbtpfWK8G6kJcYiZAQ+6wSHoXP+qCsl82JczVTWMM2juBQitVXi0
 sTKwfOu5EfN3aJCTagPojn5agNLcVrLik6xhZAVGEz3KZ3VWL/iMGntp5waP6TILJ37O
 bHce0GPwj/MQ9t+fxFCduDJb/CZ6mAjIEJvCKO5PDz5vPAGHurlm/VZDBVwbXBoR6TA6
 ME050JajUmbC654CirKvIOnIg0Ry5vhzmkRcaQrjRptsB/E+qr/oUGJdUzLf3GZYyzH0
 htzQ==
X-Gm-Message-State: AOJu0YxsV732529PPOebX1jfZF81FJvGlzCgnM6NuHA/rsVs2YhFvcDD
 FHOXfdpNn1XiH+a9qTWbK08ZI1yFZFyR9dyrG0EpW3wmWW9aMVOaKqKQC0Aq7Q/JwL4EP+sMsf5
 IFuYDOBFF+lfuVC8AWu5fZz6jJ/KwhRBsbTvcw8DWEVwtvN0AXrZgfSLi+tEuQR8v5FomZeCuRl
 bDsZ7nQniHp4eno5Nv3SWmJeR88/g=
X-Google-Smtp-Source: AGHT+IF0oYN5yAhQgQ1Lr/ERiWl502tObCLR/fje13eEgP0wXD9k9MGTJeiWFvoJ2E8cbW4LtOQr6MFIdIM=
X-Received: from pjbhl13.prod.google.com ([2002:a17:90b:134d:b0:2ef:82a8:7171])
 (user=edliaw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:fc4b:b0:2ee:b4bf:2d06
 with SMTP id 98e67ed59e1d1-2febab787fbmr348506a91.19.1740679515235; Thu, 27
 Feb 2025 10:05:15 -0800 (PST)
Date: Thu, 27 Feb 2025 18:05:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227180512.355110-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] input_common.h: Add retry loop for event device
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

Android has a delay between the entry in /proc/bus/input/devices and the
path /dev/input/eventN becoming accessible.  Add a 1s retry loop to
account for this.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/input/input_common.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/input/input_common.h b/testcases/kernel/input/input_common.h
index 0ac1624b3..06fba753e 100644
--- a/testcases/kernel/input/input_common.h
+++ b/testcases/kernel/input/input_common.h
@@ -29,9 +29,12 @@ static inline int open_event_device(void)
 			memset(path, 0, sizeof(path));
 			snprintf(path, sizeof(path), "/dev/input/%s", device);
 
-			if (!access(path, F_OK)) {
-				tst_res(TINFO, "Found event device: %s", path);
-				break;
+			for (int i = 100 ; i > 0 ; i--) {
+				if (!access(path, F_OK)) {
+					tst_res(TINFO, "Found event device: %s", path);
+					break;
+				}
+				usleep(10000);
 			}
 		}
 
-- 
2.48.1.711.g2feabab25a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
