Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E0CCD195
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761125036; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Q1xp6pBefkHXXXML5hUCWV8c2RVSbbgTzo0rCpX/ucw=;
 b=TCKvIaRjVNyvIraxbn/iD+ey7HPyh89P85EOK+48IRQ+j8nxtHpRw8+uBmX0hsiS1Scah
 S9rdpFvkksihRZjIkxivyXZc3lPG5saOYK6+NHPKxfILV33dd8ocTV9kLQNH45YuKvIZTMS
 y17KV0Lv/LJ6CkihPYKOfwmB7Xyle3M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D62F3CF09D
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 11:23:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ED453CA1FA
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:23:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 42E15600B48
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761125012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnVneZd0V1sK7KzMNM6TJZEjMkq0TwJF9puRPjV8+6Y=;
 b=O0tA+eWA9yumwAeTMnHLgl+6H02WfUCXsjIYLoMysc6OYa7kAq3eS3V24QK17ybC6I/La6
 bP0FScMFiHH50/t97NR2aZmYREFka+oZCxqKhsUv8GWKHMLsy7quYcBxY45SQE+58saNdy
 DtehYzkGvxL/JgbRYVC6SaVcyaFO218=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-YJ-_BMM9O-ORk5F9hxGI_g-1; Wed, 22 Oct 2025 05:23:30 -0400
X-MC-Unique: YJ-_BMM9O-ORk5F9hxGI_g-1
X-Mimecast-MFC-AGG-ID: YJ-_BMM9O-ORk5F9hxGI_g_1761125009
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2930e6e2c03so3579335ad.3
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 02:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761125009; x=1761729809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnVneZd0V1sK7KzMNM6TJZEjMkq0TwJF9puRPjV8+6Y=;
 b=ac1LIlS3owuJj8HqXWenrmYPKjaY2VixtfpOL/LgYcFGydD0ZDYD1bUroyQzIxacnN
 JlQZrrEmQwDKyBUMXzOlTIbbPZ4uAE1NtBz0KZO/iyFrUdOLTY4wt/SgzLnb4lc3VdqT
 juyrL8k35e4FJ+Lyo7NDXzO+/jvISYTeYJnaxfU0yo2BdYLGgvucW9o5uXgSTD/raDX3
 rV8N0ifq9tMd/scIhq20PqMoqI5o/VlkXmK7Rs2TP/CJEwvNps6LMOZPw2KpD4ycOIj5
 bmxgqNb0XNJ6h1J33m7gvrs+/yNNx3TnFWfke9/l4bJOPH+kNq3mDz5WUeSacRdSwY7i
 6YvA==
X-Gm-Message-State: AOJu0Yyc0F/XbuDkwxT87TRdrAqASVtxKmlNjweJb81Ecp+TodI3dvlK
 4nOJHqqRAIl0bGKBDHTBG21OPu/Sgyt7Xm5so1qD/9oG9MW0Up2pgZVTmiKC2gC3AGMFHyxaQ3N
 Qwq2Q4AIW39vwe8GUTSiWFDI8cubxMaQc+6sNfwaTHCLiMpx8m3ziSeEOSZ/8OAJhn32tmYawka
 jv8n7g1izx7bnoASKduVeguZlXLjY=
X-Gm-Gg: ASbGncv/OuQIROKMMe6/eBNibsMN27p5Dhn9bEGGSYHmPhO/X9xjf1VQW9MyHCM3fMN
 di8L6ofjtMtlSnI9AvLBNRFblYDYYPLSEpWNN+a2QqLRKMoNP2SnZGSmAgMooMiGJyavDNcQY2k
 Jke6hbOTsSqmLXGTP2GbOOuG+4tYjSdq4BMAt6tHc/vrB07aGQvOyljx/F
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id
 d9443c01a7336-290c9c8ae4dmr228485915ad.2.1761125009483; 
 Wed, 22 Oct 2025 02:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTiqgqc4PStgHt5H0lYKGcSecPOJ4d54MvwBR3CLxu+XPJnqIywBe2SklEv/FN78b/JiFy/eENyCUkeB4+c0Q=
X-Received: by 2002:a17:903:94e:b0:290:533b:25c9 with SMTP id
 d9443c01a7336-290c9c8ae4dmr228485795ad.2.1761125009096; Wed, 22 Oct 2025
 02:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com> <20251017143524.GA339521@pevik>
 <aPWO0j120Kr0z6Pn@localhost> <20251020132140.GA398576@pevik>
In-Reply-To: <20251020132140.GA398576@pevik>
Date: Wed, 22 Oct 2025 17:23:16 +0800
X-Gm-Features: AS18NWBo8hQUoA6Oh88VNZMPK_cLdrzV_6gFqjtg7FK1foxUHeBESDgU1Oovqj8
Message-ID: <CAEemH2crJNO+azGzhdjzQ0zh_=m5iO=snZCqqqCiTebKuWVHaA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v_z7BDAKPN3wjzMzScpwR1HkiJsoWy_jVZoBW1T0msQ_1761125009
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi  Wei,

Petr Vorel <pvorel@suse.cz> wrote:


>
> > need every commits can pass compile phase then i have to combine all
> > commits into a single big one, is that your request?
>
> No, that's other extreme :). There is something in between, right?
> You did not get me correct, therefore in v4 you not only kept broken
> functionality, but you also joined the part which could be separated.  At
> least
> "ioctl_loop01.c: Update to new .needs_cmds struct" from v3 could have been
> added
> as a separate commit (after the main change, not before). Or am I missing
> something?
>
> Unfortunately "lib: Add support option for .needs_cmds" and "Update test
> cases use
> new needs_cmds" and "tst_run_shell.c: Add new function handle new
> needs_cmds" needs to be in a single commit, but maybe you could add
> functions
> which implement it in a separate commits (e.g. preparation for a new
> change) and
> do the change (when it's actually used) in the last commit).  I'm not sure
> if
> it's worth of a separation, maybe not (hopefully we get a feedback from
> others).
> If yes:
>

Yes.


> 1) commit (lib preparation) would have: struct tst_cmd, bool
> tst_cmd_present(const char *cmd)
>
> 2) commit (shell loader preparation) would have: enum cmd_ids, static
> ujson_obj_attr cmd_attrs[], static ujson_obj cmd_obj, static struct tst_cmd
> *parse_cmds(ujson_reader *reader, ujson_val *val).
>
> 3) commit (use new functionality) would have: from "lib: Add support
> option for
> .needs_cmds":
>
> -       const char *const *needs_cmds;
> +       struct tst_cmd *needs_cmds;
>
> and use of tst_check_cmd()
>
> from "tst_run_shell.c: Add new function handle new needs_cmds"
> -                       test.needs_cmds = parse_strarr(&reader, &val);
> +                       test.needs_cmds = parse_cmds(&reader, &val);
>
> all code changes in "Update test cases use new needs_cmds"
>
> 4) "ioctl_loop01.c: Update to new .needs_cmds struct" from v3 can be
> separate,
> it just have to be after library function changed.
>
> 5) commit: modify some test to actually use some of new functionality.
>

Obviously, this is a good suggestion.

Wei, if you take a look at the git-history of LTP feature change,
most patchset organizations follow this principle.

We must keep a clean code and compile pass at the same time,
I have roughly gone through your patches, and they are seems
not so hard to rebase.



>
> If we are ok to do too many separate commits, then:
>
> 1) commit: everything from this v4 in a single commit, but separate at
> least
> "ioctl_loop01.c: Update to new .needs_cmds struct" from v3.
>
> 2) "ioctl_loop01.c: Update to new .needs_cmds struct" from v3.
>
> 3) commit: modify some test to actually use some of new functionality.
>

Yes, this is also acceptable to me.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
