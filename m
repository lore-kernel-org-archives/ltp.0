Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085BCE6F060
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:37:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47D453CD741
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 15:37:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77AF93CD537
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:37:37 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 078FE23FE09
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:37:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3611421CED;
 Fri,  1 Nov 2024 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
 b=tZW+b8BBn57rJptZ/DS24vvdVnuUTM5+A5zzAIeg5dZa1tJBxBXZCVKmkkFuEHZ+Zj7A4K
 OFKZqRtnL48ZCztEB7E/DfVYZ0qHAJNQflyhF3kLG6PrLOnZMW5Hgp106scjDI5F/TEJoU
 BuEaE1KsFOtAym9PIvIRMEBh/BiXi1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730471856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
 b=0NiI5UVCtXqS4AwwlY0AOXN72DtiwTbkyHhj+DO/m75Rf9UgII/8GJ1O8cNB0pZFhCzMne
 0Jp6/69oGYAYpLCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
 b=tZW+b8BBn57rJptZ/DS24vvdVnuUTM5+A5zzAIeg5dZa1tJBxBXZCVKmkkFuEHZ+Zj7A4K
 OFKZqRtnL48ZCztEB7E/DfVYZ0qHAJNQflyhF3kLG6PrLOnZMW5Hgp106scjDI5F/TEJoU
 BuEaE1KsFOtAym9PIvIRMEBh/BiXi1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730471856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ck9LSDMaMipvJgF6iuCZtXIr9HtMH0CnwH80XNmU9+Q=;
 b=0NiI5UVCtXqS4AwwlY0AOXN72DtiwTbkyHhj+DO/m75Rf9UgII/8GJ1O8cNB0pZFhCzMne
 0Jp6/69oGYAYpLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09B7913ACC;
 Fri,  1 Nov 2024 14:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GGnTALDnJGeICwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 14:37:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 15:37:26 +0100
Message-ID: <20241101143726.1278291-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101143726.1278291-1-pvorel@suse.cz>
References: <20241101143726.1278291-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ima_boot_aggregate: TBROK on fread() failure
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ZnJlYWQoKSBzaG91bGQgcmVhZCAxIGJ5dGUsIHF1aXQgd2hlbiBpdCBmYWlscyBpdC4KClRoaXMg
Zml4ZXMgd2FybmluZzogaWdub3JpbmcgcmV0dXJuIHZhbHVlIG9mIOKAmGZyZWFk4oCZIGRlY2xh
cmVkIHdpdGgKYXR0cmlidXRlIOKAmHdhcm5fdW51c2VkX3Jlc3VsdOKAmSBbLVd1bnVzZWQtcmVz
dWx0XS4KClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgotLS0KIC4u
Li9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9zcmMvaW1hX2Jvb3RfYWdncmVnYXRlLmMg
ICAgIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
c3JjL2ltYV9ib290X2FnZ3JlZ2F0ZS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL3NyYy9pbWFfYm9vdF9hZ2dyZWdhdGUuYwppbmRleCA2OGQxMmZjM2MyLi40MjBi
MGM3MzZkIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvc3JjL2ltYV9ib290X2FnZ3JlZ2F0ZS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJp
dHkvaW50ZWdyaXR5L2ltYS9zcmMvaW1hX2Jvb3RfYWdncmVnYXRlLmMKQEAgLTExNiw3ICsxMTYs
OCBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHZvaWQpCiAJCQlicmVhazsKIAkJfQogI2VuZGlmCi0J
CWZyZWFkKGV2ZW50LmRhdGEsIGV2ZW50LmhlYWRlci5sZW4sIDEsIGZwKTsKKwkJaWYgKGZyZWFk
KGV2ZW50LmRhdGEsIGV2ZW50LmhlYWRlci5sZW4sIDEsIGZwKSAhPSAxKQorCQkJdHN0X2JyayhU
QlJPSywgImZhaWxlZCB0byByZWFkIDEgYnl0ZSIpOwogCX0KIAogCVNBRkVfRkNMT1NFKGZwKTsK
LS0gCjIuNDUuMgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
