Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C221BC433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 09:57:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE93E3CAAEE
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 11:57:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53DD03C021B
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:57:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E287B1401148
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652954229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FOPew7aG1Ja7rESXMWZLF8plr3szsIjr6SSb/AUqCc4=;
 b=GJxWgMw5VJwGaMZwbhw4qkkCR8jlMxWif6E6c4LfjlLJ7qfyFq7oVHi7u/sPMJ1VCBj9UQ
 PPCa8y9QgGDHuyDSakbTyMpnJjFrPPemImxvHpNb9JTMLhAwCDlW/mQOOiJLZqmVdyQeow
 RCWpOXX9v7DUsot9hJVQEWw14A9barQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-Qlt-EE4tNN6C_hKisB-6ow-1; Thu, 19 May 2022 05:57:08 -0400
X-MC-Unique: Qlt-EE4tNN6C_hKisB-6ow-1
Received: by mail-lf1-f69.google.com with SMTP id
 br24-20020a056512401800b00477cb7c9a9dso351025lfb.1
 for <ltp@lists.linux.it>; Thu, 19 May 2022 02:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FOPew7aG1Ja7rESXMWZLF8plr3szsIjr6SSb/AUqCc4=;
 b=gq755HZ3htqFLNHajKz68TUaM0GifUjid1X+IGC4jW5ZvDTW9nShxuZgD7c+Wyf6O2
 h2lDlmHICqAwMepU431rQZ3/prnmULxukiWytgRbabF5BIdA5bM7sU5FBeWOmG94f4CS
 7p7C7uAIx2rdvjg8RREbELvlbvqER+BctmeWXq0OYsABJU5JzfOQa6qY5fKAPDsarwzV
 eopfqGoLupdAi3H+Wk8W8ljIQce6yARPsyk+I9zawQwq+ofw5cNXD1Cx6lABejtA6u0k
 JlO7GaNo0QLpkuIENl0hyKCPJkUindcrA8MnVuHZaG7fDseo5TAEC/byixmPBDV8Ups8
 l8gg==
X-Gm-Message-State: AOAM530oKjs0Cff6TUSbiz3OaYJAcOs2hoadefwfsOwLsGlUoLIhIsI3
 nFv/973lF7KkqF2VfYwiq/K0FJLkQb1BNlhztx363weWZpZfNrZTAnqffHZ6f+l8w6cC+gzvEB3
 EGhljkAtDlvdNDPMn3jLgKM3dIHk=
X-Received: by 2002:ac2:5f58:0:b0:477:ba0a:b846 with SMTP id
 24-20020ac25f58000000b00477ba0ab846mr2768891lfz.110.1652954227006; 
 Thu, 19 May 2022 02:57:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcMXV8Lc1k2DrbJhKputvRVp2E0g1Y3mg8FVY1opIDizjbkY2dsNkp5Zj+/uQOz0f5l26lXwOQFc/6pPNhMns=
X-Received: by 2002:ac2:5f58:0:b0:477:ba0a:b846 with SMTP id
 24-20020ac25f58000000b00477ba0ab846mr2768885lfz.110.1652954226860; Thu, 19
 May 2022 02:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
 <65a82dbc6ea54c5d02a1238f5fa26d19388c5d2a.1652789936.git.jstancek@redhat.com>
 <YoPAMBxU5zuQ5xDk@yuki>
In-Reply-To: <YoPAMBxU5zuQ5xDk@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 May 2022 11:56:51 +0200
Message-ID: <CAASaF6xNHMV+xgf7M=-iY-i+Hjgqu3jA1zVHu_XfgrgErCB6oQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_find_backing_dev: match mount point if
 major/minor can't be found
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, May 17, 2022 at 5:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > +             len = count_match_len(path, mnt_point);
> > +             if (len > best_match_len) {
>
> I wonder if we should also check for minimal len to avoid trival prefix
> matches such as "/". Maybe we should set the best_match_len to 1 to
> begin with.

Sure, we can do that. Would you ack this for release as well?
This has been failing for quite a while on fedora (which uses btrfs).

>
> > +                     strcpy(dev, pre);
> > +                     best_match_len = len;
> > +             }
> >       }
> >
> >       SAFE_FCLOSE(NULL, file);
> > --
> > 2.27.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
