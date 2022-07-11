Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E8CC43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 06:09:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02D0B3CA5A2
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 08:09:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FA6D3CA502
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:09:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6456D1A001C7
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:09:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9414C1FE77;
 Mon, 11 Jul 2022 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657519771;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XWVwsi7tzbYzufflxaCrbo95YDY6SSigG7wThbcj80=;
 b=D5GL3maWB4snx6xP0ELvg9KRXPymAgvuChvXRcQyxkOlytnRi9ZHv/Y0ggjjvbVWw4vyVW
 Tv20rS3dRkpUkk5anQhZhu/whQ7RxDK5r8I5UA446mwlCuYOT1n/2ZlrUHLYw8x33BpJGZ
 Cov4QWCmtd7Z4+3TietA1cJ/22kNx4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657519771;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XWVwsi7tzbYzufflxaCrbo95YDY6SSigG7wThbcj80=;
 b=ate5DbA9j79ruz1w/YvgSB5R+Bw229ZrMqUeF9T0q5ZJiEV3Doq3OmTgWEvK2Oyw0ftOGi
 O6lV4vwT0nbL6qCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 620DF13322;
 Mon, 11 Jul 2022 06:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 74V8Fpu+y2LpbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 06:09:31 +0000
Date: Mon, 11 Jul 2022 08:09:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <Ysu+mbkO8eUP4A2+@pevik>
References: <1656937069-17098-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1656937069-17098-1-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc01: fix variable not initialized
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
Cc: libtirpc-devel@lists.sourceforge.net, ltp@lists.linux.it,
 Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Cc Steve and libtirpc-devel ML ]

> when error occurred in function callrpc/clnt_call, return_buffer may
> be leaved not initialized.So initialize return_buffer to NULL,and
> retrieve the return_buffer->data when return_buffer is really assigned.

Shouldn't be rc used for verification?

man callrpc(3):
int callrpc(...);
...
This routine returns zero if it succeeds, or the value of enum clnt_stat cast to
an integer if it fails. The routine clnt_perrno() is handy for translating
failure statuses into messages.

Kind regards,
Petr

> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  testcases/network/rpc/basic_tests/rpc01/rpc1.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

> diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
> index bc9f35b..5691c06 100644
> --- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
> +++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
> @@ -24,7 +24,7 @@ void usage_error(char *program_name);
>  int main(int argc, char *argv[])
>  {
>  	struct hostent *hp;
> -	struct data buffer, *return_buffer;
> +	struct data buffer, *return_buffer = NULL;
>  	int i, n, rc;
>  	FILE *fp;
>  	struct stat stat_buffer;
> @@ -128,7 +128,8 @@ int main(int argc, char *argv[])
>  	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
>  			(char *)&buffer, (xdrproc_t)xdr_receive_data,
>  			(char *)&return_buffer);
> -	do_compare(rc, "callrpc", &buffer, return_buffer->data);
> +	do_compare(rc, "callrpc", &buffer,
> +				return_buffer ? return_buffer->data : NULL);

>  	server_sin.sin_port = 0;
>  	sock = RPC_ANYSOCK;
> @@ -145,7 +146,8 @@ int main(int argc, char *argv[])
>  				(char *)&buffer, (xdrproc_t)xdr_receive_data,
>  				(char *)&return_buffer, timeout);
>  	clnt_destroy(clnt);
> -	do_compare(rc, "udp transport", &buffer, return_buffer->data);
> +	do_compare(rc, "udp transport", &buffer,
> +				return_buffer ? return_buffer->data : NULL);

>  	server_sin.sin_port = 0;
>  	sock = RPC_ANYSOCK;
> @@ -160,7 +162,8 @@ int main(int argc, char *argv[])
>  				(char *)&buffer, (xdrproc_t)xdr_receive_data,
>  				(char *)&return_buffer, timeout);
>  	clnt_destroy(clnt);
> -	do_compare(rc, "tcp transport", &buffer, return_buffer->data);
> +	do_compare(rc, "tcp transport", &buffer,
> +				return_buffer ? return_buffer->data : NULL);

>  	exit(0);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
