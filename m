Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC33C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 13:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D94FF3CF86D
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 15:45:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38A1E3CAEB6
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:44:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5889E101F0B9
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:44:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 857352071F
 for <ltp@lists.linux.it>; Wed, 15 May 2024 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715780672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bG2hxhqbUzFSncff6d09KQ/06eNNI154jNwlTJAWZKs=;
 b=jbldgWnfVpAgdEvihkwpEbg76UcLJ4NyMDpFwFYxPdM5NrFuiVFMGsvIBkpUKQlTWpSOw+
 yTsqz3Q6moEJo6k7b7TNJPs2DrAwA23A5tCyqLJMU+l1DwPEkL41S8iEWcnfgWjuwuoGC7
 7Vev3cQqhhJg3RRRYAplBcwrAz3BFWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715780672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bG2hxhqbUzFSncff6d09KQ/06eNNI154jNwlTJAWZKs=;
 b=xhR938fe9zhAqKSZrJ3evtON5Vo5jXR2XYp6JnZ+iWH4ejC0W3i59FJZLsiO4RRqIFHaEX
 8gucwm3autPOYiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715780672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bG2hxhqbUzFSncff6d09KQ/06eNNI154jNwlTJAWZKs=;
 b=jbldgWnfVpAgdEvihkwpEbg76UcLJ4NyMDpFwFYxPdM5NrFuiVFMGsvIBkpUKQlTWpSOw+
 yTsqz3Q6moEJo6k7b7TNJPs2DrAwA23A5tCyqLJMU+l1DwPEkL41S8iEWcnfgWjuwuoGC7
 7Vev3cQqhhJg3RRRYAplBcwrAz3BFWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715780672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bG2hxhqbUzFSncff6d09KQ/06eNNI154jNwlTJAWZKs=;
 b=xhR938fe9zhAqKSZrJ3evtON5Vo5jXR2XYp6JnZ+iWH4ejC0W3i59FJZLsiO4RRqIFHaEX
 8gucwm3autPOYiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D44E1372E
 for <ltp@lists.linux.it>; Wed, 15 May 2024 13:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BFVfHkC8RGY/ZwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 May 2024 13:44:32 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 15:44:29 +0200
Message-ID: <20240515134432.27996-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_netdevice: Add permissive macro for adding
 traffic filters
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

Add a permissive variant of the NETDEV_ADD_TRAFFIC_FILTER() macro
for tests which expect the command to fail.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 include/tst_netdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 8d40148a6..2394f9c7f 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -179,6 +179,11 @@ int tst_netdev_add_traffic_filter(const char *file, const int lineno,
 	tst_netdev_add_traffic_filter(__FILE__, __LINE__, 1, (ifname), \
 		(parent), (handle), (protocol), (priority), (f_kind), (config))
 
+#define NETDEV_ADD_TRAFFIC_FILTER_RET(ifname, parent, handle, protocol, \
+	priority, f_kind, config) \
+	tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, (ifname), \
+		(parent), (handle), (protocol), (priority), (f_kind), (config))
+
 int tst_netdev_remove_traffic_filter(const char *file, const int lineno,
 	int strict, const char *ifname, unsigned int parent,
 	unsigned int handle, unsigned int protocol, unsigned int priority,
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
