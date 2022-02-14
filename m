Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C62AC433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 10:41:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4ACB3C9FDC
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 11:40:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F08C83C9B49
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 11:40:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5AC721A000B9
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 11:40:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E47B1F38D;
 Mon, 14 Feb 2022 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644835247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xQ48Tn0KvQK+EP1xVb4c+5egW6IKXNZknnj1dIPiOs=;
 b=dyKx42rov/FRGO0mQqaaw1MoTe8q7kcTXew26zWvanR2tBdAmdSd6bq07p0HylTBj0WyT9
 x5O6CICcBoqS2mQW/ZFxpnrk704rW2UbIvviv7Q/dpDgjsYCkkPZIb63pEIHmmaSoFZCWk
 pBSaTXBUTmWgzrHcf/DVKvnZ4NcnUNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644835247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xQ48Tn0KvQK+EP1xVb4c+5egW6IKXNZknnj1dIPiOs=;
 b=WtAGDpA7KhDWT6niENh1SEcBXxa7+XpMh+W1a829B4HggaivTxlsu1JcSxGTXGBfNTWnKo
 JKIUPZ7kWoV3n6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43E4313AA7;
 Mon, 14 Feb 2022 10:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9VmCD68xCmKoSwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 14 Feb 2022 10:40:47 +0000
Message-ID: <078b0f84-a960-39a5-046c-79fa874daa25@suse.cz>
Date: Mon, 14 Feb 2022 11:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20220213042836.3028266-1-liwang@redhat.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220213042836.3028266-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup: allow child zombied for a
 while
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 13. 02. 22 5:28, Li Wang wrote:
> diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_tests/test_children_cleanup.sh
> index 4b4e8b2f0..ec1a0d4fe 100755
> --- a/lib/newlib_tests/test_children_cleanup.sh
> +++ b/lib/newlib_tests/test_children_cleanup.sh
> @@ -13,7 +13,13 @@ if [ "x$CHILD_PID" = "x" ]; then
>  elif ! kill -s 0 $CHILD_PID &>/dev/null; then
>  	echo "TPASS: Child process was cleaned up"
>  	exit 0
> +elif grep -q -E "Z|zombie" /proc/$CHILD_PID/status; then
> +       echo "TPASS: Child process was in zombie state"
> +       exit 0

We're in a race condition here either way so reading the status procfile
after checking whether the process still exists can result in failure
even when the child was properly killed. I wrongly believed that
`kill -s 0` would fail when the target process is a zombie because the
manpage vaguely suggests that (see the description of ESRCH errno in the
kill(2) manpage) but it turns out I was wrong again.

I'll send a fix myself later today.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
