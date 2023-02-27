Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4873FC64ED8
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 14:44:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B92F13CBB99
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 15:44:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD2D73CBA5A
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 15:44:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0614D1A01972
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 15:44:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDFB31FD63;
 Mon, 27 Feb 2023 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677509046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=MCXe6fzA1gZJ+HqdRfkUrqttzPNXDHjmfvoRuJVQANc=;
 b=XcAH4FINysjPLxyoEAfX5aqpImDn4PWgs4hAG+/Q6cnTSeG1jWw4W6RQPd1c7viXwRW7Eo
 vRzin6ZWxfam8/EO0syz80+ErgZ+4IxA++xZ0dQa0cUoPZtE94blNU4n5JyzNs0OfVbRf8
 pjF8m7mbpn3JnlAcjkT1DrImNeWg0Iw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22F7213A43;
 Mon, 27 Feb 2023 14:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dWGrNrXB/GMrEgAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 27 Feb 2023 14:44:05 +0000
Date: Mon, 27 Feb 2023 09:44:02 -0500
To: rpalethorpe@suse.com
Message-ID: <20230227144402.GA23697@localhost>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Question on .needs_cgroup_ctrls for cgroupv2
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard

How to setup correct test case for cgroupv2 check? I try to put following parameter but failed.

struct tst_test test = {
	...
        .needs_cgroup_ctrls = (const char *const []){ "unified", NULL },
        .needs_cgroup_ver = TST_CG_V2,
};


After some investigation i found cgroup_find_ctrl which called by tst_cg_require seems not implement 
how to check cgroupv2, the controllers has no "unified" memeber, should we add CGROUP_CTRL_MEMBER("unified", xxx)
into controllers?  Correct me if any misunderstanding.


void tst_cg_require(const char *const ctrl_name,
                        const struct tst_cg_opts *options)
{
        struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);


Thanks.
Regards
Gao Wei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
