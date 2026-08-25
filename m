Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78CBC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 15:08:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5768C3C7152
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:08:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83A43C5816
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 17:08:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39182600A1D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 17:08:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 655D41F7F5;
 Tue, 25 Aug 2026 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787670476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AzsMDSa19qkv0QMFTKIZk/j6/GmZGS8UNIqNp8Oghc=;
 b=1C1D8Rip6hKt0VQXsv5zlNcWdia5lExVAkdVcsiRpJhMm67K5an6KqZ4niAgENheh+16FR
 O/N561Pi9z+Oof8QjOeynYR7HTv4S9RTBkQB7iT7wmFoDuP8oYHXwgNPFjtv2vCiGRPcA5
 0vAyr6CTHyZecCeSZW53SRT8waUgH4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787670476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AzsMDSa19qkv0QMFTKIZk/j6/GmZGS8UNIqNp8Oghc=;
 b=P0mdIIonhGERk53H6GvnhYHiZjz1g03TWanHdvWRdOzadt5iIiUw6VIkJyNP8JKaKbAIdc
 XVCs+LEP0RQDJ1Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787670472;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AzsMDSa19qkv0QMFTKIZk/j6/GmZGS8UNIqNp8Oghc=;
 b=NTL+8zjkDB7MygXMsGfbBG2STp0MJghIQ4BnOpbu20w5n4O1ZazTdQ4/VPgrT9HBmHFbVM
 BG7nyjzf+jnnCdxEMYTFoVf+qOsPRgPhqHUWjwCdLNEbEqUIDIzHnSUkgHga3rRhPAaagY
 0Gmk5YmMwwwR2v/fTGTC19uj+HIji94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787670472;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AzsMDSa19qkv0QMFTKIZk/j6/GmZGS8UNIqNp8Oghc=;
 b=hEhAyo+7THDWvyZamKowDXH2PYYuwQojW3K8nICC8yZKMaCRJDHKm8r8lz9rn6zXYE1Mt5
 7ILfMshc2JlUmEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C0A713331;
 Tue, 25 Aug 2026 15:07:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WZ6QAcivjWoEHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 15:07:52 +0000
Date: Tue, 25 Aug 2026 17:07:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260825150749.GA86472@pevik>
References: <20260825-sctphantom_fix-v1-1-6504f91fd7f5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260825-sctphantom_fix-v1-1-6504f91fd7f5@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve/sctphantom: fix EINVAL on pre-v4.19 kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> The test passed its 156 byte mirror of struct sctp_paddrparams, which
> includes the spp_ipv6_flowlabel and spp_dscp tail, to
> SCTP_PEER_ADDR_PARAMS. Kernels older than v4.19 only accept
> optlen == sizeof(struct sctp_paddrparams), which is 152 there, so the
> setsockopt() failed and the test broke:

>     sctphantom.c:361: TBROK: setsockopt(6, 132, 9, 0x..., 156) failed: EINVAL (22)

> Drop the tail fields from the mirrored struct so that the option length
> matches the pre-v4.19 layout. That length is also accepted by v4.19 and
> newer kernels as the compat size introduced along with the tail fields
> by upstream commit 0b0dce7a36fb ("sctp: add spp_ipv6_flowlabel and
> spp_dscp for sctp_paddrparams"), provided the SPP_DSCP and
> SPP_IPV6_FLOWLABEL flags are not set, which the test never does.

Indeed, it was added in 0b0dce7a36fb ("sctp: add spp_ipv6_flowlabel and spp_dscp
for sctp_paddrparams") in v4.19-rc1. Thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -/* Mirror of the uapi struct sctp_paddrparams */
> +/*
> + * Mirror of the uapi struct sctp_paddrparams without the spp_ipv6_flowlabel
> + * and spp_dscp tail added in v4.19: older kernels require optlen == 152,
> + * while v4.19 and newer also accept the pre-v4.19 length.
> + */
>  struct tst_sctp_paddrparams {
> -	int32_t		spp_assoc_id;
> +	int32_t			spp_assoc_id;
>  	struct sockaddr_storage	spp_address;
> -	uint32_t	spp_hbinterval;
> -	uint16_t	spp_pathmaxrxt;
> -	uint32_t	spp_pathmtu;
> -	uint32_t	spp_sackdelay;
> -	uint32_t	spp_flags;
> -	uint32_t	spp_ipv6_flowlabel;
> -	uint8_t		spp_dscp;
> +	uint32_t		spp_hbinterval;
> +	uint16_t		spp_pathmaxrxt;
> +	uint32_t		spp_pathmtu;
> +	uint32_t		spp_sackdelay;
> +	uint32_t		spp_flags;
>  } __attribute__((packed, aligned(4)));

nit: I suppose you copy paste the older struct, which used a different
whitespace. But how about (before merge) just remove spp_ipv6_flowlabel and
spp_dscp? Without touching whitespace of the other members is change more
visible even without using --ignore-space-change.

Kind regards,
Petr

+++ testcases/cve/sctphantom.c
@@ -62,7 +62,11 @@
 #define ADDR_DUMMY	"127.0.0.254"	/* third path to keep transport_count > 1 */
 #define ADDR_SPOOF	"127.0.0.3"	/* forged ASCONF packet source */
 
-/* Mirror of the uapi struct sctp_paddrparams */
+/*
+ * Mirror of the uapi struct sctp_paddrparams without the spp_ipv6_flowlabel
+ * and spp_dscp tail added in v4.19: older kernels require optlen == 152,
+ * while v4.19 and newer also accept the pre-v4.19 length.
+ */
 struct tst_sctp_paddrparams {
 	int32_t			spp_assoc_id;
 	struct sockaddr_storage	spp_address;
@@ -71,8 +75,6 @@ struct tst_sctp_paddrparams {
 	uint32_t		spp_pathmtu;
 	uint32_t		spp_sackdelay;
 	uint32_t		spp_flags;
-	uint32_t	spp_ipv6_flowlabel;
-	uint8_t		spp_dscp;
 } __attribute__((packed, aligned(4)));
 
 /* Mirror of the uapi struct sctp_paddrinfo */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
