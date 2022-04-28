Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B79BC433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 09:17:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3EFC3CA6D4
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 11:17:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EB013C13E2
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 11:17:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36272600052
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 11:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651137440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fSUpIFyP3jk1C/4qMzrjq/PUzf3LpMkNM2CoivcDkJA=;
 b=PZvfLEQjq6qry1mmlBECEpQ9MT7yQbsWbdlg82Pg9wmFcNg9VIZmX7UFbSQAz18ZnpJuqs
 nzB+KziItEXeaDAJvB7evbqX3sr8zqH4GxDhZc3ZM5eVTmfR1czTwLytlfrR5pyUQKrqWj
 VM0wfGczFHbQ8gzooGiDE+pIO10wLTA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ALlu7H1BNV61j3eIMtM0Yg-1; Thu, 28 Apr 2022 05:17:18 -0400
X-MC-Unique: ALlu7H1BNV61j3eIMtM0Yg-1
Received: by mail-yb1-f199.google.com with SMTP id
 d188-20020a25cdc5000000b00648429e5ab9so4059361ybf.13
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 02:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fSUpIFyP3jk1C/4qMzrjq/PUzf3LpMkNM2CoivcDkJA=;
 b=Rq9TTj25g21vSBfeLCmGL794EUqfu8w4fgcCS6lQgPhxbQa2MXajFKQ9BuelrA2SzQ
 P7Lq56mvLfkvoYcxs0loeHZuRatX1J3SCT8t42uH7lKyEH+CfvPyMMZOwSZobFc83VUW
 zbJrceRDdZbgrXNuQKCTTdLuzvcOx+gmCA0zLN1lSoH9FyDhRdMgC/PmcyDW3DnXwD0y
 vmkXxwdAIPKRWYuVLYB7VBk/UBOE4lb2GwqpCxrEOoLHm9x+e+JmDCcErMsebjqJsFlp
 VzI6tfYZjYk30Nwkx3olmk5XipgfBNHLvj3thu7A9ly/CfikdaK5rgU4yQhiKddFeLy1
 zJUA==
X-Gm-Message-State: AOAM531Gy8fBdODu/y933fYhcD8D5rkOOC1fSO2/hZVdm8E/FsDW6X+t
 Y0JAjfiaa0k8+C2hoN6iEHq+x6sXFiD9sai6AM4FNn7ldY3AvWBFbS1TVGdA1nhHZXA7KoauPLu
 k8Nb8nrdd5W94DsjK8rnmm2ouEGU=
X-Received: by 2002:a5b:a10:0:b0:645:deb7:294a with SMTP id
 k16-20020a5b0a10000000b00645deb7294amr26922121ybq.177.1651137438399; 
 Thu, 28 Apr 2022 02:17:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsru4YKf3042SLuz+vDpeeJ0E1fVGmGhTZZfqsQWgP7mL/JvVFp93P7FBNsyTxMpCSAIMigUqChk8ioNN54GE=
X-Received: by 2002:a5b:a10:0:b0:645:deb7:294a with SMTP id
 k16-20020a5b0a10000000b00645deb7294amr26922104ybq.177.1651137438133; Thu, 28
 Apr 2022 02:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <871qzeniu7.fsf@suse.de>
 <CADS1e3ff7dnQe8zByitszNhKViiOLOF-UfNtSbMsFkkSX5Sy7Q@mail.gmail.com>
 <878rt958yz.fsf@suse.de>
 <CADS1e3d+S-Lg436qb_AFSf1tiea1VzhbBj_BYD1qw-tSXH1J9w@mail.gmail.com>
In-Reply-To: <CADS1e3d+S-Lg436qb_AFSf1tiea1VzhbBj_BYD1qw-tSXH1J9w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Apr 2022 17:17:04 +0800
Message-ID: <CAEemH2dnPVntVHVb9x1Td6zHBXwq4BN0DZn_os0WtbueH2sbyA@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/16] API/cgroup: Implement tst_cg_load_config
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
Content-Type: multipart/mixed; boundary="===============1413231236=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1413231236==
Content-Type: multipart/alternative; boundary="00000000000079c69b05ddb364e4"

--00000000000079c69b05ddb364e4
Content-Type: text/plain; charset="UTF-8"

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:


>
> Sorry for the delay on these patches, got caught up in many other things
> again.
>

No problem with the delay, most of us (at least myself)
are part-time working on this.


>
> I have submitted a pull request for review, didn't want to spam 19 patches
> on the ML. Its my first time doing a pull request.. are you guys able to
> review and accept from there? If so here it is
> https://github.com/linux-test-project/ltp/pull/933
>

Good job, I will look into them later. But I'd still suggest
sending out to ML as well, in case of other maintainers might
interested in the latest patchset.

Ps: AFAIK doing code review in ML is the recommended way of LTP.

-- 
Regards,
Li Wang

--00000000000079c69b05ddb364e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@ca=
nonical.com">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><=
/div><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><b=
r></div><div>Sorry for the delay on these patches, got caught up in many ot=
her things again.</div></div></div></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">No problem with the delay, =
most of us (at least myself)</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">are=C2=A0part-time working on this.</div><div class=3D"gmail_=
default"></div><div class=3D"gmail_default" style=3D"font-size:small"></div=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><div>I have submi=
tted a pull request for review, didn&#39;t want to spam 19 patches on the M=
L. Its my first time doing a pull request.. are you guys able to review and=
 accept from there? If so here it is <a href=3D"https://github.com/linux-te=
st-project/ltp/pull/933" target=3D"_blank">https://github.com/linux-test-pr=
oject/ltp/pull/933</a></div><div></div></div></div></blockquote><div><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">Good job, I will=
 look into them later. But I&#39;d still suggest</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">sending out to ML as well, in case of oth=
er maintainers might</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">interested in the latest patchset.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Ps: AFAIK=C2=A0doing code review in ML is the recommended w=
ay of LTP.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail=
_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div><=
/div></div></div>

--00000000000079c69b05ddb364e4--


--===============1413231236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1413231236==--

