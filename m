Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7090CD41159
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768472047; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=D/OjKLk/VfQkQ51VAaiJmHmWuSfkLXUcpA/ln0ixtUY=;
 b=oAjNsXd7r5kvOSYth6M+MvTHLp3dE9FDtDBScx25h+GEEPg9zUyEomMzL78+K39O1MtXj
 dkKqWDwx+q+1x1ChIYmwy3M5GOLY2zGGX3igIiYlvYAByYHQa/nZY90O1rbYW8YCL8W7huC
 Fh+FcrLKZidjloWonW3o6ersHTpJZac=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3213C9E75
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 11:14:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D9893C12E0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:13:43 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 774A11A009BC
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:13:42 +0100 (CET)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b86f3e88d4dso122392866b.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768472022; x=1769076822; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5e+pttkohxmDDlQ6MMaK6+olPDftu6ym2+08RLGZ/Y=;
 b=fjHxrGRCLKXzO/pUJHpXhfQfXkNC8cX6/AOc7HPMdVkZllV6pM37511QzFnHxDo5lF
 yU5iDGGUJn6hafpa+yP0JuCAybPCAceuw9yZr4nk91stY+mNBS7Q3xcrLts0BaCxlB1E
 MoNxDNshmLLhJMZMOwNgSpfT4bzd990Cj87BC/K1KkNmJrkCBWx5M9r0E189WcRXZq0e
 otHtOAnHU72HIwRKR2xA9IeQS8AFQs0/kp+MQFhkRupJcPUe73F9z6j7bKpfbu4dddKe
 DVn7/cihuvLKFGjIcZxPQoYcHP/XPcK9qEP4uNRCA6DgETnpQPi4LxvPtBgLt4TfB2QS
 Ztsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768472022; x=1769076822;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B5e+pttkohxmDDlQ6MMaK6+olPDftu6ym2+08RLGZ/Y=;
 b=OiFINXBQHb2Tc1dSIxzU8AorKLHBzpOdhIYq0M/rvK3FMkv+AscOmQhIIOa7PpIJwY
 FqDbouvEjNHOnqygDHC7P1IJn8cF6luvb6tUGEXt9A90B+VUCt0idTTzOjVTOcNx9pRA
 tI8sEHn/dfEkoBpAK5tjSCb17m8mZw/egn8bL1Qf3UFtx9Bvz+XAbe5CrUInzycsmF8f
 uV/4XgCjr2MMj/vipOX6yjPmCWv0CGsP0bkSAkW+3fRO8HTswWee1rtYShslJreXrBY2
 5OQaF5s7GiPrOOOU+nckZeQnFpshhWgRefcdxZOE5VlGutgrRY6yCJKqvufkJfMVxON9
 Au6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwqWpb66LNepPF2bEOWRWS0Fi2mQfmzzzm+geK4QOKJqUDm+8PhjF+IGUzF+HdL7DcE04=@lists.linux.it
X-Gm-Message-State: AOJu0Ywhtqyp8YgWNmSZsjWcBB9pHX72xc9KFkiqm9CLIha5fGd7YAfM
 bBU70r0SuLgYYx9sPZ1vNhF/gQdiO3dPjyl/4K/w/Vt3HOiJoStdouZtlMp3NcIU4QI=
X-Gm-Gg: AY/fxX7yL/Jk/lEjUXLmWhXfG8gEbYtn42CYVEktCH1rjkkW8lD/ZjdulI8FRiEwWBj
 zchxdCTv6LEt0PMWLYBHfD0vly9eoBs7RHtyf9C1lWtVSwWwnnPt1SuH1l2jJjE1FjhIL9BVnaM
 OcQWxUwX380lm8OvppWPiONJHdrdJSDITP483sRz5N7czb9PmSnMVvogayi/AOVyHrrw+GCZSJI
 d/WbD4v3jHsKCHj0xEeEQ3IIwheHdnlLWVmaSmcoqRXIsvIt83IIi0AEJ4tlh/I6td8QR74vqf6
 +MR8RR321U3/Na/rlCtAUPw2x3LRILxkO+2OKF0eqmg6k6U0S/QbmzLJRaWJ4dt9we0OmZnlMEI
 QhiDy4zwg8iU2Evk+8SrgfWpKB7JXf9+2VC158dWmqSwVrMC96bZ6ZoYo4oI0XoDrTfEsNZ2zLt
 dDD1YpvRtVx8jflN/QDIJf0Um2gXg78kdCIOoF3IM9ObiPP7kF+nWHGmgJ/ysm0SxTUHy1LQmnG
 UJAYAwGfiFI+nelYQ==
X-Received: by 2002:a17:907:cd0d:b0:b87:2eb8:2b77 with SMTP id
 a640c23a62f3a-b876766e86cmr373264566b.1.1768472021771; 
 Thu, 15 Jan 2026 02:13:41 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b876c599391sm362346266b.58.2026.01.15.02.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 02:13:41 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 15 Jan 2026 11:13:40 +0100
Message-Id: <DFP30EO5EZ9M.1UTS5YNH9SX7J@suse.com>
To: "Li Wang" <liwang@redhat.com>
X-Mailer: aerc 0.18.2
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
In-Reply-To: <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> After playing with the ltp.py for a while and assisted by GPT5,
> I drafted a simple patch like below, it works from my test, can
> Do you think it's worth opening a PR to Kirk?

Thanks for checking, see considerations below.

>
> --- a/libkirk/ltp.py
> +++ b/libkirk/ltp.py
> @@ -50,7 +50,7 @@ class LTPFramework(Framework):
>          self,
>          max_runtime: float = 0.0,
>          timeout: float = 30.0,
> -        env: dict = {},
> +        env: Optional[dict] = None,

No need for this, if default it's {} already. That None adds one more
layer of complexity, because then we need to make sure env is not None.

>      ) -> None:
>          """
>          :param max_runtime: filter out all tests above this time value
> @@ -63,7 +63,8 @@ class LTPFramework(Framework):
>          self._logger = logging.getLogger("libkirk.ltp")
>          self._cmd_matcher = re.compile(r'(?:"[^"]*"|\'[^\']*\'|\S+)')
>          self._max_runtime = max_runtime
> -        self._root = os.environ.get("LTPROOT", "/opt/ltp")
> +        env = env or {}

See above.

> +        self._root = env.get("LTPROOT") or os.environ.get("LTPROOT")
> or "/opt/ltp"

This makes sense, but that "or /opt/ltp" is not needed. See below.

>          self._tc_folder = os.path.join(self._root, "testcases", "bin")
>
>          self._env = {
> @@ -79,8 +80,7 @@ class LTPFramework(Framework):
>              if timeout:
>                  self._env["LTP_TIMEOUT_MUL"] = str((timeout * 0.9) / 300.0)
>
> -        if env:
> -            self._env.update(env)
> +        self._env.update(env)
>
>      async def _read_path(self, channel: ComChannel) -> Dict[str, str]:
>          """

diff --git a/libkirk/ltp.py b/libkirk/ltp.py
index 2c0f6d2..153bc7b 100644
--- a/libkirk/ltp.py
+++ b/libkirk/ltp.py
@@ -63,7 +63,7 @@ class LTPFramework(Framework):
         self._logger = logging.getLogger("libkirk.ltp")
         self._cmd_matcher = re.compile(r'(?:"[^"]*"|\'[^\']*\'|\S+)')
         self._max_runtime = max_runtime
-        self._root = os.environ.get("LTPROOT", "/opt/ltp")
+        self._root = env.get("LTPROOT") or os.environ.get("LTPROOT", "/opt/ltp")
         self._tc_folder = os.path.join(self._root, "testcases", "bin")
 
         self._env = {
@@ -94,8 +94,7 @@ class LTPFramework(Framework):
             if not ret or ret["returncode"] != 0:
                 raise FrameworkError("Can't read PATH variable")
 
-            tcases = os.path.join(self._root, "testcases", "bin")
-            env["PATH"] = ret["stdout"].strip() + f":{tcases}"
+            env["PATH"] = ret["stdout"].strip() + f":{self._tc_folder}"
 
         self._logger.debug("PATH=%s", env["PATH"])
 

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
