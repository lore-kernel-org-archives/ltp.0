Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CDDE77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:39:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 145313C1BA3
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 14:39:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F59E3C02C4
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:39:27 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E3261413E4B
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:39:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C427E1F385;
 Wed,  8 Jan 2025 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736343566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLB19kx46kLV0szkicOCVgLzsN7Zh4f8DwRO/h8SvqQ=;
 b=B/O5sd+CrWH3JVUc05IqWbu1yq37RjSBIX3UezIQrn8UZ9xWYS/mNmhMXysDl3sYkLZ0OF
 UiBycyy8AoidbrDdKxDMGGiR0bdl/YcppcUkQlIIs8gSUvoEMmMbM2T0PReSEi9h+8311x
 0CfXrA7bj3NfbUYiHVjG0HIMo9C8+H4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736343566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLB19kx46kLV0szkicOCVgLzsN7Zh4f8DwRO/h8SvqQ=;
 b=0ZoDrtZryf+vJ+wRXdz6t6KCBR1FeygS2nBTnqxGkkU5fdE8YoU8uFFZ5C/rkGQYfYNKSq
 B4wR+f6pu0q3A8AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LOQXkOCl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mNrSHRd+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736343565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLB19kx46kLV0szkicOCVgLzsN7Zh4f8DwRO/h8SvqQ=;
 b=LOQXkOClPpjLPH9FUWQqHEkFvplu1KD8PV3+Pc6n92TydvyrjHVduTZbGDlS4uqvD2+a93
 EzWz/qqC67qmS8vE3j+VKfWREJuWJxuR2qphbcRgoY0PPtz1CAm381fT3TRM/nr+BR5Vgb
 tIlIs+E2Z7Ac5Bty1Z1Bbf/Qgt0M+bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736343565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLB19kx46kLV0szkicOCVgLzsN7Zh4f8DwRO/h8SvqQ=;
 b=mNrSHRd+qeSwxNnDEzHRbFYsbaBX8xKkrfjeeDE8DbtlCv1DuC1ND8I2dLgP9hHg/EKviq
 fniYb9s9JLrMmmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A74F7137DA;
 Wed,  8 Jan 2025 13:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhl7Jw2AfmfJOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jan 2025 13:39:25 +0000
Date: Wed, 8 Jan 2025 14:39:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250108133920.GA30914@pevik>
References: <20240603103553.8318-1-wegao@suse.com>
 <20241217061636.16366-1-wegao@suse.com>
 <20241217061636.16366-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241217061636.16366-2-wegao@suse.com>
X-Rspamd-Queue-Id: C427E1F385
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] ptrace05: Refactor the test using new LTP
 API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Generally LGTM, with few mostly formatting notes below.
Thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
...
> +/*\
> + * [Description]
>   *
> - *   You should have received a copy of the GNU General Public License along
> - *   with this program; if not, write to the Free Software Foundation, Inc.,
> - *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + * This test ptraces itself as per arbitrarily specified signals,
> + * over 0 to SIGRTMAX range.
>   *
nit: could you please pay a bit of attention to the blank lines like this one?
It's also in print_dbg_sig() and test_signal().
> - ******************************************************************************
>   */

> -int usage(const char *);
> -
> -int usage(const char *argv0)
> +static void print_dbg_sig(int signum)
>  {
> -	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
> -	return 1;
> +
> +	char const *strsig = tst_strsig(signum);
> +
> +	if (strstr(strsig, "???")) {
> +		tst_res(TDEBUG, "[child] Sending kill(.., %d)",
> +				signum);
> +	} else {
> +		tst_res(TDEBUG, "[child] Sending kill(.., %s)",
> +				strsig);
nit: this could be in a single line (below 80 or 90 chars), thus without {}
(readability).

static void print_dbg_sig(int signum)
{
	char const *strsig = tst_strsig(signum);

	if (strstr(strsig, "???"))
		tst_res(TDEBUG, "[child] Sending kill(.., %d)", signum);
	else
		tst_res(TDEBUG, "[child] Sending kill(.., %s)", strsig);
}

> +	}
>  }

> -int main(int argc, char **argv)
> +static void test_signal(int signum)
>  {

> -	int end_signum = -1;
> -	int signum;
> -	int start_signum = -1;
>  	int status;
> -
>  	pid_t child;

> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	child = SAFE_FORK();
> +
> +	if (!child) {
> +		TST_EXP_PASS_SILENT(ptrace(PTRACE_TRACEME, 0, NULL, NULL));

> -	if (start_signum == -1) {
> -		start_signum = 0;
> +		print_dbg_sig(signum);
> +		SAFE_KILL(getpid(), signum);
> +		exit(0);
>  	}
> -	if (end_signum == -1) {
> -		end_signum = SIGRTMAX;
> +
> +	SAFE_WAITPID(child, &status, 0);
> +
> +	switch (signum) {
> +	case 0:
> +		if (WIFEXITED(status)
> +				&& WEXITSTATUS(status) == 0) {
> +			tst_res(TPASS,
> +					"kill(.., 0) exited with 0, as expected.");
> +		} else {
> +			tst_res(TFAIL,
> +					"kill(.., 0) exited with unexpected %s.", tst_strstatus(status));
> +		}
> +		break;
> +	case SIGKILL:
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
> +			tst_res(TPASS, "Child killed by SIGKILL");
> +		else
> +			tst_res(TFAIL, "Child %s", tst_strstatus(status));
> +		break;
> +		/* All other processes should be stopped. */
> +	default:
> +		if (WIFSTOPPED(status))
> +			tst_res(TDEBUG, "Stopped as expected");
> +		else {
nit: if else uses { }, if should use them as well.

https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

	This does not apply if only one branch of a conditional statement is a single
	statement; in the latter case use braces in both branches

> +			tst_res(TFAIL, "Didn't stop as expected. Child %s", tst_strstatus(status));
> +			expect_stop++;
> +		}
> +		break;
>  	}
...

> +	if (expect_stop == 0)
nit: if (!expect_stop)

> +		tst_res(TPASS, "Stopped as expected");
> +	else
> +		tst_res(TFAIL, "Didn't stop as expected, total %d cases failed", expect_stop);
>  }
We don't need another TFAIL it just repeats another TFAIL.

IMHO also TPASS should not be needed (we always get TPASS/TFAIL result for
signum == 0), but it does not harm.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
