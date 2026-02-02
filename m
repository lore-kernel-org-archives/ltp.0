Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952BAE73145
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770023943; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=1SwE0LQS6sfe+yYGNsasdiMPCBE5XfM9c96e5b227Qs=;
 b=ofehD5//D761/c2GY7Fz9StSip69MPmyxtn8rulgoBwRVcKJqj+5GGYVpaVhS2YU1nsro
 s80lVG7wsIZ/1TXwqL5ODOQIlMfK7RjaM+2bHW/OmrU6MFwqfMrO6VnhSz9uE18sz9ryA2m
 YtmUPL8NbGvWJd/7b9JWFP3np7LZmUE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9779A3C76D1
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 10:19:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADA353C6A9A
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 10:18:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4264C600A13
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 10:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770023916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0oXR7RQKQZc8jIn8Xt0inFnWtHMJQEZ2n3QFA4xN+hc=;
 b=A6+EaawX16aySWW+ktrz5FkJmA4VxP3IhfZPB2AKfmGig2LKoaSmNTT19zeO0blQGeTKsT
 2KpLuDGR96Rm33Sw6b4pfAZT2CBz9ypaJXZSMOIPJ8rn/Nh4BRTYqoDZzV4Q2HlrGXoEHf
 4ppb7iZ0OYulONiDYU8KmWiRBeIy3SI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-SThdpb-KODuqgo2466z0pw-1; Mon,
 02 Feb 2026 04:18:08 -0500
X-MC-Unique: SThdpb-KODuqgo2466z0pw-1
X-Mimecast-MFC-AGG-ID: SThdpb-KODuqgo2466z0pw_1770023887
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 457011955F3D
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 09:18:07 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C7619560A2
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 09:18:05 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  2 Feb 2026 17:18:01 +0800
Message-ID: <20260202091801.68673-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WjgXW8rAx9mQ4bny-v1yoedbNIIgmkGicoe9A8Migyg_1770023887
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc/developers: document tst_/tse_/tso_ library
 namespaces
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

This helps contributors choose the correct layer when adding new library
code and clarifies expectations around legacy components.

Follow-up: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")
Follow-up: 751df4fa64 ("include/old: rename legacy headers to tso_* namespace")
Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/developers/ltp_library.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
index f76cbb75e..bb2677622 100644
--- a/doc/developers/ltp_library.rst
+++ b/doc/developers/ltp_library.rst
@@ -15,6 +15,34 @@ for :doc:`writing tests <../developers/writing_tests>`
 #. Do not add new API functions to the old API. Add new functions to
    ``tst_.[ch]`` files.
 
+Library naming and scope
+------------------------
+
+To keep the library API easy to navigate and to make layering explicit, LTP
+library components follow these naming rules:
+
+- **tst_**: Core LTP library API (located in ``lib/``).
+
+  - Stable, widely used interfaces intended for general consumption by tests.
+  - New public APIs should normally live here (in ``tst_*.h`` / ``tst_*.c``).
+
+- **tse_**: Non-core / extended library code (located in ``libs/``).
+
+  - Optional or specialized helpers that are not part of the core API.
+  - May have narrower scope or fewer stability guarantees than ``tst_``.
+  - Can be promoted to ``tst_`` later if it becomes broadly useful and stable.
+
+- **tso_**: Legacy / old library code.
+
+  - Kept for backward compatibility.
+  - No new features should be added; only minimal fixes are acceptable (e.g. build fixes, correctness fixes, security fixes).
+  - New code should not depend on ``tso_`` unless strictly necessary.
+
+**Notes:**
+
+- Prefer adding new code to ``tst_`` or ``tse_``; avoid introducing new ``tso_`` components.
+- When adding a new public interface, document where it belongs (``tst_`` vs ``tse_``) and why.
+
 Shell API
 ---------
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
