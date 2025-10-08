Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2088CAC5BB
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 10:25:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61EDB3CE722
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 12:25:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60F713CD942
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 12:25:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29A241A009A4
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 12:25:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF81F33682;
 Wed,  8 Oct 2025 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759919128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6iOZ4dDfw28CQQ2wOnFVgLWeBCqkmE/KeE5sCMvG/k=;
 b=I1cwcnN4czhCnHJilpZxH8NcLkiLXFpSk66radOcheU6aqMbwKkf27/gguAk6rPHkCd6yi
 n5arVqF9g7Rurh+m+s7XBcksEze9rDrmvOxj5ZLUrjhtdty1sI1bGKn5NWgC+aR8qN6TSJ
 /MUPFsVmpMx9MrE960z3cSsvZgIK0kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759919128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6iOZ4dDfw28CQQ2wOnFVgLWeBCqkmE/KeE5sCMvG/k=;
 b=KC34J486YHNcoDLR5OTaQyvLsL2pL80q1gtpnvamuOQeFcdvU6I7MC4egQZ8h49kUhDytB
 XQ0UYwfWlTmI3WCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759919125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6iOZ4dDfw28CQQ2wOnFVgLWeBCqkmE/KeE5sCMvG/k=;
 b=Pd2MpxMyaZWibUfcL/HdvjRhmT5/rBo/6VWxtmQx3zxI6bZw/gfDtMxUrlKP/xvegkIw4d
 tuHU3s3I2edK8txBw/DvL2zEUK9wD4SaInKUkV1qA9sdsEtkIIzMv0QnNSAWZ39fcP3S3W
 iUMKTGdVPfxBSfGvm7gBQNsdYu8hiJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759919125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6iOZ4dDfw28CQQ2wOnFVgLWeBCqkmE/KeE5sCMvG/k=;
 b=QsUV4t8D2rwhd6d20gwSSxfrOvdg5HIUVKGbRwUgh2IJB24ip6W/7WAWUFroeMkEz8dF+R
 I98MdCh6dEub/kAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D652013A3D;
 Wed,  8 Oct 2025 10:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fzpeMxU85mixEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Oct 2025 10:25:25 +0000
Date: Wed, 8 Oct 2025 12:26:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aOY8SAGEklIur9eW@yuki.lan>
References: <20251007160516.145121-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007160516.145121-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email, gnu.org:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] fs: Remove acl/tacl_xattr.sh
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Old script which is not using LTP API, not in any runtest file.
> 
> It tests acl (getfacl, setfacl) and attr (getfattr, setfattr) tools, but
> both project have their own tests [1] [2]. LTP concentrates on kernel
> part of testing nowadays, therefore remove it.  Script is very simple
> that it does not have any benefit for upstream.
> 
> [1] https://cgit.git.savannah.gnu.org/cgit/acl.git/tree/test
> [2] https://cgit.git.savannah.gnu.org/cgit/attr.git/tree/test

While I agree that this is testing an userspace tools we do not have
much acl coverate in LTP, there seems to be some network nfsv4 tests but
that seems to be all. I guess that we should at least create an github
issue that we should write a few tests for that. I guess that writing a
simple test that sets up right extended attributes and expecte a file to
be accessible or not shouldn't be that hard.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
