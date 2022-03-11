Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC97C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 05:46:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0A333C8CA2
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 06:46:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96CBB3C7B4E
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F190B601BD1
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 06:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646977569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HnBJ51LICUX9i4kzdRaEhJlAQqBm+ENEk+2aTzKwXw4=;
 b=TWp95k1DC74SjJuAPunQqKwOPZWw4Ag/Dfge2UXO5JRK1V+xqluMCglal8Ha7dBSI+XGgR
 pVX7Wny+ClomGQnhkj8iKoAirU3Zto3oQ+7B/b4l9M4vXSDILxgz/cmKw0A/IeubHM5L8o
 a4JoQDdlZSOf8noYTmbnrQ54yunOQjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-bg1N8HbuNc-6cAOISEyy-w-1; Fri, 11 Mar 2022 00:46:07 -0500
X-MC-Unique: bg1N8HbuNc-6cAOISEyy-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06BF91091DA1
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:07 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30752108D4
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 05:46:05 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 13:46:00 +0800
Message-Id: <20220311054603.57328-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] refine the MIN/MAX macros
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add type checking to MIN/MAX and make use of them for both
new and old testcases.

Li Wang (3):
  include: replace min/max macro by the new definition
  lib: adding unnecessary pointer comparison
  minmax: ensure the comparison numbers have compatible type

 include/ipcmsg.h                                      | 2 --
 include/libnewipc.h                                   | 1 -
 include/tst_minmax.h                                  | 2 ++
 lib/tst_cgroup.c                                      | 2 +-
 lib/tst_memutils.c                                    | 4 ++--
 lib/tst_timer_test.c                                  | 4 ++--
 testcases/kernel/mem/mmapstress/mmapstress01.c        | 3 +--
 testcases/kernel/mem/mmapstress/mmapstress09.c        | 1 -
 testcases/kernel/mem/mmapstress/mmapstress10.c        | 3 +--
 testcases/kernel/security/cap_bound/cap_bounds_r.c    | 3 +--
 testcases/kernel/security/cap_bound/cap_bounds_rw.c   | 7 +++----
 testcases/kernel/syscalls/fallocate/fallocate06.c     | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress01.c | 2 +-
 testcases/kernel/syscalls/ipc/msgstress/msgstress02.c | 2 +-
 14 files changed, 16 insertions(+), 22 deletions(-)

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
