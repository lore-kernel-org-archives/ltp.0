Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61638F54AC0
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774361412; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0gNCnEEiac/2YH6mp8BvPJsM7Fl8Kv7jQf9vRjTFqP8=;
 b=JJRwJ0ijTZImYg68iGgIIUrQyPDHfU880vyDKBn1hBh6yQtlvFhn7sPSi48SdsZsXNNWG
 yFAuu/6ZYYAOVBtENj+XonqMusbvdEMPB2NuzLthdVHdJ7/3GJZe0B5W5UlTnMxq1SAo/3Z
 3YFFgShyc/EY1BEz10QF57E5LnAI/vg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9D273E5258
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 15:10:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B223CC477
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:09:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 35031140044C
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 15:09:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774361384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONtgma3vro0jGF13TzBr6jI3uOM/wdnt+7kA5KBh9lM=;
 b=UTbQSb2t6XR4LDxt7UD6CHPSqloZgtFh8fiLM4FReRE5nNx90JX2An0a7+hg0u5CpYpRrZ
 H+M29ZLDymo+taM3Yr8gf3YufUfritYV4MZ0bzaTP3uIFvKYT08z3Bl85eJqMjeo90gyKG
 QEe/pJmf7KmU1UcCaZyFA0U53eFxihw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76--rLdMJclNU-Z9XdiCUi5rg-1; Tue, 24 Mar 2026 10:09:43 -0400
X-MC-Unique: -rLdMJclNU-Z9XdiCUi5rg-1
X-Mimecast-MFC-AGG-ID: -rLdMJclNU-Z9XdiCUi5rg_1774361382
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so1080420f8f.1
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 07:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361382; x=1774966182;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONtgma3vro0jGF13TzBr6jI3uOM/wdnt+7kA5KBh9lM=;
 b=EM9kfmn2w27enqYHIJjBjcqM5o8rk8X/3beg12kYR8Oyj18V55ahvdjHeFfp/IiCW/
 gepEEsTGoubLLvI/I6q5FveVPXBKiunCnwNHV7WKgxRTYt80fsrP95c7QMSwDIvoLgzm
 zaINE5KMG6nz0usQjz1Cw0iaQneL22xKQ+fhYp97lSoOJQjOGtR3f9Xfasxb3gOijndC
 hxfV7yXHR5feiHCxcNjS9RK81yZstNpabCZGTMhajkqFyksT5OQ4iRgpwuTiPVNeWpR9
 kC7SxdHyKSjZLQs50xM8W+BFBBD4l+f6SqC+UGssOA6GtskR+Ot956cRKu2WpsIazx5k
 8kmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5G3TIkF4zbFD3INZomzSBycS2qJeEgeG/UXkgksC94G5qBp1hAwHbIrtmtPNBz0OmbTo=@lists.linux.it
X-Gm-Message-State: AOJu0YybZ2FvblJFCQNp5YHCaRYOWusxpZ29amxC1e+Xl016kHpuGXOr
 NRQUoG6869dQWaCgOZDD9kAaXYWETdqxP7SsEoeku125/bwoNYoYwXvUuypNVBg8GUR1/fG4cBp
 fr+Z2K4l/fzX1UpjEaWveGg+uttCkt2xxobh5RJlzQzrocFFd40tw
X-Gm-Gg: ATEYQzylzs4He6/JBoWTLtruz/hDeGSlUMnnZiIFrbhZoBqqYRt1Z5BN0ihDOQppVza
 +1edURtuZ62BoEs6082UJ9eHfxFnFrmsTtu5CTmwSgrgX+wxjuUyhcUKXW6RymvvnVO8FcDpKCy
 Vu1cfbwjIIPRJZNPefGFMdutHWUf0TZ6tNzYuCkw+JDNd5kqZWPd/gzubNC91KQFA0MEKe6JmNC
 4PStNA2QGjtdKfbz62WHYQeBz5WP0Wopi4SmuK2J8o1up+aHfA5+lxrBn43GB4qeLcc5+0jwz9s
 UDHxId9lp2S/CV5a/3bUQbk7I46SsxByByhAv9qj+sIc+2WZFuixwjqD6LWkOKTraun211FfnMz
 Ccz6GAqK+ZtYwNfhIowzuskKXSHYBF33J0w==
X-Received: by 2002:a05:6000:2f84:b0:439:ac98:751f with SMTP id
 ffacd0b85a97d-43b642424d6mr22790410f8f.23.1774361381817; 
 Tue, 24 Mar 2026 07:09:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2f84:b0:439:ac98:751f with SMTP id
 ffacd0b85a97d-43b642424d6mr22790363f8f.23.1774361381330; 
 Tue, 24 Mar 2026 07:09:41 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd923sm44486797f8f.12.2026.03.24.07.09.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:09:40 -0700 (PDT)
Date: Tue, 24 Mar 2026 15:09:38 +0100
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <acKPE_1MwQhayd4O@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VIeMXYg-IKOWz-rWV--6kC8CQepab22C817GR-DVyKI_1774361382
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Tue  2026-03-24  14:18 , Cyril Hrubis wrote:
> Hi!
> > LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> > help valgrind to use LTP for testing. It discards the actual content of
> > the messages printed by the test (removes everything after printing
> > TINFO/TPASS/TFAIL/...  flag).
> > 
> > Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
> > TINFO, and TDEBUG messages. Therefore LTP_REPRODUCIBLE_OUTPUT=1 is not
> > needed any more.
> 
> I do not think so. We still have things like pids and timestamps in
> TPASS/TFAIL messages that needs to be removed in order for the output to
> be reproducible.

From Valgrind persp, seems like we could drop it at the first
glance.  But let me confirm that based on a thorough check.

Thanks,
Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
