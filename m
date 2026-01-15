Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4268ED41154
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768471104; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jzWWT2FsT8l0AuEuumAv8UVTiM+T1Jw6UJBki4Xv9Mk=;
 b=ByLVDUW5KYtT3mPQ+SPRBCa4LSDoyQD6ZfXVnHvbazFKkS1fLaIX7jYGwZOZeWoQJkpTK
 +SKIFrquBu994i9O3ZsE+e40W4wP/kSzNmbNqKjLHfPOuLxEpoGhjkytOPZk4SU/5DmespO
 ORarSKhV3Ba+KGI8PKFplii1jiGVqdQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9AB13C9C10
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 10:58:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5C633C9A5F
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 10:57:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E6016008BC
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 10:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768471077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WoIpKUZyKukLZH4btBQ3flJdO7IKv7CIzlaYjcQ+RCY=;
 b=JsYIsQ+cL06Pe8Of7LdHQT6fm9j3e81cqXyjpJf3HCcxREUyn1HucwQdluwHimNlhg5c/v
 hxNHNpv4qF9nwmL9tVaPocYumRZPFtrR5NOpm5AEMAg2MlPr4SdQz2BxDuVshiwwfoUbIM
 uf0+cBYBC8Iyou9VBMW1x4VV2b9yjFU=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-GOZpnz78P0ydgU6SI7q72Q-1; Thu, 15 Jan 2026 04:57:54 -0500
X-MC-Unique: GOZpnz78P0ydgU6SI7q72Q-1
X-Mimecast-MFC-AGG-ID: GOZpnz78P0ydgU6SI7q72Q_1768471074
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ac363a9465so863092eec.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 01:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768471074; x=1769075874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoIpKUZyKukLZH4btBQ3flJdO7IKv7CIzlaYjcQ+RCY=;
 b=Rc1acnTUfytWlWqgGCBjAOh4gw44S3OaAM77Cbt6mtBl9qVsjuo7A9+4ebOmN+WCFt
 Uv22aOSdcN+zEva2zeSY7GgExtVOqZUqTGs6TfwmpYTRC/jzg2ijOnrf4c7KITE6DPRo
 RYMVc8h3v/RuwRdJUTwrVbWzcQeBM7QM3xKsmfXnwH02nXCRwnjXblk+eKmaJLmHys6+
 gGckworGAlWHHgPKrbKCEFteHUD8vvqC+RlxrakZke/QUJSudeckyWdhPA8tyJRogsUe
 TPvdclEgtd7vp9EzyvEtYlNcnUiij7JUIZntZFWPz29/bsNQvgxRUVKmyb/ynNC4tpCL
 sGCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmfN9QYiFPsRbskyTt93RHp5aVHOzJy2SDyGcF/eQSYbVsik1MY4QYdvrpl6RC7DjkxDg=@lists.linux.it
X-Gm-Message-State: AOJu0Yw2Jp03T1+TekDlzMyX7cOL8wKNZjgH7PezTlEMGlzLpjzWQMSb
 U7VB5bSW2KrubPiHuA8DRLG7Oj8rNw6ZsUfwKDtQFrId0dBe2ILRJdDbXXttCBPJzuf4q8WXJvs
 fTT65nuPgbFEx+8fScwd4MqHhho4csr6ey8t592xf32hlgE+9GojKlL3uNRiFdPl9I4KoNzPwDy
 hgt8tSxl1yGoTW2lRrgrU0hBY+Z0M=
X-Gm-Gg: AY/fxX5B8KcZpZnhG81WitZMGrT6EvgLm01BM/dgdMAxl2wICnWdUNbe869kXeWHJte
 fKP8ADPxYKznxvFKfyzLKKhZRhBWcn0FrqQuzlaWcNnYlSIG8bAeEHfu3wczya7oxUrEJsGSTR2
 AMuRLQBQFtAft0NJVhR48N5SArkDHaAqvsbvlxK8YZISqpstQ4dCK96IVrGtN1iNC/UB0=
X-Received: by 2002:a05:7300:f193:b0:2b0:4fe2:6a2e with SMTP id
 5a478bee46e88-2b48f105131mr9003999eec.9.1768471073635; 
 Thu, 15 Jan 2026 01:57:53 -0800 (PST)
X-Received: by 2002:a05:7300:f193:b0:2b0:4fe2:6a2e with SMTP id
 5a478bee46e88-2b48f105131mr9003970eec.9.1768471073259; Thu, 15 Jan 2026
 01:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
In-Reply-To: <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
Date: Thu, 15 Jan 2026 17:57:41 +0800
X-Gm-Features: AZwV_QiNd-MGtE3H4VChqPILJ2wLnZUglmR7Egz3-GR_XyvgZLf84ycDjBfywic
Message-ID: <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B81uShGHWsdqRD79tbXjyh5C_Xb9BYOiNmhw1p_FDFs_1768471074
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

> > ===== Log =====
> > # ./kirk --env LTPROOT=/root/ltp-install/  --run-suite sched -v
> > --json-report sched.json
> > Host information
> >
> > Hostname:   dell-per430-09.gsslab.pek2.redhat.com
> > Python:     3.12.12 (main, Jan  6 2026, 00:00:00) [GCC 14.3.1 20250617
> > (Red Hat 14.3.1-2)]
> > Directory:  /tmp/kirk.root/tmp1a062qkt
> >
> > Connecting to SUT: default
> > Error: LTP folder doesn't exist: /opt/ltp
> >
> > Disconnecting from SUT: default
> > Session stopped
> >
> > ==============
> >
>
> This is strange. The --env feature is taking info from shell and
> updating its dictionary if it has been defined.
>
> This is exactly why this ticket has been open. Too much confusion
> between shell variables and --env parameter. We can't have 2 different
> ways to set internal variables.
>
> https://github.com/linux-test-project/kirk/issues/72

After playing with the ltp.py for a while and assisted by GPT5,
I drafted a simple patch like below, it works from my test, can
Do you think it's worth opening a PR to Kirk?

--- a/libkirk/ltp.py
+++ b/libkirk/ltp.py
@@ -50,7 +50,7 @@ class LTPFramework(Framework):
         self,
         max_runtime: float = 0.0,
         timeout: float = 30.0,
-        env: dict = {},
+        env: Optional[dict] = None,
     ) -> None:
         """
         :param max_runtime: filter out all tests above this time value
@@ -63,7 +63,8 @@ class LTPFramework(Framework):
         self._logger = logging.getLogger("libkirk.ltp")
         self._cmd_matcher = re.compile(r'(?:"[^"]*"|\'[^\']*\'|\S+)')
         self._max_runtime = max_runtime
-        self._root = os.environ.get("LTPROOT", "/opt/ltp")
+        env = env or {}
+        self._root = env.get("LTPROOT") or os.environ.get("LTPROOT")
or "/opt/ltp"
         self._tc_folder = os.path.join(self._root, "testcases", "bin")

         self._env = {
@@ -79,8 +80,7 @@ class LTPFramework(Framework):
             if timeout:
                 self._env["LTP_TIMEOUT_MUL"] = str((timeout * 0.9) / 300.0)

-        if env:
-            self._env.update(env)
+        self._env.update(env)

     async def _read_path(self, channel: ComChannel) -> Dict[str, str]:
         """



-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
