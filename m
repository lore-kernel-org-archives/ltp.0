Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5C9C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 12:55:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607073C555B
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:55:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 875073C0BCC
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:54:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C06CC1A007E5
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:54:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00F4F212CA;
 Tue,  7 Dec 2021 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638881698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LDnk0LfrXNq2xBPJGp6WPeWmjvQBdp1EYqek7+HeTo=;
 b=xoz7AkoDoavs9+jiBdGIWk3Fx/mRrOt35JmsjsEeVIKvjT8zEZNdQ2iZkNAK0cXAhTEZJZ
 PccaoZ0mPDR+VOXim0XuTNQ5KbcSHqApKp3X9oFnxG1Rj9gDYhJ8N9qi4KDc7iKwlTjQ2d
 D6fO5KhYGj5ex+JRDl+L4h/YQCpKSGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638881698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LDnk0LfrXNq2xBPJGp6WPeWmjvQBdp1EYqek7+HeTo=;
 b=p+ut1YyMwSqA8m9DlEn6keZjnSPvaE+N3E5Tep6hN7Nwe/TDlCMWJZHwgsIty4b0cAWXOS
 jHf3mmEUD8r6DqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89DB213A78;
 Tue,  7 Dec 2021 12:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9yNjH6FZr2H+OgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Dec 2021 12:54:57 +0000
Date: Tue, 7 Dec 2021 13:56:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Ya9Z7ukjNryOs2vM@yuki>
References: <20211207114625.30495-1-andrea.cervesato@suse.com>
 <Ya9ZYCErHU/XqjLn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ya9ZYCErHU/XqjLn@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add tst_parse_filesize functionality in LTP
 test API
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
> > +	if (str == end || (strlen(end) != 0 && strlen(end) != 1))
> 
> No need for the strlen() here. what you do here is a fancy way of doing (!end[0] && !end[1]).

And of course it should be (end[0] && end[1]) that means that the string
is not terminated.

Or optionally (strlen(end) > 1) would work too.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
