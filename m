Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813ADC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 14:21:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87EC13C0932
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 15:21:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BD253C0932
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 15:20:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71539200743
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 15:20:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33BC41FE71;
 Mon, 30 Oct 2023 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698675657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Db9wcHmtvMCVdDKqU2jDSyGyPcRUTv+k/+xnebfx11o=;
 b=GLWYZBpK4Jn+p3Jmr6K21KOdW2JpLFGNqduANSROPP0Jg72+TXan+NZIqrRJQUf40HZXHj
 ZL3bLQBT8T6Y1xmelPE9CDaQmmyCiXjcvn5VNLCMZTA3qQvc0OKEN53obMMgVhmcZ5GyIw
 mcbn7PJ8p/fGUun9P+q69xzJPRkJ2TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698675657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Db9wcHmtvMCVdDKqU2jDSyGyPcRUTv+k/+xnebfx11o=;
 b=Zy+5qxJUuqVXO+iPVx7IpTJmL/n1vjAZq9lNUwKC65yoohPIhr28nbKygi4+3lMSbiRkO7
 Ci5Us1+tcswCUBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF193138F8;
 Mon, 30 Oct 2023 14:20:56 +0000 (UTC)
Received: from dovecot-director1.suse.de ([192.168.254.64])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0bA9OMi7P2U5PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 30 Oct 2023 14:20:56 +0000
Date: Mon, 30 Oct 2023 15:20:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231030142055.GA21733@pevik>
References: <20231027174322.710674-1-pvorel@suse.cz>
 <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
 <20231030072819.GA9167@pevik>
 <CAEemH2eUQxxQAh-Ln_hyzu_C_AL36fXsjbKZJqC3rcHsASgQgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eUQxxQAh-Ln_hyzu_C_AL36fXsjbKZJqC3rcHsASgQgQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Cc: Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > > -%_16: CPPFLAGS += -D$(DEF_16)=1

> > Not related to this effort: shouldn't we convert all CPPFLAGS to CFLAGS?
> > Or the
> > LTP build system it just prepared to the crazy ideas about using C++? :)


> No, I don't think so. I guess you memories it confused with CXXFLAGS :).

> FYI:

> CPPFLAGS (C PreProcessor Flags) are options for the C preprocessor,
> which is the first stage of compilation where macro substitution occurs,
> and conditional compilation directives are processed. These flags are often
> used to specify additional include directories.
>     e.g. CPPFLAGS="-I/some/include/path"

> CFLAGS (C Compiler Flags) are options for the C compiler. These
> flags are often used to specify various compiler settings, such as
> optimization level, warnings level, and debugging information.
>     e.g.  CFLAGS="-O2 -g -Wall"

> CXXFLAGS (C++ Compiler Flags) are options for the C++ compiler.
> It can be used to define options like optimization levels, debugging
> information, warning levels, and more.
>     e.g.  CXXFLAGS="-O2 -g -Wall"

Ah, you're right. Thanks!

> > > Seems we need to keep this one line, otherwise it can't transfer the
> > > 'TST_USE_COMPAT16_SYSCALL=1' macro in the compilation.

> > Ah, thanks!

> > > The rest looks good to me.
> > > Reviewed-by: Li Wang <liwang@redhat.com>

> > BTW I'm going to push it with you as an author + with your Signed-off-by:
> > tag
> > (you're effectively the autor of the code) and with my RBT.


> Sure, thanks for doing this for me.

Yw.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
