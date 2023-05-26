Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6307DC7EE23
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 14:28:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E25A3CE7A0
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 16:27:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7AE13C995F
 for <ltp@lists.linux.it>; Fri, 26 May 2023 16:27:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 523D7600D20
 for <ltp@lists.linux.it>; Fri, 26 May 2023 16:27:47 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D1801FD8E;
 Fri, 26 May 2023 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685111267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkupZFUyPSYAyyygMvhPgYhiigucsIWAQ0eZpYqTexE=;
 b=z5WWI/B3RKBTfhDuIlvfKijkCogKKjG5wKAnkFlbaVexHiGcC/IDGL3Wzvo2iBx+Wo376Q
 cdTvnqN52e3POguiprO8qMg5lQtK5YJvOc2vg+0NRRpACY86gAGakiMs/u6doH9PWEn/SH
 hwx87A6jjG621KRbh9BuR9CYh+C3Mpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685111267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkupZFUyPSYAyyygMvhPgYhiigucsIWAQ0eZpYqTexE=;
 b=RVJM5DmLIY8KbXNYB1Pvho3qTAB8XWzYkwllTyMWfsXWY2oc+17Nww9E7FVJ/2IMU8TddP
 ewQmLowLWzc/N9BA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 19648134AB;
 Fri, 26 May 2023 14:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id eA+RAuPBcGS7eAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 26 May 2023 14:27:47 +0000
Date: Fri, 26 May 2023 16:27:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it,
 Nicolai Stange <nstange@suse.de>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230526142745.GA813136@pevik>
References: <20230526133435.7369-1-mdoucha@suse.cz>
 <20230526133435.7369-3-mdoucha@suse.cz>
 <20230526140759.GA805411@pevik> <20230526141001.GA810612@pevik>
 <20230526141445.GB810612@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230526141445.GB810612@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/7] Add test for CVE 2021-3656
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Martin sent patch which fixed it.

I'm going to merge whole patchset.

Thanks!

Kind regards,
Petr

diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
index e6ff5e874..5d2e2ce37 100644
--- a/testcases/kernel/kvm/kvm_svm02.c
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -34,7 +34,7 @@ static void *vmsave_buf;
 static int guest_vmload(void)
 {
        asm (
-               "vmload\n"
+               "vmload %0\n"
                :
                : "a" (vmsave_buf)
        );
@@ -45,7 +45,7 @@ static int guest_vmload(void)
 static int guest_vmsave(void)
 {
        asm (
-               "vmsave\n"
+               "vmsave %0\n"
                :
                : "a" (vmsave_buf)
        );

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
