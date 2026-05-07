Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825FCD3444
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778152746; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=7i4OvHwpBvwktx4TVT2YbeF9s7pbDxkla/vuS7bAic0=;
 b=YjpuXDMGisOxJMot7Q6VwF4d0TJRlsIAegUHmsjAi5Rb4N3aKCYYs6pEu3nMdEgwUw3sO
 NsRQxBOzh0BhPmV4DdBlHkwDIcajBBO2iVekqEAoXV00qDwAcDrYIiJ2J7/PHcNq3OMSVSI
 Q71297tkOhDeHuVu3lFVvjzdvrwSOI4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE64F3E5F76
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:19:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38A5A3E24B3
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A532D600063
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778152700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3TxJTGgdW8glMynldWKQKfTle31OBEC20AqfuU7I//s=;
 b=HH6Oorrsq2Z0RxkREYPzKoUsNNAhFP4x13eQ5++q3WzBqJvSTsYZwbsPVZhRD2Jn3k0B4/
 tE7IMq48YYyZQPlNcITyzk/Z15fmDVmfI4sOvFu0VZaUd1xIvrPVAuIKSwOPngpYHS2jyG
 iEzz4T2GroDkceQSP3avo4CdsIcWiUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Dj-3Ke9kNYiAKSSfqeR27A-1; Thu, 07 May 2026 07:18:17 -0400
X-MC-Unique: Dj-3Ke9kNYiAKSSfqeR27A-1
X-Mimecast-MFC-AGG-ID: Dj-3Ke9kNYiAKSSfqeR27A_1778152697
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a5952c635so7288345e9.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152696; x=1778757496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TxJTGgdW8glMynldWKQKfTle31OBEC20AqfuU7I//s=;
 b=HHQmuiTeI73PAv0vBHcb2rj8+vdMJ5zJyoNOFEKvYU6x7MysvALlTTRhm/RBhBFd85
 WutHdd+OodRHOcTleQ2m9iePD81Bwv2cFjESlCMec9Mns4Z81aHDKM/M3qbh6wN6gAL8
 vku3M6QQfcCaxuBJo334jUoPvlFHZGCJpKkMjnzb7+uOnEGSBzFeXWvW899ZL3l8ZIb8
 roo5TfuR5n9VW/tSobcj0Hbg9psYDud07dp8VX52O/ZfdcB0eREh96KJSkmk2L5qu41L
 d87QEMmcDWPckm5IQ6gfgzB9yic5KEVHFbpmCv6KJyIPD/viNfIITjUiXOPdbLjsJ3rN
 im1Q==
X-Gm-Message-State: AOJu0YyO9khzhKkg334scmtXLH9nVpjAimqVFwTzrYlT0fTrvsnU8mGd
 pm4OmiF/uR8o1XaIYzsfasFCdeNx+vzTYPmL/OBf6o0Noyvjp5KrQT34dlNdSd4Y6MWvZXFyTGp
 vJNd9HNehrhCzTIDi0rUflTbe3jxxj11Xt3SZUITWSrIYMC8V163iJHOXXWu9SGWuAeFYu/ktke
 obGRdbsQTDx0fZFC416h+ejvUA7bbkRnAY6iOw
X-Gm-Gg: AeBDiet6vX3yN4GLICuH0Jepfx2PwW6X2rxyqu8cYjJezNNomXicdu2TST8PyxGMS/t
 vc2O2GW0Md1HDmIS6WzAyceWr/L6shx0DiYGfnkP04g1fHzjIWbgvDIw3gMTQRRdsurs0S1rAKa
 LupHAXJWwE4vcwbLArNADA5IiQxORIbTDYO/SjwI4b8YP+Q2BC8py98MYNsouOAuvonGw+yDLb2
 18HRE9M+h1/f/GkdqEf0MJJQ1VFFKDh2zxca5fm6uCr+9ykZkKu+Gj8OqbZ2uZZC+/JqctSzNDN
 /7oGwQ0egww2vXFlBurDcJ7t7M8Y/rrpkSP5aPBzPnk5E8UIpob2SN1M8Xt1L8GwtTUSsk3J9Jg
 6/jf4gGMZAZ1UlDf+S50wXjogAAmnJnZ6By+Zp1d/8nTxl46ruPnig/qMRHByXlO19zlSEmF8kG
 HiIgs2cVFtuMvts/bU
X-Received: by 2002:a05:600c:1f0d:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-48e51f45874mr120232965e9.23.1778152694271; 
 Thu, 07 May 2026 04:18:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1f0d:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-48e51f45874mr120230895e9.23.1778152692184; 
 Thu, 07 May 2026 04:18:12 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530cf964sm74515835e9.1.2026.05.07.04.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:18:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:18:05 +0300
Message-ID: <20260507111809.28934-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7-cYPobbYasxQaV3lgfaXuQXtkIieB_QWPjTQjCULVQ_1778152697
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Improve error handling coverage for futex syscalls by adding tests
for missing error conditions that were previously untested.

futex_wait06 verifies EFAULT is returned when uaddr or timeout
points to unmapped memory.

futex_wait07 verifies EINTR is returned when futex_wait() is
interrupted by a signal.

futex_wake05 verifies EFAULT is returned when uaddr points to
unmapped or PROT_NONE memory.

futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
uaddr2 points to unmapped or inaccessible (PROT_NONE) memory.

v4:
 - Add commit body and Signed-off-by to all patches
 - Remove incorrect EACCES/kernel-version check from futex_cmp_requeue03;
   get_futex_key() always returns EFAULT for inaccessible pages
 - Fix misleading comment in futex_wake05
 - Shorten overlong comment in futex_wait07

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 94 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 73 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 88 +++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 85 +++++++++++++++++
 6 files changed, 348 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
