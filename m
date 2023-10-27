Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE47DC25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 11:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF56B3CEB92
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 13:57:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAE633C9A19
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 13:57:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06A151001268
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 13:57:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FF651F86C;
 Fri, 27 Oct 2023 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698407857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6h6oZ+sRHDMZpIVwu5Zy8HV3sUpu42SK2cgpD/+430=;
 b=WEJ22m+mB1R1jc7IgpWD90bjhxIaqtQH+YBrSpxbRizyvcnf/Cs3XYI1v4xLR+9+VlFndL
 dTmSkscaHUnA3s8dZneod7WcWl+0QhikJqq+WeoSEGjC03YNvrbFnCiuPPB+IeNdJ26Sna
 PrM+yltKqgGZGEAJl5kp3mmXZqGc+no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698407857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6h6oZ+sRHDMZpIVwu5Zy8HV3sUpu42SK2cgpD/+430=;
 b=ZtH67zWcms+mv2M00b0gZNM8OmOUKKSwUsXzfgOpJ+o5FxMyQR7RDvRAf5U+n/heMrIoHw
 zugs4UBst64spACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCC5013524;
 Fri, 27 Oct 2023 11:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K6CjCK+lO2VKLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 27 Oct 2023 11:57:35 +0000
Date: Fri, 27 Oct 2023 13:58:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZTulylBTt01VNnOL@yuki>
References: <20230718100050.1162482-1-pvorel@suse.cz>
 <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
 <20230719101225.GB1221211@pevik>
 <CAEemH2esxksDg1NznrCW4QKO3NvEFUENWVcc4s-jf+Yk1-_RHw@mail.gmail.com>
 <20230720094343.GA1300426@pevik>
 <CAEemH2fbuqyT3Crdv_9vhf56BkxpNj_3TB76z8+_8vh5Yfu+wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fbuqyT3Crdv_9vhf56BkxpNj_3TB76z8+_8vh5Yfu+wQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.53 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.93)[99.71%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > LGTM, would you mind to send it as a follow up to my patch, as an
> > additional
> > cleanup?
> >
> 
> Yes, sure.

@Peter since there is going to be follow up patch, feel free to push the
original patch with my Reviewed-by:

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
