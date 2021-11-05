Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDAAC433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 01:40:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F3A61246
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 01:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54F3A61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E821F3C763D
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 02:40:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2FF3C6A90
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 02:40:30 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61F05140113E
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 02:40:30 +0100 (CET)
Received: by mail-pl1-x631.google.com with SMTP id u17so10102048plg.9
 for <ltp@lists.linux.it>; Thu, 04 Nov 2021 18:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=A5DoEqYcJm3GT6UlxCxnwm2Fa8j+fBpaS2Tv7Qpucck=;
 b=DxPQoLrMNac8eJCoRw+IqEw/fjYIOWLmiasKACCkFcEGOYTQ/+UWHYggVw5A20c6A3
 xNzgckdfVuIz6TMtYAB8laqDQM6IYLoNkvQRCQ6oeDtiZKgSQTB5fjYZ+aIeIBgvk5T2
 R4sAMsBmkjXkAtBCXnjjcut8BakbZhbikOWzgnbw+VFN8aAH0s1hlIEKCyfkIDYRnU5F
 /VNScoIaiP5uWOqOy2rzlsUXsksEazRbNCCCj5hVDo5eQ1J8NRwZtkfGAjyoDDU/bUKu
 VCKM4CSoGBZu6x0tO4a+Qf4LlkNRmhNlgMSYS+RWc9FPWIcg5leF3hdhyMPgTD7k11c5
 l3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A5DoEqYcJm3GT6UlxCxnwm2Fa8j+fBpaS2Tv7Qpucck=;
 b=fDfmLMf7T6Na38lUgtvDPOqOHytw5toiL59Y8G022v3de9iNCrr8ytFt7et0Fl5TBj
 6alkiIn/o5vkya3HYl1dzX9g7Z4SaQWf6ksKkkbVQBkh2hahCJeUWKej3yxgHK+CO78u
 yYonepC9TGGZRBqirpq5ukue55dhLPoXW2EMOlQSa7MvFSuZaqsEvG6cm56r5IhsIBnX
 c0jR/lHo4UqkZDq483DHxCHSjEOm1QSdMgkiI0rFv4np5TURtL6cjrb33qFCjddnSz8y
 T9imPE7UAdWa4SgpaE9GHrU+w1wuz0SQaRRqsLWYt5KBSUqWEEvvTuhpr6TqLKCH//aH
 J+zQ==
X-Gm-Message-State: AOAM533B5vMHsvyCS5Va+T3oQsIRBiFWo6PmF1HaPWggXaFXEHPYnmRf
 OiwaUJSqPM2MBzQrvxp35cS+Iw==
X-Google-Smtp-Source: ABdhPJyR1trAw6ixYUjWE3Mc0ulKrz4lw3I/QBFZ+n2ihX9G1qO/9HmlFehOPoYoDDIjfXBcj4iPmg==
X-Received: by 2002:a17:902:c713:b0:141:bbb2:1ec7 with SMTP id
 p19-20020a170902c71300b00141bbb21ec7mr38920209plp.57.1636076428511; 
 Thu, 04 Nov 2021 18:40:28 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id co4sm8606835pjb.2.2021.11.04.18.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Nov 2021 18:40:27 -0700 (PDT)
Date: Fri, 5 Nov 2021 01:40:21 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YYSLhTxZWpQLL745@google.com>
References: <20211104121941.32957-1-zhaogongyi@huawei.com>
 <YYQobypksa1GZPYo@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYQobypksa1GZPYo@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Nov 04, 2021 at 07:37:35PM +0100, Petr Vorel wrote:
> Hi all,
> 
> > Before the main process exit abnormally, we need to kill
> > the child process.
> 
> Amir, Matthew, could you please have a look?

If anything, I feel as though stop_children() should probably be called
from cleanup() as that callback will be invoked if any of the
SAFE_FANOTIFY_* macros fail anyway, right?

I don't feel like there's a need to introduce another helper here to
explicitly handle the cleanup case, but I could also be wrong.

> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  .../kernel/syscalls/fanotify/fanotify07.c     | 35 ++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > index cc56d9019..0a0b4f1e4 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> > @@ -108,6 +108,39 @@ static int setup_instance(void)
> >  	return fd;
> >  }
> 
> > +static int setup_another_instance(void)
> > +{
> > +	int rval;
> > +	int fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY);
> > +
> > +	if (fd == -1) {
> > +		stop_children();
> > +		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
> > +	}
> > +
> > +	if (fd < -1) {
> > +		stop_children();
> > +		tst_brk(TBROK | TERRNO,
> > +			"invalid fanotify_init() return %d", fd);
> > +	}
> > +
> > +	rval = fanotify_mark(fd,
> > +		FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
> > +
> > +	if (rval == -1) {
> > +		stop_children();
> > +		tst_brk(TBROK | TERRNO, "fanotify_mark() failed");
> > +	}
> > +
> > +	if (rval < -1) {
> > +		stop_children();
> > +		tst_brk(TBROK | TERRNO,
> > +			"invalid fanotify_mark() return %d", rval);
> > +	}
> > +
> > +	return fd;
> > +}
> > +
> >  static void loose_fanotify_events(void)
> >  {
> >  	int not_responded = 0;
> > @@ -160,7 +193,7 @@ static void test_fanotify(void)
> >  	 * Create and destroy another instance. This may hang if
> >  	 * unanswered fanotify events block notification subsystem.
> >  	 */
> > -	newfd = setup_instance();
> > +	newfd = setup_another_instance();
> 
> >  	SAFE_CLOSE(newfd);

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
