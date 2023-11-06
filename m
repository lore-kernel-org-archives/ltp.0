Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A49C4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 09:30:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2293CE87F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:30:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 316983C26EE
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:30:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1AC46140163F
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699263037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f1udA4OwKnWcNIbIVaR2fylV6DHS2G7Qhby+jok7Vz0=;
 b=Gd3aGTFlgywL/+xb/HkhCHFUyPNcguDePRXvFoQWvdhcWIAjE2cH0HRF5STzaZb7kMfTfY
 IBXcUO/Kg6xAivmtffApBc6VLRMEymKBdbNPVG7yqoCT7VPSLKzmPydWdxBHh9JUzKaCvw
 8p2OAYzGoYRSEPtIsM1t8VRWjWc+ON0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-z0-0kXEFP6Gxzw9n3m9o0w-1; Mon, 06 Nov 2023 04:30:35 -0500
X-MC-Unique: z0-0kXEFP6Gxzw9n3m9o0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B31FC83B827
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 09:30:35 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C681E1C060AE
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 09:30:34 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  6 Nov 2023 17:30:28 +0800
Message-Id: <20231106093031.1844129-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Introduce new field .hptype for reserving
 gigantic page
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

In the beginning, I was just thinking of using specified .hpsize by users
to reserve gigantic or default huge pages. But after thinking over and
discussing with Richard, we both think that it might be easy to get typos and
limit the test case to run on more potential platforms.

Here change the field to .hptype with two enum TST_HUGE and TST_GIGANITC,
as the name suggests, if people want to reserve variant page size in their
case, this field could be defined.

But considering there are many different sizes and it could be configured
by linux users, we don't assume what the size of the gigantic page is, it
all depends on the system set, for instance, an aarch64 has four types:

    hugepages-1048576kB, hugepages-2048kB,
    hugepages-32768kB,    hugepages-64kB

LTP library will pick up the largest one as gigantic page. For a system
without configuring the 1GB or similar large size, it also gives a chance
to test on default hpage size. Compared with just TCONF on no-gigantic page,
this is adding test coverage.

(To Richard: the reason why I didn't go to use the smallest and second
 smallest size is because, platform like aarch64 typically configure many
 medium sizes for user, but the default huge is 2MB and gigantic is 1GB,
 that doesn't fit to most popular scenarios. But to x86_64, situations
 becomes common and easy, they only has two: 2MB, 1GB, this method could
 handle the case smoothly.)

Note: Patchset test passed on the RHEL8.9 and RHEL9.3 (x86_64/aarch64).

V2 --> V3
	* introduce new field .hptype
	* add enum tst_hp_type { TST_HUGE, TST_GIGANTIC }
	* drop the is_hugetlb_gigantic function
	* just choose the largest huge pagesize as gigantic

Li Wang (3):
  lib: add support for kinds of hpsize reservation
  hugemmap32: improvement test
  hugemmap34: Test to detect bug with migrating gigantic pages

 doc/C-Test-API.asciidoc                       |  42 +++++-
 include/tst_hugepage.h                        |  11 ++
 lib/tst_hugepage.c                            |  63 ++++++++-
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  |  59 +-------
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 129 ++++++++++++++++++
 7 files changed, 240 insertions(+), 66 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
