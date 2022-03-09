Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48FCC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 19:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4859B3C698F
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 20:13:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D41F3C1FE9
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 20:13:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5693601374
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 20:13:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 966D11F381;
 Wed,  9 Mar 2022 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646853217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3e79+EBgRlWhw7iT2v46YRI9Sa7+1A7+qSCWx1V9fdE=;
 b=nhTcynkpywaf4p0HQ30ENazFnq0mfKkZZPCKI7S+bq/2vt0Wbp8Vz2+HGC/EKGluF3kKqS
 t9812awwtBVUNiFv2WfHiYuuxbTwgnlRHBIg4f0pCqwFkIo8kXXoqC9dmU1ZJFoF41KK9I
 QMMSJmhl6YIxW/eRuJ+a3fiJmGSd9/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646853217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3e79+EBgRlWhw7iT2v46YRI9Sa7+1A7+qSCWx1V9fdE=;
 b=osq69i7KgUg+JG/ghe25gPi5BKjEG0tAEosO5FwIoNMcQWu1OCCMExd59qqKfgaXjRg0uP
 07XC4dFS5tlP2jDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B27613D7C;
 Wed,  9 Mar 2022 19:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Mz9hGGH8KGI4QAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 09 Mar 2022 19:13:37 +0000
Date: Wed, 9 Mar 2022 20:13:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yij8XwFjK3Ua+jYA@pevik>
References: <20220309164954.23751-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220309164954.23751-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] KVM test infrastructure
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

Hi Martin,

this patchset looks really great.

Unfortunately there are some compilation time errors [1].
Various Debian/Ubuntu versions (but not all) and Alpine have problem to compile it [1]:
/usr/bin/ld: bootstrap_x86_64.o: relocation R_X86_64_16 against symbol `kvm_gdt32_desc' can not be used when making a PIE object; recompile with -fPIE

Can you please have look into it?

Kind regards,
Petr

[1] https://github.com/pevik/ltp/actions/runs/1959152447

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
