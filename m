Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA87C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F8773CC65B
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:19:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C30F3CC658
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 26F481400053
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 12:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669634321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l7ZZ665w0GozTZTReXDQlccF1fsgWY4RRgy61Rg/xlg=;
 b=RIYEZAmylUJJDVEuRxwuxulIF2y56fpBP+IxsZaDfL9GbarARkwTTqRfx7CepF6zCgixDH
 zIY2z+xpAQGvQ7Ef8ceCgpkSLhgjVaPanmMVcp2AHmZI++Dig0Y7taHW5IcULqkyJw3nsJ
 SlNv3t8+BW8f5tkVjhIN87jsbSY5UXs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-HifIrSn_OXusG8-4__hlfg-1; Mon, 28 Nov 2022 06:18:38 -0500
X-MC-Unique: HifIrSn_OXusG8-4__hlfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 188DE3803904;
 Mon, 28 Nov 2022 11:18:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B78D3C15BA4;
 Mon, 28 Nov 2022 11:18:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 28 Nov 2022 12:18:30 +0100
Message-Id: <20221128111833.98937-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time TCONF
 handling
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
Cc: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let's provide include/lapi/userfaultfd.h such that we can fix
the dirtyc0w_shmem testcase and cleanup the userfaultfd01 testcase.

Cc: Martin Doucha <mdoucha@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Petr Vorel <pvorel@suse.cz>

David Hildenbrand (3):
  lapi/userfaultfd.h: Preparation for removing compile-time TCONF
    handling from userfaultfd testcases
  security/dirtyc0w_shmem: Fix compile-time absence of
    UFFD_FEATURE_MINOR_SHMEM
  syscalls/userfaultfd01: Remove compile-time TCONF handling

 include/lapi/userfaultfd.h                    | 190 ++++++++++++++++++
 .../dirtyc0w_shmem/dirtyc0w_shmem_child.c     |  12 +-
 .../syscalls/userfaultfd/userfaultfd01.c      |   8 +-
 3 files changed, 192 insertions(+), 18 deletions(-)
 create mode 100644 include/lapi/userfaultfd.h

-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
