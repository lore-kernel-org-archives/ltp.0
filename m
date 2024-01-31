Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66497C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 15:16:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC7293CF91F
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 16:16:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9EF93CE0B3
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:15:02 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A0F001013443
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:15:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 124F121FFC;
 Wed, 31 Jan 2024 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706714101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4NyHzSypAU/xhXztmRK3JNtz4kEoUGMQzmH2fCkhWE=;
 b=wT0FWUuyq8yVM/QPWmfPmtR63QKyvy+s3fRt+PA7xVcIlrfgim3oEjtN8cnVb1LegYxwps
 qTROtNha9siKuxJ/Wau5VNlFQrKNyNvufq4ameUQMAbLoVsm5E0NRMCDZ5zez/Huu2ZFlu
 04IyuhYpQxFh3M+5Bi3gbdND+GDRyRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706714101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4NyHzSypAU/xhXztmRK3JNtz4kEoUGMQzmH2fCkhWE=;
 b=ds4Goqyf31KXGfVxZuMgU7R5tzeKIMUBVviQbRRaCkI/95MnJAuxPCC0SndvKpUYl4tgFd
 +ZY/tCGOifmyn/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706714101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4NyHzSypAU/xhXztmRK3JNtz4kEoUGMQzmH2fCkhWE=;
 b=wT0FWUuyq8yVM/QPWmfPmtR63QKyvy+s3fRt+PA7xVcIlrfgim3oEjtN8cnVb1LegYxwps
 qTROtNha9siKuxJ/Wau5VNlFQrKNyNvufq4ameUQMAbLoVsm5E0NRMCDZ5zez/Huu2ZFlu
 04IyuhYpQxFh3M+5Bi3gbdND+GDRyRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706714101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4NyHzSypAU/xhXztmRK3JNtz4kEoUGMQzmH2fCkhWE=;
 b=ds4Goqyf31KXGfVxZuMgU7R5tzeKIMUBVviQbRRaCkI/95MnJAuxPCC0SndvKpUYl4tgFd
 +ZY/tCGOifmyn/Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CDDB139F5;
 Wed, 31 Jan 2024 15:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id kN9hJPRjumWJeQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:15:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 16:14:45 +0100
Message-ID: <20240131151446.936281-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131151446.936281-1-pvorel@suse.cz>
References: <20240131151446.936281-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] nfsstat01.sh: Add support for NFSv4*
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

NFSv4, NFSv4.1 and NFSv4.2 have following changes:
* server (/proc/net/rpc/nfsd) has "remove" remove 1) in proc4ops line 2)
  in column 31.
* client (/proc/net/rpc/nfs) has "remove" record in column 24.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Dear NFS developers,

I hope I found correct column (reading utils/nfsstat/nfsstat.c [1] and
comparing content of /proc/net/rpc/nfs{,d} and nfsstat output), but
please correct me, if other value should be tested.

You can test this LTP patchset with these commands:

git clone -b rename-net.nfs.v2 https://github.com/pevik/ltp.git && cd ltp
# optionally install LTP build dependencies with ./ci/YOUR_DISTRO.sh
make autotools && ./configure
for i in testcases/lib testcases/kernel/fs/fsstress/ testcases/network/nfs*/; do cd $i && make -j`nproc` && make install; cd -; done

PATH=/opt/ltp/testcases/bin:$PATH LTP_SINGLE_FS_TYPE=ext4 nfsstat01.sh -v4.1 # -v can be 3, 4, 4.1, 4.2

Kind regards,
Petr

[1] https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=utils/nfsstat/nfsstat.c;h=ca845325f0dc02a4f005dd44b010fcadcff4d3c7;hb=HEAD

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index 4c09ae135..c2856eff1 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -45,7 +45,9 @@ get_calls()
 #           tracking using the 'nfsstat' command and /proc/net/rpc
 do_test()
 {
-	local client_calls server_calls new_server_calls new_client_calls field
+	local client_calls server_calls new_server_calls new_client_calls
+	local client_field server_field
+	local client_v=$VERSION server_v=$VERSION
 
 	tst_res TINFO "checking RPC calls for server/client"
 
@@ -75,21 +77,23 @@ do_test()
 
 	tst_res TINFO "checking NFS calls for server/client"
 	case $VERSION in
-	2) field=13
+	2) client_field=13 server_field=13
 	;;
-	*) field=15
+	3) client_field=15 server_field=15
+	;;
+	4*) client_field=24 server_field=31 client_v=4 server_v=4ops
 	;;
 	esac
 
-	server_calls="$(get_calls proc$VERSION $field nfsd)"
-	client_calls="$(get_calls proc$VERSION $field nfs)"
+	server_calls="$(get_calls proc$server_v $server_field nfsd)"
+	client_calls="$(get_calls proc$client_v $client_field nfs)"
 	tst_res TINFO "calls $server_calls/$client_calls"
 
 	tst_res TINFO "Checking for tracking of NFS calls for server/client"
 	rm -f nfsstat01.tmp
 
-	new_server_calls="$(get_calls proc$VERSION $field nfsd)"
-	new_client_calls="$(get_calls proc$VERSION $field nfs)"
+	new_server_calls="$(get_calls proc$server_v $server_field nfsd)"
+	new_client_calls="$(get_calls proc$client_v $client_field nfs)"
 	tst_res TINFO "new calls $new_server_calls/$new_client_calls"
 
 	if [ "$new_server_calls" -le "$server_calls" ]; then
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
