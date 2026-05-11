Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93FCD37B5
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 07:09:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BBC33C682F
	for <ltp@archiver.kernel.org>; Mon, 11 May 2026 09:09:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14F623C5F08
 for <ltp@lists.linux.it>; Mon, 11 May 2026 09:09:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9F59C200907
 for <ltp@lists.linux.it>; Mon, 11 May 2026 09:08:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6904683AA;
 Mon, 11 May 2026 07:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778483339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vg7/DRtt/WPet9H7O7eXWA5I7FFIwJ7noLt6Nl+hIOs=;
 b=qTYv1PdImWe4/sY0K8gxYvyzOpjSylAIotk69qPkJLMokcEjncKHaPGhjpCKpPMJO8Hqqm
 61Dnf7cbE8F2UGJkIntdTEavn76TASqlmkRpAd1JMPRf6ZPDKTgM1o5wUNZQqQVOQea8Kj
 vT4HcSZ40CBFxcEirDPJRpxWj9+ycoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778483339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vg7/DRtt/WPet9H7O7eXWA5I7FFIwJ7noLt6Nl+hIOs=;
 b=lnUs/vXTjEWDNsFKlMNN/SvvwOKFH2Ul/ukOzVKFqIUguMJg/fN3xjBSS8m9fdfVWLLa0i
 ddop2nhKURxM/oAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778483338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vg7/DRtt/WPet9H7O7eXWA5I7FFIwJ7noLt6Nl+hIOs=;
 b=ln2k3qBTgxVothUOd31XAvnEuX3C3xaiNJpFmmYU2SmeRNIcLMrWaRT98Tc13dqOuFudLr
 n6Y2/uPA23o5moSHTBVYwv11EgJr7Fd9gcXUo0DD9hxlAR1w0KMb+SrM9TAnylyYQPSuyR
 T/7OjglvIOLLUIX1GKQKXDPZRJ/QggI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778483338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vg7/DRtt/WPet9H7O7eXWA5I7FFIwJ7noLt6Nl+hIOs=;
 b=yDv4yLbACLFfu1WoAcghiOHcWfpwW/rWX2XFEB77Ll6e6/4w5wtlraozuPk2pbyGS2v/gD
 Qr5G8PoHsur/+8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7E36593A3;
 Mon, 11 May 2026 07:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RXioL4qAAWrBHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 May 2026 07:08:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 11 May 2026 09:08:52 +0200
Message-ID: <20260511070852.90379-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc/cve_catalog: Link CVE to www.cve.org
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

Although test_catalog page links to www.cve.org, it's more convenient for
readers to have that link also on page dedicated to CVEs.

While at it, change warning to note (it's really an info, nothing to
warn about).

Follow-up: 79396c7b71 ("doc: Add CVE catalog to documentation")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Sachin, Andrea,

thanks a lot for implementing the CVE list page. Very simple change to
it but I prefer not to modify the page without your ack.

Kind regards,
Petr

 doc/conf.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 668cb4d980..591c1534df 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -19,6 +19,7 @@ author = 'Linux Test Project'
 release = '1.0'
 ltp_repo = 'https://github.com/linux-test-project/ltp'
 ltp_repo_base_url = f"{ltp_repo}/tree/master"
+cve_url = "https://www.cve.org/CVERecord?id="
 
 # -- General configuration ---------------------------------------------------
 # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
@@ -293,7 +294,7 @@ def _generate_tags_table(tags):
         "linux-stable-git": "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=",
         "glibc-git": "https://sourceware.org/git/?p=glibc.git;a=commit;h=",
         "musl-git": "https://git.musl-libc.org/cgit/musl/commit/src/linux/clone.c?id=",
-        "CVE": "https://www.cve.org/CVERecord?id=CVE-",
+        "CVE": cve_url + 'CVE-',
     }
 
     table = [
@@ -586,7 +587,7 @@ def generate_cve_catalog(_):
     # Generate single CVE catalog file
     total_cves = len(cve_data)
     text = [
-        '.. warning::',
+        '.. note::',
         '    The following CVE catalog has been generated from test',
         '    metadata and includes all CVE reproducers in LTP.',
         '',
@@ -614,8 +615,10 @@ def generate_cve_catalog(_):
         # Join multiple tests with commas
         tests_str = ', '.join(test_links)
 
+        cve_link = f'`{cve_id} <{cve_url}{cve_id}>`_'
+
         text.extend([
-            f'   * - {cve_id}',
+            f'   * - {cve_link}',
             f'     - {tests_str}',
         ])
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
