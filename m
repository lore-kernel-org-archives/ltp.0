Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA3DC636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F7A73CCA05
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 17:28:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EACD43CB077
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 17:28:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36500600835
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 17:28:15 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 46FBF1FD64;
 Mon, 13 Feb 2023 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676305695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExGiB8npANtzrLOYxnjVX6i27zw5AwLK11egoU2TZCw=;
 b=dkV2/aTcAPeVpXKO0vEfYSNvTJjJRZ8noq4n+py2Gd2xejU0sgIRq7L6zlIg8RLzYD+xY7
 bzS9Xm0urMuTTQrwoQoHSFGwcpG88KwcRrML/aXVZZUYl+VS1ZvAYgggB0wmZio3meZcIz
 wvZBbgSkh19olGEQ3lxLxfzrVJ59GGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676305695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExGiB8npANtzrLOYxnjVX6i27zw5AwLK11egoU2TZCw=;
 b=5D/BMx9ElLdusnZPLoYxgR5lqpzUYUCAQwJqIuVmTDaEugDdEpuw6OCQ9GEWmcxV6QlGCL
 baFBsrSc8V62XtDA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0CF312C142;
 Mon, 13 Feb 2023 16:28:14 +0000 (UTC)
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
 <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
 <20230208135404.GB31469@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Feb 2023 16:08:02 +0000
Organization: Linux Private Site
In-reply-to: <20230208135404.GB31469@pevik>
Message-ID: <87zg9ho7hg.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Petr Vorel <pvorel@suse.cz> writes:

> Hi Li,
>
>> > +#define        DEFAULT_TTY_DEVICE      "/dev/tty0"
>
>> Hidden the device path parameter is a good idea.
>
>> But maybe can we add a function to find available char devices
>instead

There is already something like this built into the kernel; you can
create a PTY on demand with /dev/ptmx.

See the kernel/pty tests.

>> of using the tty0 as default? In that function, we do the S_ISCHR() check
>> and return the valid path of it. Then the rest test (e.g. ioctl02) can make
>> use of it but not set the specified device as well. WDYT?
>
> FYI I'm using S_ISCHR() in other patches, which check if device can be used.
> Implementing search looks like a good idea. Are useful files any /dev/tty*
> (including /dev/tty, /dev/ttyACM0, /dev/ttyS0) or should I avoid any file
> or include other paths?

These are real serial devices except /dev/tty which could be a real
device or a pty IIUC. Same goes for /dev/hvc[0-9] and possibly some
others.

I'm going to put the patch set to changes requested because /dev/tty0 is
the current virtual console. It seems the test just overwrites the
permissions and starts sending ioctls to it.

I don't know if this is safe and probably it's no different from
creating a pty.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
