Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54762C6FD1F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:21:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1FF3D0045
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:21:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45BE23CFBF2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F6C91001185
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 439FE347BA;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rttOSaNhiBXV6/MrRJZcLSBG3hEKd9lcoqVKu/LFLhY=;
 b=TGllzSpQpAp3lLa+cSaYQjHt5MkUyBkgf+SDuoyKXjtiskszTdFumEsAqIkrsoncKZOJhn
 dZ9FeajZjUt3RdRVMm2Oy8BvAns+wyKej8aC6JsSsi0B+5hW/nUbp4wjz3KSlOeEHwB2FP
 Kz6vzb5ngSs+feRvdR6cIa+yfqt1M4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rttOSaNhiBXV6/MrRJZcLSBG3hEKd9lcoqVKu/LFLhY=;
 b=Z42Rk4fQYDXGu9R1vny5RgW7YR8x68HjnWMGJi38Lh1xxYWgsr8MoVkRRFa6wx1/8azSJf
 PXlFT6I1/2tB+yCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rttOSaNhiBXV6/MrRJZcLSBG3hEKd9lcoqVKu/LFLhY=;
 b=TGllzSpQpAp3lLa+cSaYQjHt5MkUyBkgf+SDuoyKXjtiskszTdFumEsAqIkrsoncKZOJhn
 dZ9FeajZjUt3RdRVMm2Oy8BvAns+wyKej8aC6JsSsi0B+5hW/nUbp4wjz3KSlOeEHwB2FP
 Kz6vzb5ngSs+feRvdR6cIa+yfqt1M4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rttOSaNhiBXV6/MrRJZcLSBG3hEKd9lcoqVKu/LFLhY=;
 b=Z42Rk4fQYDXGu9R1vny5RgW7YR8x68HjnWMGJi38Lh1xxYWgsr8MoVkRRFa6wx1/8azSJf
 PXlFT6I1/2tB+yCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B07013974;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UAYoCd4M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:46 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-2-79b603c8aea1@suse.com>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.it:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/10] Add new mailing list setup documentation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Mailing list setup documentation explains how to setup the email in
order to send patches to the LTP mailing list.
---
 doc_new/developers/setup_mailinglist.rst | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/doc_new/developers/setup_mailinglist.rst b/doc_new/developers/setup_mailinglist.rst
index b7320b9a2..1eee0ae9f 100644
--- a/doc_new/developers/setup_mailinglist.rst
+++ b/doc_new/developers/setup_mailinglist.rst
@@ -2,3 +2,49 @@
 
 Setting up the Mailing list
 ===========================
+
+Before using ``git send-email``, you need to set up your email client to send
+emails from the command line. This typically involves configuring an SMTP server
+and authentication details.
+
+Open a terminal and configure Git with your email settings using the following
+commands:
+
+.. code-block:: bash
+
+    git config --global sendemail.from "Your Name <your_email@example.com>"
+    git config --global sendemail.smtpserver "smtp.example.com"
+    git config --global sendemail.smtpuser "your_email@example.com"
+    git config --global sendemail.smtpserverport 587
+    git config --global sendemail.smtpencryption tls
+
+Replace ``smtp.example.com`` with the SMTP server address provided by your email
+provider. Replace ``your_email@example.com`` with your email address. Adjust the
+SMTP port and encryption settings according to your email provider's
+requirements.
+
+To test the configuration you can use ``--dry-run`` parameter.
+
+.. code-block:: bash
+
+    git send-email --dry-run --to "ltp@lists.linux.it" --subject "Test Email" --body "This is a test email." HEAD^
+
+Depending on your SMTP server's configuration, you may need to authenticate
+before sending emails. If required, configure authentication settings using:
+
+.. code-block:: bash
+
+    git config --global sendemail.smtpuser "your_email@example.com"
+    git config --global sendemail.smtppass "your_password"
+
+Replace ``your_email@example.com`` with your email address and ``your_password``
+with your email account password.
+
+For any corner case, please take a look at the
+`email + git <https://git-send-email.io/>`_ documentation.
+
+.. note::
+
+    This method still works in most of the cases, but nowadays we often
+    require to setup a two factor authentication. If this is the case, please
+    consider setting up Git accordingly.

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
