Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797C9D41157
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 10:04:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 201E73C9EE6
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 11:04:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E64D3C9CAE
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:04:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C95401400040
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:03:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B234B33694;
 Thu, 15 Jan 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912EC3EA63;
 Thu, 15 Jan 2026 10:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fH6NIo67aGlxbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 Jan 2026 10:03:58 +0000
Date: Thu, 15 Jan 2026 11:03:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260115100357.GA445534@pevik>
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B234B33694
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> > > ===== Log =====
> > > # ./kirk --env LTPROOT=/root/ltp-install/  --run-suite sched -v
> > > --json-report sched.json
> > > Host information

> > > Hostname:   dell-per430-09.gsslab.pek2.redhat.com
> > > Python:     3.12.12 (main, Jan  6 2026, 00:00:00) [GCC 14.3.1 20250617
> > > (Red Hat 14.3.1-2)]
> > > Directory:  /tmp/kirk.root/tmp1a062qkt

> > > Connecting to SUT: default
> > > Error: LTP folder doesn't exist: /opt/ltp

> > > Disconnecting from SUT: default
> > > Session stopped

> > > ==============


> > This is strange. The --env feature is taking info from shell and
> > updating its dictionary if it has been defined.

> > This is exactly why this ticket has been open. Too much confusion
> > between shell variables and --env parameter. We can't have 2 different
> > ways to set internal variables.

> > https://github.com/linux-test-project/kirk/issues/72

> After playing with the ltp.py for a while and assisted by GPT5,
> I drafted a simple patch like below, it works from my test, can
> Do you think it's worth opening a PR to Kirk?

> --- a/libkirk/ltp.py
> +++ b/libkirk/ltp.py
> @@ -50,7 +50,7 @@ class LTPFramework(Framework):
>          self,
>          max_runtime: float = 0.0,
>          timeout: float = 30.0,
> -        env: dict = {},
> +        env: Optional[dict] = None,
>      ) -> None:
>          """
>          :param max_runtime: filter out all tests above this time value
> @@ -63,7 +63,8 @@ class LTPFramework(Framework):
>          self._logger = logging.getLogger("libkirk.ltp")
>          self._cmd_matcher = re.compile(r'(?:"[^"]*"|\'[^\']*\'|\S+)')
>          self._max_runtime = max_runtime
> -        self._root = os.environ.get("LTPROOT", "/opt/ltp")
> +        env = env or {}
> +        self._root = env.get("LTPROOT") or os.environ.get("LTPROOT")

Do I understand you want to get back --env? Would it be too hard for you to use
shell environment variable? The purpose was to simplify the code (Andrea's
concern, which I don't object because he does all the kirk work).

Also, I'm sorry to merge update without your ack, next time I'll wait for the
testing.

Kind regards,
Petr

> or "/opt/ltp"
>          self._tc_folder = os.path.join(self._root, "testcases", "bin")

>          self._env = {
> @@ -79,8 +80,7 @@ class LTPFramework(Framework):
>              if timeout:
>                  self._env["LTP_TIMEOUT_MUL"] = str((timeout * 0.9) / 300.0)

> -        if env:
> -            self._env.update(env)
> +        self._env.update(env)

>      async def _read_path(self, channel: ComChannel) -> Dict[str, str]:
>          """

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
