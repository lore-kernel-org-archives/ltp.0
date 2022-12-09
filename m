Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40419C4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 21:17:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9644C3CBFE6
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 22:17:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 476393CBFCA
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 22:17:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA6EC60012E
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 22:17:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5BE122BB8;
 Fri,  9 Dec 2022 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670620663;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pfj3JCbFy8HxloqO6wNkoyLL8yX1wKwvX3rFc/IPRPg=;
 b=V9AK3Z6wv4acm5Dd7N7GCfnkHI8p7TU7fQ4Smkc8j9xC+A8cDOjlt5JtdRYf79iicVIgAC
 56RF1lqlVhqWtVqtIFMbW1fi6Q6aj3zZW1prJibFHJ/E6gVcnITzGbOBKa+mpEaaKkRxLL
 foPmoNm1748ERJYRTXv3wLr7T1CUUiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670620663;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pfj3JCbFy8HxloqO6wNkoyLL8yX1wKwvX3rFc/IPRPg=;
 b=fEYu8id/8WtUsmbzNXwQkEFQBloIVv1TZmCSYv8r8FsHYbZ4Q3aZsuZqg//8N39CqZ8/pz
 z+fETMeidQZvaWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85169138E0;
 Fri,  9 Dec 2022 21:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 73UKH/elk2M/PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Dec 2022 21:17:43 +0000
Date: Fri, 9 Dec 2022 22:17:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Y5Ol9aYGsBOiYioQ@pevik>
References: <20221209141002.15551-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221209141002.15551-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ci: Add hook to mirror docparse to homepage
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Aleks L <aleksandrosansan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

...
> +          printf "metadata.nightly.html: Update to $commit\n\nUpdate metadata.nightly.html to $commit_desc\n" > /tmp/msg
> +          git commit -F /tmp/msg .
> +
> +          echo "::notice::GH_PERSONAL_ACCESS_TOKEN: $GH_PERSONAL_ACCESS_TOKEN"
> +          git push https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/linux-test-project/linux-test-project.github.com.git
I'll also add here:
echo "::notice::pushed $commit_desc"

So that it's obvious in github actions that commit was pushed.

Because github action does not allow to add exit code for "cancel"
- any non-zero exit code means failure:
https://docs.github.com/en/actions/creating-actions/setting-exit-codes-for-actions

"skip" due if: (e.g. if: ${{ github.repository == 'linux-test-project/ltp' }})
would allow it, but we have no way to exit like this.

Thus even nothing is pushed the result is always "green".

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
