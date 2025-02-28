Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BC6C282C5
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 11:49:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93C6F3C6C97
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 12:49:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28523C58A4
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 12:49:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C165B620A98
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 12:49:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8585D21166;
 Fri, 28 Feb 2025 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740743345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91Uh6eTjWX57LU2Rh4PRQII7avzlm0XqUJxRFgGMTFU=;
 b=muWPlww4SZSwZxM1UOUEY5lCruIQUQrp1QUgOzaZL4W00OtADxlCmV9YeKunxuX/7wvYw2
 KZSFH1v5v7BpZ9s8NX6ATGeQDEFO77OrWK2+0rKWfsyAtT+V4ljUSM64EnDpsRUpVdA+Ts
 alwR7Ej5vdSSn/4G9qF5cMNV+kVQRvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740743345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91Uh6eTjWX57LU2Rh4PRQII7avzlm0XqUJxRFgGMTFU=;
 b=4E3s1nI3Z5qqHe9ko0Yh8lf7J1q8itaxoAiUNJtFV0sssHGnrqd3rVK7K9k1N1Xmf2vH3x
 4eyKsXfgIAl1xtCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=muWPlww4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4E3s1nI3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740743345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91Uh6eTjWX57LU2Rh4PRQII7avzlm0XqUJxRFgGMTFU=;
 b=muWPlww4SZSwZxM1UOUEY5lCruIQUQrp1QUgOzaZL4W00OtADxlCmV9YeKunxuX/7wvYw2
 KZSFH1v5v7BpZ9s8NX6ATGeQDEFO77OrWK2+0rKWfsyAtT+V4ljUSM64EnDpsRUpVdA+Ts
 alwR7Ej5vdSSn/4G9qF5cMNV+kVQRvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740743345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91Uh6eTjWX57LU2Rh4PRQII7avzlm0XqUJxRFgGMTFU=;
 b=4E3s1nI3Z5qqHe9ko0Yh8lf7J1q8itaxoAiUNJtFV0sssHGnrqd3rVK7K9k1N1Xmf2vH3x
 4eyKsXfgIAl1xtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62D461344A;
 Fri, 28 Feb 2025 11:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nQ3yFrGiwWfTfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 11:49:05 +0000
Date: Fri, 28 Feb 2025 12:49:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20250228114903.GA3228400@pevik>
References: <20250214112135.18947-1-chrubis@suse.cz>
 <20250214112135.18947-2-chrubis@suse.cz>
 <20250214133727.GA2221874@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250214133727.GA2221874@pevik>
X-Rspamd-Queue-Id: 8585D21166
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] testcases/lib/run_tests.sh
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > Enable TESTS_TBROK

> > diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> > index 0abca2f3c..168dbb451 100755
> > --- a/testcases/lib/run_tests.sh
> > +++ b/testcases/lib/run_tests.sh
> > @@ -90,6 +90,7 @@ run_tests()

> >  run_tests 0 $TESTS_PASS
> >  run_tests 32 $TESTS_TCONF
> > +run_tests 2 $TESTS_TBROK

> Maybe also add $TESTS_FAIL (untested)?
> run_tests 1 $TESTS_FAIL

> Fixes: 29d8613dbd ("testcases/lib/run_tests.sh: Check expected results")
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

I dared to merge this obvious fix with adding also $TESTS_FAIL:
https://github.com/linux-test-project/ltp/commit/a92aedfabd5826d07809559508c8486c12ff7b96

+ sort by exit code, see following diff.

Thanks!

Kind regards,
Petr

> Thanks!

> Kind regards,
> Petr

+++ testcases/lib/run_tests.sh
@@ -89,8 +89,9 @@ run_tests()
 }
 
 run_tests 0 $TESTS_PASS
-run_tests 32 $TESTS_TCONF
+run_tests 1 $TESTS_FAIL
 run_tests 2 $TESTS_TBROK
+run_tests 32 $TESTS_TCONF
 
 echo
 echo "*** Testing LTP test -h option ***"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
