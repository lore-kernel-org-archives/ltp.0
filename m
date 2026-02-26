Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C24FC591D
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 09:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772098625; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=D+IGxOU53IrAPvp6sZmShVGtfYhUystpKOW/1FhsiFc=;
 b=lk7EmnHGDw0z/RPEGQm+9UOL2nWSnD5h+lkkcTmEU4u5Lf8ns6BJ8cWRJi/Dmno+LFac5
 nN5gEaTnULFmgDxkyNZd0bXF9vc1N96RNjEqamjWo8Zu+Qd+bolR2y2zQnPRA9Oj4x0fUWU
 ASq03TWDKpUGi5ZPUULJUEPclJwDUqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60FF3CB5C4
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 10:37:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF5073C7BA1
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 10:36:44 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D9899140098E
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 10:36:43 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso5717385e9.2
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772098603; x=1772703403; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVp/aA56TrNcejgd3II1XtiZQIobqcnzSVFb2Pcr6Qc=;
 b=VDZIbL+vdlTfvX9+RE4Su6bUKaz+aQKcIQ8FpjomHi5yXl2tKYLNehnxIkqbmZIqDX
 wNh6Odmo9TZpgGDuCVIktb+rbg6aOA+lqJq6KBbXMjT4Z/F6yIsgDROVgR1NakosbJ9Y
 O9aT87uGptujPPNQuBFNMg4D9oEOKne5M0+ljxEDI2+Qmx0B63loDf0Ig/+vaIJUV9h1
 ShL522b3ZH46RDzvbh6Vf9y40PoFsUSn27b7QmSba63eh8R0X9GkT853D4+8Fn9fAA0f
 iUECz4ANO+r8Wgsel/TeTIDhewGamdedbuYeG0oWAoiwtZMB0c0gCcVFvV/nMH1KsyCA
 8GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772098603; x=1772703403;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVp/aA56TrNcejgd3II1XtiZQIobqcnzSVFb2Pcr6Qc=;
 b=VitTCDn9E3yjlcuDEUKohrq9I2iqRqR4Mj9HfolFqKIko0X0FVvlZ++K9B2EltJtTz
 Y1ioW+o352WalVuOO5AMQfBxBmJ6f+WZZ49OrL/pTu39CuBJ2EBkNWlHbiWI3+wP5Z6h
 yJLcEMhcOoW9NRCKq6ZFzbGF9rFs0QdLH0P1XiCFMU1JlyFT9ncTuXwo/OuWTH9c6N4U
 VNQlwzLQhTGM2hRy3xwZWStYYHTPFBnxvMQi+YIDHr6YWOtZBWKhQDKrWSTcVviDKHuk
 YmE95xj/VMDA3ZIZNIZch+GQ/0J68HQ+DxMMuWqvRDtPnEbkuADZmpaVN+wT5INnphNm
 ZXNw==
X-Gm-Message-State: AOJu0YzPnmpcNdpJHFVuhkZitXSuQQpxmNkaZtEJySD5iDEJqbCqWPIo
 9cMmKC9FoOSU5wqXnnvPlde3f9RiBwTRd6hfSOzoXFjDBaizVkvvoPeKvWmSkwjs7Yk=
X-Gm-Gg: ATEYQzyS3Xma2OTE5UmBgrK35zdFW6g3UlN0NvKL7ES882vjXwDaE4aH3ZG4OFpe/ut
 QUbpENNxOkVbz7Yp0FE9ifDwFYtJq0wrcTSWk/gEmaD3OpNxeWYetiTiGxp1nObdlxXRzFjn8KX
 KkSBX7hDfmqDCwgfzYfxbTQjAMX9nZMy6tjhw84/J/bkC9yYrLP2zYC+r8XLZfBTI4rrpwV7iXY
 3+XsieZVqZI6sxLS7/BUDEugE35SbbjaJc87V7P89+YPVFw1XgKQ4QTHmefIRy1o/FSf6HWAK70
 xhgPSos6eMMRxssohzUivVkdFll8WqH/EHRcQyt2pKtLbACKsorHMHPXq72loQa2AXiVSJNouAQ
 v96JHT75shaxcEybZ8SuRt5zXT6NskrZFHOaHJ4wOUftlxLHAjQYw0DIV4PcqlDo2kzfE0xhKpD
 xv5Bcvy7RX0oMGlkLT3QHtpizh/d1als8PxwnA2fW3Fl8CgeIIfdPjhIBPCfsNeXSBAQZUutdyD
 uxWIATb2KbGXfDI3oV2IXZ0lMSjzw==
X-Received: by 2002:a05:600c:820e:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-483a95eb591mr326365215e9.2.1772098601480; 
 Thu, 26 Feb 2026 01:36:41 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750701sm140778035e9.11.2026.02.26.01.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 01:36:40 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 26 Feb 2026 10:36:40 +0100
Message-Id: <DGOSIY7VL1R3.1KTK35389TOL3@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Wei Gao" <wegao@suse.com>
X-Mailer: aerc 0.18.2
References: <20251125044057.20922-1-wegao@suse.com>
 <20260225015044.19233-1-wegao@suse.com> <aZ7V7XD6LIiZ4m0e@yuki.lan>
 <aZ-jDRXSWK78VmdE@autotest-wegao.qe.prg2.suse.org>
 <aaALdx9zYZDUzs2G@yuki.lan>
In-Reply-To: <aaALdx9zYZDUzs2G@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Thu Feb 26, 2026 at 9:59 AM CET, Cyril Hrubis wrote:
> Hi!
> > diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> > index 9b024a74e..0c06a306c 100644
> > --- a/lib/tst_tmpdir.c
> > +++ b/lib/tst_tmpdir.c
> > @@ -186,8 +186,10 @@ static int purge_dirat(int dir_fd, const char *path, char **errptr)
> >                         continue;
> >  
> >                 /* Recursively remove the current entry */
> > -               if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
> > +               if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0) {
> > +                       close(subdir_fd);  <<<<<<<<<< first close
> >                         ret_val = -1;
> > +               }
> >         }
> >         
> >         closedir(dir);  <<<<<<<<<<<<< second close
>
> Ah, right, we hand the fd to the fdopendir() and it's closed in the
> closedir() call. I've missed that since the closedir() is not shown in
> the diff since that part of the code wasn't modified and haven't shown
> up in the diff.
>
> The patch looks good to me then.

Feel free to ack and merge :-)

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
