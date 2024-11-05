Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA2ED12690
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:42:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB9723D2101
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:42:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4073D1FCB
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:41:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C70991028546
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:41:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36C171FBEF;
 Tue,  5 Nov 2024 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730806913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYR/zUni931f/H5PLD0pMxQh6J+tlYeX6iQRWrztepo=;
 b=ibo+l+9SoAMR4yrK5a+e3/q2yH/omsycTA2rqkf17PsgP0j/3uFz7E/3COlHULW0MJUo22
 vWF9Q4WSfImWXH5VSjxf2uAM3i4Sv8702ZineOskoAEl/mTWMbL03iU6GvUl3SsPfKmEza
 9mp9pDXOBh6o39yY2wED1vt+NHHHG7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730806913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYR/zUni931f/H5PLD0pMxQh6J+tlYeX6iQRWrztepo=;
 b=8Q5GThqD0WIR+9gDjEmjN5vu53xcV7T4B6qGBc1jX51WiUfOc8Rg6Kl8Fsbpl4w0Y54f+s
 k6P8Ezo081GPuFCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730806913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYR/zUni931f/H5PLD0pMxQh6J+tlYeX6iQRWrztepo=;
 b=ibo+l+9SoAMR4yrK5a+e3/q2yH/omsycTA2rqkf17PsgP0j/3uFz7E/3COlHULW0MJUo22
 vWF9Q4WSfImWXH5VSjxf2uAM3i4Sv8702ZineOskoAEl/mTWMbL03iU6GvUl3SsPfKmEza
 9mp9pDXOBh6o39yY2wED1vt+NHHHG7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730806913;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYR/zUni931f/H5PLD0pMxQh6J+tlYeX6iQRWrztepo=;
 b=8Q5GThqD0WIR+9gDjEmjN5vu53xcV7T4B6qGBc1jX51WiUfOc8Rg6Kl8Fsbpl4w0Y54f+s
 k6P8Ezo081GPuFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 175F31394A;
 Tue,  5 Nov 2024 11:41:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uJ03BIEEKmeYaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 05 Nov 2024 11:41:53 +0000
Date: Tue, 5 Nov 2024 12:41:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241105114151.GA1576432@pevik>
References: <20241105052507.29630-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241105052507.29630-1-wegao@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Move cpuset_lib code to libs/ directory
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

Hi Wei,


First, this does not work [1].

1) LTP would depend on fts.h on musl:
Musl has missing fts.h dependency for HAVE_FTS_H:
2024-11-05T10:52:38.2449988Z CC libs/cpuset_lib/cpuinfo.o
2024-11-05T10:52:38.2681767Z libcpuset.c:32:10: fatal error: fts.h: No such file or directory

libcpuset is compiled on Musl only when fts.h is installed (not part of official
musl):
ifneq ($(HAVE_FTS_H),1)
	FILTER_OUT_DIRS += cpuset
endif
The new library would need to be compiled conditionally and
e.g. libcpuset being mandatory will break musl without

And anything which depends on this will need to have the same check (e.g. the
original cpuset02 patch [3]).

2) There are still some problems with the patchset, e.g. on Fedora, old Leap 42.2 and Ubuntu bionic

2024-11-05T10:53:18.7290696Z /usr/bin/ld: ../../lib/libltp.a: error adding symbols: file format not recognized
2024-11-05T10:53:18.7295116Z clang: error: linker command failed with exit code 1 (use -v to see invocation)

I haven't found what causes it.

3) Debian when cross compiling seqfaults
2024-11-05T10:54:35.2460053Z collect2: fatal error: ld terminated with signal 11 [Segmentation fault], core dumped
2024-11-05T10:54:35.2461039Z compilation terminated.
2024-11-05T10:54:35.2461847Z collect2: fatal error: ld terminated with signal 11 [Segmentation fault], core dumped

I suppose the same root cause as 2).

Some general tips for the patches:

1) Always push to your fork
It would save reviewers time if you push to your fork before sending a patch.
That would save me to do that and reviewers to look at the broken patch.

2) Describe the reason of the change in the commit message ("what" vs. "why")
I.e. *why* the change is needed is sometimes more important than to describe
what was *changed* [2].

3) Put common things together
I'm not sure if I move code to libs/ on it's own (without the patch which that
requires it [3]). And even if the change itself makes sense (maybe apply here as
a cleanup), it would be nice to post here the motivation (e.g. link of the
original patch). That's actually 2 (*why*). This people looking at your patches
to get the context). Sometimes it's worth to have it in the commit message,
here would be enough just to put link [3] below --- (note which will not be part
of the commit message).

4) very nit: it's nice to respect the credit (for new ideas) :)
Suggested-by: Petr Vorel <pvorel@suse.cz>

> ---
>  .../cpuset/cpuset_lib => include}/cpuset.h    |  0
>  .../bitmask.h => include/cpuset_bitmask.h     |  0
>  .../common.h => include/cpuset_common.h       |  0
>  .../cpuinfo.h => include/cpuset_cpuinfo.h     |  0
>  .../meminfo.h => include/cpuset_meminfo.h     |  0

You added 'cpuset_' prefix for headers. Good, but IMHO it should be 'libcpuset_' prefix.

We usually have 'tst_' or 'safe_' or 'lib' prefix for new code in include/*.
When I filter also config.h and vendored ujson library (which we obviously did
not want to change just to add the 'lib' prefix) there is not much left:

$ ls include/*.h |grep -v -e /tst_ -e /safe_ -e /lib -e /ujson -e /config.h
include/ipcmsg.h
include/ipcsem.h
include/parse_vdso.h
include/time64_variants.h

I wonder if we need whole cpuset_lib or just part. Moving just what is needed
into libs/ might have also solve fts.h dependency on musl.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/actions/runs/11682645742
[2] https://cbea.ms/git-commit/
[3] https://patchwork.ozlabs.org/project/ltp/patch/20240930135809.9300-1-wegao@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
