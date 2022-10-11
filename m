Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0DDC433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 08:48:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74F553CAE8E
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 10:48:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E22C3C3030
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 10:48:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 06C11600917
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 10:48:07 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 166D821954;
 Tue, 11 Oct 2022 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665478087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x44McQrofZdn0xhv8+oaDPSQ3DMWsOQNfCZy+oYJWc4=;
 b=uUGQ+08fbX7v0yOw6HXO5J0qyuxoK9nESnzEGyjvB7nLp8/NO+QBTyyhoIjhxHDQD6St0p
 T3ag0f9CoyVwzklKZsfhk/YjMAmbSxUvSeqdnuF9a30jMjl/vEdF1Y3A0rEk6m9uRg8rH1
 iepejCm1s9eLg45cgFC3o6bFA0K+oag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665478087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x44McQrofZdn0xhv8+oaDPSQ3DMWsOQNfCZy+oYJWc4=;
 b=COlpLai9RSSC9m4Eb9Ug/7tF4fYXOAEIPG7I3OvRxtNyhiT13u9CnAga3d/GMXG+4G8jqn
 uZpkUCmbt6Y6fgBQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3C4DA2C141;
 Tue, 11 Oct 2022 08:48:06 +0000 (UTC)
References: <Ysu+mbkO8eUP4A2+@pevik>
 <1657608229-6189-1-git-send-email-zhanghongchen@loongson.cn>
 <871qrfak22.fsf@suse.de> <Y0Qu7IEihZcYK46i@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Oct 2022 09:36:08 +0100
In-reply-to: <Y0Qu7IEihZcYK46i@pevik>
Message-ID: <87sfju9262.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rpc01: fix variable not initialized
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Steve Dickson <steved@redhat.com>,
 libtirpc-devel@lists.sourceforge.net,
 Hongchen Zhang <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>
>> Hello,
>
>> Looks OK to me, Petr?
>
>> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> I replied at ML at v1 [1] with a question to use rc for verification.
> I'm not sure whether it was me who marked the question as superseded.

Probably me.

>
> @Hongchen you sent v1 twice, v2 twice. Duplicate send without your reply does
> not speedup things. Please next time reply with ping (but if you don't reply to
> the question, ball is on your side).

I'll mark this as changes requested.

TBH I think the test needs rewriting in the new API in pure C. So this
is likely to be wasted effort.

>
> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/ltp/Ysu+mbkO8eUP4A2+@pevik/
> [2] https://patchwork.ozlabs.org/project/ltp/list/?submitter=84160&state=*
>
>> Hongchen Zhang <zhanghongchen@loongson.cn> writes:
>
>> > when error occurred in function callrpc/clnt_call, return_buffer may
>> > be leaved not initialized.
>> > As Petr said, we should check the return value before retrieve the
>> > return_buffer->data. Change do_compare's parameter from char * to
>> > struct data * to fix it.
>
>> > Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> > ---
>> >  testcases/network/rpc/basic_tests/rpc01/rpc1.c | 14 ++++++++------
>> >  1 file changed, 8 insertions(+), 6 deletions(-)
>
>> > diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
>> > index bc9f35b..6b8619d 100644
>> > --- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
>> > +++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
>> > @@ -18,7 +18,8 @@ char *file_name = NULL;
>> >  char host_name[100];
>> >  long host_address;
>
>> > -void do_compare(int, char *, struct data *, char *);
>> > +void do_compare(int rpc_rc, char *msg, struct data *buffer,
>> > +			struct data *ret_buffer)
>> >  void usage_error(char *program_name);
>
>> >  int main(int argc, char *argv[])
>> > @@ -128,7 +129,7 @@ int main(int argc, char *argv[])
>> >  	rc = callrpc(server, program, version, 1, (xdrproc_t)xdr_send_data,
>> >  			(char *)&buffer, (xdrproc_t)xdr_receive_data,
>> >  			(char *)&return_buffer);
>> > -	do_compare(rc, "callrpc", &buffer, return_buffer->data);
>> > +	do_compare(rc, "callrpc", &buffer, return_buffer);
>
>> >  	server_sin.sin_port = 0;
>> >  	sock = RPC_ANYSOCK;
>> > @@ -145,7 +146,7 @@ int main(int argc, char *argv[])
>> >  				(char *)&buffer, (xdrproc_t)xdr_receive_data,
>> >  				(char *)&return_buffer, timeout);
>> >  	clnt_destroy(clnt);
>> > -	do_compare(rc, "udp transport", &buffer, return_buffer->data);
>> > +	do_compare(rc, "udp transport", &buffer, return_buffer);
>
>> >  	server_sin.sin_port = 0;
>> >  	sock = RPC_ANYSOCK;
>> > @@ -160,12 +161,13 @@ int main(int argc, char *argv[])
>> >  				(char *)&buffer, (xdrproc_t)xdr_receive_data,
>> >  				(char *)&return_buffer, timeout);
>> >  	clnt_destroy(clnt);
>> > -	do_compare(rc, "tcp transport", &buffer, return_buffer->data);
>> > +	do_compare(rc, "tcp transport", &buffer, return_buffer);
>
>> >  	exit(0);
>> >  }
>
>> > -void do_compare(int rpc_rc, char *msg, struct data *buffer, char *ret_data)
>> > +void do_compare(int rpc_rc, char *msg, struct data *buffer,
>> > +			struct data *ret_buffer)
>> >  {
>> >  	int rc;
>
>> > @@ -175,7 +177,7 @@ void do_compare(int rpc_rc, char *msg, struct data *buffer, char *ret_data)
>> >  		printf("\n");
>> >  		exit(1);
>> >  	}
>> > -	rc = memcmp(buffer->data, ret_data, buffer->data_length);
>> > +	rc = memcmp(buffer->data, ret_buffer->data, buffer->data_length);
>> >  	if (rc) {
>> >  		printf("Data compare for %s returned %d\n", msg, rc);
>> >  		exit(1);
>> > -- 
>> > 1.8.3.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
