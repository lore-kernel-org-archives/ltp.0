Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F05D7308C
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775185318; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lWWeYWHm8V1y12U0/xbJ/PjyUxvx9eiYTgFCz/xyUa8=;
 b=P2gVP/UYFUjtsS7gVZVXnpoiRahEUIt9rEfOWktSKUbi2xg79sa+cCgwhB9mKiF3yyoGP
 pS0kNCvSERsHoRvYE6HQV0It5r15c0Xt9p3x7lP3yB3pd/4sGXcFZjWMghsmuNXfqjIqbx6
 4orCAXFz2YlMagOLZNk6IwER3wPwwt8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBCE63E237A
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 05:01:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 070F93E237A
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:01:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74EBA14010E5
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775185291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xYNwC/jtP/Vhe0pHcs88OVxZuecMT6a8nRcOb2aNUdA=;
 b=OeIo2P8/P17Gz7k/Wa2DmBC8KJAsJkebbKgh9FmJzVeQcYM7P0mTbHidEKJjhP/xB5ga1s
 ZmPCc2i1WZ1Vbp9s2NcpmjVtpzO5JgjwLLDq9yyZs4bRGbNem6gk/aV//s6ri8Og0XmknG
 RqoCs2dq8UTVhpIud5cmUqvk3JXOqbw=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-uRbcoC5uPDyXYwVgINdH3g-1; Thu, 02 Apr 2026 23:01:30 -0400
X-MC-Unique: uRbcoC5uPDyXYwVgINdH3g-1
X-Mimecast-MFC-AGG-ID: uRbcoC5uPDyXYwVgINdH3g_1775185289
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12bf921cf49so1005929c88.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 20:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775185289; x=1775790089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYNwC/jtP/Vhe0pHcs88OVxZuecMT6a8nRcOb2aNUdA=;
 b=QALq8xluil2QtKkpYF4NrLonwmVMKAxlxPBN106H96w82jyg2t6ZoEF/9JfgTEh2iR
 S4zgrEHQdUY7LQM/VhXsgNDM/gihsQxV5PuB/NlAQJhTJOq++ytXzDR/2F2LMg5UVICd
 /Sh/pURMlW0a5d7jtp3Ns4yZTUbEFKXcwDkd+5wGJRYGI6ibrNY8eNDct0QaqPukVy9t
 ZAWv1OaZWLyALgymBuMYz57Mp49Q9wGqicAp4y+T37EU4KVxCAU2tteoi8BMVU9JLboK
 6xj+KVJcj6wPM2qg674FBmoJnDlZcPEBluH8pMqgL13D+TkUQDqm05/o3lF/qm90QHFl
 jy+Q==
X-Gm-Message-State: AOJu0Yz23gJdy0xjNFRRmx+X5sXM/A/ZX5kNASpQIxhtdY7VR+t0zjpY
 zio242a+d1fylJ8DSDZcvLs2ELTG+jbnUOwqHpYsOl+QsOdavgPB8LVBVfRWVd7s5X1OtpOmDay
 PJkIch5abRw6jRCKLlbLl8hwtb3afApsqnTIEC+Q17d6sGM1qBK/mJh6X2Hj6gR5pin1nWaSRSq
 lBrccBH8mP2IYqgoZSpbI3g8LV0wA=
X-Gm-Gg: ATEYQzwnlIwSH7H+l4y2Fdf+6OPQuwaYXxPR3odxqCmP1bEWR8xlKT0sCaDMJJ5HJ8y
 BIahjy4TDBociT8yGyU/Y7MpkHUJzt8R8MfxIDvqQocnc7RmwNa3yi/B8RXencr7jWu+xqkbw5c
 JtznMNpqBUQcKyG7eEJZeHf6g/qW39lC5K3tuG+1uCpfGBRN88ml+VZCKD5/LXzSU1IBit8An0/
 Ng4/Ro=
X-Received: by 2002:a05:7022:1005:b0:12a:6a64:81ef with SMTP id
 a92af1059eb24-12bfb6f3d90mr798980c88.9.1775185289407; 
 Thu, 02 Apr 2026 20:01:29 -0700 (PDT)
X-Received: by 2002:a05:7022:1005:b0:12a:6a64:81ef with SMTP id
 a92af1059eb24-12bfb6f3d90mr798964c88.9.1775185288848; Thu, 02 Apr 2026
 20:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-17-chrubis@suse.cz>
In-Reply-To: <20260402121356.31266-17-chrubis@suse.cz>
Date: Fri, 3 Apr 2026 11:01:17 +0800
X-Gm-Features: AQROBzBDSuEBTFs_NFRHNlGK-jUMTvajdILf8AnB8m5BUNLB0MpqHxhJHzy2kpU
Message-ID: <CAEemH2c5OfBhcR_KB6LY4yJdxAUDR7HbWAf-V0KjiZMN2Jkarw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RC_WaGQkJSYJeTuwfl6Zhh3yAvS1w-M6LxhR_JVYbUA_1775185289
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 16/17] lib: tst_test: Remove now unused
 needs_drivers
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

> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -498,10 +498,6 @@ struct tst_fs {
>   *                  to the test temporary directory from the LTP datafiles
>   *                  directory.
>   *
> - * @needs_drivers: A NULL terminated array of kernel modules required to run
> - *                 the test. The module has to be build in or present in order
> - *                 for the test to run.
> - *
>   * @save_restore: A {} terminated array of /proc or /sys files that should
>   *                saved at the start of the test and restored at the end. See
>   *                tst_sys_conf_save() and :ref:`struct tst_path_val` for details.

As we add runtime_check and module_check, I think we also need to update
the descrition comments of @needs_kconfigs in tst_test.h.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
