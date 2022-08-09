Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB74C19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 12:04:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20AC3C945E
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 14:04:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F41343C0294
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 14:04:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 506181A00819
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 14:04:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 822BF34E33;
 Tue,  9 Aug 2022 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660046685;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0m2UuwtImN9yByRWf2yw7pqM3D04ZMPSb7O7jZGA4b8=;
 b=ZycS707NlPNiWdUy5jyInGcTfqLvuP4tQwn7NTwRa8WJvC5fVXVY3m/UHT72TIGKCBfGh2
 FKS6PCMt1DaHHgkZULDLRQyiGey6odrSuxehajRrzO/2VxTkhr8sG4p/JXVAUOcJ/cmO53
 IgXknRoaFlOUAX96MRhZLs9kxleWEKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660046685;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0m2UuwtImN9yByRWf2yw7pqM3D04ZMPSb7O7jZGA4b8=;
 b=C+53NuOpr4yBaCAD9XLOWI9ElDI6E3MwK4nEUcEu6uyYuM2SDrbJ1NzJ/iWUGpeotrNZN5
 4ThK8bIrqrqPhFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63BBB13A9D;
 Tue,  9 Aug 2022 12:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kwFNFl1N8mIFBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 Aug 2022 12:04:45 +0000
Date: Tue, 9 Aug 2022 14:04:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YvJNW4okkn2OLK8d@pevik>
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-3-pvorel@suse.cz>
 <CAEemH2eZmemcmn1H3Gi6zpvr+a-tAZ38GFuGzXbWPM7uKCw-AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eZmemcmn1H3Gi6zpvr+a-tAZ38GFuGzXbWPM7uKCw-AQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] tst_ansi_color.sh: Allow to run with set -e
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On Mon, Aug 8, 2022 at 7:38 PM Petr Vorel <pvorel@suse.cz> wrote:

> > set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit
> > code, therefore any && must be turned into || (or if ...; then ..; fi).
> > Fix hardens tst_res TINFO to be able to be used on scripts with errexit.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > changes v2->v3:
> > * really fix it.

> >  testcases/lib/tst_ansi_color.sh | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)

> > diff --git a/testcases/lib/tst_ansi_color.sh
> > b/testcases/lib/tst_ansi_color.sh
> > index 703df1eb8..517b709d0 100644
> > --- a/testcases/lib/tst_ansi_color.sh
> > +++ b/testcases/lib/tst_ansi_color.sh
> > @@ -24,18 +24,19 @@ tst_flag2color()

> >  tst_color_enabled()
> >  {
> > -       [ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" = "0"
> > ] && return 0
> > -       [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1"
> > ] && return 1
> > +       [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]
> > || return 1
> > +       [ "$LTP_COLORIZE_OUTPUT" = "y" -o "$LTP_COLORIZE_OUTPUT" = "1" ]
> > || return 0

> This can work but looks a bit strange to read. I personally think
> use 'if ...; then ; fi' will be better to understand, because this is a
> simple function, no need to go with weird logic for over simplifying:).

Hi Li,

sure, I can reuse what I posted to as a suggestion to 3rd patch [1],
therefore I'll use it for these two:

if [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]; then
        return 0
fi

if [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ]; then
        return 1
fi

For the latter two I can use 'if ...' as well:

if [ "$color" = 1 ]; then
        tst_flag2color "$1"
fi
printf "$2"
if [ "$color" = 1 ]; then
        printf '\033[0m'
fi

although the original != 1 ] || is IMHO quite readable.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220808113756.11582-4-pvorel@suse.cz/

> >         [ -t 1 ] || return 0
> >         return 1
> >  }

> >  tst_print_colored()
> >  {
> > -       tst_color_enabled
> > -       local color=$?
> > +       local color=0

> > -       [ "$color" = "1" ] && tst_flag2color "$1"
> > +       tst_color_enabled || color=$?
> > +
> > +       [ "$color" != 1 ] || tst_flag2color "$1"
> >         printf "$2"
> > -       [ "$color" = "1" ] && printf '\033[0m'
> > +       [ "$color" != 1 ] || printf '\033[0m'
> >  }
> > --
> > 2.37.1


> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
