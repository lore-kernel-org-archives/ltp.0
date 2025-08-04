Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACFFC87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:49:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1F453CCFF2
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:49:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2841C3CC209
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:49:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 72DDC10007C0
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:49:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3046F211DD;
 Mon,  4 Aug 2025 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754333340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6vEhP808ABLeOm/0QakgHjhgh+cVHf6pLpzg+qw1pJ8=;
 b=UeitXEJaD2/CowZZoelIhGfGQYbgJlpe46Jq6CnK8wNfar0qpJiHjo5Jum+Ll253JDHdKf
 iz2D94frG72zBMtbBlx/JeXdBHd6BrHC/Eg/YptZfvaF2DrEfBW4EkJvQdozGA55GL5ZLz
 Pdn14U18nCOXAIrCj3mDI4vmQW49PL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754333340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6vEhP808ABLeOm/0QakgHjhgh+cVHf6pLpzg+qw1pJ8=;
 b=IhMnqqEcUB2f6qbUtCZI7633i3TVs1AekfHs1PVl17yNvPyuuc/HX/ciCywTHp/VDcPen7
 FcivDToRLj3IrTCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754333340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6vEhP808ABLeOm/0QakgHjhgh+cVHf6pLpzg+qw1pJ8=;
 b=UeitXEJaD2/CowZZoelIhGfGQYbgJlpe46Jq6CnK8wNfar0qpJiHjo5Jum+Ll253JDHdKf
 iz2D94frG72zBMtbBlx/JeXdBHd6BrHC/Eg/YptZfvaF2DrEfBW4EkJvQdozGA55GL5ZLz
 Pdn14U18nCOXAIrCj3mDI4vmQW49PL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754333340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6vEhP808ABLeOm/0QakgHjhgh+cVHf6pLpzg+qw1pJ8=;
 b=IhMnqqEcUB2f6qbUtCZI7633i3TVs1AekfHs1PVl17yNvPyuuc/HX/ciCywTHp/VDcPen7
 FcivDToRLj3IrTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED831133D1;
 Mon,  4 Aug 2025 18:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RsmiMZoAkWiXMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Aug 2025 18:48:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  4 Aug 2025 20:48:50 +0200
Message-ID: <20250804184850.313101-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,rpc_test.sh:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] rpc_test.sh: Check for rpcbind remote calls
 support
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
Cc: libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 Steve Dickson <steved@redhat.com>,
 =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

client binaries rpc_pmap_rmtcall and tirpc_rpcb_rmtcall require rpcbind
compiled with remote calls.  rpcbind has disabled remote calls by
default in 1.2.5. But this was not detectable until 1.2.8, which brought
this info in -v flag.

Detect the support and skip on these 2 functions when disabled.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

BTW it'd be nice to investigate why the broadcast functions fail,
enabling remote calls does not help, testing on:
./configure --enable-libwrap --enable-warmstarts --enable-debug --with-statedir=/run/rpcbind --with-rpcuser=rpc --with-systemdsystemunitdir=/usr/lib/systemd/system '--with-nss-modules=files usrfiles' --enable-rmtcalls

Kind regards,
Petr

# PATH="/opt/ltp/testcases/bin:$PATH" ./rpc_test.sh -s rpc_svc_1 -c rpc_clnt_broadcast
rpc_test.sh -s rpc_svc_1 -c rpc_clnt_broadcast
rpc_test 1 TINFO: Running: rpc_test.sh -s rpc_svc_1 -c rpc_clnt_broadcast
rpc_test 1 TINFO: Tested kernel: Linux ts 6.13.6-1-default #1 SMP PREEMPT_DYNAMIC Mon Mar 10 08:49:24 UTC 2025 (495d82a) x86_64 x86_64 x86_64 GNU/Linux
rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
rpc_test 1 TINFO: add local addr 10.0.0.2/24
rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
rpc_test 1 TINFO: add remote addr 10.0.0.1/24
rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
rpc_test 1 TINFO: Network config (local -- remote):
rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
rpc_test 1 TINFO: timeout per run is 0h 5m 0s
rpc_test 1 TINFO: check registered RPC with rpcinfo
rpc_test 1 TINFO: registered RPC:
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp  20048  mountd
    100024    1   udp  36235  status
    100005    1   tcp  20048  mountd
    100024    1   tcp  60743  status
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100021    1   udp  40939  nlockmgr
    100021    3   udp  40939  nlockmgr
    100021    4   udp  40939  nlockmgr
    100021    1   tcp  38047  nlockmgr
    100021    3   tcp  38047  nlockmgr
    100021    4   tcp  38047  nlockmgr
rpc_test 1 TINFO: using libtirpc: yes
rpc_test 1 TFAIL: rpc_clnt_broadcast 10.0.0.2 536875000 failed unexpectedly
RPC: Timed out
1
rpc_test 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
rpc_test 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
rpc_test 2 TINFO: loaded SELinux profiles: none



 testcases/network/rpc/rpc-tirpc/rpc_test.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index cadae55203..1a8cf46399 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -53,6 +53,11 @@ setup()
 		fi
 	fi
 
+	if [ "$CLIENT" = 'rpc_pmap_rmtcall' -o "$CLIENT" = 'tirpc_rpcb_rmtcall' ] && \
+		rpcbind -v 2>/dev/null && rpcbind -v 2>&1 | grep -q 'remote calls: no'; then
+		tst_brk TCONF "skip due rpcbind compiled without remote calls"
+	fi
+
 	[ -n "$CLIENT" ] || tst_brk TBROK "client program not set"
 	tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
 
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
