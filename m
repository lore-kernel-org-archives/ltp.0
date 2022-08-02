Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE2C00140
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 14:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F6823C92BD
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 16:53:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9F403C2FF1
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 16:53:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A9CF1A00251
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 16:53:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DE6B1FA4F;
 Tue,  2 Aug 2022 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659452027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0/0HEaiqeSIEcWF+fQuUnsJgSOcC4moxW3AcMTFV98=;
 b=fTIpZVI4V6++Ec0EtslHbQ2GICSSy0tCwIdFkRgG//FHTBQN1PQN0PH2xTgIl3jxlzjV7o
 uOrHKUO+OrjdanwVBVuQ9fPET4hMoMl3HZRxcvv/a1NFX0o7iN1Bs8jV2XBdGvhkg/JM41
 MVHcqWZQzOInbmXRp+ktt0IwQWtGKkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659452027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0/0HEaiqeSIEcWF+fQuUnsJgSOcC4moxW3AcMTFV98=;
 b=ssH2n+7yOfbjSUHiKmKv6TSjXuCD2lQjnR6CeVZPGfTEGt1NwM31NjEozq/i/TAQyJhtDt
 83Z7j/NUtvT9f7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8311813A8E;
 Tue,  2 Aug 2022 14:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LGqdH3s66WJaAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 02 Aug 2022 14:53:47 +0000
Date: Tue, 2 Aug 2022 16:55:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yuk66ELT2ugQFAlb@yuki>
References: <20220728114258.30832-1-mdoucha@suse.cz>
 <20220728114258.30832-2-mdoucha@suse.cz>
 <b2ff91ff-d65c-325c-c07e-18dcc5fe1805@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2ff91ff-d65c-325c-c07e-18dcc5fe1805@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_rod: Fail on directory change commands
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Beware that this patch will cause a lot of broken shell tests to fail.
> Another patchset fixing the incorrect ROD usage in shell tests is needed
> before merging this patch.

The only broken test I've found is du01.sh that does
"ROD_SILENT cd basedir" are there actually any other tests that does so?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
