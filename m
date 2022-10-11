Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A48FC433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 14:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E8693CAEA1
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 16:35:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56E433C07B4
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 16:35:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32B6B2000A6
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 16:34:59 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 91F7620B93;
 Tue, 11 Oct 2022 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665498899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4bqtmSh0ZJW3TstH0kbqHini/Xs49ap/UoEDD9Owr0=;
 b=lHwNfCy2aGIjODD2oVG3TMLRVYE5lv35StfISww3mxzqlMcyHvj42JB6Eafr01JxTJfzg2
 +XC9Ppr7Wf2DYFzqEi25tAmiKS6nf6JIhyftldYWRU1HoyA13AdNSU9ulKXRXkSni4aLtb
 5gpQ8FPXoF9jvRxhuOKFn3IkVIxeorY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665498899;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4bqtmSh0ZJW3TstH0kbqHini/Xs49ap/UoEDD9Owr0=;
 b=Sb1E/LIJf5FjKo5n0B8MeHf/nF9AvNq7qDqRei5j5rZkXO/1xZNS5N7ViNzxeEESjYiIRc
 zmFp4zxSnUiBBjDw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3434A2C142;
 Tue, 11 Oct 2022 14:34:59 +0000 (UTC)
References: <20220817133700.233524-1-tudor.cretu@arm.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tudor Cretu <tudor.cretu@arm.com>
Date: Tue, 11 Oct 2022 15:17:37 +0100
In-reply-to: <20220817133700.233524-1-tudor.cretu@arm.com>
Message-ID: <87sfju5sz1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] IDcheck: Add check for root user/group
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tudor Cretu <tudor.cretu@arm.com> writes:

> Some tests (e.g. getgid, getegid, etc.) need to have a valid user id and
> group for root. Add the check to IDcheck.sh. Also, make a user and a group
> for root if necessary.


Merged! Although this might be better handled in the tests or test
library (e.g. add tst_test options for what a test needs in /etc/passwd
and /etc/group).

>
> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>  IDcheck.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/IDcheck.sh b/IDcheck.sh
> index 591695915..c6c41b965 100755
> --- a/IDcheck.sh
> +++ b/IDcheck.sh
> @@ -26,9 +26,11 @@ echo "Checking for required user/group ids"
>  echo ""
>  
>  # Check ids and create if needed.
> +NO_ROOT_ID=1
>  NO_NOBODY_ID=1
>  NO_BIN_ID=1
>  NO_DAEMON_ID=1
> +NO_ROOT_GRP=1
>  NO_NOBODY_GRP=1
>  NO_BIN_GRP=1
>  NO_DAEMON_GRP=1
> @@ -49,7 +51,7 @@ fe() {
>  prompt_for_create() {
>  	if [ -z "$CREATE_ENTRIES" ] ; then
>  
> -		if [ $NO_NOBODY_ID -ne 0 -o $NO_BIN_ID -ne 0 -o $NO_DAEMON_ID -ne 0 -o $NO_NOBODY_GRP -ne 0 -o $NO_BIN_GRP -ne 0 -o $NO_DAEMON_GRP -ne 0 -o $NO_USERS_GRP -ne 0 -o $NO_SYS_GRP -ne 0 ] ; then
> +		if [ $NO_ROOT_ID -ne 0 -o $NO_NOBODY_ID -ne 0 -o $NO_BIN_ID -ne 0 -o $NO_DAEMON_ID -ne 0 -o $NO_ROOT_GRP -ne 0 -o $NO_NOBODY_GRP -ne 0 -o $NO_BIN_GRP -ne 0 -o $NO_DAEMON_GRP -ne 0 -o $NO_USERS_GRP -ne 0 -o $NO_SYS_GRP -ne 0 ] ; then
>  			echo -n "If any required user ids and/or groups are missing, would you like these created? [y/N]"
>  			read ans
>  			case "$ans" in
> @@ -74,10 +76,12 @@ for i in "$passwd" "$group"; do
>      fi
>  done
>  
> +fe root "$passwd"; NO_ROOT_ID=$?
>  fe bin "$passwd"; NO_BIN_ID=$?
>  fe daemon "$passwd"; NO_DAEMON_ID=$?
>  fe nobody "$passwd"; NO_NOBODY_ID=$?
>  
> +fe root "$group"; NO_ROOT_GRP=$?
>  fe bin "$group"; NO_BIN_GRP=$?
>  fe daemon "$group"; NO_DAEMON_GRP=$?
>  fe nobody "$group" || fe nogroup "$group"; NO_NOBODY_GRP=$?
> @@ -91,9 +95,11 @@ debug_vals() {
>  echo "Missing the following group / user entries:"
>  echo "Group file:		$group"
>  echo "Password file:		$passwd"
> +echo "root			$NO_ROOT_ID"
>  echo "nobody:			$NO_NOBODY_ID"
>  echo "bin:			$NO_BIN_ID"
>  echo "daemon:			$NO_DAEMON_ID"
> +echo "root grp:			$NO_ROOT_GRP"
>  echo "nobody[/nogroup] grp:	$NO_NOBODY_GRP"
>  echo "bin grp:			$NO_BIN_GRP"
>  echo "daemon grp:		$NO_DAEMON_GRP"
> @@ -130,6 +136,7 @@ make_user_group() {
>  		fi
>  	fi
>  }
> +make_user_group root 0 $NO_ROOT_ID $NO_ROOT_GRP
>  make_user_group nobody 65534 $NO_NOBODY_ID $NO_NOBODY_GRP
>  make_user_group bin 1 $NO_BIN_ID $NO_BIN_GRP
>  make_user_group daemon 2 $NO_DAEMON_ID $NO_DAEMON_GRP
> @@ -149,7 +156,7 @@ fi
>  MISSING_ENTRY=0
>  
>  # For entries that exist in both $group and $passwd.
> -for i in bin daemon; do
> +for i in root bin daemon; do
>      for file in "$group" "$passwd"; do
>          if ! fe "$i" "$file"; then
>              MISSING_ENTRY=1
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
