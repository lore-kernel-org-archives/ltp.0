Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B195EC433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 01:38:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C443CA9C7
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 03:38:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F8C83CA9C9
 for <ltp@lists.linux.it>; Thu, 12 May 2022 03:38:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 791631400E1C
 for <ltp@lists.linux.it>; Thu, 12 May 2022 03:38:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652319520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xBEK/eujM2j6sku00fG5CpKRZFDMmP70WOz/CF0cDSk=;
 b=RWbA7XSJZdn10braU1erXKQ+pe1MtToNPfAAJ7ap8td6DTc7tqYOY4j3OQQKMZxmOOqFZ0
 tJsgbbvbAEBhy3A+dcTGovRpxt2ZZW1tIWo+V7nvhC3sYS1XghccvDMbJrzmP6O0bpMgOt
 n6Y5CzHBFqN7ddbxL7n71K0QQZ8VomQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-haNmi_WWPdGxqoxJwgI-Sg-1; Wed, 11 May 2022 21:38:31 -0400
X-MC-Unique: haNmi_WWPdGxqoxJwgI-Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1702F811E84;
 Thu, 12 May 2022 01:38:31 +0000 (UTC)
Received: from mail (unknown [10.22.8.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE978150592B;
 Thu, 12 May 2022 01:38:30 +0000 (UTC)
From: Andrea Arcangeli <aarcange@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 11 May 2022 21:38:29 -0400
Message-Id: <20220512013830.8534-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aarcange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/1] ksm: fix occasional page_volatile false positives
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
Cc: Eirik Fuller <efuller@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

Some LTP KSM tests (ksm0[2-4]) occasionally reported some
page_volatile elevated failure that turned out to be a false positive
from LTP.

This proposed fix has been verified by running the tests in a loop
like this: "while ./ksm02; do : ; done".

Thanks,
Andrea

Andrea Arcangeli (1):
  ksm: fix occasional page_volatile false positives

 testcases/kernel/mem/lib/mem.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
