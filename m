Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C0C433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 08:23:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AD3D3C8FC9
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:23:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34E433C0E12
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:22:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A78171001F37
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 09:22:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C21E11F466;
 Fri, 17 Dec 2021 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639729369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VTgfgQWkkeF1DTJY+7WP7oVOIR428fjqNPI/njV930=;
 b=de2MRx7ZiX7/8/zbXohW+vhl830NshDUiIi4bbBX3n+8PC9LMkk33s2Md246o9VLvVgWyH
 wZPg90uTY3S2+Qbvm4tgWYMu/2kycJutwc3ebcE61MUByxz075EM7oyyWEyMOilPFVvVSo
 9quxKubZ2WJ1MBQKmt5Si7ksswARpE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639729369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VTgfgQWkkeF1DTJY+7WP7oVOIR428fjqNPI/njV930=;
 b=FEv46ctQN7LImoBL7+BV3Hkw3WStRiNchn0cG6SKQZ/1hgId7B2Tjjmmj5AvANzft9IPn+
 58WSCc+Iqc4RAWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9127913F21;
 Fri, 17 Dec 2021 08:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7W+tIdlIvGHKcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Dec 2021 08:22:49 +0000
Date: Fri, 17 Dec 2021 09:22:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbxI10d517WiDMHW@pevik>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639552849-2251-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] zram/zram03: Convert into new api
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

Hi Xu,

> Also add hot_add/hot_remove in setup/cleanup, so this case can adapt the situation that
> zram module is being used by zram-generator or zram module is builtin.
Very nice. Again, I like you added both CONFIG_ZRAM=y support and simultaneous
run.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
...
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * This case check whether data read from zram device is consistent with
> + * thoese are written.
>   */

> +
nit: I'd remove this extra line
>  #include <sys/types.h>
>  #include <sys/stat.h>

...
>  	if (i != SIZE - 1) {
> -		tst_resm(TFAIL, "expect size: %ld, actual size: %ld.",
> +		tst_res(TFAIL, "expect size: %ld, actual size: %ld.",
>  			 SIZE - 1, i);
>  	} else if (s[i] != '\0') {
> -		tst_resm(TFAIL, "zram device seems not null terminated");
> +		tst_res(TFAIL, "zram device seems not null terminated");
>  	} else if (fail) {
> -		tst_resm(TFAIL, "%ld failed bytes found.", fail);
> +		tst_res(TFAIL, "%ld failed bytes found", fail);
>  	} else {
> -		tst_resm(TPASS, "data read from zram device is consistent "
> +		tst_res(TPASS, "data read from zram device is consistent "
>  			 "with those are written");
nit: I'd join this line (less than over 100)
>  	}

...
> +static void setup(void)
> +{
> +	const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
> +	int hot_add_fd;
> +
> +	if (!access(ZRAM_CONTROL_PATH, F_OK)) {
> +		hot_add_fd = SAFE_OPEN(HOT_ADD_PATH, O_RDONLY);
> +		SAFE_READ(0, hot_add_fd, &buf, 20);
> +		dev_num = atoi(buf);
> +		SAFE_CLOSE(hot_add_fd);
> +		hot_add_flag = 1;
We have SAFE_FILE_SCANF(), you can use just:
		SAFE_FILE_SCANF(HOT_ADD_PATH, "%d", &dev_num);

> +	} else {
> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
> +		modprobe = 1;
> +	}
> +	sprintf(zram_block_path, "/sys/block/zram%d", dev_num);
> +	sprintf(zram_dev_path, "/dev/zram%d", dev_num);
> +}
> +
> +static void cleanup(void)
> +{
> +	const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};
> +	int hot_remove_fd;
> +
> +	if (hot_add_flag) {
> +		hot_remove_fd = SAFE_OPEN(HOT_REMOVE_PATH, O_WRONLY);
> +		SAFE_WRITE(0, hot_remove_fd, buf, 20);
> +		SAFE_CLOSE(hot_remove_fd);
> +	}
Ad here
	if (hot_add_flag)
		SAFE_FILE_PRINTF(HOT_REMOVE_PATH, "%d", dev_num);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
