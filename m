Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C0C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81A333C9179
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 10:05:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00F0C3C2005
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:05:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E22761000926
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:05:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7F8E1F397;
 Fri,  7 Jan 2022 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641546322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHHA29WBKepf3iR8s2kBw013kgPbSZ16x4PjwuY8FVE=;
 b=jrFEQ6tCS+ZoOn0rA4EC6x0b8bzhjXD8YUHjt/PnTAN6T1iQZ3ca0h5leW5i0vpLkVbmKm
 GD8mHR4Txg8Cv8X5/AKwhT24L2sTdMaQ/PccRPSKbK/4X8sA98i+mnw4ANVbgfi8gbtjpE
 +0fNsxj/d/HvIJF3viyNMMtz+Mopfi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641546322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHHA29WBKepf3iR8s2kBw013kgPbSZ16x4PjwuY8FVE=;
 b=W6cas+OdoUOJKRqC8N2mlkNAC2l/uayT/kmHdQtR3hNkYMxt64kZYeysgne1eqH+l3AilI
 yHjniNbktmFkiJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B89D413CA6;
 Fri,  7 Jan 2022 09:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VG19K1IC2GEPSAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jan 2022 09:05:22 +0000
Date: Fri, 7 Jan 2022 10:05:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YdgCUBI6XQRGRWGh@pevik>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
 <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
 <61D7F9AA.9020401@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61D7F9AA.9020401@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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

Hi all,

> >> int main(int argc, const char *argv[])
> >> {
> >>           char delims[] = ",";
> >>           char kconfig[PATH_MAX];
> >>           char str[PATH_MAX];
> >>           char *result = NULL;
> >>           char *next = NULL;
> >>           int i = 0;

> >>           if (argc<  2) {
> >>                   fprintf(stderr, "Please provide kernel kconfig list\n");
> >>                   return 1;
> >>           }

> >>           strcpy(str, argv[1]);
> >>           result = strtok_r(str, delims,&next);

> >>           while (result != NULL) {
> >>                   strcpy(kconfig, result);
> >>                   printf("%s %s %d\n", kconfig,result, i);
> >>                   const char *const kconfigs[] = {
> >>                           kconfig,
> >>                           NULL
> >>                   };
> >>                   if (tst_kconfig_check(kconfigs)) {
> >>                            fprintf(stderr, "Kernel config doesn't meet
> >> test's requirement!\n");
> >>                            return 1;
> >>                   }

> >>                   i++;
> >>                   result = strtok_r(NULL, delims,&next);
> >>           }

> >>           return 0;
> >> }

> >> But it must call tst_kconfig_check for every kconfig expression and
> >> print many info "Parsing kernel config ..." because we need to create a
> >> NULL terminated array for  tst_kconfig_check.

> > Maybe we can combine the arguments into one kconfigs struct and
> > just do once check? something like:
> Yes, it works well. Thanks.

LGTM. NOTE: Cyril suggested strchr() with loop, maybe he thought about even
simpler solution.

> I checked the kernel config, it seems comma can not meet the CONFIG_LSM 
> situation (Petr mention it but I don't notice before).
> CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

> so I think we may TST_NEEDS_KCONFIGS_IFS variable and default value is 
> comma.
Maybe use '|' as the default? That's very unlikely to be used
(but I'd still have TST_NEEDS_KCONFIGS_IFS).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
