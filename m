Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DE0CEF177
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 14:00:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E0413C1881
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 16:00:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7322D3C042F
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:45 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A9CA1A00939
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728395982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NhqZJw40w+kzxsueOovCYQnPMAwBLgRn1V/pnadYYs4=;
 b=dreqdlmA0QhnI/hjP2QPhWDSBWN4/2GKUbHH3vp2388nrew05drxNr5rb1QlwhLlDk5Oue
 x7tzrcR+TAB3UVurQPV/NtSRlfSl/eAvVSnyQMtO2cDw6uIZf9FbQMLvvNVYVY+QxQK5fo
 UoJupwuw6x7QpbGvCqFuxaI/EEmeU5c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-zEpDhJxTN8G8FCtk2_cBBQ-1; Tue,
 08 Oct 2024 09:59:40 -0400
X-MC-Unique: zEpDhJxTN8G8FCtk2_cBBQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78DD31955D80; Tue,  8 Oct 2024 13:59:38 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.33.151])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77B341955F42; Tue,  8 Oct 2024 13:59:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Oct 2024 15:59:31 +0200
Message-ID: <20241008135934.2491333-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] move_pages04: fixes and improvements
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

This is v2 of [1].

Fix and extend the move_pages04 test case to make it pass on upstream
kernels again. While at it, clean it up a bit and convert it to the new
test API.

[1] https://lkml.kernel.org/r/20240829141002.1962303-1-david@redhat.com

Cc: Jan Stancek <jstancek@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>

David Hildenbrand (3):
  move_pages04: check for "invalid area", "no page mapped" and "shared
    zero page mapped"
  move_pages04: remove special-casing for kernels < 4.3
  move_pages04: convert to new test API

 .../kernel/syscalls/move_pages/move_pages04.c | 267 +++++++++---------
 1 file changed, 127 insertions(+), 140 deletions(-)

-- 
2.46.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
