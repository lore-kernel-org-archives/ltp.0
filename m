Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D774C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:03:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AABB3C9F0B
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 08:03:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6D273C0E63
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:03:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C8ED2601C69
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644563004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yiVqVXhliBJMMvGQLXKJV3ATQGyXT2Vn7wXsaUw6DnU=;
 b=iYTHZWiJO3afHsA0wDhNaYy04gyl3T1tsub/L5YOt8SENNabn5J+6FQy6d1khukvRcKaYC
 gAfrNfjtDVILbrl0t/18mZOf3fFtjGLOisqYTBiSQYMxc3FV1EMaFoX7G9Xs6lkMU48OLT
 7lMWSkfug417lWqHkpHQXe2pSXfh/r0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-snePEgEGNSGB_i5nb-5CFw-1; Fri, 11 Feb 2022 02:03:20 -0500
X-MC-Unique: snePEgEGNSGB_i5nb-5CFw-1
Received: by mail-ot1-f70.google.com with SMTP id
 w16-20020a056830111000b005a3e1a958ccso4840690otq.11
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 23:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yiVqVXhliBJMMvGQLXKJV3ATQGyXT2Vn7wXsaUw6DnU=;
 b=eTjvz7D+a7ysqi+nTxTO+cd5kuPhvjWtuhEU6bLJyQHjporNqdFwQPsfyngfzTXgea
 kw1jtJLPQ/xZDOoYAjeGCyrXLaeDqorrCj4QdWr7P1ZN0eF03jmiIT6/0SdNVrkVG84G
 bH09F+C/pR0EsgTW+wuFK5QtN5YZClBZqSnYwlus4ApMYrJJuGcWfGv9Ue2sf2S3OQKV
 C5VrYuelghl4aVLBmj/t6TbrCVMb73A5MV6hMGTtfOGUWolOog1KuR6Dd7z23TvD+n5d
 pbnxu3H+qri7tu2LuO6w/qM6/qTlQIgRiSMGJvKFgJrgzLF+3ql310KqJRfuojSdgMg6
 RIpA==
X-Gm-Message-State: AOAM532dRvFrXSna1eELgF24Qg/X2LwbvvUXlH5meLqKNHYwc3A9CQHp
 wJ+vurS7v8rxcsuTCSdBPhZHHtMTL3urDpmBRK/1ITwEh1V1hiirB1l4kbLgEF+bRLZerv0cn8V
 tetQM6xewmEllas7kvQqzKBoUv+g=
X-Received: by 2002:a05:6870:822a:: with SMTP id
 n42mr257497oae.175.1644563000043; 
 Thu, 10 Feb 2022 23:03:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6XENTv3pbu7S6AJhFYogBkH+R2ZNoju1gKwzM7ZBWjZP40Xt9cwMODg5EFZhnXJlEHynVW7T/0bTZsRmnxU4=
X-Received: by 2002:a05:6870:822a:: with SMTP id
 n42mr257489oae.175.1644562999763; 
 Thu, 10 Feb 2022 23:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
In-Reply-To: <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 11 Feb 2022 08:03:03 +0100
Message-ID: <CAASaF6yu935ZQYvEb6MW-pf+jO8EnfbQ-QCQacqKqFUuYROAYQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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

On Fri, Feb 11, 2022 at 7:48 AM Li Wang <liwang@redhat.com> wrote:
>
>
>
> On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha <mdoucha@suse.cz> wrote:
>>
>> When the main test process crashes or gets killed e.g. by OOM killer,
>> the watchdog process currently does not clean up any remaining child
>> processes. Fix this by sending SIGKILL to the test process group when
>> the watchdog process gets notified that the main test process has exited
>> for any reason.
>
>
>>
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -1399,6 +1399,13 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
>>         }
>>  }
>>
>> +static void sigchild_handler(int sig LTP_ATTRIBUTE_UNUSED)
>> +{
>> +       /* If the test process is dead, send SIGKILL to its children */
>> +       if (kill(test_pid, 0))
>> +               kill(-test_pid, SIGKILL);
>> +}
>> +
>>  unsigned int tst_timeout_remaining(void)
>>  {
>>         static struct timespec now;
>> @@ -1481,6 +1488,7 @@ static int fork_testrun(void)
>>                 tst_disable_oom_protection(0);
>>                 SAFE_SIGNAL(SIGALRM, SIG_DFL);
>>                 SAFE_SIGNAL(SIGUSR1, SIG_DFL);
>> +               SAFE_SIGNAL(SIGCHLD, SIG_DFL);
>>                 SAFE_SIGNAL(SIGINT, SIG_DFL);
>>                 SAFE_SETPGID(0, 0);
>>                 testrun();
>> @@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>>
>>         SAFE_SIGNAL(SIGALRM, alarm_handler);
>>         SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
>> +       SAFE_SIGNAL(SIGCHLD, sigchild_handler);
>
>
> Do we really need setup this signal handler for SIGCHILD?

 I had same question.

>
> Since we have already called 'SAFE_WAITPID(test_pid, &status, 0)'
> in the library process (lib_pid) which rely on SIGCHILD as well.
> And even this handler will be called everytime when test exit normally.
>
> Maybe better just add a kill function to cleanup the remain
> descendants if main test process exit with abonormal status.
>
> e.g.
>
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1503,6 +1503,8 @@ static int fork_testrun(void)
>         if (WIFEXITED(status) && WEXITSTATUS(status))
>                 return WEXITSTATUS(status);
>
> +       kill(-test_pid, SIGKILL);

Could we skip the call if forks_child == 0 ?

> +
>         if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
>                 tst_res(TINFO, "If you are running on slow machine, "
>                                "try exporting LTP_TIMEOUT_MUL > 1");
>
> --
> Regards,
> Li Wang
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
