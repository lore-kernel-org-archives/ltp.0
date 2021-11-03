Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C5C433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 14:48:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E16361058
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 14:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E16361058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 621653C72B5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 15:48:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C04B3C704D
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 15:48:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 190BB1A009B3
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 15:48:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5253C212C5;
 Wed,  3 Nov 2021 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635950896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GZFVqHFBwEqktVmnlvU2CYZ7l132YHx00xGHzjn0BIo=;
 b=p3G9q2y85dEVw5QaCr9Z2J3FyCh9R5TWNC7Q+bLKhyDtvyxyhh0vBCESptjRcxqye3kG3l
 2LdNE2WAN+DpZRBRdJlpn4bGkOoNV2b5EBsRd8oqLvUsCRXBubPooP5C0xZLiA2ZS6xfgv
 OhgiGh5qIOVro1urCj42lBYgrsDrh8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635950896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GZFVqHFBwEqktVmnlvU2CYZ7l132YHx00xGHzjn0BIo=;
 b=dA7DfsyY5fitl+l2W17GY/wYlXlnoKuXhJ8v5HpbhJihd5UZ5JjnYGvh4abljdM3BZTwXr
 bY39AlJbRSid4kCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3099513E03;
 Wed,  3 Nov 2021 14:48:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6CoACjChgmE6IQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 Nov 2021 14:48:16 +0000
Date: Wed, 3 Nov 2021 15:48:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYKhLrXVhCgTfNS4@pevik>
References: <20211027075615.19832-1-pvorel@suse.cz>
 <YYKeZRuVLat/xFuS@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYKeZRuVLat/xFuS@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ver_linux: Print filesystems
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

Hi Cyril,

> Hi!
> > +echo 'mounted filesystems (df):'
> > +df_opt=
> > +if ! (df -h 2>&1 | grep -i -q -e 'unknown option' -e 'invalid option'); then df_opt="$df_opt -h"; fi
> > +if ! (df -T 2>&1 | grep -i -q -e 'unknown option' -e 'invalid option'); then df_opt="$df_opt -T"; fi

> Uff that's ugly, can't we simply depend on df returning non-zero on
> invalid option?

On real HW (2 laptops with different linux distros) it fails for something else:
$ df -hT; echo $?
df: /run/user/1000/doc: Operation not permitted
1

If you want simpler form, I suggest
df -hT 2>/dev/null || df

instead of:
df -hT 2>/dev/null || df -h

Which version should I merge?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
