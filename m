Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA73C46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:38:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58093CCB19
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 11:38:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA773C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:38:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9931A2001AF
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:38:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A52D683D4;
 Tue, 10 Jan 2023 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673347114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgHYZsoEoDql5O7/b7aPBLV5ah6pHs3VfVhg5xhW4Ns=;
 b=MNNABVKJ+lxArWcsjW0TSiuMA74JNQT+AELO1BljRAaDYsTMrHCKI9RtuG92iZr2dS0Pdv
 kRfuURSRabv5GrDJ7pQjYKNpNTZR31OxcKQXv/Kxm9EX06sf+v/vSXZ3OIupgdTdXvaFw3
 8jEhNbvjmdaF7QOtryX2cXX+yUTUVYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673347114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgHYZsoEoDql5O7/b7aPBLV5ah6pHs3VfVhg5xhW4Ns=;
 b=sUL6TjFHR829j8/hReDDCpLWkcrWje8esUkHghgPzmUCoRK6M2mThBxuTKrfDkQND2408Y
 LcoLtauQ5TY5wYAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97ECE13338;
 Tue, 10 Jan 2023 10:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BMpYFilAvWOiXAAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 10 Jan 2023 10:38:33 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Jan 2023 16:08:30 +0530
Message-ID: <37195382.rXvGVjUE4X@localhost>
Organization: SUSE
In-Reply-To: <Y709W2qjGVFqvnvU@pevik>
References: <20230104100730.20425-1-pvorel@suse.cz> <874jsyiufl.fsf@suse.de>
 <Y709W2qjGVFqvnvU@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] github: Improve pull request template
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

On Tuesday, January 10, 2023 3:56:35 PM IST Petr Vorel wrote:
> Hi Richie, Avinesh,
> 
> thanks for your review.
> > Hello,
> 
> > Please merge.
> Before merge, are you ok with one more change?
> 
> Kind regards,
> Petr
> 
> +++ .github/pull_request_template.md
> @@ -9,6 +9,11 @@ We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list
>  * Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
>  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>  
> +* Commit message should be meaningful, following common style
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> +https://chris.beams.io/posts/git-commit/
+1 for the change, as long as the last url can be considered reliable. It already redirects to another website for me.

> +
>  * New code should follow Linux kernel coding style, see
>  https://www.kernel.org/doc/html/latest/process/coding-style.html.
>  You can run 'make check' or 'make check-foo' in the folder with modified code to check style and common errors.
> 


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
