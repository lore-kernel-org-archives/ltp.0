Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CABECAAD8
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 04:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 849FF3CAD64
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 06:32:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D0E63C8942
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 06:32:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1BD6C600830
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 06:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663821162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HK2BCYhseGQtm3eEyfiD1tDtPz5cCB6O5sFt8AZbeZ0=;
 b=Du29JL7T+TR3xaE48DHAIFYX2CIqDlKQPq9rNXKCJqN+aMyjIFki6bSdGPcpWjwkpgl8Q7
 /oAsgjKynZ+h+FjTz6ozGzxXirJKYHVL+96D8jkGcQgHqEEKhcx+paeaROmY2zCTVF3lYM
 zWIsLADN4LbXH1TE0kM7XGKTUCp5/+c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-C-QBscUeMSOTwHqs1lQDqQ-1; Thu, 22 Sep 2022 00:32:40 -0400
X-MC-Unique: C-QBscUeMSOTwHqs1lQDqQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 t12-20020adfa2cc000000b0022adcbb248bso2892466wra.1
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 21:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=HK2BCYhseGQtm3eEyfiD1tDtPz5cCB6O5sFt8AZbeZ0=;
 b=kvtiStVPE3jN4tI7lS1f5vF8zREBeC10vPLjXvZCQ+tYqLh4Wv7P41MmHh1FgKKNN7
 YugIEBl1DGJfzxFT717tpOuOX4dk21vhJdKut96bpTBmXIJ+7lcNYTdP3uj2yEHLpTAT
 FLGHVLs91Xnx/83+7SVv9/YQ1/PDHqq5j30NJVJ5jEPcc7BuI3KehH1RpwKBWwPZ++8w
 L8u0106kSPstOqrXsEzoBw3mimVHc+0vGq/4GgDJmrDeg5IdtQY2c1BJMRg63pSmTAOT
 G0UKvtmwlkjDXcIzTtjaHNWDD/9LkuPArFTAqi4NctxGWYhgxcanjqnf/tV+uVZrkt3M
 ZO1A==
X-Gm-Message-State: ACrzQf0TtaW2HttClu59NTuAXIjKkcwmF02iBXbOelctluF54CAtj+dE
 YeAlhHMKfvVHG0uasWAhvv6IvmA9D3++VAl8Pj0uEo8zhnRlSFH0WGyFbTKsJRmd7Ux4LKYIo0F
 HwEy7QsmzR2w9kST07VxAG8A6n4w=
X-Received: by 2002:a7b:c848:0:b0:3b4:73f4:2320 with SMTP id
 c8-20020a7bc848000000b003b473f42320mr848774wml.124.1663821159163; 
 Wed, 21 Sep 2022 21:32:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4jgrL6zOdGaPo8iYA7AqNC4whK94IE1L9eOt/kyX81//3IcCFzuPe3bKc3uMXH2FSS1d00NlDob7uszimZbHs=
X-Received: by 2002:a7b:c848:0:b0:3b4:73f4:2320 with SMTP id
 c8-20020a7bc848000000b003b473f42320mr848765wml.124.1663821158991; Wed, 21 Sep
 2022 21:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220921102655.31156-1-pvorel@suse.cz>
In-Reply-To: <20220921102655.31156-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Sep 2022 12:32:27 +0800
Message-ID: <CAEemH2fWzcXuOC8-=n9H0p1OAvJhOfB33EAJT0yC06=vS=_7DA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] tst_test.sh: Fix filesystem support
 detection
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
Content-Type: multipart/mixed; boundary="===============1817116210=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1817116210==
Content-Type: multipart/alternative; boundary="00000000000026e4a305e93c8d6b"

--00000000000026e4a305e93c8d6b
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 6:27 PM Petr Vorel <pvorel@suse.cz> wrote:

> Filesystem detection of locally used filesystem was broken on tests
> which did not use TST_ALL_FILESYSTEMS as it 1) expected used filesystem
> is $TST_FS_TYPE 2) this variable was not yet set.
>
> Also this check makes sense only if test defines TST_SKIP_FILESYSTEMS
> (to align with the condition in do_test_setup() in C API).
>
> Move filesystem check after (optional) cd "$TST_TMPDIR" (TMPDIR can have
> different filesystem).
>
> Not printing extra TINFO "$_tst_fs is supported by the test" (which is
> printed in C API) when test is supported, because there is already
> similar TINFO from testcases/lib/tst_supported_fs.c:
> tst_supported_fs.c:104: TINFO: btrfs is not skipped
>
> Fixes: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")
>
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> First, sorry for introducing a regression.
>
> I don't like df and tail dependency. Also df output is stable (even on
> busybox), but I'd prefer to use code from do_test_setup() in
> lib/tst_test.c:
>
>         long fs_type = tst_fs_type(".");
>         const char *fs_name = tst_fs_type_name(fs_type);
>
> Instead adding yet another binary, I wonder if we could add extra getopt
> parameter to ask for current filesystem.
>
> i.e. to replace:
> -tst_supported_fs -s skip_list fs_type
> +tst_supported_fs -s skip_list -d DIR
>

+1, and Martin already sent out the achievement patch,
you can rebase this patch on that.

And I'd like to vote for merging your both patches for
adding to the new release.


-- 
Regards,
Li Wang

--00000000000026e4a305e93c8d6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 21, 2022 at 6:27 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Filesystem detection of locally=
 used filesystem was broken on tests<br>
which did not use TST_ALL_FILESYSTEMS as it 1) expected used filesystem<br>
is $TST_FS_TYPE 2) this variable was not yet set.<br>
<br>
Also this check makes sense only if test defines TST_SKIP_FILESYSTEMS<br>
(to align with the condition in do_test_setup() in C API).<br>
<br>
Move filesystem check after (optional) cd &quot;$TST_TMPDIR&quot; (TMPDIR c=
an have<br>
different filesystem).<br>
<br>
Not printing extra TINFO &quot;$_tst_fs is supported by the test&quot; (whi=
ch is<br>
printed in C API) when test is supported, because there is already<br>
similar TINFO from testcases/lib/tst_supported_fs.c:<br>
tst_supported_fs.c:104: TINFO: btrfs is not skipped<br>
<br>
Fixes: 1f6bd6e66 (&quot;tst_test.sh: Add $TST_ALL_FILESYSTEMS&quot;)<br>
<br>
Reported-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=3D=
"_blank">mdoucha@suse.cz</a>&gt;<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
First, sorry for introducing a regression.<br>
<br>
I don&#39;t like df and tail dependency. Also df output is stable (even on<=
br>
busybox), but I&#39;d prefer to use code from do_test_setup() in lib/tst_te=
st.c:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long fs_type =3D tst_fs_type(&quot;.&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *fs_name =3D tst_fs_type_name(fs_typ=
e);<br>
<br>
Instead adding yet another binary, I wonder if we could add extra getopt<br=
>
parameter to ask for current filesystem.<br>
<br>
i.e. to replace:<br>
-tst_supported_fs -s skip_list fs_type<br>
+tst_supported_fs -s skip_list -d DIR<br></blockquote><div><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">+1, and Martin alread=
y sent out the achievement patch,</div><div class=3D"gmail_default" style=
=3D"font-size:small">you can rebase this patch on that.</div><br></div><div=
><div class=3D"gmail_default" style=3D"font-size:small">And I&#39;d like to=
 vote for merging your both patches for</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">adding to the new release.</div></div><div><br></d=
iv></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--00000000000026e4a305e93c8d6b--


--===============1817116210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1817116210==--

