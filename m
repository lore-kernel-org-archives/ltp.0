Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A3C4321E
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 14:01:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 775843CC436
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 15:01:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BD573CC3CA
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 15:01:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F20D3641F8D
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 15:01:32 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B92361F8D7;
 Fri,  2 Dec 2022 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669989691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yqmgQRKupwQi0lOIi9kb53YgtiKvUXbsDO39LklCic=;
 b=Qc8Jn2f1e0TR4V4qfxfhKwcVb+nlpPKdziKQhOIY/7TBermf5xKHT0hvz2fg+JxG75RQXw
 SdBBwf23SHQXxbzNnmTqHOaNM4G7iQXjdzc5fy4uy38RcmGLSZDxG4RKjxu3tmpaFKR5An
 bpWLIkrhwap7EfyjgNbfL7m+IxyVZd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669989691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yqmgQRKupwQi0lOIi9kb53YgtiKvUXbsDO39LklCic=;
 b=czlcYcZ/09zhIMONRO9LvYgYpkVrLUxKmNGcg9YLNqhf6Y3tubJw0ZwFDA0DntDwraMwyV
 zk5Tn7PUUR0Ev7Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 80DE813644;
 Fri,  2 Dec 2022 14:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id UA2vHDsFimOFXgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 02 Dec 2022 14:01:31 +0000
Date: Fri, 2 Dec 2022 15:01:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y4oFOSgPd+2lxVWx@pevik>
References: <20221202103011.12206-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221202103011.12206-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add runltp-ng to upstream
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

Hi Andrea,

> runltp-ng is the next generation runner for Linux Testing Project and it
> will replace the current obsolete runltp script in the next future.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .gitmodules     | 3 +++
>  tools/runltp-ng | 1 +
>  2 files changed, 4 insertions(+)
>  create mode 160000 tools/runltp-ng

> diff --git a/.gitmodules b/.gitmodules
> index a3c34af4b..e85fc6279 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -4,3 +4,6 @@
>  [submodule "tools/sparse/sparse-src"]
>  	path = tools/sparse/sparse-src
>  	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> +[submodule "tools/runltp-ng"]
> +	path = tools/runltp-ng
> +	url = https://github.com/acerv/runltp-ng
> diff --git a/tools/runltp-ng b/tools/runltp-ng
> new file mode 160000
> index 000000000..b08471158
> --- /dev/null
> +++ b/tools/runltp-ng
> @@ -0,0 +1 @@
> +Subproject commit b0847115891bd3dddbe920a716342917e7088379

Thank you for this submission! Finally we get close to adding runltp-ng :).

I've tested runltp-ng separately last few weeks, next week I'll do more testing
of b0847115891bd3dddbe920a716342917e7088379. BTW there are 2 more commits in
your master.

The integration: What I can see now is that it requires to run "git submodule
update --init" by user. Looking at tools/sparse/Makefile. sparse is specific
(not needed unless make check is evoked), therefore sparse is not installed if
not needed (make in tools/ does not init the submodule).

Maybe we could add in tools/Makefile add:
git submodule update --init runltp-ng/
That would update only runltp-ng submodule.

I suppose there is a reason to deliver the tool separately (without LTP),
e.g. separate development or used on systems, which use LTP built into distro
package (we already use it in SUSE this way). In that case I'd be for moving the
repo to LTP github (https://github.com/linux-test-project/runltp-ng).

We could also add it directly to LTP git repository (no submodule), because also
for the above case (packaging) is a simple solution using just single
repository: there could be two separated packages: ltp and runltp-ng.

Otherwise to be part of LTP git repository
add code directly to tools/runltp-ng/.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
