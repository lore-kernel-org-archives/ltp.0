Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6248DCD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778083102; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=PE3x0ISnHHbV6k51+GaPa5gAqQUIaxSvvhnQEDFa5uLDaAQ4ZzU9Y5wIdGKRAB/Q96QOG
 +x1FQRYUJiVWNlxdQ1PwE7nTo0bR9cgm0vwBOlnQlu9TkNibjuUIjRAkfTK+HrzaOWHX/CY
 cYelJ3/9EbVCR5HE6por8B8mzgPbq1U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED6943E61FA
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:58:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CD673CBC10
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:57:57 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EB8EA600BD5
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:57:56 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso4071959f8f.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778083076; x=1778687876; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=UUJQmXKxq2H/e4HGM+KdLqEF0mHxZ8bSR1l9m4r7q5DSEmdyXEM6ZuOIAZnbiufcY8
 vT5yCsfFrnvIDwE6p8x9OkCD2TIZ4jsLRfiTmyZ4QBwzvisC3QVuWPkCUHXuBU10FaB8
 sPbo2TujH1qHzs27JcOxwaREwOTUl2YMDU3QCKEAXYt00REEuMa88iP+byGGEcMWdVHE
 xWecke45uXAwrfzUJQXKPgk7sKyKcm1Bm9jRvw7iAEKCB7QzL54i1k0Xc2vLBw6lSuqC
 AJrXtZvbBoR8txpAJK05Iy/k8etAim9xsP50/umgfxXAXp9nNDsw/Yc3ieXDeoC3K40n
 tWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083076; x=1778687876;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=AogT/Mu5JbqaT94EE9XXTZ1K1Ppp0ThzKQUEvKZxdBwduS8DD7UYIQkinTYQqYmbHi
 nHSGS5eNIBRxHK4FuMOAbEzKtYUlHITeWUYLUAg2SRTCbJEdSHIa8vzXBNvogzT0nRXp
 VZ2u3zhijQaA1Jmh7ro2HJVaLTOzCR/VropdTWAxTQh4xhRk2h53i3YOBp0rnMYyHNP7
 YYz9w7OBaWH6BvwCWv9HLmIas7usIGQl6KAAUgCR8MMkEkwy9wYQixc41P6KiC0OcrZw
 3ZbQ7sTF/AKbCy7nAQjtP5i69A36ZG4r79ffhCYRoRNvO9CjwxSHAhgJRZnK0YKOxFsZ
 4zRQ==
X-Gm-Message-State: AOJu0YxW77P7RpLfrmEGcN7j7eeCJOpK9Fbk7Kl2eQcUVfn1vzSsQr3o
 Fk3sTnciCPu3obNyx1lZAjZ2gHX9+pm249GwxIMEuzZQ/YDyw8g+p8S9+WQynsJ5ZNM=
X-Gm-Gg: AeBDiesgBEOgShvb7yBAmAeev5JHxiYDxPT830V2tPVdYRN7RxzG1PGu/DeCvqPQMSG
 6H6Vok55+V7C+AKvSiixPnS9nKLJHyJ6H1ZjBSbiw0mQzojN2Zrg6rS6U66/OHO3eki+VgZdWrx
 awuAGSItqe4swvXGNA7ZQjgHd7g0AAbWAiAaajQcaSEdq63bW0rC782jDhc9u+63wpGrLZUJTrH
 B+qVhDQjNF30lhwxYpmrdwEBDgondH2lm4iFee+LHRUDHqIjnm6GTeuioq/gr9NhwF6vpxhhGTZ
 R2JqsV8+L+EHxlCdrMj2QRsNLPx/q5AtTPa5KMTNfIaFYUHEzpzgOiXakInH8BCkyJa/yuQ4+Q8
 5q3KZd/F99bejg5+1Nm20m7UQb0QrTBlXRyegUyZF8lPVCcQHNF+riW8hpk40iR2x11BK46YN/j
 urGlcaKMAnnbjrIsYaLXGsPmGYVKdncf198hEzYa31qzml1Ps3T7kReG84QFLS1J12WfBUZr1gF
 Mtys3QZ2av3iycLr7+eFWnBjPbYtMxvXaXqV5BujTCRNw==
X-Received: by 2002:a05:6000:26c2:b0:43d:7cb5:43b2 with SMTP id
 ffacd0b85a97d-4515b61b827mr6649543f8f.15.1778083076338; 
 Wed, 06 May 2026 08:57:56 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48c04sm14001788f8f.15.2026.05.06.08.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:57:56 -0700 (PDT)
Message-ID: <69fb6504.050a0220.136238.b5d3@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260429101244.3309913-1-wakel@google.com>
Date: Wed, 06 May 2026 15:57:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/userfaultfd04: Require
 CONFIG_USERFAULTFD=y
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
Cc: rbranco@suse.com, Wake
 Liu <wakel@google.com>, camann@suse.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
