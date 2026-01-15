Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72BFD4115D
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768473340; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ADmZ4B+Ux0hTRPu7qx6qpqTJo3t1TU9m5oUZ0JTkBHk=;
 b=nZEthNRMQYIvR8Oce6bShj0bxI57Quj5/yOvmiAdhiHsVLJpawAcpRa27yXS5L7NMyOXH
 cTEvdH395G6/u32yuDacfVQiSW0ZKWdTTGz8of54tZVvPbuR3u/4V4v7ZCiJijUlByT4dJH
 nTBrVTeVgYjYB6BbgnxxiV0soblVVnI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73C833C9EC5
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 11:35:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC49C3C5F64
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:35:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED6E81400E13
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:35:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768473314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+U9wPk67QUn7p5sMps/mtOjpj3e+4k5Ckb+ku+RRrA=;
 b=U8EI25FIE3Lq6arJZG5WuKui8tAVDAF8AnvdTK6C8t5Xyp4Qm1DMCeDEzVp6av/0lXyvkH
 BFEjwgouMSVMXbT5DYvQO57vsO8nKlr3egaC9U631Re60HeyxwJ3K3W7WKTHwQ+M7PQJQB
 uwv45mNvVS7azdcqZQXjLfPrWD9i4bY=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-rHKvlUHxMuWBiLbk4Gdh6Q-1; Thu, 15 Jan 2026 05:35:12 -0500
X-MC-Unique: rHKvlUHxMuWBiLbk4Gdh6Q-1
X-Mimecast-MFC-AGG-ID: rHKvlUHxMuWBiLbk4Gdh6Q_1768473311
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b048fc1656so2754772eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 02:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768473310; x=1769078110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+U9wPk67QUn7p5sMps/mtOjpj3e+4k5Ckb+ku+RRrA=;
 b=c75kVoNoaeZYQ/gQWLWtbMuiZEF1CuF/IdAfEFIuFdDzR6zJ+2Cat+06hfpYoNb6dD
 Zp6lW2diHG8Xg5E4yhveAvtebdEnIb4O+peIszdwBsuH6hhvZcJIdToTVyP3Vq/kMjyk
 9UkuLVhIfd0ypPXvmOLScGKUY6q/gDRs0jwh0XOhqtTJYLgHKYRVAms+ADYm04yAJc4L
 +SBlO1Fi1KX/6RaU8TqG2a1ZzlFsGhaDUDKDW/QXm18823p6wCLQkxQrSLwQkBccPS2r
 yVmlX5230cGwz1bZFndiBOF8043HD/tCcI5Gd4634f9VbwJ+TDlPeI92WgfsxbXPYUYO
 M2Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW5so3cc+E/TKzoFd3oRuOQ6XVMDZrRo6ZJDDqsU8SlN04LTPtMs+gjnHSqg/+yf3opJg=@lists.linux.it
X-Gm-Message-State: AOJu0YynJFW/RjxHrMrDyk049N9n6gOH9dyTRBHihkaVoAeWltIj5NUc
 1oiZyh+1AWnxAMLplSLJrVnl2NrIcIN2v6LK/m6oHR68tbAe9RgHYf1KufeHfFXcUQX523Wc1uv
 yVRChMPDKw2tzswHkM9d3B7WUqjH8mk4f3pG+efE37Qai84+5HRDyCwGIaIH8XyAure/8kaD/qc
 muwkczRpsa8qQtq5/n1Cy4/YIzl/0bg7jB11/hmg==
X-Gm-Gg: AY/fxX7ZB6YHTqy+mlk0dSsw15H6tDXzjZlfGC8r2T3Mf9fEbuRC29GSD7OzLV/+YjH
 mbyoog+YIVFsWaFU4Y3W14j76yx+zufbWkugq5QyR1jPD0CpW07zw+DN2IqZDbmziVZiCkIuc4S
 JkSyM/77Ey59N7hjfQ7lki0lxVW+tDV/dnV2QaCwKc/phqjeVPj6jyqivJkfqEpAuV9mg=
X-Received: by 2002:a05:7301:1e4c:b0:2b0:6a03:f13a with SMTP id
 5a478bee46e88-2b486ca93acmr8059694eec.19.1768473310517; 
 Thu, 15 Jan 2026 02:35:10 -0800 (PST)
X-Received: by 2002:a05:7301:1e4c:b0:2b0:6a03:f13a with SMTP id
 5a478bee46e88-2b486ca93acmr8059673eec.19.1768473310115; Thu, 15 Jan 2026
 02:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
 <DFP30EO5EZ9M.1UTS5YNH9SX7J@suse.com>
In-Reply-To: <DFP30EO5EZ9M.1UTS5YNH9SX7J@suse.com>
Date: Thu, 15 Jan 2026 18:34:58 +0800
X-Gm-Features: AZwV_QhqAQGZi7t8zuQUIMkJZ5Etf3hvXYWLz3IeFivcPUPOFxryEl1Jl6NJ9e0
Message-ID: <CAEemH2c0CpvpTNgoSn9WPGU1MQkgPWjiZ4fOmFpaxgziEZjnUg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wzVExP5o5NMQ3VlrT-skZgu0DFAaB2x9yAKHV1xGj80_1768473311
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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

Andrea Cervesato <andrea.cervesato@suse.com> wrote:

> > After playing with the ltp.py for a while and assisted by GPT5,
> > I drafted a simple patch like below, it works from my test, can
> > Do you think it's worth opening a PR to Kirk?
>
> Thanks for checking, see considerations below.
>
> >
> > --- a/libkirk/ltp.py
> > +++ b/libkirk/ltp.py
> > @@ -50,7 +50,7 @@ class LTPFramework(Framework):
> >          self,
> >          max_runtime: float = 0.0,
> >          timeout: float = 30.0,
> > -        env: dict = {},
> > +        env: Optional[dict] = None,
>
> No need for this, if default it's {} already. That None adds one more
> layer of complexity, because then we need to make sure env is not None.
>
> >      ) -> None:
> >          """
> >          :param max_runtime: filter out all tests above this time value
> > @@ -63,7 +63,8 @@ class LTPFramework(Framework):
> >          self._logger = logging.getLogger("libkirk.ltp")
> >          self._cmd_matcher = re.compile(r'(?:"[^"]*"|\'[^\']*\'|\S+)')
> >          self._max_runtime = max_runtime
> > -        self._root = os.environ.get("LTPROOT", "/opt/ltp")
> > +        env = env or {}
>
> See above.
>
> > +        self._root = env.get("LTPROOT") or os.environ.get("LTPROOT")
> > or "/opt/ltp"
>
> This makes sense, but that "or /opt/ltp" is not needed. See below.
>
> >          self._tc_folder = os.path.join(self._root, "testcases", "bin")
> >
> >          self._env = {
> > @@ -79,8 +80,7 @@ class LTPFramework(Framework):
> >              if timeout:
> >                  self._env["LTP_TIMEOUT_MUL"] = str((timeout * 0.9) / 300.0)
> >
> > -        if env:
> > -            self._env.update(env)
> > +        self._env.update(env)
> >
> >      async def _read_path(self, channel: ComChannel) -> Dict[str, str]:
> >          """
>
> diff --git a/libkirk/ltp.py b/libkirk/ltp.py
> index 2c0f6d2..153bc7b 100644
> --- a/libkirk/ltp.py
> +++ b/libkirk/ltp.py
> @@ -63,7 +63,7 @@ class LTPFramework(Framework):
>          self._logger = logging.getLogger("libkirk.ltp")
>          self._cmd_matcher = re.compile(r'(?:"[^"]*"|\'[^\']*\'|\S+)')
>          self._max_runtime = max_runtime
> -        self._root = os.environ.get("LTPROOT", "/opt/ltp")
> +        self._root = env.get("LTPROOT") or os.environ.get("LTPROOT", "/opt/ltp")
>          self._tc_folder = os.path.join(self._root, "testcases", "bin")
>
>          self._env = {
> @@ -94,8 +94,7 @@ class LTPFramework(Framework):
>              if not ret or ret["returncode"] != 0:
>                  raise FrameworkError("Can't read PATH variable")
>
> -            tcases = os.path.join(self._root, "testcases", "bin")
> -            env["PATH"] = ret["stdout"].strip() + f":{tcases}"
> +            env["PATH"] = ret["stdout"].strip() + f":{self._tc_folder}"
>
>          self._logger.debug("PATH=%s", env["PATH"])


This change worked for me, and I saw in kirk/issues/72 that someone
still wants support for both methods.

So, maybe keeping it can be helpful to set env for remote SUT
execution? Since exporting locally may not affect the remote side
unless Kirk forwards env.

I am not quite familar to Kirk code, so just raise my questions to you
to evaluation.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
