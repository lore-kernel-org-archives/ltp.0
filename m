Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C11C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:50:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E624C3D064D
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:50:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F8C73C713B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9EC1F6008C6
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:49:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 154204119;
 Wed,  5 Aug 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwROtMHCV2w7iaThEsHuDqDvdqnSilzEdVOv0LUQ700=;
 b=yZJF4p7wFnDdcA6Z4fSgoqs969YrBnzZ+r1vavKJwIbpjv8uXPjBXEcPqlBDDbmep2NsW4
 rJt4SCiA3IgDnAQM/lY65ppqpayAHfv4RWA3CDFejxFkn5WRD+BhmeYjX+aFs9bE2CktQU
 s3KGv8s8mmLBfivJ3JCJg/FmekVSFeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwROtMHCV2w7iaThEsHuDqDvdqnSilzEdVOv0LUQ700=;
 b=Cf4vneLpDFrtFCOM9b1szEDN8iwYDt+Y2fPFyv81ZsFjOuiSWT+gS+fghu6po2sIdOiyBv
 e3+S8MLV0mjrfLDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwROtMHCV2w7iaThEsHuDqDvdqnSilzEdVOv0LUQ700=;
 b=hVWwqaxSR9Ql+DVPLSmIfJs0+ukZNb690HXiUZ1bUEJuwwpl70si89+lv9M7wwppfhdVuJ
 p0AS/EFLBfORT26SciAhCOLWSEANfLrbVPPWhF1iWqYYaa61lO5QhArWjAY0/xBW9GuqUS
 1pkjfM4jcQ1WH2gyyHF0lXEasMNMvfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwROtMHCV2w7iaThEsHuDqDvdqnSilzEdVOv0LUQ700=;
 b=V2mN2OSy4SlHOhKxFeAqEk5hJ6nylT154plGHcH+Z3ZtIwrOq0PUw849Htma+Nmhrsvnhu
 sOGBlc78sxCrSHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3BDE779C2;
 Wed,  5 Aug 2026 09:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gB2VMTMHc2rvSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 09:49:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 11:49:32 +0200
Message-ID: <20260805094935.448896-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805094935.448896-1-pvorel@suse.cz>
References: <20260805094935.448896-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[readthedocs.org:url,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] readthedocs: Update to Ubuntu 26.04, Sphinx 8.2.3
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

Update readthedocs.org environment + local requirements.txt
* Ubuntu 24.04 => 26.04
* Sphinx 7.2.6 => 8.2.3 (based on Ubuntu 26.04 version to match local
  development with readthedocs.org)
* sphinx-rtd-theme 2.0.0 => 3.1.0 (required by Sphinx 8.2.3 update)

This helps to use newer Sphinx features.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .readthedocs.yml     | 2 +-
 doc/requirements.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 51825da77f..bb70bce70d 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -1,7 +1,7 @@
 version: 2
 
 build:
-  os: "ubuntu-24.04"
+  os: "ubuntu-26.04"
   tools:
     python: "3.12"
   apt_packages:
diff --git a/doc/requirements.txt b/doc/requirements.txt
index 442ff2eee6..f04676c7bd 100644
--- a/doc/requirements.txt
+++ b/doc/requirements.txt
@@ -1,7 +1,7 @@
 # Use the same sphinx as on readthedocs.org. When updated, make sure
 # sphinx-rtd-theme is compatible with sphinx.
-sphinx==7.2.6
-sphinx-rtd-theme==2.0.0
+sphinx==8.2.3
+sphinx-rtd-theme==3.1.0
 
 linuxdoc==20240924
 sphinxcontrib-spelling==7.7.0
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
