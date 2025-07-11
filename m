Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF3C8303C
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 11:33:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 592943CAD82
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 13:33:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24DDA3C6BC7
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 13:32:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E4FF1A00704
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 13:32:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4B711F7DC;
 Fri, 11 Jul 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEF321388B;
 Fri, 11 Jul 2025 11:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1ysyLkn2cGgaFgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Jul 2025 11:32:25 +0000
Date: Fri, 11 Jul 2025 13:33:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aHD2cISM0-xPAHz_@yuki.lan>
References: <20250620154346.19864-1-chrubis@suse.cz>
 <20250620154346.19864-3-chrubis@suse.cz>
 <c712df4f-2438-4376-8c21-c20b623a5bfa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c712df4f-2438-4376-8c21-c20b623a5bfa@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D4B711F7DC
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] metaparse: Map arrays with designated
 initializers to JSON objects
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This patch is actually causing documentation build failure due to the =

> way we are defining .hugepages as:
> =

>  =A0=A0=A0 .hugepages =3D {TST_NO_HUGEPAGES},
> =

> The shmget02 metadata (for instance) will have an empty hugepages =

> dictionary:

Ah, right, I've missed a special case in the C structure parsing.

This on the top of the patchset fixes the problem:

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index e9e9aee10..36736ac06 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -379,13 +379,17 @@ static int array_is_hash(FILE *f)
        long pos =3D ftell(f);
        int has_ids =3D 1;
        int elem_seen =3D 0;
+       int comma_last =3D 0;
        int in_id =3D 1;
        char *token;

        while ((token =3D next_token(f, NULL))) {

-               if (!strcmp(token, "}"))
+               if (!strcmp(token, "}")) {
+                       if (in_id && !comma_last)
+                               has_ids =3D 0;
                        goto ret;
+               }

                elem_seen =3D 1;

@@ -419,8 +423,12 @@ static int array_is_hash(FILE *f)
                        }

                        in_id =3D 1;
+
+                       comma_last =3D 1;
                } else if (!strcmp(token, "=3D")) {
                        in_id =3D 0;
+               } else {
+                       comma_last =3D 0;
                }
        }


I will send a new version.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
