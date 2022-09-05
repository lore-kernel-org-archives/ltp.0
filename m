Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E15ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 09:15:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1018B3CA95D
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 11:15:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D4D83CA6C7
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 11:15:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 693E720074C
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 11:15:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49AF5377F4;
 Mon,  5 Sep 2022 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662369331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gFcmTLs5lx3aGHEWwzZQK8rxKcPPSL/GPFSmInFXYWI=;
 b=h8f5Orih/SS7pfTdwifnyTufOQJ0At4YBKUSUinDGUehbE5yMdo5IyrtBJPlfdmgPIWhlq
 s+OoZq8sba8sYJXjU1V38+8xNSmnvt6vZiJwlEsPn2wmNAbS6pzEt4cZg+FfGozrthKPL1
 3+Bg5nY29AWSCAy4g+CZfhYQtQzg7Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662369331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gFcmTLs5lx3aGHEWwzZQK8rxKcPPSL/GPFSmInFXYWI=;
 b=8K+Zdly8VdyAxXPBAuEpjUiAV4g4MmAchdTmseEDBx3nA284yL8Oj3/f+e1p4Q6ByJ7CEZ
 iz99DPl74HjJh6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CC90139C7;
 Mon,  5 Sep 2022 09:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id laCmADO+FWOiIgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 05 Sep 2022 09:15:31 +0000
Date: Mon, 5 Sep 2022 11:15:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Liang <xiliang@redhat.com>
Message-ID: <YxW+Mbb1KEy4qe16@pevik>
References: <20220905074330.24989-1-xiliang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905074330.24989-1-xiliang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] zram03: unload zram when it is loaded during
 test run
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xiao,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Indeed, test does not unload zram on older kernels without zram-control
interface. Good catch!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
