Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA9FC433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 08:36:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 734563CAAE6
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 10:36:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05C33C21CE
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:36:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA63A6008C8
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653035793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te01y8gnqFXhiIJVDuX/mwZ+jUPLVuF+G2UdsSZ8qUM=;
 b=VhXuxE+EQfjx+EKHVixDCdpzxxLGMZn1dUUyyXhW8Ztk4L95UH9tZS2YPydHIopEWvF4lc
 cHt0vK1pkaeqkagUvbaXUEDiMbn69CLj3gnuMEfSSH1U30VpxhrCxENPjNsl3ckEp4I/lt
 7m6kpQ5q/Q7xSHDKHgK10oov7S48Cio=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-7ab7HdCPMt29pLH_zc46Ig-1; Fri, 20 May 2022 04:36:30 -0400
X-MC-Unique: 7ab7HdCPMt29pLH_zc46Ig-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 588A18630C0
 for <ltp@lists.linux.it>; Fri, 20 May 2022 08:36:30 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6525D492C3B
 for <ltp@lists.linux.it>; Fri, 20 May 2022 08:36:29 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 20 May 2022 16:36:25 +0800
Message-Id: <20220520083627.2499121-1-liwang@redhat.com>
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] two follow up fix for Introduce-of-max-runtime
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

I run a quick test for verifying those patches with the latest mainline kernel.
Apart from these two tiny issues, the result looks good.

  kernel: 5.18.0-rc7
  arch: x86_64, ppc64le, s390x, aarch64
  git-repo: https://github.com/wangli5665/ltp

Ps. I'm going to submit more tests against different RHEL products later.

Li Wang (2):
  testcases: make use of runtime
  mmap3: reset runtime to 10s

 runtest/mm                            | 2 +-
 testcases/cve/cve-2014-0196.c         | 1 +
 testcases/cve/cve-2016-7117.c         | 1 +
 testcases/cve/cve-2017-2671.c         | 1 +
 testcases/kernel/mem/mtest06/mmap3.c  | 2 +-
 testcases/network/can/cve/can_bcm01.c | 1 +
 testcases/network/packet/fanout01.c   | 1 +
 testcases/network/sockets/vsock01.c   | 1 +
 8 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
