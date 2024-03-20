Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A4FC54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:21:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BD593CFFAB
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:21:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873243CFBF2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:47 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F02231A01212
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 034E5347B3;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N5okU6y+i4U/cx//Ws7K9UARLcEY1Pem920T3NtmTfo=;
 b=DsZuo7fNsTST2m4R82fXNxP8zWWyyBOFc2CrOUTc8nMUuXvMpLxiYBqaFHFwS7ng9rt6CQ
 pikpj89cDuV47STqEXc/lifqxgTTpwkdWeKBZ7U3PDHSgCZpuXTkttbsMsybb4IgNdkyBj
 zZ8xE9kvePFs2lKp1F38t+/5sPan3jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N5okU6y+i4U/cx//Ws7K9UARLcEY1Pem920T3NtmTfo=;
 b=Ib+dVGh/m4u+N7lfHoA2JSG16FprFnPShB5I7szttMVx8gapct+EEduSA15UJ0AZwdkU6U
 IEhzDuCEPSehaCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N5okU6y+i4U/cx//Ws7K9UARLcEY1Pem920T3NtmTfo=;
 b=DsZuo7fNsTST2m4R82fXNxP8zWWyyBOFc2CrOUTc8nMUuXvMpLxiYBqaFHFwS7ng9rt6CQ
 pikpj89cDuV47STqEXc/lifqxgTTpwkdWeKBZ7U3PDHSgCZpuXTkttbsMsybb4IgNdkyBj
 zZ8xE9kvePFs2lKp1F38t+/5sPan3jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N5okU6y+i4U/cx//Ws7K9UARLcEY1Pem920T3NtmTfo=;
 b=Ib+dVGh/m4u+N7lfHoA2JSG16FprFnPShB5I7szttMVx8gapct+EEduSA15UJ0AZwdkU6U
 IEhzDuCEPSehaCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1482136D6;
 Wed, 20 Mar 2024 16:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fN2gNd0M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:44 +0100
Message-Id: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANwM+2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0MT3bzU8vjy1KTizJJUXeMkc1MD02RzE6NUEyWgjoKi1LTMCrBp0bG
 1tQAM0l1pXQAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.34 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.04)[57.54%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/10] New LTP documentation
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

The new LTP documentation is meant to use Sphinx as the main
documentation framework, with ReconStructedText as the main language.
All the conversion has been done step-by-step, each chapter at time,
updating english syntax and fixing typos. There are minor improvements,
but overall the structure is the same.

C / Networking / KVM API are not documented yet, because they will be
probably integrated in the LTP library. C API documentation is already
on going, but the others not.

For a demo, please take a look at:

https://ltp-acerv.readthedocs.io/en/latest/index.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (10):
      Add the new basics documentation
      Add new mailing list setup documentation
      Rewrite writing tests guidelines documentation
      Refactor patch review guidelines documentation
      Refactor LTP release procedure documentation
      Refactor debugging documentation
      Refactor LTP library guidelines documentation
      Refactor build system documentation
      Refactor test case tutorial documentation
      Introduce kernel-doc API support

 .readthedocs.yml                              |   15 +
 doc_new/.gitignore                            |    1 +
 doc_new/Makefile                              |    5 +
 doc_new/_static/custom.css                    |    4 +
 doc_new/conf.py                               |   26 +
 doc_new/developers/api_c_tests.rst            |    7 +
 doc_new/developers/api_kvm_tests.rst          |    7 +
 doc_new/developers/api_network_tests.rst      |    7 +
 doc_new/developers/api_shell_tests.rst        |    4 +
 doc_new/developers/build_system.rst           |  213 +++++
 doc_new/developers/debugging.rst              |   21 +
 doc_new/developers/ltp_library.rst            |   42 +
 doc_new/developers/setup_mailinglist.rst      |   50 ++
 doc_new/developers/test_case_tutorial.rst     | 1038 +++++++++++++++++++++++++
 doc_new/developers/writing_tests.rst          |  537 +++++++++++++
 doc_new/index.rst                             |  124 +++
 doc_new/maintainers/ltp_release_procedure.rst |  173 +++++
 doc_new/maintainers/patch_review.rst          |  171 ++++
 doc_new/requirements.txt                      |    2 +
 doc_new/users/quick_start.rst                 |  126 +++
 doc_new/users/setup_tests.rst                 |  104 +++
 doc_new/users/supported_systems.rst           |  110 +++
 22 files changed, 2787 insertions(+)
---
base-commit: 6c37214b32d6632bec79f864d2435149b1768f3b
change-id: 20240314-new_website-3b7505c742e4

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
