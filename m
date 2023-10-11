Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E133CDB465
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:24:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28DE33D0019
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 18:24:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B8993C8B68
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:24:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8400D1BB9C18
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:24:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE3E31FF01;
 Wed, 11 Oct 2023 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697041472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oc4wJg/gg/HlfaCOdKXGINkF0d8I9q+JH/EqZTv6ghU=;
 b=i5CdHVWZr2AqVW2VkcHaRIpfz3H7aOUgKEKPBqPMp7+JVDfkNQmnMYtelz7Jy7s6UogsFQ
 Rmne8nkbosEdqr9h64VZPuj6DspuT7TThNnzOkYIRnIg8DyBY7uEwbiamHtLYL3onX7C61
 asFftJyscUncMxP7AJOpIeRnwqICqjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697041472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oc4wJg/gg/HlfaCOdKXGINkF0d8I9q+JH/EqZTv6ghU=;
 b=KSGl5Ts9DEMdctqAwDhWamSqYBVei7NIkJvca3T6dLndybYAQozo1b1+QMAAGINsVk4ZQj
 9sXooqkOyy1QqODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A98E134F5;
 Wed, 11 Oct 2023 16:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ls7vOj/MJmVIKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 16:24:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:24:26 +0200
Message-ID: <20231011162428.583911-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] swapon01: Test on all filesystems, cleanup
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this is based on patch from Marius:

https://patchwork.ozlabs.org/project/ltp/patch/20231011152900.4274-1-mkittler@suse.de/
https://lore.kernel.org/ltp/20231011152900.4274-1-mkittler@suse.de/

It's also related to (but independent on it):
https://patchwork.ozlabs.org/project/ltp/list/?series=377166

Kind regards,
Petr

Petr Vorel (2):
  swapon01: Test on all filesystems
  swapon01: Simplify code, add copyright

 testcases/kernel/syscalls/swapon/swapon01.c | 29 ++++++++++-----------
 1 file changed, 14 insertions(+), 15 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
