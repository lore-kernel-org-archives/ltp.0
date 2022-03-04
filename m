Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBEAC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 16:01:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79DD13CA3F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 17:01:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509473C0F5D
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 17:01:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59E571000B52
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 17:01:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34B9921124;
 Fri,  4 Mar 2022 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646409682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdMw5w2lkFlUVQL9x4tC8B/A0BYJEP8RBAaQ7ogwv6A=;
 b=UkhSqMiKMp/ZJkX4eQv1n8hkrFEIycRwkjYa7j6N35dO8z2gqn7zcrVHsIgJg4zeHNGv2d
 al8knKHvpfdCbLej1p3CrJ4M6vVDPpSWp67p002aXS7j4V8OhihY3wUod7uUsgs4sN7fGL
 OaBajj3yK7cOu1DRQJAr13m/c0HGRvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646409682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdMw5w2lkFlUVQL9x4tC8B/A0BYJEP8RBAaQ7ogwv6A=;
 b=21auWOPRkjOJp3ZxYLTXrE3vQyZ5nkdwSmhTufnK1WdwowpUvSrpXy8v5y4Dz+znS67hi5
 yHUONi8kDjumZbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07AC713B64;
 Fri,  4 Mar 2022 16:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v8O0OtE3ImK1PgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Mar 2022 16:01:21 +0000
Date: Fri, 4 Mar 2022 17:03:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YiI4XgwISfrk1BdP@yuki>
References: <20220303083429.3827302-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220303083429.3827302-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] migrate_pages02: check file exist before opening
 it
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
Cc: bgoncalv@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test reports a warning on some special kernel (with NUMA BALANCE
> disabling). The main reason is that prefix '?' makes tst_sys_conf_save
> only silent ignores non-exist paths. But seems we still open it in other
> places (e.g. in setup function).
> 
>   tst_sys_conf.c:58: TINFO: Path not found: '/proc/sys/kernel/numa_balancing'
>   tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
>   migrate_pages02.c:279: TWARN: Failed to open FILE '/proc/sys/kernel/numa_balancing'
>   migrate_pages02.c:317: TINFO: Using nodes: 0 1
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     Looks like we have many tests use the prefix '?' for knob save/restore,
>     but none of them check if the paths are valid when opening at other places,
>     by now, I just get informed that migrate_pages02 threw a warning.
>     
>     I'm thinking maybe we can keep the return value of tst_sys_conf_save
>     as a check condition before opening the file, but this is not fit for
>     test with many paths saving:
>     e.g.
>         add_key05.c-	"?/proc/sys/kernel/keys/gc_delay",
>         add_key05.c-	"?/proc/sys/kernel/keys/maxkeys",

Looking at the test we set these values to make the test run faster and
the test works fine even without these knobs, right?

Maybe we just need to enhance the .save_restore with another parameter;
a value to set the knob to if it does exists, so in add_key05.c it would
look like:

struct tst_path_val {
	const char *path;
	const char *val;
};

        .save_restore = (const struct tst_path_val const[]) {
                {"?/proc/sys/kernel/keys/gc_delay", "1"},
                {"?/proc/sys/kernel/keys/maxkeys", "200"},
                {"?/proc/sys/kernel/keys/maxbytes", "20000"}
                NULL,
        },

And in cases we do not need to set value we would just pass NULL as val...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
