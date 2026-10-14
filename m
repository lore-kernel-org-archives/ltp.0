Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630C4CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791980466; h=date : to :
 message-id : mime-version : content-type : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : sender : from;
 bh=7YdlzAYlk8czG/uB2uapLBKUilJcs/W+gNOp62BIt3s=;
 b=QwtNBgVuM2V5Ej08To4HwCOZeiS+TFLyr/7Aq4ox/0nuyhp8nSuSkymrfKq9Z5xPOt8dx
 DPLJMKYw8K77vIOo1DcqPV42S+d0WCYKdV3ZrBbZnSkUgmpXiLPvtOPVwXXBfUUSGemXAvl
 bA0q6bw7bYKysWb8SJDg2Rh21+kaecM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B41CD3EA78D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 14:21:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9294B3E29CE
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 14:20:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F3044200B20
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 14:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791980445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=sBOPSxB23586CvQk+wILcvXU/p7vLjMy5vCecidhnIo=;
 b=ejiwO+GQrEG7oCE+kw4fqP2g74Uf5omdl8bvfiPZLp3iRNz+XEDI3mi/vP46ePoxUlolDY
 6syyMTfSEc5h4HUWDJjSPqgAzEm8NFp3KNtUmppmwXx6XdR/TK/agUrFn4PLM5oufTgFyL
 NTt9d5xfGD2kNipiRrxDuvqRMAsjO6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-gJ4U-Z-JPx6eGSRZuiItVQ-1; Wed, 14 Oct 2026 12:20:43 +0000
X-MC-Unique: gJ4U-Z-JPx6eGSRZuiItVQ-1
X-Mimecast-MFC-AGG-ID: gJ4U-Z-JPx6eGSRZuiItVQ_1791980442
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c7fe9736eso3248025f8f.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980442; x=1792585242;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9C6SrixT1Mo0mHVPdryMJBYouarxBiXP54MwR+htios=;
 b=vWNNPATYx+RIpttbsRABYShZ6VttvAywlavgg2aDyE5/dzxDDyW+ahrumSEQg0l880
 QWM2heDwv+GHGsDthN0OIvRHTSmUrEaBBZHXKpAQ7MW1uvfybF6pHY409gacIvBotEDf
 syrmkTEVa5tRHUInA+qoXf7/6pPLFiZQ97W8h9dN4OmDCuZxU2X/8S6nB5jEahqnezW4
 RN39vPtIkCDzEICiM7Y3UiBrkv90dpY3D947CJue5V9xpUOyttX9sC7robC/jQ+uDaBg
 RyZJ2s7SpJRKFGEzEYPlbY+OSkhhAXspqHAKEAQR6AIcFcHQ8HRauKNUP5cqPQ2TOmIA
 BYHA==
X-Gm-Message-State: AFq9FYKcUl1yMR0E6Se/kbQ6fdVZsFN29t5gqUaCtwWUhOev+BrgDFBR
 gKUnTPZnCe8ZSYvU59OuZ/B9mZH6gyJOXLLa6sNqkEt4vNPqmdcqva+t5iLtM1kghLk7yMYXH+K
 QzWFqGTgJsPSQ2XyVDH2BqaCFIO/khW99uMmhW9grHx1vW86ZuqQnlTdym6sfsuP2elzQYVkPuc
 5dzPClh2/3uzRUu8D9FwfATfVtA6OWi60H5kA=
X-Gm-Gg: AYBFou0CIHSh+657gUI//LR2rjMZVphPGSRKW0UVz3UTwG7O0TQMNQ30z4Gov51qKym
 931LTbGg8OHCWw/3y9J3Db7XkqsdSaw9j/G7buSui6jVkUxnwp8BRumMmn0QD26Tzruo4+fClxt
 VbjOviXN5Wk/V7Vcj015z3lfEXmhv7m/P58rKfw5kZ+qN2b+/zqNcBtBKvmrawV5pLpBnkGFMSL
 wOiCMvaqxegGcRBNXKkfZZJbg7yyIbEJ3Mlu/f0K0nyhJFxJyoAmg+PS03dsY7j+zZu4zXa1UcF
 Rb1JdZwie+eOr3WUVnnJ9DzJ/uR4X0wsBM7+9dECypsYSeJy+6GtWH8kXCqMsDx2
X-Received: by 2002:a05:6000:4008:b0:48d:ece3:d180 with SMTP id
 ffacd0b85a97d-48dece3d31fmr2994276f8f.34.1791980441883; 
 Wed, 14 Oct 2026 05:20:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4008:b0:48d:ece3:d180 with SMTP id
 ffacd0b85a97d-48dece3d31fmr2994179f8f.34.1791980441150; 
 Wed, 14 Oct 2026 05:20:41 -0700 (PDT)
Received: from toolbx ([85.93.121.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72d2b13sm6493691f8f.55.2026.10.14.05.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:20:40 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:20:38 +0200
To: ltp@lists.linux.it, valgrind-developers@lists.sourceforge.net, 
 Mark Wielaard <mark@klomp.org>
Message-ID: <as9x2R-9IQb7vjn7@toolbx>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kcpEnIz9rvUmSZBB8XawOTb0OPwkEvvqnDtWQ5TVJOE_1791980442
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="xmel73ysnsjkwssg"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Suggested fix for the mremap03 syscall testcase
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--xmel73ysnsjkwssg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello folks,

I suspect that LTP commit 88cfde5fbc14b23f673b81855127448a519679c0
introduced a regression it the mremap03 testcase.  I've originally
reported it as a Valgrind bug:

https://bugs.kde.org/show_bug.cgi?id=526974

But now I think it's an LTP bug.  Proposed fix:

$ cat 0001-Fix-the-mremap03-syscall-testcase.patch
From 3ddcfa8c303feeb8681632e458d71001fbfb825c Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Wed, 14 Oct 2026 14:07:45 +0200
Subject: [PATCH] Fix the mremap03 syscall testcase

Commit 88cfde5fbc14b23f673b81855127448a519679c0 introduced a regression
in the setup() function of the mremap03 testcase.  The goal is to pass
a bad_addr to the mremap() syscall.

The original version of the setup() function did generate the bad_addr
using tst_get_bad_addr().  This gives a mapped address which is not
accessible (PROT_NONE).  The new version of the test does the same, but
unmaps that address right after that.  Valgrind flags that as an error.

This patch restores the original behavior of the setup() funcrion.
---
 testcases/kernel/syscalls/mremap/mremap03.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 4e647cdca..6003657d4 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -35,7 +35,6 @@ static void setup(void)
 	newsize = 2 * memsize;

 	bad_addr = tst_get_bad_addr(NULL);
-	SAFE_MUNMAP(bad_addr, page_size);
 }

 static void run(void)
--
2.55.0

$

Thanks,
Martin

--xmel73ysnsjkwssg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-the-mremap03-syscall-testcase.patch"

From 3ddcfa8c303feeb8681632e458d71001fbfb825c Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Wed, 14 Oct 2026 14:07:45 +0200
Subject: [PATCH] Fix the mremap03 syscall testcase

Commit 88cfde5fbc14b23f673b81855127448a519679c0 introduced a regression
in the setup() function of the mremap03 testcase.  The goal is to pass
a bad_addr to the mremap() syscall.

The original version of the setup() function did generate the bad_addr
using tst_get_bad_addr().  This gives a mapped address which is not
accessible (PROT_NONE).  The new version of the test does the same, but
unmaps that address right after that.  Valgrind flags that as an error.

This patch restores the original behavior of the setup() funcrion.
---
 testcases/kernel/syscalls/mremap/mremap03.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 4e647cdca..6003657d4 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -35,7 +35,6 @@ static void setup(void)
 	newsize = 2 * memsize;
 
 	bad_addr = tst_get_bad_addr(NULL);
-	SAFE_MUNMAP(bad_addr, page_size);
 }
 
 static void run(void)
-- 
2.55.0


--xmel73ysnsjkwssg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--xmel73ysnsjkwssg--

