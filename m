Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C87C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:29:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613223C9338
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 11:29:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18FB43C6574
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:28:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6ADE110011DB
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:28:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7BD71F7AC;
 Fri, 25 Mar 2022 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648204138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=68vRZKcWjnjprE9BgbsErDiDqkJ8xsLYjVIKVoun34U=;
 b=cGTmjPpbVxGbb1yl1ZHiiAQvfutc5GV8hJS98ykU2c547YGGF1OoGGzTZBu0JhO3/eumbz
 nyX3i8f9Eomu8P5ZRlcv46ErBuq1+sAP9VuXt/YyekDR+6HRHE6GPqvlmLKAlQ1TTg5nq1
 hV1YzQL1Te1e3IyfrjgsJdFYZn7xS6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648204138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=68vRZKcWjnjprE9BgbsErDiDqkJ8xsLYjVIKVoun34U=;
 b=K9+uT6XwrzVJ0edIwos3oIlcHItFfh5lozFE2konCh9qy8DiRrVnISuDAtNZPxovyoRexg
 4hCg+TYC893m1EDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86ED81332D;
 Fri, 25 Mar 2022 10:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y4ZkH2qZPWKcHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 10:28:58 +0000
Date: Fri, 25 Mar 2022 11:28:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <Yj2ZaI7PledNS3Fu@pevik>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
 <20220325093626.11114-3-andrea.cervesato@suse.de>
 <Yj2ZLWhtH46xBcOT@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yj2ZLWhtH46xBcOT@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/9] Rewrite userns02.c using new LTP API
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

Lol, added my tag twice, sorry :).

Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
