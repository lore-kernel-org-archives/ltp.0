Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3047BC67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 07:35:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384F13CE730
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 09:35:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 887673CE1A6
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 09:34:56 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 74C511000DB0
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 09:34:54 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A12D1F786;
 Fri,  5 Apr 2024 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712302494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfhRR5uzCnLfnK0TbkhSGYxGfL+aAPc0jsYAjnQC1zc=;
 b=ynf7Estb7papTJ4zyKZrR9UEoqWNXJk7OTt69LajnabPYQZDdjrz4z5dWHU3qX2n+RNFZm
 u88qQUv/0hPljL9Mtpsz7dvdiMywrwuWHYPvl5aWlPbc6FsipV0EpP9DfZOYGnijFI2ijg
 i6c2H/I3CU6Cgl/OggODa9Nzfke6e0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712302494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfhRR5uzCnLfnK0TbkhSGYxGfL+aAPc0jsYAjnQC1zc=;
 b=FAE+6hYVABIZUq42DheV8r2ThfmjEuQS/p7EtZG6nMjXo+N58ZO9nR3HLDDzVEZvrY1uLV
 ydni8Dx0W+YWiVDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712302493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfhRR5uzCnLfnK0TbkhSGYxGfL+aAPc0jsYAjnQC1zc=;
 b=wy81ofQSicw10km8q5QtGn+2EIrKTCcCwFN4fM4Oj3jC9mus2CzqumOvUzyeK/6JGup++s
 vkAKjs0rC9t04YknWHNkVC3dqv5iwaAAMie1tDdUJzsl5CULzXxStrwzakhEyC0lpkGCpD
 T2TJTny7nMsTNrdyY4M81HEXhldsUDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712302493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfhRR5uzCnLfnK0TbkhSGYxGfL+aAPc0jsYAjnQC1zc=;
 b=GyDkP7gKJWYD0aEMbDNuhnVzCO13zNpO+Up5EQzgnq1+2YOqVr2dzA+lmdXiztHMM7H/Mb
 E55+yFfGpmw6WcDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04EC1139F1;
 Fri,  5 Apr 2024 07:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id bJ0oAJ2pD2bKMAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 05 Apr 2024 07:34:53 +0000
Date: Fri, 5 Apr 2024 09:34:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: yangfeng59949 <yangfeng59949@163.com>
Message-ID: <20240405073451.GA601301@pevik>
References: <20240329154715.7130-1-yangfeng59949@163.com>
 <20240404135323.GB526878@pevik>
 <386395b4.21c5.18ead090cbb.Coremail.yangfeng59949@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <386395b4.21c5.18ead090cbb.Coremail.yangfeng59949@163.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[163.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[163.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sctp: bugfix for
 utils/sctp/func_tests/test_1_to_1_events.c
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
Cc: yangfeng <yangfeng@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgo+IEhpLDxici8+VGhhbmtzIGZvciBnZXR0aW5nIGJhY2sgdG8gbWUuPGJyLz48YnIvPmdj
YyAoR0NDKSA3LjMuMDxici8+TGludXggbG9jYWxob3N0LmxvY2FsZG9tYWluIDQuMTkuOTAtODku
Ni52MjQwMS5reTEwLmFhcmNoNjQgIzEgU01QIFRodSBNYXIgMTQgMjA6MDY6MTAgQ1NUIDIwMjQg
YWFyY2g2NCBhYXJjaDY0IGFhcmNoNjQgR05VL0xpbnV4PGJyLz5NYW51ZmFjdHVyZXJzIElE77ya
ICAgICAgICAgICAgICAgICAgIEhpU2lsaWNvbjxici8+QklPUyBWZW5kb3IgSUQ6ICAgICAgICAg
ICAgICAgICAgICAgICAgUUVNVTxici8+TW9kZWwgbmFtZe+8miAgICAgICAgICAgICAgICAgICAg
ICAgICAgS3VucGVuZy05MjA8YnIvPkJJT1MgTW9kZWwgbmFtZTogICAgICAgICAgICAgICAgICAg
IHZpcnQtNC4xPGJyLz48YnIvPktpbmQgcmVnYXJkcyw8YnIvPnlhbmdmZW5nCgpUaGFua3MgZm9y
IGluZm8sIG1lcmdlZC4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
