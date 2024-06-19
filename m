Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AE5C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 16:31:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 022863D0DCE
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 18:31:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B7073D081B
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:31:30 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3FF3360083F
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:31:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3ACE21A30;
 Wed, 19 Jun 2024 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718814689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQhvcvk07vxZFl3ntSALl+TBJc5TBOkPcq8jKjI6sN8=;
 b=dFDDrtWmkC6WJV4o1kRfPlr5mya1EG237YuA6bj0khQ/bv4KlWpTUXPmbapkMHh/hd15Ql
 Xknc6DqlTmvcpj+EmaYf6XopqAxyA87lEoGzPciHhXg+CNCEhKPEQFXDYtgngZ9439w64+
 4s3O+WKkrQSLBJ7sf/9WhN+j+P0tSEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718814689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQhvcvk07vxZFl3ntSALl+TBJc5TBOkPcq8jKjI6sN8=;
 b=Ve1rjUqVveo78MN520fbsn7nDTiqy7n2biT4HwhgOl1jkTS35OfyF+s7OjLzck8Z4qOjO/
 9EsWf0IjggchStDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718814688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQhvcvk07vxZFl3ntSALl+TBJc5TBOkPcq8jKjI6sN8=;
 b=MjkDRl7x7Uu00ahFzHIlhbPbY/aZWZHtbcAuCBl3pM9oYIOzveme4rOhd66es5PCItsYdz
 xr6fA09Lb438qhQ229P52BX6z9fI4EABZqLtxhivJWtuJyNOeTHFFZknf3wHOZF0yA4Ley
 oQJ2+3mmGte1yCujfwSdTNmM9r8+6Uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718814688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQhvcvk07vxZFl3ntSALl+TBJc5TBOkPcq8jKjI6sN8=;
 b=VMR+yxxhjcrRgXXKhWUdA6mopBvUgnzJffaO6zmi9v0CrGKo7N3v4YPJNWkHSmUMmTqu4j
 TUadWQ81s1t0hzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB30513AAA;
 Wed, 19 Jun 2024 16:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hs9BJuAHc2aYOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 16:31:28 +0000
Date: Wed, 19 Jun 2024 18:31:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20240619163126.GA493392@pevik>
References: <20240613075348.696575-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240613075348.696575-1-po-hsu.lin@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] logrotate: fix permission issue on Ubuntu
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

> When running this logrotate test on Ubuntu, the test will fail with:
>   logrotate_tests 2 TINFO: sleep 1 min to wait for rotating logs
>   logrotate_tests 2 TFAIL: [ -f /var/log/tst_largelogfile.1.gz ] failed unexpectedly
>   logrotate_tests 2 TFAIL: Failed to create a compressed file

> Look more closely to what this test is trying to do we will see there
> are two issues here in the tst_largelog.conf:

> 1. "include /etc/logrotate.d"
> This will rotate other log files defined here, since we are just testing
> the log rotation capibility I think there is no need to rotate log files
> other than the one for this test.

> 2. Permission issue on Ubuntu
Is it only Ubuntu or also Debian? Or, wouldn't be better to add permissions
regardless the system?

> Trying to rotate the target file on Ubuntu will cause the following error:
>   error: skipping "/var/log/tst_largelogfile" because parent directory has
>          insecure permissions (It's world writable or writable by group which
>          is not "root") Set "su" directive in config file to tell logrotate
>          which user/group should be used for rotation.

> Solution is to add an extra line with the user and group information of
> the /var/log directory. This change has been limited to Ubuntu to prevent
> causing regression on other OS.

> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  testcases/commands/logrotate/logrotate_tests.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
> index 1f3e61294..4506ab5c6 100755
> --- a/testcases/commands/logrotate/logrotate_tests.sh
> +++ b/testcases/commands/logrotate/logrotate_tests.sh
> @@ -90,14 +90,17 @@ test1()

>  test2()
>  {
> +	permission=""
missing keyboard local (it.d be local permission, ="" not needed). But it's
better to put it into setup function to be executed only once (one can run kind
of stress tests with -i1000, permission detection will be needed only once.

> +	if `grep -q 'NAME="Ubuntu"' /etc/os-release 2>/dev/null`; then
`` are not needed. Also grepping ID would be slightly more readable:

> +		permission="su `stat -c "%U %G" /var/log`"
Do we really need to use su? It would have to be installed and configured.
IMHO it should be OK to to run stat without su.

> +	fi


>  	cat >tst_largelog.conf <<-EOF
>          # create new (empty) log files after rotating old ones
>          create
>          # compress the log files
>          compress
> -        # RPM packages drop log rotation information into this directory
> -        include /etc/logrotate.d
>          /var/log/tst_largelogfile {
> +            $permission
>              rotate 5
>              size=2k
>          }

I propose these changes over your patch. Could you please test it?

+++ testcases/commands/logrotate/logrotate_tests.sh
@@ -25,8 +25,18 @@ TST_NEEDS_CMDS="crontab file grep logrotate"
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_CNT=2
+TST_SETUP=setup
 TST_CLEANUP=cleanup
 
+PERMISSION=
+
+setup()
+{
+	if grep 'ID=ubuntu' /etc/os-release 2>/dev/null; then
+		PERMISSION="$(stat -c "%U %G" /var/log)"
+	fi
+}
+
 cleanup()
 {
 	(crontab -l | grep -v tst_largelog) | crontab -
@@ -90,17 +100,13 @@ test1()
 
 test2()
 {
-	permission=""
-	if `grep -q 'NAME="Ubuntu"' /etc/os-release 2>/dev/null`; then
-		permission="su `stat -c "%U %G" /var/log`"
-	fi
 	cat >tst_largelog.conf <<-EOF
         # create new (empty) log files after rotating old ones
         create
         # compress the log files
         compress
         /var/log/tst_largelogfile {
-            $permission
+            $PERMISSION
             rotate 5
             size=2k
         }
---

Or, even without condition on PERMISSION.

With these changes, you may add.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

+++ testcases/commands/logrotate/logrotate_tests.sh
@@ -21,7 +21,7 @@
 # - Add messages to the logfile until it gets rotated when a re-dittermined size
 #   is reached.
 
-TST_NEEDS_CMDS="crontab file grep logrotate"
+TST_NEEDS_CMDS="crontab file grep logrotate stat"
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_CNT=2
@@ -32,9 +32,7 @@ PERMISSION=
 
 setup()
 {
-	if grep 'ID=ubuntu' /etc/os-release 2>/dev/null; then
-		PERMISSION="$(stat -c "%U %G" /var/log)"
-	fi
+	PERMISSION="$(stat -c "%U %G" /var/log)"
 }
 
 cleanup()


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
