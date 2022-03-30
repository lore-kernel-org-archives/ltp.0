Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF52C433F5
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 16:13:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CA3F3CA013
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 18:13:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0EAA3C07BE
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 18:13:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B97841000553
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 18:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648656818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRZxs1W8R1IqMTZDRmwiKk0US7NntCIz2vr7obrFzgQ=;
 b=hDayNcND98l6OucGOMDgr0WG961YNLTM7mPsYYTIy82s5PUdc+BR05yN16GB18NT5E1RLe
 yM3QxmsXp6lihO8NWGhGjBDyj1nmquVIsVumpisSSG8Omy5FmRJ1qU9foeAGHIn0Vvk/To
 Vw+AlK/Rp/Eop0dysgBi8qexKy2BFtY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-IoDkMcBgNE6Td3tiYsLTQA-1; Wed, 30 Mar 2022 12:13:33 -0400
X-MC-Unique: IoDkMcBgNE6Td3tiYsLTQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68F722800F90;
 Wed, 30 Mar 2022 16:13:32 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F422CC08095;
 Wed, 30 Mar 2022 16:13:29 +0000 (UTC)
Message-ID: <4011ef1e-f457-3134-d933-b5d9f2646b20@redhat.com>
Date: Wed, 30 Mar 2022 12:13:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To: Li Wang <liwang@redhat.com>
References: <20220329050351.688432-1-liwang@redhat.com>
 <d14a7c35-db49-4b7c-7951-9ad597b99831@redhat.com>
 <CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_gettime04: set threshold based on the
 clock resolution
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0520741096=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a multi-part message in MIME format.
--===============0520741096==
Content-Type: multipart/alternative;
 boundary="------------0YV9FysfyEJq05MF8oy8aYQ7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0YV9FysfyEJq05MF8oy8aYQ7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/29/22 23:16, Li Wang wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>
>     The patch looks good in general. However, maybe we should do
>     something like:
>
>     diff --git a/clock_gettime04.c b/clock_gettime04.c
>     index a8d2c5b..1ba218b 100644
>     --- a/clock_gettime04.c
>     +++ b/clock_gettime04.c
>     @@ -92,11 +92,18 @@ static struct time64_variants variants[] = {
>
>       static void setup(void)
>       {
>     +       delta = 5;
>              if (tst_is_virt(VIRT_ANY)) {
>                      tst_res(TINFO, "Running in a virtual machine,
>     multiply
>     the delta by 10.");
>                      delta *= 10;
>              }
>
>     +       clock_getres(CLOCK_REALTIME, &res);
>     +       precise_delta = delta + res.tv_nsec / 1000000;
>     +
>     +       clock_getres(CLOCK_REALTIME_COARSE, &res);
>     +       coarse_delta = delta + res.tv_nsec / 1000000;
>     +
>              find_clock_gettime_vdso(&ptr_vdso_gettime,
>     &ptr_vdso_gettime64);
>       }
>
>     to avoid a coarse_delta that is too large for vm.
>
>
> Thierically that's right, we only make the resolution as additional 
> value to tolerate.
>
> But I'm afraid this is the part we can not guarantee especially for VM.
> As from Eirik's test history, the KVM guest ever failed with "150ms" 
> delay:
> clock_gettime04.c:163: TFAIL: CLOCK_BOOTTIME(vDSO with old kernel 
> spec): Difference between successivereadings greater than 50 ms (2): 150
>
> If we decide to go with your suggestion, I think we'd better skip this 
> test on VM.
>
I see. So we really need more tolerance for vm. I am OK with your 
current patch then.

Acked-by: Waiman Long <longman@redhat.com>

--------------0YV9FysfyEJq05MF8oy8aYQ7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 3/29/22 23:16, Li Wang wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small">Waiman Long
            &lt;<a href="mailto:longman@redhat.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">longman@redhat.com</a>&gt;
            wrote:<br>
          </div>
        </div>
        <div class="gmail_quote">
          <div><br>
          </div>
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            The patch looks good in general. However, maybe we should do
            something like:<br>
            <br>
            diff --git a/clock_gettime04.c b/clock_gettime04.c<br>
            index a8d2c5b..1ba218b 100644<br>
            --- a/clock_gettime04.c<br>
            +++ b/clock_gettime04.c<br>
            @@ -92,11 +92,18 @@ static struct time64_variants variants[]
            = {<br>
            <br>
              static void setup(void)<br>
              {<br>
            +       delta = 5;<br>
                     if (tst_is_virt(VIRT_ANY)) {<br>
                             tst_res(TINFO, "Running in a virtual
            machine, multiply <br>
            the delta by 10.");<br>
                             delta *= 10;<br>
                     }<br>
            <br>
            +       clock_getres(CLOCK_REALTIME, &amp;res);<br>
            +       precise_delta = delta + res.tv_nsec / 1000000;<br>
            +<br>
            +       clock_getres(CLOCK_REALTIME_COARSE, &amp;res);<br>
            +       coarse_delta = delta + res.tv_nsec / 1000000;<br>
            +<br>
                     find_clock_gettime_vdso(&amp;ptr_vdso_gettime,
            &amp;ptr_vdso_gettime64);<br>
              }<br>
            <br>
            to avoid a coarse_delta that is too large for vm.<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Thierically
              that's right, we only make the resolution as additional
              value to tolerate.</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">But I'm
              afraid this is the part we can not guarantee especially
              for VM. </div>
            <span class="gmail_default" style="font-size:small">As f</span>rom
            Eirik<span class="gmail_default" style="font-size:small">'s</span>
            test history<span class="gmail_default"
              style="font-size:small">, the KVM guest ever failed with
              "150ms" delay:</span></div>
          <div><span class="gmail_default" style="font-size:small">  </span>clock_gettime04.c:163:
            TFAIL: CLOCK_BOOTTIME(vDSO with old kernel spec): Difference
            between successive<span class="gmail_default"> </span>readings
            greater than 50 ms (2): 150</div>
          <div><br>
          </div>
        </div>
        <div>
          <div class="gmail_default" style="font-size:small">If we
            decide to go with your suggestion, I think we'd better skip
            this test on VM.</div>
        </div>
        <div><br>
        </div>
      </div>
    </blockquote>
    <p>I see. So we really need more tolerance for vm. I am OK with your
      current patch then.</p>
    <p>Acked-by: Waiman Long <a class="moz-txt-link-rfc2396E" href="mailto:longman@redhat.com">&lt;longman@redhat.com&gt;</a></p>
  </body>
</html>

--------------0YV9FysfyEJq05MF8oy8aYQ7--


--===============0520741096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0520741096==--

