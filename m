Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3E6C433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 11:47:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B9D43CA6B0
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 13:47:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C1183C12C4
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 13:47:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E28706002F9
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 13:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650455246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ik82cphj7NntWqsGB76oNU2HZlI0YoG/wJA6YzeCoA=;
 b=NWX4wBDPM4NkrcW+bnub3z7vZJ4rhJi9SxvrYgjbfMPRVrZnvWukwpw6wX0wKuntH4eE/s
 sD+vc62nCoVw/uAfJHkE1fbwglk9EEac+xDwTyxJdozR7E8G6L/qKfU3WUNCD3f+1FBXA9
 mcqw4AiBYgF+g+Kwmd0yEJ6wEBeFhvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-VP1HrYBcMjiHXNorEHyRuQ-1; Wed, 20 Apr 2022 07:47:25 -0400
X-MC-Unique: VP1HrYBcMjiHXNorEHyRuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1483C185A7A4
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:47:25 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20FB37C28
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:47:23 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 20 Apr 2022 19:47:20 +0800
Message-Id: <20220420114720.1463473-2-liwang@redhat.com>
In-Reply-To: <20220420114720.1463473-1-liwang@redhat.com>
References: <20220420114720.1463473-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] mkswap01: wait for the triggered events to
 complete
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/commands/mkswap/mkswap01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index f6494f6e3..cb3563b49 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -128,7 +128,7 @@ mkswap_test()
 		return
 	fi
 
-	udevadm trigger --name-match=$TST_DEVICE
+	udevadm trigger --name-match=$TST_DEVICE --settle
 
 	if [ -n "$device" ]; then
 		mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size" "$dev_file"
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
