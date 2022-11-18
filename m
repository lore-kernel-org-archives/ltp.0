Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B656DC433FE
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 19:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 051EB3CCEC5
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 20:54:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02F553CCE9E
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 20:54:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CE60909C78
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 20:54:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 696EB1FF47;
 Fri, 18 Nov 2022 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668801269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlMYQP2lVQV1DAhvIlr5QGY/FlAgfEjvT/y+rh77ePo=;
 b=FCtop+b08HxEazbXDuBBS5FkGsPq29xi623ib5EIE+8MU6CP+tcGKqTXbl9/9teXzNflZ/
 glYLWxk493cJraMxmqjOJr96Fjcue0EuASpHde7YzjsZ9yq3yhoJp/AUrdL5IkyV6xwGNE
 RQtSO6+/mnE/Ua5cUp1Yq5EP1iXCejg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668801269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlMYQP2lVQV1DAhvIlr5QGY/FlAgfEjvT/y+rh77ePo=;
 b=qLrB5Sh3b/BS9VgMv3kpZYu8SINn1RrqKpVx1GTIMIirXTSMGat0H2sZjKl63Azcvv28ok
 5ljiz4ib/fmjdWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 363A813A66;
 Fri, 18 Nov 2022 19:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 761XC/Xid2PTYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Nov 2022 19:54:29 +0000
Date: Fri, 18 Nov 2022 20:54:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tim Bird <tim.bird@sony.com>
Message-ID: <Y3fi8ljdbNP/CvQ3@pevik>
References: <416608e6-10ac-c943-1fc8-a3944286f193@suse.com>
 <BYAPR13MB25032674327E22B588074DE0FD069@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB25032674327E22B588074DE0FD069@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC] Include runltp-ng (runltp
 successor) into LTP git
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tim,

> Just one quick bit of feedback...

> > -----Original Message-----
> > From: automated-testing@lists.yoctoproject.org <automated-testing@lists=
.yoctoproject.org> On Behalf Of Andrea Cervesato via
> > lists.yoctoproject.org

> > Hi,

> > as you may know, runltp has been under bug fixing for years without
> > providing any new feature. For this reason the Perl runltp-ng
> > (https://github.com/metan-ucw/runltp-ng) was developed, providing an
> > alternative solution that wasn't completely accepted by LTP community
> > due to the choice of using Perl as the main language.

> > For this reason, a new Python runltp-ng has been developed during this
> > year, with the target to replace Perl version and the current runltp in
> > the next future. Its code can be found here:
> > https://github.com/acerv/runltp-ng

> I think this sounds like a great project, and I look forward to trying it=
 out.

> > runltp-ng Python version provides the following features:
> >  =A0=A0=A0 - class based architecture in Python 3.6+

> Why python 3.6+?  Fuego uses a docker container with an older
> version of Debian, that defaults to Python version 3.5.3.
We support versions from 3.6 to 3.11.
We didn't want to maintain anything older.

> Is there something specifically in Python 3.6 that is required for runltp=
-ng?
> Could it be avoided so that runltp-ng could be backward compatible with
> older interpreters?
Andrea will give more info, there was some limitations.

FYI runltp-ng allows you to connect over SSH (i.e. running on newer host) or
test qcow image started with QEMU. We are also thinking about supporting ro=
otfs
+ separate kernel (output of https://buildroot.org/). Not sure if this helps
you.

We actually try to encourage people to not run runltp-ng on SUT, running fr=
om
host will allow more control in case of crashed system by test.

Kind regards,
Petr

> (Sorry, but this is one of my pet peeves about the whole Python ecosystem=
 - the lack of
> backward compatibility, and the constant need to be creating virtual envi=
ronments
> for basic tools and apps.)
>  -- Tim



> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1194): https://lists.yoctoproject.org/g/automated-tes=
ting/message/1194
> Mute This Topic: https://lists.yoctoproject.org/mt/94688149/3616762
> Group Owner: automated-testing+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/automated-testing/unsub [pv=
orel@suse.cz]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
