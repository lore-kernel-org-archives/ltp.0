Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A2F483F8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 20:56:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C339F3E6BD1
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 21:56:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 851FD3E1712
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 21:56:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1565B100077A
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 21:56:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39F815BD63;
 Mon, 23 Mar 2026 20:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774299362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OHwWy4Cfi1aBaEjY/trhdt5HRdV9pgU7ipSMgqDneo4=;
 b=KC0wAeA471Nl6le0605sMLTv6nqqd/omW/vksZztnYLBBYzLU+9KZJrHb2LQMQZD7lr3Si
 APxhM05AeinxDFxOsnN9ALo39QofSwjo/sNEgm6j/Hkv5dxJA2ORf4vSPGMQLXp7shBor1
 4ODU8mZgJtPg3/xR+eNJv7eeNnGq39I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774299362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OHwWy4Cfi1aBaEjY/trhdt5HRdV9pgU7ipSMgqDneo4=;
 b=r/b9/5Q/D8SYj24jmf+u3H8omzXR6tumNpN8lFB4Ci4dImfb4aG+fe7ZYA4SE4GRntmuM6
 2dsnUSr5wMvUOaAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Lo7fyB2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ak/F/cIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774299361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OHwWy4Cfi1aBaEjY/trhdt5HRdV9pgU7ipSMgqDneo4=;
 b=0Lo7fyB2EYfbKVS8FGbmpfvvoT4X5LSB+j5aKc5fw9JGz6rgNx6US6QMVB/2kXI8T4xh3N
 lI+EtutPhuuWyliEnwZY82v5rxAMZhkRbeTiZZQeOmoJcHN6wESZAuFoErDDRvs+POg53f
 gJmWJIDNVPtQPuIH/cV8SlqNbwDfGfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774299361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OHwWy4Cfi1aBaEjY/trhdt5HRdV9pgU7ipSMgqDneo4=;
 b=ak/F/cIxQLN0GFFkFT2cIa6xXA377IeT/1pGxTIjWoytCQ/XZTFNHd2xbf2a8Zi/hSxj1v
 k2Czt3qP46EqE8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DFA643A8C;
 Mon, 23 Mar 2026 20:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BkZaAuGowWlqMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 20:56:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 21:55:42 +0100
Message-ID: <20260323205547.19058-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 39F815BD63
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] network: cleanup stress tests
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (5):
  network: Remove outdated TCP stress tests
  network: Remove outdated ICMP stress tests
  network: Remove outdated UDP stress tests
  network: Remove outdated route rmmod tests
  ns-tools: Remove unused tools

 testcases/network/.gitignore                  |   5 -
 testcases/network/stress/icmp/Makefile        |   2 +-
 .../icmp/multi-diffip/00_Descriptions.txt     |  56 --
 .../network/stress/icmp/multi-diffip/Makefile |  29 -
 .../icmp/multi-diffip/icmp4-multi-diffip01    | 378 ----------
 .../icmp/multi-diffip/icmp4-multi-diffip02    |  66 --
 .../icmp/multi-diffip/icmp4-multi-diffip03    |  67 --
 .../icmp/multi-diffip/icmp4-multi-diffip04    |  66 --
 .../icmp/multi-diffip/icmp4-multi-diffip05    |  67 --
 .../icmp/multi-diffip/icmp4-multi-diffip06    |  67 --
 .../icmp/multi-diffip/icmp4-multi-diffip07    |  66 --
 .../icmp/multi-diffip/icmp6-multi-diffip01    |  56 --
 .../icmp/multi-diffip/icmp6-multi-diffip02    |  66 --
 .../icmp/multi-diffip/icmp6-multi-diffip03    |  67 --
 .../icmp/multi-diffip/icmp6-multi-diffip04    |  66 --
 .../icmp/multi-diffip/icmp6-multi-diffip05    |  67 --
 .../icmp/multi-diffip/icmp6-multi-diffip06    |  67 --
 .../icmp/multi-diffip/icmp6-multi-diffip07    |  66 --
 .../icmp/multi-diffnic/00_Descriptions.txt    |  56 --
 .../stress/icmp/multi-diffnic/Makefile        |  29 -
 .../icmp/multi-diffnic/icmp4-multi-diffnic01  | 301 --------
 .../icmp/multi-diffnic/icmp4-multi-diffnic02  |  66 --
 .../icmp/multi-diffnic/icmp4-multi-diffnic03  |  67 --
 .../icmp/multi-diffnic/icmp4-multi-diffnic04  |  66 --
 .../icmp/multi-diffnic/icmp4-multi-diffnic05  |  67 --
 .../icmp/multi-diffnic/icmp4-multi-diffnic06  |  67 --
 .../icmp/multi-diffnic/icmp4-multi-diffnic07  |  66 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic01  |  56 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic02  |  66 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic03  |  67 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic04  |  66 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic05  |  67 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic06  |  67 --
 .../icmp/multi-diffnic/icmp6-multi-diffnic07  |  66 --
 .../stress/ns-tools/00_Descriptions.txt       |  68 --
 testcases/network/stress/ns-tools/Makefile    |   7 +-
 .../network/stress/ns-tools/add_ipv6addr      |  93 ---
 .../network/stress/ns-tools/check_envval      |  88 ---
 .../stress/ns-tools/check_icmpv4_connectivity |  70 --
 .../stress/ns-tools/check_icmpv6_connectivity |  71 --
 testcases/network/stress/ns-tools/check_netem |  73 --
 .../network/stress/ns-tools/check_setkey      |  66 --
 .../network/stress/ns-tools/find_portbundle   | 128 ----
 testcases/network/stress/ns-tools/get_ifname  | 103 ---
 .../network/stress/ns-tools/initialize_if     |  89 ---
 .../stress/ns-tools/killall_icmp_traffic      |  83 ---
 .../stress/ns-tools/killall_tcp_traffic       | 102 ---
 .../stress/ns-tools/killall_udp_traffic       | 101 ---
 .../network/stress/ns-tools/ns-echoclient     | 140 ----
 .../stress/ns-tools/ns-icmpv4_sender.c        | 622 -----------------
 .../network/stress/ns-tools/ns-tcpclient.c    | 346 ----------
 .../network/stress/ns-tools/ns-tcpserver.c    | 650 ------------------
 .../network/stress/ns-tools/ns-udpclient.c    | 346 ----------
 .../network/stress/ns-tools/ns-udpserver.c    | 375 ----------
 .../network/stress/ns-tools/output_ipsec_conf | 172 -----
 .../network/stress/ns-tools/set_ipv4addr      |  95 ---
 .../network/stress/route/00_Descriptions.txt  |   6 -
 testcases/network/stress/route/route4-rmmod   | 283 --------
 testcases/network/stress/route/route6-rmmod   | 279 --------
 testcases/network/stress/tcp/Makefile         |   5 +-
 .../tcp/multi-diffip/00_Descriptions.txt      | 125 ----
 .../network/stress/tcp/multi-diffip/Makefile  |  29 -
 .../tcp/multi-diffip/tcp4-multi-diffip01      | 450 ------------
 .../tcp/multi-diffip/tcp4-multi-diffip02      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip03      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip04      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip05      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip06      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip07      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip08      |  64 --
 .../tcp/multi-diffip/tcp4-multi-diffip09      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip10      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip11      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip12      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip13      |  70 --
 .../tcp/multi-diffip/tcp4-multi-diffip14      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip01      |  64 --
 .../tcp/multi-diffip/tcp6-multi-diffip02      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip03      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip04      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip05      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip06      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip07      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip08      |  64 --
 .../tcp/multi-diffip/tcp6-multi-diffip09      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip10      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip11      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip12      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip13      |  70 --
 .../tcp/multi-diffip/tcp6-multi-diffip14      |  70 --
 .../tcp/multi-diffnic/00_Descriptions.txt     | 125 ----
 .../network/stress/tcp/multi-diffnic/Makefile |  29 -
 .../tcp/multi-diffnic/tcp4-multi-diffnic01    | 383 -----------
 .../tcp/multi-diffnic/tcp4-multi-diffnic02    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic03    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic04    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic05    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic06    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic07    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic08    |  64 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic09    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic10    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic11    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic12    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic13    |  70 --
 .../tcp/multi-diffnic/tcp4-multi-diffnic14    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic01    |  64 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic02    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic03    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic04    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic05    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic06    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic07    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic08    |  64 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic09    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic10    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic11    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic12    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic13    |  70 --
 .../tcp/multi-diffnic/tcp6-multi-diffnic14    |  70 --
 .../tcp/multi-diffport/00_Descriptions.txt    | 125 ----
 .../stress/tcp/multi-diffport/Makefile        |  29 -
 .../tcp/multi-diffport/tcp4-multi-diffport01  | 382 ----------
 .../tcp/multi-diffport/tcp4-multi-diffport02  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport03  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport04  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport05  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport06  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport07  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport08  |  64 --
 .../tcp/multi-diffport/tcp4-multi-diffport09  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport10  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport11  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport12  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport13  |  70 --
 .../tcp/multi-diffport/tcp4-multi-diffport14  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport01  |  64 --
 .../tcp/multi-diffport/tcp6-multi-diffport02  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport03  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport04  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport05  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport06  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport07  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport08  |  64 --
 .../tcp/multi-diffport/tcp6-multi-diffport09  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport10  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport11  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport12  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport13  |  70 --
 .../tcp/multi-diffport/tcp6-multi-diffport14  |  70 --
 .../tcp/multi-sameport/00_Descriptions.txt    | 125 ----
 .../stress/tcp/multi-sameport/Makefile        |  29 -
 .../tcp/multi-sameport/tcp4-multi-sameport01  | 381 ----------
 .../tcp/multi-sameport/tcp4-multi-sameport02  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport03  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport04  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport05  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport06  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport07  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport08  |  64 --
 .../tcp/multi-sameport/tcp4-multi-sameport09  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport10  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport11  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport12  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport13  |  70 --
 .../tcp/multi-sameport/tcp4-multi-sameport14  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport01  |  64 --
 .../tcp/multi-sameport/tcp6-multi-sameport02  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport03  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport04  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport05  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport06  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport07  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport08  |  64 --
 .../tcp/multi-sameport/tcp6-multi-sameport09  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport10  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport11  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport12  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport13  |  70 --
 .../tcp/multi-sameport/tcp6-multi-sameport14  |  70 --
 .../stress/tcp/uni-basic/00_Descriptions.txt  | 124 ----
 .../network/stress/tcp/uni-basic/Makefile     |  29 -
 .../stress/tcp/uni-basic/tcp4-uni-basic01     | 529 --------------
 .../stress/tcp/uni-basic/tcp4-uni-basic02     |  67 --
 .../stress/tcp/uni-basic/tcp4-uni-basic03     |  67 --
 .../stress/tcp/uni-basic/tcp4-uni-basic04     |  67 --
 .../stress/tcp/uni-basic/tcp4-uni-basic05     |  67 --
 .../stress/tcp/uni-basic/tcp4-uni-basic06     |  67 --
 .../stress/tcp/uni-basic/tcp4-uni-basic07     |  67 --
 .../stress/tcp/uni-basic/tcp4-uni-basic08     |  61 --
 .../stress/tcp/uni-basic/tcp4-uni-basic09     |  68 --
 .../stress/tcp/uni-basic/tcp4-uni-basic10     |  68 --
 .../stress/tcp/uni-basic/tcp4-uni-basic11     |  68 --
 .../stress/tcp/uni-basic/tcp4-uni-basic12     |  68 --
 .../stress/tcp/uni-basic/tcp4-uni-basic13     |  68 --
 .../stress/tcp/uni-basic/tcp4-uni-basic14     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic01     |  61 --
 .../stress/tcp/uni-basic/tcp6-uni-basic02     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic03     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic04     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic05     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic06     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic07     |  68 --
 .../stress/tcp/uni-basic/tcp6-uni-basic08     |  62 --
 .../stress/tcp/uni-basic/tcp6-uni-basic09     |  69 --
 .../stress/tcp/uni-basic/tcp6-uni-basic10     |  69 --
 .../stress/tcp/uni-basic/tcp6-uni-basic11     |  69 --
 .../stress/tcp/uni-basic/tcp6-uni-basic12     |  69 --
 .../stress/tcp/uni-basic/tcp6-uni-basic13     |  69 --
 .../stress/tcp/uni-basic/tcp6-uni-basic14     |  69 --
 .../tcp/uni-dsackoff/00_Descriptions.txt      | 126 ----
 .../network/stress/tcp/uni-dsackoff/Makefile  |  29 -
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff01      |  81 ---
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff02      |  67 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff03      |  67 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff04      |  67 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff05      |  67 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff06      |  67 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff07      |  67 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff08      |  61 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff09      |  68 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff10      |  68 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff11      |  68 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff12      |  68 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff13      |  68 --
 .../tcp/uni-dsackoff/tcp4-uni-dsackoff14      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff01      |  61 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff02      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff03      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff04      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff05      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff06      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff07      |  68 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff08      |  62 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff09      |  69 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff10      |  69 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff11      |  69 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff12      |  69 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff13      |  69 --
 .../tcp/uni-dsackoff/tcp6-uni-dsackoff14      |  69 --
 .../tcp/uni-pktlossdup/00_Descriptions.txt    | 125 ----
 .../stress/tcp/uni-pktlossdup/Makefile        |  29 -
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup01  |  78 ---
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup02  |  67 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup03  |  67 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup04  |  67 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup05  |  67 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup06  |  67 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup07  |  67 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup08  |  61 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup09  |  68 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup10  |  68 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup11  |  68 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup12  |  68 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup13  |  68 --
 .../tcp/uni-pktlossdup/tcp4-uni-pktlossdup14  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup01  |  61 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup02  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup03  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup04  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup05  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup06  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup07  |  68 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup08  |  62 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup09  |  69 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup10  |  69 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup11  |  69 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup12  |  69 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup13  |  69 --
 .../tcp/uni-pktlossdup/tcp6-uni-pktlossdup14  |  69 --
 .../tcp/uni-sackoff/00_Descriptions.txt       | 126 ----
 .../network/stress/tcp/uni-sackoff/Makefile   |  29 -
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff01 |  84 ---
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff02 |  67 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff03 |  67 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff04 |  67 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff05 |  67 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff06 |  67 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff07 |  67 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff08 |  61 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff09 |  68 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff10 |  68 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff11 |  68 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff12 |  68 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff13 |  68 --
 .../stress/tcp/uni-sackoff/tcp4-uni-sackoff14 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff01 |  61 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff02 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff03 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff04 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff05 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff06 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff07 |  68 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff08 |  62 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff09 |  69 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff10 |  69 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff11 |  69 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff12 |  69 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff13 |  69 --
 .../stress/tcp/uni-sackoff/tcp6-uni-sackoff14 |  69 --
 .../tcp/uni-smallsend/00_Descriptions.txt     | 124 ----
 .../network/stress/tcp/uni-smallsend/Makefile |  29 -
 .../tcp/uni-smallsend/tcp4-uni-smallsend01    |  75 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend02    |  67 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend03    |  67 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend04    |  67 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend05    |  67 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend06    |  67 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend07    |  67 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend08    |  62 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend09    |  68 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend10    |  68 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend11    |  68 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend12    |  68 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend13    |  68 --
 .../tcp/uni-smallsend/tcp4-uni-smallsend14    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend01    |  61 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend02    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend03    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend04    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend05    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend06    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend07    |  68 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend08    |  62 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend09    |  69 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend10    |  69 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend11    |  69 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend12    |  69 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend13    |  69 --
 .../tcp/uni-smallsend/tcp6-uni-smallsend14    |  69 --
 .../stress/tcp/uni-tso/00_Descriptions.txt    | 125 ----
 testcases/network/stress/tcp/uni-tso/Makefile |  29 -
 .../network/stress/tcp/uni-tso/tcp4-uni-tso01 |  78 ---
 .../network/stress/tcp/uni-tso/tcp4-uni-tso02 |  67 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso03 |  67 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso04 |  67 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso05 |  67 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso06 |  67 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso07 |  67 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso08 |  61 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso09 |  68 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso10 |  68 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso11 |  68 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso12 |  68 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso13 |  68 --
 .../network/stress/tcp/uni-tso/tcp4-uni-tso14 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso01 |  61 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso02 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso03 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso04 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso05 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso06 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso07 |  68 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso08 |  62 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso09 |  69 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso10 |  69 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso11 |  69 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso12 |  69 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso13 |  69 --
 .../network/stress/tcp/uni-tso/tcp6-uni-tso14 |  69 --
 .../tcp/uni-winscale/00_Descriptions.txt      | 124 ----
 .../network/stress/tcp/uni-winscale/Makefile  |  30 -
 .../tcp/uni-winscale/tcp4-uni-winscale01      |  75 --
 .../tcp/uni-winscale/tcp4-uni-winscale02      |  67 --
 .../tcp/uni-winscale/tcp4-uni-winscale03      |  67 --
 .../tcp/uni-winscale/tcp4-uni-winscale04      |  67 --
 .../tcp/uni-winscale/tcp4-uni-winscale05      |  67 --
 .../tcp/uni-winscale/tcp4-uni-winscale06      |  68 --
 .../tcp/uni-winscale/tcp4-uni-winscale07      |  67 --
 .../tcp/uni-winscale/tcp4-uni-winscale08      |  61 --
 .../tcp/uni-winscale/tcp4-uni-winscale09      |  68 --
 .../tcp/uni-winscale/tcp4-uni-winscale10      |  68 --
 .../tcp/uni-winscale/tcp4-uni-winscale11      |  68 --
 .../tcp/uni-winscale/tcp4-uni-winscale12      |  68 --
 .../tcp/uni-winscale/tcp4-uni-winscale13      |  68 --
 .../tcp/uni-winscale/tcp4-uni-winscale14      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale01      |  61 --
 .../tcp/uni-winscale/tcp6-uni-winscale02      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale03      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale04      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale05      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale06      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale07      |  68 --
 .../tcp/uni-winscale/tcp6-uni-winscale08      |  62 --
 .../tcp/uni-winscale/tcp6-uni-winscale09      |  69 --
 .../tcp/uni-winscale/tcp6-uni-winscale10      |  69 --
 .../tcp/uni-winscale/tcp6-uni-winscale11      |  69 --
 .../tcp/uni-winscale/tcp6-uni-winscale12      |  69 --
 .../tcp/uni-winscale/tcp6-uni-winscale13      |  69 --
 .../tcp/uni-winscale/tcp6-uni-winscale14      |  69 --
 testcases/network/stress/udp/Makefile         |   5 +-
 .../udp/multi-diffip/00_Descriptions.txt      |  56 --
 .../network/stress/udp/multi-diffip/Makefile  |  29 -
 .../udp/multi-diffip/udp4-multi-diffip01      | 418 -----------
 .../udp/multi-diffip/udp4-multi-diffip02      |  66 --
 .../udp/multi-diffip/udp4-multi-diffip03      |  67 --
 .../udp/multi-diffip/udp4-multi-diffip04      |  66 --
 .../udp/multi-diffip/udp4-multi-diffip05      |  67 --
 .../udp/multi-diffip/udp4-multi-diffip06      |  67 --
 .../udp/multi-diffip/udp4-multi-diffip07      |  66 --
 .../udp/multi-diffip/udp6-multi-diffip01      |  56 --
 .../udp/multi-diffip/udp6-multi-diffip02      |  66 --
 .../udp/multi-diffip/udp6-multi-diffip03      |  67 --
 .../udp/multi-diffip/udp6-multi-diffip04      |  66 --
 .../udp/multi-diffip/udp6-multi-diffip05      |  67 --
 .../udp/multi-diffip/udp6-multi-diffip06      |  67 --
 .../udp/multi-diffip/udp6-multi-diffip07      |  66 --
 .../udp/multi-diffnic/00_Descriptions.txt     |  56 --
 .../network/stress/udp/multi-diffnic/Makefile |  29 -
 .../udp/multi-diffnic/udp4-multi-diffnic01    | 350 ----------
 .../udp/multi-diffnic/udp4-multi-diffnic02    |  66 --
 .../udp/multi-diffnic/udp4-multi-diffnic03    |  67 --
 .../udp/multi-diffnic/udp4-multi-diffnic04    |  66 --
 .../udp/multi-diffnic/udp4-multi-diffnic05    |  67 --
 .../udp/multi-diffnic/udp4-multi-diffnic06    |  67 --
 .../udp/multi-diffnic/udp4-multi-diffnic07    |  66 --
 .../udp/multi-diffnic/udp6-multi-diffnic01    |  56 --
 .../udp/multi-diffnic/udp6-multi-diffnic02    |  66 --
 .../udp/multi-diffnic/udp6-multi-diffnic03    |  67 --
 .../udp/multi-diffnic/udp6-multi-diffnic04    |  66 --
 .../udp/multi-diffnic/udp6-multi-diffnic05    |  67 --
 .../udp/multi-diffnic/udp6-multi-diffnic06    |  67 --
 .../udp/multi-diffnic/udp6-multi-diffnic07    |  66 --
 .../udp/multi-diffport/00_Descriptions.txt    |  56 --
 .../stress/udp/multi-diffport/Makefile        |  29 -
 .../udp/multi-diffport/udp4-multi-diffport01  | 343 ---------
 .../udp/multi-diffport/udp4-multi-diffport02  |  66 --
 .../udp/multi-diffport/udp4-multi-diffport03  |  67 --
 .../udp/multi-diffport/udp4-multi-diffport04  |  66 --
 .../udp/multi-diffport/udp4-multi-diffport05  |  67 --
 .../udp/multi-diffport/udp4-multi-diffport06  |  67 --
 .../udp/multi-diffport/udp4-multi-diffport07  |  66 --
 .../udp/multi-diffport/udp6-multi-diffport01  |  56 --
 .../udp/multi-diffport/udp6-multi-diffport02  |  66 --
 .../udp/multi-diffport/udp6-multi-diffport03  |  67 --
 .../udp/multi-diffport/udp6-multi-diffport04  |  66 --
 .../udp/multi-diffport/udp6-multi-diffport05  |  67 --
 .../udp/multi-diffport/udp6-multi-diffport06  |  67 --
 .../udp/multi-diffport/udp6-multi-diffport07  |  66 --
 .../stress/udp/uni-basic/00_Descriptions.txt  |  55 --
 .../network/stress/udp/uni-basic/Makefile     |  29 -
 .../stress/udp/uni-basic/udp4-uni-basic01     | 331 ---------
 .../stress/udp/uni-basic/udp4-uni-basic02     |  66 --
 .../stress/udp/uni-basic/udp4-uni-basic03     |  67 --
 .../stress/udp/uni-basic/udp4-uni-basic04     |  66 --
 .../stress/udp/uni-basic/udp4-uni-basic05     |  67 --
 .../stress/udp/uni-basic/udp4-uni-basic06     |  67 --
 .../stress/udp/uni-basic/udp4-uni-basic07     |  66 --
 .../stress/udp/uni-basic/udp6-uni-basic01     |  56 --
 .../stress/udp/uni-basic/udp6-uni-basic02     |  66 --
 .../stress/udp/uni-basic/udp6-uni-basic03     |  67 --
 .../stress/udp/uni-basic/udp6-uni-basic04     |  66 --
 .../stress/udp/uni-basic/udp6-uni-basic05     |  67 --
 .../stress/udp/uni-basic/udp6-uni-basic06     |  67 --
 .../stress/udp/uni-basic/udp6-uni-basic07     |  66 --
 455 files changed, 6 insertions(+), 36713 deletions(-)
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/Makefile
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip02
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip03
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip04
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip05
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip06
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip07
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip01
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip02
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip03
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip04
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip05
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip06
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip07
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/Makefile
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic02
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic03
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic04
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic05
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic06
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic07
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic01
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic02
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic03
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic04
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic05
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic06
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic07
 delete mode 100644 testcases/network/stress/ns-tools/add_ipv6addr
 delete mode 100644 testcases/network/stress/ns-tools/check_envval
 delete mode 100644 testcases/network/stress/ns-tools/check_icmpv4_connectivity
 delete mode 100644 testcases/network/stress/ns-tools/check_icmpv6_connectivity
 delete mode 100644 testcases/network/stress/ns-tools/check_netem
 delete mode 100644 testcases/network/stress/ns-tools/check_setkey
 delete mode 100644 testcases/network/stress/ns-tools/find_portbundle
 delete mode 100644 testcases/network/stress/ns-tools/get_ifname
 delete mode 100644 testcases/network/stress/ns-tools/initialize_if
 delete mode 100644 testcases/network/stress/ns-tools/killall_icmp_traffic
 delete mode 100644 testcases/network/stress/ns-tools/killall_tcp_traffic
 delete mode 100644 testcases/network/stress/ns-tools/killall_udp_traffic
 delete mode 100644 testcases/network/stress/ns-tools/ns-echoclient
 delete mode 100644 testcases/network/stress/ns-tools/ns-icmpv4_sender.c
 delete mode 100644 testcases/network/stress/ns-tools/ns-tcpclient.c
 delete mode 100644 testcases/network/stress/ns-tools/ns-tcpserver.c
 delete mode 100644 testcases/network/stress/ns-tools/ns-udpclient.c
 delete mode 100644 testcases/network/stress/ns-tools/ns-udpserver.c
 delete mode 100644 testcases/network/stress/ns-tools/output_ipsec_conf
 delete mode 100644 testcases/network/stress/ns-tools/set_ipv4addr
 delete mode 100644 testcases/network/stress/route/route4-rmmod
 delete mode 100644 testcases/network/stress/route/route6-rmmod
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/Makefile
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip02
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip03
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip04
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip05
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip06
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip07
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip08
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip09
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip10
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip11
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip12
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip13
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip14
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip01
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip02
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip03
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip04
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip05
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip06
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip07
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip08
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip09
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip10
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip11
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip12
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip13
 delete mode 100644 testcases/network/stress/tcp/multi-diffip/tcp6-multi-diffip14
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/Makefile
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic02
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic03
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic04
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic05
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic06
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic07
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic08
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic09
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic10
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic11
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic12
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic13
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic14
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic01
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic02
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic03
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic04
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic05
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic06
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic07
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic08
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic09
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic10
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic11
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic12
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic13
 delete mode 100644 testcases/network/stress/tcp/multi-diffnic/tcp6-multi-diffnic14
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/Makefile
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport02
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport03
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport04
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport05
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport06
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport07
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport08
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport09
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport10
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport11
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport12
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport13
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport14
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport01
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport02
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport03
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport04
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport05
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport06
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport07
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport08
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport09
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport10
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport11
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport12
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport13
 delete mode 100644 testcases/network/stress/tcp/multi-diffport/tcp6-multi-diffport14
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/Makefile
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport02
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport03
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport04
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport05
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport06
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport07
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport08
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport09
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport10
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport11
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport12
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport13
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport14
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport01
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport02
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport03
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport04
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport05
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport06
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport07
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport08
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport09
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport10
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport11
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport12
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport13
 delete mode 100644 testcases/network/stress/tcp/multi-sameport/tcp6-multi-sameport14
 delete mode 100644 testcases/network/stress/tcp/uni-basic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-basic/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic01
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic02
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic03
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic04
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic05
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic06
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic07
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic08
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic09
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic10
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic11
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic12
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic13
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp4-uni-basic14
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic01
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic02
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic03
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic04
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic05
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic06
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic07
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic08
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic09
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic10
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic11
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic12
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic13
 delete mode 100644 testcases/network/stress/tcp/uni-basic/tcp6-uni-basic14
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff01
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff02
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff03
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff04
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff05
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff06
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff07
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff08
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff09
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff10
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff11
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff12
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff13
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp4-uni-dsackoff14
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff01
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff02
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff03
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff04
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff05
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff06
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff07
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff08
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff09
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff10
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff11
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff12
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff13
 delete mode 100644 testcases/network/stress/tcp/uni-dsackoff/tcp6-uni-dsackoff14
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup01
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup02
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup03
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup04
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup05
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup06
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup07
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup08
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup09
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup10
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup11
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup12
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup13
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp4-uni-pktlossdup14
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup01
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup02
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup03
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup04
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup05
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup06
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup07
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup08
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup09
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup10
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup11
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup12
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup13
 delete mode 100644 testcases/network/stress/tcp/uni-pktlossdup/tcp6-uni-pktlossdup14
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff01
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff02
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff03
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff04
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff05
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff06
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff07
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff08
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff09
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff10
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff11
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff12
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff13
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp4-uni-sackoff14
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff01
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff02
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff03
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff04
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff05
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff06
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff07
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff08
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff09
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff10
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff11
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff12
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff13
 delete mode 100644 testcases/network/stress/tcp/uni-sackoff/tcp6-uni-sackoff14
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend01
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend02
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend03
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend04
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend05
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend06
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend07
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend08
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend09
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend10
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend11
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend12
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend13
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp4-uni-smallsend14
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend01
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend02
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend03
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend04
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend05
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend06
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend07
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend08
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend09
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend10
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend11
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend12
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend13
 delete mode 100644 testcases/network/stress/tcp/uni-smallsend/tcp6-uni-smallsend14
 delete mode 100644 testcases/network/stress/tcp/uni-tso/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-tso/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso01
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso02
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso03
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso04
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso05
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso06
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso07
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso08
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso09
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso10
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso11
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso12
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso13
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp4-uni-tso14
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso01
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso02
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso03
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso04
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso05
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso06
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso07
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso08
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso09
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso10
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso11
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso12
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso13
 delete mode 100644 testcases/network/stress/tcp/uni-tso/tcp6-uni-tso14
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/Makefile
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale01
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale02
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale03
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale04
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale05
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale06
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale07
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale08
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale09
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale10
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale11
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale12
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale13
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp4-uni-winscale14
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale01
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale02
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale03
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale04
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale05
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale06
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale07
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale08
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale09
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale10
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale11
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale12
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale13
 delete mode 100644 testcases/network/stress/tcp/uni-winscale/tcp6-uni-winscale14
 delete mode 100644 testcases/network/stress/udp/multi-diffip/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/multi-diffip/Makefile
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip02
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip03
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip04
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip05
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip06
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip07
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip01
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip02
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip03
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip04
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip05
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip06
 delete mode 100644 testcases/network/stress/udp/multi-diffip/udp6-multi-diffip07
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/Makefile
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic02
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic03
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic04
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic05
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic06
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic07
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic01
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic02
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic03
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic04
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic05
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic06
 delete mode 100644 testcases/network/stress/udp/multi-diffnic/udp6-multi-diffnic07
 delete mode 100644 testcases/network/stress/udp/multi-diffport/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/multi-diffport/Makefile
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport02
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport03
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport04
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport05
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport06
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp4-multi-diffport07
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport01
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport02
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport03
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport04
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport05
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport06
 delete mode 100644 testcases/network/stress/udp/multi-diffport/udp6-multi-diffport07
 delete mode 100644 testcases/network/stress/udp/uni-basic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/udp/uni-basic/Makefile
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic01
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic02
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic03
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic04
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic05
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic06
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp4-uni-basic07
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic01
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic02
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic03
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic04
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic05
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic06
 delete mode 100644 testcases/network/stress/udp/uni-basic/udp6-uni-basic07

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
