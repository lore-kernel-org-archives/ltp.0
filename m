Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6DEEE021D
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 06:04:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCC813CE69B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 08:04:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E502D3CB133
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 08:04:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BD22A14052F1
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 08:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694757872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hK9+ofEyqQX2PAtibymPB2aalaiA88wG1fFZtB3zIaM=;
 b=b30hHACFn+Z0+4gcoVHOol4dSBdQHZpFnDRZp59btZCaE+0E7qtwIaY8LLOW/ggfFWa1ev
 +XUL0rWppvYyyDN6yd56mbwp8nYIiYjX0vJsQW0JpXsopkbEikZR5yIato2qaCkQTOaRnz
 +ocEnV9Y2w/6H4GP3SbQITzmWF3CP8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-AxCpZOG3Mmmt5E6sO0yEMA-1; Fri, 15 Sep 2023 02:04:30 -0400
X-MC-Unique: AxCpZOG3Mmmt5E6sO0yEMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AB82101FAA0
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 06:04:30 +0000 (UTC)
Received: from loobloo.nay.redhat.com (unused-66-82-83.nay.redhat.com
 [10.66.82.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29BA41054FC0;
 Fri, 15 Sep 2023 06:04:28 +0000 (UTC)
From: Shizhao Chen <shichen@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 14:04:25 +0800
Message-ID: <20230915060425.47337-1-shichen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] numa01.sh: unset default cpuset awareness before
 verify physcpubind
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

On systems with cpu isolation configured (a very common technique used in the
real time kernel), $run_on_cpu may happen to be an isolated core and hence
unaccessible to numactl.

Unset default cpuset awareness with --all, so numactl can use all possible
CPUs/nodes for following physcpubind settings.

Signed-off-by: Shizhao Chen <shichen@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 367813ce9..0181cd8f5 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -183,7 +183,7 @@ test4()
 	no_of_cpus=$(tst_ncpus)
 	# not sure whether cpu's can't be in odd number
 	run_on_cpu=$(($((no_of_cpus+1))/2))
-	numactl --physcpubind=$run_on_cpu support_numa pause & #just waits for sigint
+	numactl --all --physcpubind=$run_on_cpu support_numa pause & #just waits for sigint
 	pid=$!
 	var=`awk '{ print $2 }' /proc/$pid/stat`
 	while [ $var = '(numactl)' ]; do
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
