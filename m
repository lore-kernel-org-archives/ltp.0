Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB5AC433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 10:14:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3196F3C94FB
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 11:14:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 450A93C8857
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 11:14:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C9771000F32
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 11:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641982439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cUVf3yfQ1e5NY1pFlfVlSP7Rfg+e6EurKGUvAGN4P8=;
 b=FVtYeEVPaLZfgWmKw9F7kzTvQgF5tQM3IiNyKf8EgLuoMY1kZO2n8xPZkSCaPPQbj3ixOe
 DyvLhz3zo+zxGtT949rCWOon0N5it1TRzBOnCNJHRZhmceNlHisU9wZGQ2wgEfSI/2qOv0
 4+n+V3w1wum7al8JyZWT0dRVWMg0Td4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-mwejrJJIO6ykPNczQrCVbA-1; Wed, 12 Jan 2022 05:13:57 -0500
X-MC-Unique: mwejrJJIO6ykPNczQrCVbA-1
Received: by mail-yb1-f197.google.com with SMTP id
 n2-20020a255902000000b0060f9d75eafeso4074162ybb.1
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 02:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3cUVf3yfQ1e5NY1pFlfVlSP7Rfg+e6EurKGUvAGN4P8=;
 b=WzlaxqgVuGA/d3zyEwMG0X4oqZk0hFQ23o8AKQfYbCIZrwfsNvcT4UnzQ/C8Ve03mb
 Vc8ekXbDmo2ZcBvyyfG28y4ZBSZuoNkcZVDU8pvg6NP9XlVmWWW3uBGxZLs9JhPe+mCd
 9EJBIEkn6W00YEfKpLH7nTLvi7mydop4ZwW1fCrAHsYZWzKCocKDwXlrV6vllIICetsq
 1lxUtUafm20BEHQa/qHq3pZq7G+8LVCuyhBxl/v5wjkiuaJCJsdod4aLmHKm3rR0gOeH
 N6yaiAlbP7+oKjmn/D4Z5uXMK0kUauJ27cPSHH6O3GZbDnB9kjwjgDTTtSgvyvZmdhgc
 K8tA==
X-Gm-Message-State: AOAM533L3OXonC7UfMc1nXfAKh+LrBMUe7gvVd5meHZTlIlU4UEgAmw6
 99l4rDmr4ElEn8Fl52ZA6/A45Pjs5ZXNgf9cW33DMTLlWxT5RuwVgeznbasbBZFRALwgKsgsGJc
 2zkXPKmMgahUzkpWzyssJvdRIU14=
X-Received: by 2002:a25:b00b:: with SMTP id q11mr5959994ybf.421.1641982437001; 
 Wed, 12 Jan 2022 02:13:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBqytOlz4UEoWlU5QKaixQhWmFsQRwHpAk7xZFX5BY/pD7Ks7DK4QSXPNCIxXx7tAgsE6uIr6G/aoD4smDmFc=
X-Received: by 2002:a25:b00b:: with SMTP id q11mr5959965ybf.421.1641982436651; 
 Wed, 12 Jan 2022 02:13:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <91b9d5928cd129ebb21430a60e715113a6a6f6b7.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2dHHNz25Vacu3r49MHgyd+Urk3c=NHMwA6zV=FFAQSpQw@mail.gmail.com>
 <CADS1e3f0UMMOyovAGovGp33hQ6ovt1W6h0-RUSVkQRsHWpy=DA@mail.gmail.com>
In-Reply-To: <CADS1e3f0UMMOyovAGovGp33hQ6ovt1W6h0-RUSVkQRsHWpy=DA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 12 Jan 2022 18:13:42 +0800
Message-ID: <CAEemH2e_k4XCb+ST4oZP=y8Hq1tdxcaspO-dh5bm92YrcibkWQ@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] tools: Implement tst_cgctl binary utility
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

Hi Luke,

>> > +static int cgctl_cleanup(const char *config)
>> > +{
>> > +    tst_cgroup_scan();
>> > +    tst_cgroup_load_config(config);
>>
>> This tst_cgroup_load_config() does not work as expected.
>> From my manual check, the ltp and drain dir have been created
>> but it prints " Created_Ltp_Dir=no Created_Drain_Dir=no" strings.
>>
>> ...
>> Detected Roots:
>> /sys/fs/cgroup/memory Mounted_Root=no Created_Ltp_Dir=no
>> Created_Drain_Dir=no Test_Id=test-1801
>> ...
>>
>>
>
> Hm, I'm not sure what this could be. Are you sure when you were reading the printed info it was in the same invocation as when it was being created? Because the tst_cgroup_print_config is just pretty directly printing out the state of the cgroup framework.

I have got the reason, because I manually run Cgroup test but did
not allow it to do cleanup so leaves the ltp/ and drain/ dir there, so
it will not be recorded as "yes" in Created_Ltp_dir next time, that
behavior is correct.

>
>> > +    tst_cgroup_cleanup();
>>
>> This does not work as expected too, but the problem should exist
>> in previous patches. Anyway, I will look into the details tomorrow.
>>
>> # ./tst_cgctl cleanup "$_cgroup_state"
>> tst_cgroup.c:414: TBROK: Could not find root from config. Roots
>> changing between calls?
>>
>
> Was "/sys/fs/cgroup/cpu,cpuacct" one of the roots that was printed out? Because if so the way I have it now it would not be able to parse that. I will look into fixing this.

Yes, it was, I just cut the message to show the problem.


Detected Controllers:
memory V1 @ /sys/fs/cgroup/memory Required
cpu V1 @ /sys/fs/cgroup/cpu,cpuacct
cpuset V1 @ /sys/fs/cgroup/cpuset
Detected Roots:
/sys/fs/cgroup/memory Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=test-5091
/sys/fs/cgroup/cpu,cpuacct Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=NULL
/sys/fs/cgroup/cpuset Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=NULL


From my test, the progress works well on Cgroup V2,
but now fails on parsing the root config in V1.
I suspect there is a bug in patch 4/6, but still checking
why the "roots" is NULL at that moment.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
