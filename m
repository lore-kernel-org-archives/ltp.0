Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4FEC3ABDA
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 01:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747274370; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=olBGpPWcQHHTh3Tud2FG4Nli5dB9Upp6gqdeiPWjkWY=;
 b=eb3DidBnRM2InhlOqeR4brAYMwjTx7mU77OsoRkHU1j/Ui+9Ab0Ju//EM877tezAIrS+v
 VY4iGHkKUoZfPiYqWTI5unhXAZMz9wDQQclhXYvRq+QgVg83CmC1PVT8w/3vGh6dbPfzqVr
 tLVPmXb97pnAVY+42uLHy8tR5p8Z2Co=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 990E93CC3EF
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 03:59:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B2D83CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 03:59:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A153600CF1
 for <ltp@lists.linux.it>; Thu, 15 May 2025 03:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747274345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7ohGtzCcL645iVCQmvwAWfvgKCKjDIcW08ugVsdVzRA=;
 b=XJ+p/Oj1BUpTHQjtpXChgOd9YW1dVtNIqL609oq/UnVQGgq+JUEv1nJ8sRd+Ds5n9Fag1w
 c37EnOHq9FHIqLuftyWwq8LQZv2qHLT65+XmK7kqa3nytE7OKsCOq8Nk8RjbHXCsUp0T0x
 //+8FdTZEVOn0wOpos1QdyoLO8SfAY4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-fLxVznC2OeexgsIKHSxGcw-1; Wed,
 14 May 2025 21:59:03 -0400
X-MC-Unique: fLxVznC2OeexgsIKHSxGcw-1
X-Mimecast-MFC-AGG-ID: fLxVznC2OeexgsIKHSxGcw_1747274342
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 652351800256
 for <ltp@lists.linux.it>; Thu, 15 May 2025 01:59:02 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D78C1955F24
 for <ltp@lists.linux.it>; Thu, 15 May 2025 01:59:00 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 15 May 2025 09:58:53 +0800
Message-ID: <20250515015855.68510-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P6bxqvmG3G9hM5DJ5cNWZcYKH85m8u2j0DFGYkVLu88_1747274342
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] Refactor test state handling and clarify
 naming in lib
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RFC -> V1
  * rebase code on the latest branch
  * replace pid_t by int32_t
  * memset zero in allocating ipc_region
  * adding back SAFE_MMAP in setup_ipc
  * set context->lib_pid in setup_ipc

CI job: https://github.com/wangli5665/ltp/actions/runs/15034122818

Also, manually tested by myself on RHEL-9.6 and RHEL-10.0 (all arches).

This patch series introduces two improvements to the test infrastructure:

1: Introduce shared struct context for runtime test state

This refactor consolidates scattered global runtime state variables
into a single struct context, which is stored in a new struct ipc_region.
This change is aimed at improving test robustness and maintainability
by enabling structured state sharing between parent and child processes,
particularly for tests requiring checkpointing or fork/exec workflows.

2: Rename tid to tcid

This is a simple but meaningful rename to avoid confusion between thread
ID (tid) and test case ID (tcid). This improves code clarity and avoids
misinterpretation during code review.

Li Wang (2):
  lib: rename tid to tcid
  lib: moves test infrastructure states into a shared context structure

 lib/tst_test.c | 234 ++++++++++++++++++++++++++++---------------------
 1 file changed, 132 insertions(+), 102 deletions(-)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
