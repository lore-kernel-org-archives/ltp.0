Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0A5C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 09:18:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00F7B3C9AC7
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 10:18:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 630403C9820
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:17:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC69D1000993
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644225477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OVTv7cv9JQ1/afqLs27NkwqMrowWgZ+7Sc4P1NdbIsY=;
 b=LCKF+umyUP6R1ST6EnrnNxaTTPPTPs4DRArc3a6VqTpTcDL32M3z2RN0krjOXZFr9uZ+dn
 NkpnRnBU4M6Oxg1Bo0l/NI9HaBFPWklR7kOiwn550LmjwCBqKpYfcmDI2njwXoBGE2ionl
 VWF3+OnrdYgZ3939pyVuLxMYpLGZ2GU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-HvXNsjk0PBezYcGqczObBw-1; Mon, 07 Feb 2022 04:17:56 -0500
X-MC-Unique: HvXNsjk0PBezYcGqczObBw-1
Received: by mail-oo1-f72.google.com with SMTP id
 h7-20020a4aa287000000b002eb15de5797so8561844ool.23
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 01:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OVTv7cv9JQ1/afqLs27NkwqMrowWgZ+7Sc4P1NdbIsY=;
 b=TEBSz+QtJ5NdWyNmEq9BEm781IjgHZgirXnr3KlbUtMJLPiEevfVSHNvPpuRqsCMNN
 DaTNBT3lZVgxvrTvQIdsJZ/Xbg5E/E/VyZAs/cEjELN19lsQ90KZjDDgK8m6d+QcpeLZ
 /Ewf7AVHLomlpHptbH73kbsEmG0f4acTdSvnyjOf4oKgQ3NqMQQI4HYdmaKsjZgtrhcf
 DRPGRIIECDtB5RZs1SjkXA+7b8TI+Xd466GETXWn3wdxRup57wCZfBhxIVtx7zpie0Lf
 l3ReT3dbkwlI+n0OQOv0xHoVF5h42PAF7Ig4uKX6IPeW0TAsnwvw8J9LsdXf8DMwBXvW
 YTBg==
X-Gm-Message-State: AOAM532Tkhc+XNAzJLM4QBhJWO3hA9vdylQONWG1Y5Kqn0YEG56d8g3n
 HtRwhXs1Oezpj+dzynPdQB8mXGPDrNbJiGLCH/6E8eHjDt7tms6jSRU1ru7ftJmzltoglv3iMtE
 0RkGfSWERJn6BvZhI6cvWTfuEKEY=
X-Received: by 2002:a05:6870:822a:: with SMTP id
 n42mr3883714oae.175.1644225475489; 
 Mon, 07 Feb 2022 01:17:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaQo/6H6IMu7FwTdZxxRYeaOpWveirKZZpbb+ZI6nVt8+dIg0CglX2OKxcUOLNY0aeu5ftnCfdhvVmaCdtEuY=
X-Received: by 2002:a05:6870:822a:: with SMTP id
 n42mr3883709oae.175.1644225475346; 
 Mon, 07 Feb 2022 01:17:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643980361.git.jstancek@redhat.com>
 <b10d44db50b76cf5332cff491b5f22500b2b88c6.1643980361.git.jstancek@redhat.com>
 <CAEemH2f7=baDouBjo_VwBgVw0a_oT5YSFuOcF=CcWRZGFNi+bQ@mail.gmail.com>
In-Reply-To: <CAEemH2f7=baDouBjo_VwBgVw0a_oT5YSFuOcF=CcWRZGFNi+bQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 7 Feb 2022 10:17:36 +0100
Message-ID: <CAASaF6w1C9WWHXY36RjdWdUk7pCf=uPzr_x=8CR38nfCA+yBVw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_test_macros: add TST_EXP_FAIL_SILENT
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

On Sat, Feb 5, 2022 at 4:07 AM Li Wang <liwang@redhat.com> wrote:
>
>
>
> On Fri, Feb 4, 2022 at 9:14 PM Jan Stancek <jstancek@redhat.com> wrote:
>>
>> This variant does not print TPASS messages when
>> SCALL fails as expected.
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>> ---
>>  doc/c-test-api.txt        |  3 +++
>>  include/tst_test_macros.h | 15 ++++++++++-----
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
>> index 6f4de3f80f95..9119e094dbfd 100644
>> --- a/doc/c-test-api.txt
>> +++ b/doc/c-test-api.txt
>> @@ -298,6 +298,9 @@ The 'TST_EXP_FAIL2()' is the same as 'TST_EXP_FAIL()' except the return value is
>>  expected to be non-negative integer if call passes. These macros build upon the
>>  +TEST()+ macro and associated variables.
>>
>> +'TST_EXP_FAIL_SILENT()' and 'TST_EXP_FAIL2_SILENT()' variants are less verbose
>> +and do not print TPASS messages when SCALL fails as expected.
>> +
>>  [source,c]
>>  -------------------------------------------------------------------------------
>>  TEST(socket(AF_INET, SOCK_RAW, 1));
>> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
>> index ec8c38523344..f7de8d00a666 100644
>> --- a/include/tst_test_macros.h
>> +++ b/include/tst_test_macros.h
>> @@ -163,7 +163,7 @@ extern void *TST_RET_PTR;
>>                         TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>>         } while (0)                                                            \
>>
>> -#define TST_EXP_FAIL_(PASS_COND, SCALL, SSCALL, ERRNO, ...)                    \
>> +#define TST_EXP_FAIL_(SILENT, PASS_COND, SCALL, SSCALL, ERRNO, ...)            \
>
>
> I think maybe the better way is to define TST_EXP_FAIL_SILENT_
> but not add a new SILENT parameter. So that it keeps consistent with
> the existing TST_EXP_PASS_SILENT_ macros.

It looked like smaller change, but I can update it (Along with the
suggestion to create/delete more directories)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
