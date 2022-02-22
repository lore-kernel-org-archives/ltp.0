Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18667C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 14:45:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC9043CA1BA
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 15:45:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20B953C97EB
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:45:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8052B6023D5
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 15:45:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C8A51F39D;
 Tue, 22 Feb 2022 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1645541112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylvuPtIO/EHY1EQpndBr3i6gZ4mdiq0nlK8G5GyVhDw=;
 b=ghu2c2O05dxLplKd31OkdZgzlJNqlmRZI8FIgzaYM431bL3+8X2J6D3p3A7coddQNeuyHl
 NgJe58Vbl4ZxLeZ8JaP1dV7fxapPLghedDUoThsBEoIJh+ude5Q+14ud4v9Lq7c086CN6G
 5qK3SaEyd0xMRD57B3177JmJ+cCb1wA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BB5813BC2;
 Tue, 22 Feb 2022 14:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZN+DIfj2FGJgDAAAMHmgww
 (envelope-from <mkoutny@suse.com>); Tue, 22 Feb 2022 14:45:12 +0000
Date: Tue, 22 Feb 2022 15:45:11 +0100
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <20220222144511.GA12037@blackbody.suse.cz>
References: <20220222124547.14396-1-rpalethorpe@suse.com>
 <20220222124547.14396-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222124547.14396-3-rpalethorpe@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] memcontrol04: Copy from kselftest
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello.

On Tue, Feb 22, 2022 at 12:45:47PM +0000, Richard Palethorpe <rpalethorpe@suse.com> wrote:
> + * "First, this test creates the following hierarchy:
> + * A       memory.low = 50M,  memory.max = 200M
> + * A/B     memory.low = 50M,  memory.current = 50M
> + * A/B/C   memory.low = 75M,  memory.current = 50M
> + * A/B/D   memory.low = 25M,  memory.current = 50M
> + * A/B/E   memory.low = 500M, memory.current = 0
> + * A/B/F   memory.low = 0,    memory.current = 50M
> + *
> + * Usages are pagecache
> + * Then it creates A/G and creates a significant
> + * memory pressure in it.
> + *
> + * A/B    memory.current ~= 50M
> + * A/B/C  memory.current ~= 33M
> + * A/B/D  memory.current ~= 17M
> + * A/B/E  memory.current ~= 0

This nicely misses the expected consumption of the F cgroup (I see it's
missing in the original too). But one can expect from complementarity
it's zero (if one accepts these values, which unfortunately is not true
with hierarchical & scaled reclaim protection).

> +		if (i < E || (i == F && tst_cg_memory_recursiveprot())) {
> +			TST_EXP_EXPR(low > 0,
> +				     "(%c low events=%ld) > 0", id, low);
> +		} else {
> +			TST_EXP_EXPR(low == 0,
> +				     "(%c low events=%ld) == 0", id, low);
> +		}

Despite this makes the test behavior consistent, I think this is
unexpected behavior with recursive_memoryprot. With the given
configuration, there should never be residual protection that F assumes.

Unless there is a good explanation [1], I'd consider non-zero
memory.events:low in F the test failure here.

Michal

[1] I will need to look into some more detailed tracing data.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
