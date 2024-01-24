Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C6C47DDF
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 12:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B2323CE1F2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 13:35:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75C513C7676
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:34:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29B056000FD
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:34:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00E161F7EF;
 Wed, 24 Jan 2024 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706099684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zIcBU8P135jg89dRWhFAfhzmXQffa+5V7qtwvm768xs=;
 b=jvMwJ33EqJ/E258tnpynoT94JVPTMMBbN1wagwraAwprirHDvd12NsMjpc34V/WONadGKV
 capzMiAJpmNE4UngWy2ZvnqIbIadhmumI5DZfR/617H+KO1Bn1MUZbh4L4xk2sicQrO2LQ
 e+MPRSdGU189qbYoEr36oIxnqYq6SKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706099684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zIcBU8P135jg89dRWhFAfhzmXQffa+5V7qtwvm768xs=;
 b=uCoEZi3tlBMf4L+gpu3Ckp5itcJ+TcTqNPEZ5lzABqq2ja3+oTRzT9Cw6ca5nqXaz4ILDh
 EvAys8sy6d6Va7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706099684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zIcBU8P135jg89dRWhFAfhzmXQffa+5V7qtwvm768xs=;
 b=jvMwJ33EqJ/E258tnpynoT94JVPTMMBbN1wagwraAwprirHDvd12NsMjpc34V/WONadGKV
 capzMiAJpmNE4UngWy2ZvnqIbIadhmumI5DZfR/617H+KO1Bn1MUZbh4L4xk2sicQrO2LQ
 e+MPRSdGU189qbYoEr36oIxnqYq6SKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706099684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zIcBU8P135jg89dRWhFAfhzmXQffa+5V7qtwvm768xs=;
 b=uCoEZi3tlBMf4L+gpu3Ckp5itcJ+TcTqNPEZ5lzABqq2ja3+oTRzT9Cw6ca5nqXaz4ILDh
 EvAys8sy6d6Va7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0CF1333E;
 Wed, 24 Jan 2024 12:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 75SnNeMDsWVSNQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Jan 2024 12:34:43 +0000
Message-ID: <9f884555-dbd3-46f8-8eaf-000815bf404c@suse.cz>
Date: Wed, 24 Jan 2024 13:34:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240123162647.210424-1-pvorel@suse.cz>
 <20240123162647.210424-5-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240123162647.210424-5-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-8.28 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.969];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] network: Fix tst_brk TFAIL
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
two comments below.

On 23. 01. 24 17:26, Petr Vorel wrote:
> It needs to be replaced with tst_res TFAIL and return
> 
> Fixes: 1878502f6 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/network/nfs/nfs_stress/nfs06.sh     |  5 ++++-
>   testcases/network/stress/route/route-lib.sh   |  8 +++++--
>   testcases/network/stress/ssh/ssh-stress.sh    | 16 ++++++++++----
>   testcases/network/tcp_cmds/host/host01.sh     |  5 +++--
>   .../network/tcp_cmds/ipneigh/ipneigh01.sh     | 21 ++++++++++++-------
>   testcases/network/virt/virt_lib.sh            | 12 +++++++----
>   testcases/network/xinetd/xinetd_tests.sh      |  7 ++++---
>   7 files changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs06.sh b/testcases/network/nfs/nfs_stress/nfs06.sh
> index 560df05b1..09e55fe34 100755
> --- a/testcases/network/nfs/nfs_stress/nfs06.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs06.sh
> @@ -34,7 +34,10 @@ do_test()
>   
>   	tst_res TINFO "waiting for pids:$pids"
>   	for p in $pids; do
> -		wait $p || tst_brk TFAIL "fsstress process failed"
> +		if ! wait $p; then
> +			tst_res TFAIL "fsstress process failed"
> +			return
> +		fi
>   		tst_res TINFO "fsstress '$p' completed"
>   	done
>   	pids=
> diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
> index 163c15423..29aa2e913 100644
> --- a/testcases/network/stress/route/route-lib.sh
> +++ b/testcases/network/stress/route/route-lib.sh
> @@ -97,10 +97,14 @@ test_netlink()
>   	tst_res TINFO "running $cmd $opt"
>   	$cmd $opt || ret=$?
>   	if [ "$ret" -ne 0 ]; then
> -		[ $((ret & 3)) -ne 0 ] && \
> -			tst_brk TFAIL "$cmd failed"
> +		if [ $((ret & 3)) -ne 0 ]; then
> +			tst_res TFAIL "$cmd failed"
> +			return
> +		fi
> +
>   		[ $((ret & 32)) -ne 0 ] && \
>   			tst_brk TCONF "not supported configuration"
> +
>   		[ $((ret & 4)) -ne 0 ] && \
>   			tst_res TWARN "$cmd has warnings"
>   	fi
> diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
> index e7c4d45ce..c27c27a28 100755
> --- a/testcases/network/stress/ssh/ssh-stress.sh
> +++ b/testcases/network/stress/ssh/ssh-stress.sh
> @@ -93,8 +93,10 @@ IdentityFile $TST_TMPDIR/id_rsa\n\" > $RHOST_SSH_CONF"
>   
>   test_ssh_connectivity()
>   {
> -	tst_rhost_run -c "$RHOST_SSH 'true >/dev/null 2>&1' >/dev/null"
> -	[ $? -ne 0 ] && tst_brk TFAIL "SSH not reachable"
> +	if ! tst_rhost_run -c "$RHOST_SSH 'true >/dev/null 2>&1' >/dev/null"; then
> +		tst_res TFAIL "SSH not reachable"
> +		return
> +	fi
>   }
>   
>   test1()
> @@ -121,7 +123,10 @@ test1()
>   		[ $? -ne 0 ] && num=$((num + 1))
>   	done
>   
> -	[ $num -ne 0 ] && tst_brk TFAIL "$num ssh processes died unexpectedly during execution"
> +	if [ $num -ne 0 ]; then
> +		tst_res TFAIL "$num ssh processes died unexpectedly during execution"
> +		return
> +	fi
>   
>   	test_ssh_connectivity
>   
> @@ -216,7 +221,10 @@ test3()
>   
>   	# Setup an ssh tunnel from the remote host to testhost
>   	tst_rhost_run -c "$RHOST_SSH -f -N -L $lport:$rhost:$port </dev/null >/dev/null 2>&1"
> -	[ "$?" -ne 0 ] && tst_brk TFAIL "Failed to create an SSH session with port forwarding"
> +	if [ "$?" -ne 0 ]; then
> +		tst_res TFAIL "Failed to create an SSH session with port forwarding"
> +		return
> +	fi
>   	RHOST_PIDS=$(tst_rhost_run -c "pgrep -f '^ssh .*$lport:$rhost:$port'")
>   
>   	# Start the TCP traffic clients
> diff --git a/testcases/network/tcp_cmds/host/host01.sh b/testcases/network/tcp_cmds/host/host01.sh
> index 6a4067495..9ed44bae3 100755
> --- a/testcases/network/tcp_cmds/host/host01.sh
> +++ b/testcases/network/tcp_cmds/host/host01.sh
> @@ -21,11 +21,12 @@ do_test()
>   	if addr=$(host $lhost); then
>   		addr=$(echo "$addr" | grep address | tail -1 | awk '{print $NF}')
>   		if [ -z "$addr" ]; then
> -			tst_brk TFAIL "empty address"
> +			tst_res TFAIL "empty address"
> +			return
>   		fi
>   		EXPECT_PASS host $addr \>/dev/null
>   	else
> -		tst_brk TFAIL "host $lhost on local machine failed"
> +		tst_res TFAIL "host $lhost on local machine failed"
>   	fi
>   }
>   
> diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> index e67ff5cc8..4b818357e 100755
> --- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> +++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
> @@ -57,8 +57,10 @@ do_test()
>   
>   	for i in $(seq 1 $NUMLOOPS); do
>   
> -		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null || \
> -			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
> +		if ! ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null; then
> +			tst_res TFAIL "cannot ping $(tst_ipaddr rhost)"
> +			return
> +		fi
>   
>   		local k
>   		local ret=1
> @@ -66,19 +68,22 @@ do_test()
>   			$SHOW_CMD | grep -q $(tst_ipaddr rhost)
>   			if [ $? -eq 0 ]; then
>   				ret=0
> -				break;
> +				break
>   			fi
>   			tst_sleep 100ms
>   		done
>   
> -		[ "$ret" -ne 0 ] && \
> -			tst_brk TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
> +		if [ "$ret" -ne 0 ]; then
> +			tst_res TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
> +			return
> +		fi
>   
>   		$DEL_CMD
>   
> -		$SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)" && \
> -			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
> -				"$(tst_hwaddr rhost)' $i/$NUMLOOPS"
> +		if $SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)"; then
> +			tst_res TFAIL "'$DEL_CMD' failed, entry has $(tst_hwaddr rhost)' $i/$NUMLOOPS"
> +			return
> +		fi
>   	done
>   
>   	tst_res TPASS "verified adding/removing $entry_name cache entry"
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index d7e694eb7..0aadbfdb9 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -174,8 +174,10 @@ virt_multiple_add_test()
>   	tst_res TINFO "add $NS_TIMES $virt_type, then delete"
>   
>   	for i in $(seq $start_id $max); do
> -		virt_add ltp_v$i id $i $opt || \
> -			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
> +		if ! virt_add ltp_v$i id $i $opt; then
> +			tst_res TFAIL "failed to create 'ltp_v0 $opt'"
> +			return

This is a library function so tst_brk TBROK is probably the correct fix 
here. Also, the message should say ltp_v$i instead of ltp_v0, but that's 
for a separate patch.

> +		fi
>   		ROD_SILENT "ip link set ltp_v$i up"
>   	done
>   
> @@ -196,8 +198,10 @@ virt_add_delete_test()
>   	tst_res TINFO "add/del $virt_type $NS_TIMES times"
>   
>   	for i in $(seq 0 $max); do
> -		virt_add ltp_v0 $opt || \
> -			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
> +		if ! virt_add ltp_v0 $opt; then
> +			tst_res TFAIL "failed to create 'ltp_v0 $opt'"
> +			return

Same here.

> +		fi
>   		ROD_SILENT "ip link set ltp_v0 up"
>   		ROD_SILENT "ip link delete ltp_v0"
>   	done
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index 505dae5d7..25ec91d26 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -91,9 +91,10 @@ xinetd_test()
>   
>   	for a in $check_addr; do
>   		p=$(echo $pattern | sed "s/ADDR/$a/")
> -		echo '' | telnet $a 2>&1 | grep -qiE "$p"
> -		[ $? -ne 0 ] && \
> -			tst_brk TFAIL "not expected output for 'telnet $a'"
> +		if ! echo '' | telnet $a 2>&1 | grep -qiE "$p"; then
> +			tst_res TFAIL "not expected output for 'telnet $a'"
> +			return
> +		fi
>   	done
>   	tst_res TPASS "expected output with telnet $desc"
>   }

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
