Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7877AC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 12:10:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA2393C9570
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 13:09:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6F9B3C862B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 13:09:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5192A600D4B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 13:09:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 643431F38E;
 Fri, 14 Jan 2022 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642162188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B59Dlr/IjW/S+Cu72HPG+ocRHJYag2xcy/ldJ1CTZ/A=;
 b=TKyfYzARp/+PZNcEdQnPpuMykyCVu0HCAiNc3KW5JOSIav6TFa0Ceqt9SDpZ5YgPc9yvnC
 3o6A5U7tn4soEMa3sqowfLKLZgZDMlEHk89I8eM6EWRcyf0mvwriuDYoCb9OOHbSAhyWPF
 5x8o3X/75dkUeUB0r0rshQX/cBYEscQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642162188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B59Dlr/IjW/S+Cu72HPG+ocRHJYag2xcy/ldJ1CTZ/A=;
 b=268Q2HJ3aeiBqlPobogXBimLoEMTX9atc8ym0zW1oCcdrldE8avz/B0FaPVNqM7zz0fNyX
 O33HNnqF+MOAVGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 379BB13B92;
 Fri, 14 Jan 2022 12:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZSQ4DAxo4WGYYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 12:09:48 +0000
Date: Fri, 14 Jan 2022 13:09:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kushal Chand <kushalchand@zilogic.com>
Message-ID: <YeFoCtIgRTB0mZwl@pevik>
References: <20220111150028.92961-1-kushalchand@zilogic.com>
 <Yd7xWuhoI+IBUi9l@pevik>
 <17e51a0a10c.33eb200245902.4455067589425493654@zilogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17e51a0a10c.33eb200245902.4455067589425493654@zilogic.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_taint: Print readable error message
 instead of numerical code
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Kushal,

> Hi Petr,

> I am really sorry I forgot to mention the link to issue on LTP for which =
I have submitted the patch.=A0

> Can you please check=A0https://github.com/linux-test-project/ltp/issues/7=
76=A0if you have not already?=A0

Thanks, I was not aware of this. Thank you for working on this.
Please next time add flag to git commit message:

if it's an implementation:
Implements: #776

or if it's a fix:
Fixes: #776

Cyril wanted to transform numeric value to string name - there are various =
taint
flags, but we print flag as number. Could you please have look at const char
*tst_strerrno(int err) in lib/errnos.h and wrote similar function for this?
i.e.:

-		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
+		tst_brk(TBROK, "Kernel is already tainted: %u", tst_strtaint(taint));

const char *tst_strtaint(int err)
{
    static const struct pair taint_pairs[] =3D {
		STRPAIR(TST_TAINT_A, "A (ACPI table has been overwritten)")
		STRPAIR(TST_TAINT_B, "B (page-release function found bad page)")
		...
	};

    PAIR_LOOKUP(errno_pairs, err);
}

Maybe Cyril has additional comments how the string should look like.

Kind regards,
Petr


> I just followed what the issue points out.=A0

> If not I will follow what you have mentioned if given more references to =
tst_strerrno()






> ---- On Wed, 12 Jan 2022 20:48:50 +0530 Petr Vorel <pvorel@suse.cz> wrote=
 ----



> Hi Kushal, =


> >  =A0=A0=A0=A0if ((taint & taint_mask) !=3D 0) =

> > -=A0=A0=A0=A0=A0=A0=A0=A0tst_brk(TBROK, "Kernel is already tainted: %u"=
, taint); =

> > +=A0=A0=A0=A0=A0=A0=A0=A0tst_brk(TBROK, "Kernel is already tainted: TAI=
NT_D (OOPS)"); =


> Kernel can be tainted before testing with different flags than D. =


> If you don't like the number, how about create function to map taint flag=
 to =

> char? i.e. similarly to tst_strerrno()? =


> Kind regards, =

> Petr =







> Regards,
> Kushal

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
