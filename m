Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03214CCD1AB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761142773; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PPGjxl9rsKOzwPFSfmBB/JFxPtw1qPIvlhoJ56lXeaM=;
 b=XZssz3unWYtbntMH+iVorgJcVVd1sGXgjP1p/hrz+n9nW1ydqa0XKRsdbm0HYcFYrmJYD
 R+Xn88fD8xRXdf/SyZYYQbDDj6N7zLItkOaAbkyRd7uzHSJTlhb2oHbgIOB0Me9teJdUwHa
 s+NXsiIiHvX8JEokje3egHCxxIEUKyo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AE473CF128
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 16:19:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BB993CF0CD
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 16:19:12 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6335860046D
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 16:19:11 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-471076f819bso55190975e9.3
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761142751; x=1761747551; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JX8B3fRf6wwogLC7FnHG+E08lu+ggNjvIZwkAKO04Ho=;
 b=Uy9NeC7jwUtV4jl43kjN4A9HNOCUC+X8HKaEIvnh+vniWwOO3QmhpGJdVepUxBD8uc
 M0TuPZuXi5PwGT5QnmGf4oLj2CB0/qOGeLKBcv1QkzxgYCDyFnEete+oOjvK7gPZiJy/
 TbWulwZsJRk2kb1lpHmsQLyqEDQA9OM9MZKQH5/Dqp6DZ0jsp4HkjE3cnZWPdeITve2s
 VnDBal/J1TEWPAU/nnULDm1kM2Hg2/3akzCresnTfrsGbs57QPqbSN3WzXAOz8aG03s4
 Iceh7ogAF7kvrWRfeuPMq+48gzdE1NKtgqP8bPJx7TfuDO8dp31pYijaSevw1qePV1LF
 1Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761142751; x=1761747551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX8B3fRf6wwogLC7FnHG+E08lu+ggNjvIZwkAKO04Ho=;
 b=w6hpvFqQRw1hujWP5Zr5XLpuJ1dLkdlF0ewNwQQq5PdcPc1FKzeSpfpZl22W5oUnUs
 WIc40iH9ezEzcgMCLFl2Ew9Y9sRLvgMsBhNjDkGcpeXbjBYhzwl7bNRwCMIkEHO2IFGG
 +2UBMjNmg/K7poY4T3zf+izaL5bDie5kDCjF115+/TdFdl9SqeY4W2T/OUDSRJpq5yWQ
 bfhfv6ymSsSxtXHgQHwWzBRy38UkrEvscsQSGh9GF48F5KRbOFZG4+wdwWcbV7IqqNml
 VOvaGtjvgOxRZTzAQGin3UciYHaZrg34utdYdMhwRY6oPQsp9bLm7F/rc/M+KQFUSoh3
 REUw==
X-Gm-Message-State: AOJu0YwaImtNroxH0N1qQhqVSqA+zzb4mxE/e1Wur+zymYVa2Mi1IlSX
 eO3mc2Ki+IewObZjbKGaBePJo7w7nZIulIxFeip5wpRaJZpN9bYXmpbO/WnTQbF8kQ==
X-Gm-Gg: ASbGnctVupFwPrSVi/LW0zv8a/u403Bo4CTL25raDMmZN+ZUQ8HHsN3/R1n1O+FUEbI
 CXCDuwdPGPza7UQzVCN/WpwgkoseasOKrUQnluDH4LfG/nZpVx+AHPFMCbNmiUT1SakCU4lqdEJ
 etIf+rfKHwxLLbalA3I101kfospaYRkmEEoUGaUBwzo/iOzMMMbyyyk0EzFUvTez4PQRlXNMO3F
 raa/mgAbcWDfR8+z/H+CD8U4cnaN40fv5kZFHgQVD9U5J7XtLBgaL19CWwR3ixheH21RuN153CE
 XomuRmLEz+hGXM2SMieE7EkCycs4b3QSAluz+AGwMMlpRAKC/ObMIyNYOT2tkV4U1GvbBPhc9bt
 bNMK2Wcz7ECGlSHV+hjGECx91Ypr9XNAbQRKYk8PP1EGe9jWS7e2zuQIZKrlJSEnE0rBSSBQz01
 1VpAMpZy94A90P1T5N0pGokFcenk+d
X-Google-Smtp-Source: AGHT+IHgvtoqe/ebmx4WtElHc+Y/Dqm2UfASCoEjEH7AMAawOKePXwqbhklu6S24QXlg8nlrbqb9jQ==
X-Received: by 2002:a05:6000:144d:b0:428:55c3:cea5 with SMTP id
 ffacd0b85a97d-42855c3d44cmr1411402f8f.11.1761142750646; 
 Wed, 22 Oct 2025 07:19:10 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5bab52sm25147714f8f.22.2025.10.22.07.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 07:19:10 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:19:09 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aPjn3SNSVKhbJLGW@autotest-wegao.qe.prg2.suse.org>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
 <20251017143524.GA339521@pevik> <aPWO0j120Kr0z6Pn@localhost>
 <20251020132140.GA398576@pevik>
 <CAEemH2crJNO+azGzhdjzQ0zh_=m5iO=snZCqqqCiTebKuWVHaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2crJNO+azGzhdjzQ0zh_=m5iO=snZCqqqCiTebKuWVHaA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 22, 2025 at 05:23:16PM +0800, Li Wang wrote:
> Hi  Wei,
> 
> Petr Vorel <pvorel@suse.cz> wrote:
> 
> 
> >
> > > need every commits can pass compile phase then i have to combine all
> > > commits into a single big one, is that your request?
> >
> > No, that's other extreme :). There is something in between, right?
> > You did not get me correct, therefore in v4 you not only kept broken
> > functionality, but you also joined the part which could be separated.  At
> > least
> > "ioctl_loop01.c: Update to new .needs_cmds struct" from v3 could have been
> > added
> > as a separate commit (after the main change, not before). Or am I missing
> > something?
> >
> > Unfortunately "lib: Add support option for .needs_cmds" and "Update test
> > cases use
> > new needs_cmds" and "tst_run_shell.c: Add new function handle new
> > needs_cmds" needs to be in a single commit, but maybe you could add
> > functions
> > which implement it in a separate commits (e.g. preparation for a new
> > change) and
> > do the change (when it's actually used) in the last commit).  I'm not sure
> > if
> > it's worth of a separation, maybe not (hopefully we get a feedback from
> > others).
> > If yes:
> >
> 
> Yes.
> 
> 
> > 1) commit (lib preparation) would have: struct tst_cmd, bool
> > tst_cmd_present(const char *cmd)
> >
> > 2) commit (shell loader preparation) would have: enum cmd_ids, static
> > ujson_obj_attr cmd_attrs[], static ujson_obj cmd_obj, static struct tst_cmd
> > *parse_cmds(ujson_reader *reader, ujson_val *val).
> >
> > 3) commit (use new functionality) would have: from "lib: Add support
> > option for
> > .needs_cmds":
> >
> > -       const char *const *needs_cmds;
> > +       struct tst_cmd *needs_cmds;
> >
> > and use of tst_check_cmd()
> >
> > from "tst_run_shell.c: Add new function handle new needs_cmds"
> > -                       test.needs_cmds = parse_strarr(&reader, &val);
> > +                       test.needs_cmds = parse_cmds(&reader, &val);
> >
> > all code changes in "Update test cases use new needs_cmds"
> >
> > 4) "ioctl_loop01.c: Update to new .needs_cmds struct" from v3 can be
> > separate,
> > it just have to be after library function changed.
> >
> > 5) commit: modify some test to actually use some of new functionality.
> >
> 
> Obviously, this is a good suggestion.
> 
> Wei, if you take a look at the git-history of LTP feature change,
> most patchset organizations follow this principle.
> 
> We must keep a clean code and compile pass at the same time,
> I have roughly gone through your patches, and they are seems
> not so hard to rebase.
> 
> 
> 
> >
> > If we are ok to do too many separate commits, then:
> >
> > 1) commit: everything from this v4 in a single commit, but separate at
> > least
> > "ioctl_loop01.c: Update to new .needs_cmds struct" from v3.
> >
> > 2) "ioctl_loop01.c: Update to new .needs_cmds struct" from v3.
> >
> > 3) commit: modify some test to actually use some of new functionality.
> >
> 
> Yes, this is also acceptable to me.
Li, Thanks for your feedback, will plan next patch.
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
