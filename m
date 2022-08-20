Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DDEC25B08
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 20:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EF983CA357
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 22:40:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 244423C8D45
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 22:40:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BDDB1000444
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 22:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661028045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Om8Vvbirc9mAVpxMg3s28/Wg51whLgy0C6eHBMCQ5+8=;
 b=Dh3K4ZJdHd2jYQ+DdWtUA0hkEux/P4MQM6Wh50dw4kmui7dP0zdw1DOTzQ3KpT++vX9YAJ
 CkQ24WzFjJ44+pavLSTocNDIsluwE7Tk55Sw7wUWJaT9V+wo8KCC4DQbsShTLB23OcSVOI
 1xrL27AeoTqtc6lSV9gtMyd1NREq5Zo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-Up5c-VxYO7O_8DbJmgxcJw-1; Sat, 20 Aug 2022 16:40:43 -0400
X-MC-Unique: Up5c-VxYO7O_8DbJmgxcJw-1
Received: by mail-lf1-f71.google.com with SMTP id
 p8-20020a056512234800b0048b12cb7738so2108018lfu.6
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 13:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Om8Vvbirc9mAVpxMg3s28/Wg51whLgy0C6eHBMCQ5+8=;
 b=uiCLH2ImNXBQsfDY2G74v0vh7/CKiptmKBnQCp4Nie7wM0JGeYyUnG+XRof6Jf0YAS
 rk/VQF9myQD8BDT33zgzw14bAT8eYdSNxvTMuyV2qKPZi/6Xm8zunP457cDCM1DR87k/
 PQGwy4nvGwA1w11wqNCIdEaaTd0KtDS7YHd/UzI4aHhAWvo9b74q5I0eBjUq6UZiwPrc
 kQdQyzqeMdDDaUSpSbNMY6LVVGCm4Sa3/BK+cRYXRdv7HywAUiHDF7L/mNLPGcikX3cu
 MRbN4rWzvNm5vNotIxjckf8ODBVEKyFcoqPen8lck9viaZH8+aNaA+KRD+ykE5T7ZZt4
 +0uQ==
X-Gm-Message-State: ACgBeo2L1ut0B51MnuJ4SGVLi9p9+bx6qJ9N3hcg3OZCWJvrqWimOpHT
 yQNm7SysJ4syOnXYOCRHbPzg3Ev9qHAY4XESLL0ehn8XnGMS7CimBaCqPdq2PEpEDqqXCBQEpZz
 7dPYOyqgHiibAFe6lw+JO8dqi7O0=
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id
 2-20020a2eb282000000b0025e46b6ff33mr3769650ljx.503.1661028042182; 
 Sat, 20 Aug 2022 13:40:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6U1zrwozn486E/WrZXuUyhDJBZVGn/kbSOlhfVXNh67gmuusYBII1uA1KcdauaHg1hsIqtKdOpMaLghnZoJrs=
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id
 2-20020a2eb282000000b0025e46b6ff33mr3769647ljx.503.1661028041953; Sat, 20 Aug
 2022 13:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
 <Yv+rxD5EO4MDayXT@pevik>
In-Reply-To: <Yv+rxD5EO4MDayXT@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 20 Aug 2022 22:40:25 +0200
Message-ID: <CAASaF6xWmj4Gk39E7Edbn55bfhGJiJ=nWX=XVUtV3WctFSiK4g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] commands/df01.sh: print more logs when test fails
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

On Fri, Aug 19, 2022 at 5:27 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/commands/df/df01.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
>
> > diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> > index f74032c962e5..6b20f21d0d74 100755
> > --- a/testcases/commands/df/df01.sh
> > +++ b/testcases/commands/df/df01.sh
> > @@ -103,6 +103,11 @@ df_check()
>
> >       grep ${TST_DEVICE} output | grep -q "${total}.*${used}"
> >       if [ $? -ne 0 ]; then
> > +             echo "total: ${total}, used: ${used}"
> > +             echo "df saved output:"
> I wonder why you didn't use tst_res TINFO? It'd be more readable as the output
> can be quite long...

It didn't cross my mind at the time. It looks like the df failures are
coming to a resolution,
so I don't mind if you want to drop these 'echos' later.

> > +             cat output
> > +             echo "df output:"
> > +             $@
>
> Kind regards,
> Petr
>
> >               return 1
> >       fi
> >  }
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
