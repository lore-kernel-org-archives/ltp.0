Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B199CEDD8B
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:22:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10CAC3C259C
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:22:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07603C042F
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:22:00 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D7A1200072
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:21:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5871021F61;
 Wed,  9 Oct 2024 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728476519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Toof0mD+hJOOyhrEHgPfdc4ft6tbDc/Lpj7voTLKio=;
 b=24GwfS5MHCN1UtaDifvVhuT411oUQLEpWH1UlvuHaIkcLqQmPW6+T93bU9wr7RJjidXCHx
 3RDmQamQyxZ9amPd2aAHtRhpekwNClVG63gMGv876KecQ2O2eDiWq+kVjbSfSWZdtSQ5/X
 eU1l6iVgJLc0aIf9EQp2xIrLoSxdaK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728476519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Toof0mD+hJOOyhrEHgPfdc4ft6tbDc/Lpj7voTLKio=;
 b=07qBT/gr/zTIOBR7QZwZvXnphvV++CDpR6OROnxNZ4a3XQ5FqDdW2l2o+zUPImA5tj0np4
 R6S0s+dsFV7OzyBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728476518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Toof0mD+hJOOyhrEHgPfdc4ft6tbDc/Lpj7voTLKio=;
 b=d1ZigYUeHCTNkH1axvT+qAyu8q0hKeCgds4MjaDW36+MD7RiieSk1dsD1Jv2KV2lh/TEXz
 FcHxS2TiCDe/aOR74VxzKr8A7dmFsoERRJvbhL8lRibDHaXudRz6B5yBcRjEAK7PcnFCzz
 P41lPF8lLwaYJj2n9L8UkJkWdsCqMCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728476518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Toof0mD+hJOOyhrEHgPfdc4ft6tbDc/Lpj7voTLKio=;
 b=sKip1rqWu21PNefaI0S9RWBnwihJYbOubf3uqbwNLIzmaQPw9iX9TU6bdv2l+gwsFLUUjb
 7SL39xjErB6qxLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464E4136BA;
 Wed,  9 Oct 2024 12:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1Dr8D2Z1BmePGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 09 Oct 2024 12:21:58 +0000
Date: Wed, 9 Oct 2024 14:20:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZwZ1KdiQDNwynzvx@yuki.lan>
References: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
 <20241008-ioctl_ficlone01_fix-v4-2-eae3adac33c9@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241008-ioctl_ficlone01_fix-v4-2-eae3adac33c9@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] Add minimum kernel requirement for FS setup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> index ee029b666..e871760e2 100644
> --- a/testcases/lib/tst_run_shell.c
> +++ b/testcases/lib/tst_run_shell.c
> @@ -156,11 +156,13 @@ enum fs_ids {
>  	MKFS_VER,
>  	MNT_FLAGS,
>  	TYPE,
> +	FS_MIN_KVER,

This is stil in the wrong place, has to be placed first.

>  };
>  
>  static ujson_obj_attr fs_attrs[] = {
>  	UJSON_OBJ_ATTR_IDX(MKFS_OPTS, "mkfs_opts", UJSON_ARR),
>  	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
> +	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),

Here as well.

>  	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
>  	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
>  	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
> @@ -235,6 +237,9 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
>  			case TYPE:
>  				ret[i].type = strdup(val->val_str);
>  			break;
> +			case FS_MIN_KVER:
> +				ret[i].min_kver = strdup(val->val_str);
> +			break;
>  			}
>  
>  		}
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
