Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F12CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:38:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 645723E57D7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D08833E20C0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:38:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B3AD100022D
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:38:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38CF01F84E;
 Tue, 29 Sep 2026 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790692677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Nswe6X5fDNrJayJPGHBPdIwrR5lhk8WXGQMniHK04/Y=;
 b=Ctxgxd4ldIlTIDujwYzDyu5woP/6zfU4OD5DMy/UOImTO6m0NG+QfugIbjZv0S2tf2C20d
 4BNSDYiqDh/KLsdP0HKb1xTddBp+q5DF7CV7BX0DdV/wjkfy0A1UHYiupIzdR/xe1yCFQt
 EJDwX6BHEPDDGeJbXBDHu40aRsApTB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790692677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Nswe6X5fDNrJayJPGHBPdIwrR5lhk8WXGQMniHK04/Y=;
 b=MSSdUCmu68m/ffITc1bEwMVqLbGDd0bhddIFi9bc9pfx1X6vIUJFUfFjye60WHiRhn0z7I
 ccJJWd4HW2bKHRBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FgVGzpxf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="b+x/L5Tl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790692673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Nswe6X5fDNrJayJPGHBPdIwrR5lhk8WXGQMniHK04/Y=;
 b=FgVGzpxfY5HNpDfFw7dWCyekHFQi1ZFHVkCAFMIk6iESEb7LHFnZKFtYkaYkNT/mnNmlCj
 yY5XRGmyJuEWgykY6b7tH9zCO1HOHeRaGSYOKjifkMf08b9cADbHx0ddREUgVBnHEqCVfr
 Sfae4p4r1nnnGPGIPQCd3PO1kusEPo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790692673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Nswe6X5fDNrJayJPGHBPdIwrR5lhk8WXGQMniHK04/Y=;
 b=b+x/L5Tl66RH+SQ9GN/aGpgmIKZbwGcTEEvg+vwSy9I2+td42KvMqTxpURS0R8qv0IoOuJ
 /8iwamFQSI5xbXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D585613710;
 Tue, 29 Sep 2026 14:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uFMWJ0DNu2qUaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 14:37:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 29 Sep 2026 16:37:48 +0200
Message-ID: <20260929143748.2529138-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38CF01F84E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,regen.sh:url,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] generate_syscalls.sh: Make help visible
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

Shell opt "nounset" (set -u parameter, passed via shebang) prints error
instead of printing help:

    include/lapi/syscalls/generate_syscalls.sh: line 7: $1: unbound variable

Check number of input arguments correctly.

Fixes: cbd535838a ("Refactor regen.sh script to generate syscalls")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Simple fix which I dared to merge before the release.
IMHO the standard way is to check $# than use ${1:-} when we deal with
input arguments.

 include/lapi/syscalls/generate_syscalls.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
index 19f280dfb8..1601696326 100755
--- a/include/lapi/syscalls/generate_syscalls.sh
+++ b/include/lapi/syscalls/generate_syscalls.sh
@@ -4,9 +4,7 @@
 # Generate the syscalls.h file, merging all architectures syscalls input file
 # which are in the current folder and defined inside supported-arch.txt file.
 
-SYSCALLS_FILE="$1"
-
-if [ -z "${SYSCALLS_FILE}" ]; then
+if [ $# -eq 0 ]; then
 	echo "Please provide the syscalls.h directory:"
 	echo ""
 	echo "$0 path/of/syscalls.h"
@@ -14,6 +12,7 @@ if [ -z "${SYSCALLS_FILE}" ]; then
 	exit 1
 fi
 
+SYSCALLS_FILE="$1"
 SCRIPT_DIR="$(realpath $(dirname "$0"))"
 SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
