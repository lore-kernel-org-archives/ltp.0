Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C2AC87FCA
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 03:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754104915; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=PiHWWfb0GfRnK1WUfFUl/FLjCl62+ZZT1Dqhebkuxtg=;
 b=gKQsr+67VSTrAQYWy8MuXxrn2of+dNxmb8u/wfTlLZoSR1nQWlny0+wqblNen6AKhs/iF
 +N1oFy4DW0FJL+mHaYw+l0HdYoXwqO6IPVb5Qt1y+pqY8CAt7W5/ooYpvOmnig6QYXuBjMX
 QtEGJ57zaBTafqCvG0rUTJEbdw7eAyA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECD993CCB87
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 05:21:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92C1A3CCAA6
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 05:21:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8BDA360080B
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 05:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754104890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ln6YcoTtDJ91iumqDzgfV6qjIJ+bhG4BWI+C2dI3dbY=;
 b=agB8eVsX1fO4hgdBH9HR4GUZY1Zj5bGlf8vjTHqf4Jtc+Vmm+deUlvxcku7HxBdi7Tuz/+
 DL9q4NhegccPE3EjsVakhwh6zZxSujp0fLv62Xw/YbW0oGnAKVelVcKQw7D6PTiGvDV+Nh
 rtpYEQ3KZ36mqwj+PbphnibCPylz9dk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-Cq9MrHKnNP-O_WwKDbH3lA-1; Fri,
 01 Aug 2025 23:21:28 -0400
X-MC-Unique: Cq9MrHKnNP-O_WwKDbH3lA-1
X-Mimecast-MFC-AGG-ID: Cq9MrHKnNP-O_WwKDbH3lA_1754104887
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720AE180045B
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 03:21:27 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20F1A19373D9
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 03:21:25 +0000 (UTC)
To: ltp@lists.linux.it
Date: Sat,  2 Aug 2025 11:21:23 +0800
Message-ID: <20250802032123.26335-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UmO-L1J6uyLbcV5oFmkkZimZFIAmwPccwm3nG06f8pY_1754104887
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mk: fix typo in module.mk
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/mk/module.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mk/module.mk b/include/mk/module.mk
index 10914084c..c3cbf9c21 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -7,7 +7,7 @@
 # REQ_VERSION_MAJOR and REQ_VERSION_PATCH must be defined beforehand.
 
 $(if $(REQ_VERSION_MAJOR),,$(error You must define REQ_VERSION_MAJOR))
-$(if $(REQ_VERSION_PATCH),,$(error You must define REQ_VERSION_MINOR))
+$(if $(REQ_VERSION_PATCH),,$(error You must define REQ_VERSION_PATCH))
 
 ifeq ($(WITH_MODULES),no)
 SKIP := 1
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
