Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A84EC87FD3
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 07:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C14D3CA3C5
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 09:38:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D6263C033E
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 09:38:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A396060066C
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 09:38:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9284333DFA;
 Fri,  8 Aug 2025 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754638697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDLMoXomU5OMI79RH8W9PQ12K8XoyD0uItCITrHQ3Jg=;
 b=W3YV6xdhJDMlnPKJWIlLevz4ITqrLlw2shVQRqJO2rb5pav11GBxoRyB4/fTwcv1QkchIJ
 LwIJKs9ZK81ifAqNmr39B6mvqI/h3x3c0sC187XAHpSZf8IUL5XEWbWp/3OKvEUyVXBZpb
 J+OUYudylzO+CAItKh+0P+TJc7l9Lmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754638697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDLMoXomU5OMI79RH8W9PQ12K8XoyD0uItCITrHQ3Jg=;
 b=OEA/46aaaajyfV6RYDO3n5VdwSL75szJI56A4vhNV+YgD4+N6LyORz+ckUqwT0rMov0GOM
 kO8COX0TlJbzalCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W3YV6xdh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="OEA/46aa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754638697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDLMoXomU5OMI79RH8W9PQ12K8XoyD0uItCITrHQ3Jg=;
 b=W3YV6xdhJDMlnPKJWIlLevz4ITqrLlw2shVQRqJO2rb5pav11GBxoRyB4/fTwcv1QkchIJ
 LwIJKs9ZK81ifAqNmr39B6mvqI/h3x3c0sC187XAHpSZf8IUL5XEWbWp/3OKvEUyVXBZpb
 J+OUYudylzO+CAItKh+0P+TJc7l9Lmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754638697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDLMoXomU5OMI79RH8W9PQ12K8XoyD0uItCITrHQ3Jg=;
 b=OEA/46aaaajyfV6RYDO3n5VdwSL75szJI56A4vhNV+YgD4+N6LyORz+ckUqwT0rMov0GOM
 kO8COX0TlJbzalCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B5DA1392A;
 Fri,  8 Aug 2025 07:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yw9CFWmplWiVMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 07:38:17 +0000
Date: Fri, 8 Aug 2025 09:38:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250808073814.GB410227@pevik>
References: <20250804184850.313101-1-pvorel@suse.cz>
 <aJFVNdvkdfqPFsse@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJFVNdvkdfqPFsse@localhost>
X-Rspamd-Queue-Id: 9284333DFA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] rpc_test.sh: Check for rpcbind remote calls
 support
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
Cc: linux-nfs@vger.kernel.org,
 Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>,
 libtirpc-devel@lists.sourceforge.net, ltp@lists.linux.it,
 Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Aug 04, 2025 at 08:48:50PM +0200, Petr Vorel wrote:
> > client binaries rpc_pmap_rmtcall and tirpc_rpcb_rmtcall require rpcbind
> > compiled with remote calls.  rpcbind has disabled remote calls by
> > default in 1.2.5. But this was not detectable until 1.2.8, which brought
> > this info in -v flag.

> > Detect the support and skip on these 2 functions when disabled.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> >  testcases/network/rpc/rpc-tirpc/rpc_test.sh | 5 +++++
> >  1 file changed, 5 insertions(+)

> > diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> > index cadae55203..1a8cf46399 100755
> > --- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> > +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> > @@ -53,6 +53,11 @@ setup()
> >  		fi
> >  	fi

> > +	if [ "$CLIENT" = 'rpc_pmap_rmtcall' -o "$CLIENT" = 'tirpc_rpcb_rmtcall' ] && \
> > +		rpcbind -v 2>/dev/null && rpcbind -v 2>&1 | grep -q 'remote calls: no'; then
> > +		tst_brk TCONF "skip due rpcbind compiled without remote calls"
> > +	fi
> Should we check rpcbind version? Since you mentioned remove call
> detectable until 1.2.8.

We would not get any benefit from it. The check skips tests only when remote
calls are disabled and it's detectable. 'rpcbind -v' is on >= 1.2.8, therefore
'rpcbind -v 2>/dev/null &&' is hidden check for rpcbind >= 1.2.8.

But looking at the code it's confusing and 'rpcbind -v 2>/dev/null && ' is
redundant (as '-v' certainly does not produce wanted output on rpcbind < 1.2.8),
therefore I'll send v2:

-               rpcbind -v 2>/dev/null && rpcbind -v 2>&1 | grep -q 'remote calls: no'; then
+               rpcbind -v 2>&1 | grep -q 'remote calls: no'; then

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
