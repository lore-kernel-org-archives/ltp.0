Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6741CA5FC7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:28:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1DEF3E55CD
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 17:28:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 553193E4C03
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:28:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D3B7E1000997
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:28:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6EA521E87;
 Wed, 30 Sep 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50A0013722;
 Wed, 30 Sep 2026 15:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WqRnA5oqvWomOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 15:28:26 +0000
Date: Wed, 30 Sep 2026 17:28:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260930152809.GC2729765@pevik>
References: <20260930-fix_generate_syscalls-v1-0-fccaef437fa1@suse.com>
 <20260930-fix_generate_syscalls-v1-1-fccaef437fa1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930-fix_generate_syscalls-v1-1-fccaef437fa1@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A6EA521E87
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] generate_arch.sh: Fix syscall extraction bugs
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Some improvements below. Feel free to ignore them and I'll send a following
patchset afterwards.
...
> -grab_syscall_names_from_unistd_h() {
>  	grep -E -h "^#define __NR_" \
> -		${LINUX_HEADERS}/usr/include/asm/unistd*.h \
> -		${LINUX_HEADERS}/usr/include/asm-generic/unistd.h \
> -		>${TEMP}/syscall-names.tosort
> +		${KERNELSRC}/include/uapi/asm-generic/unistd.h \
> +		${KERNELSRC}/arch/*/include/uapi/asm/unistd*.h \
Is the star (*) intentional? It will work, but IMHO it's not needed.

> +		>>${TEMP}/syscall-names.tosort 2>/dev/null || true

Redirecting stderr to /dev/null is effective way to hide bugs forever.
I suppose the reason here is to hide error that some file is missing.
But I'd prefer to see the "No such file or directory" errors than hide a bug,
could you remove "2>/dev/null" before the release?

Also "|| true" used due the same reason will hide any other error.
Are really some files missing? Even if yes, wouldn't be better to before loop
over the files, test if they exist with [ -f ... ] and store existing ones in
variable which you pass grep.

> +
> +	awk '{ print $1 }' ${SCRIPT_DIR}/*.in >>${TEMP}/syscall-names.tosort

>  	drop_bad_entries
>  }
> @@ -60,6 +59,7 @@ grab_syscall_names_from_unistd_h() {
>  drop_bad_entries() {
>  	grep -E -v "(unistd.h|NR3264|__NR_syscall|__SC_COMP|__NR_.*Linux|__NR_FAST)" \
>  		${TEMP}/syscall-names.tosort |
> +		grep -E -vi "(not implemented|available|unused|reserved|spill|xtensa)" |
>  		grep -E -v "(__SYSCALL|SYSCALL_BASE|SYSCALL_MASK)" |
>  		sed -e "s/#define\s*__NR_//g" -e "s/\s.*//g" |
>  		sort -u >${TEMP}/syscall-names.txt
> @@ -68,51 +68,43 @@ drop_bad_entries() {
>  generate_table() {
>  	echo "- $arch"

> +	local flags="${extraflags:-}"
>  	if [ "$bits" -eq "32" ]; then
> -		extraflags="${extraflags} -D__BITS_PER_LONG=32"
> +		flags="${flags} -D__BITS_PER_LONG=32"
>  	fi

>  	local uppercase_arch=$(echo "$arch" | tr '[:lower:]' '[:upper:]')

> -	# ignore any error generated by gcc. We want to obtain all the
> -	# available architecture syscalls for the current platform and to handle
> -	# only supported architectures later on
> -	gcc ${TEMP}/list-syscalls.c -U__LP64__ -U__ILP32__ -U__i386__ \
> +	rm -f "${TEMP}/list-syscalls"
> +	gcc "${TEMP}/list-syscalls.c" -U__LP64__ -U__ILP32__ -U__i386__ \
>  		-D${uppercase_arch} \
> -		-D__${arch}__ ${extraflags} \
> -		-I ${LINUX_HEADERS}/usr/include/ \
> -		-o ${TEMP}/list-syscalls || true
> +		-D__${arch}__ ${flags} \
> +		-I "${LINUX_HEADERS}/usr/include/" \
> +		-o "${TEMP}/list-syscalls" || {
> +		echo "Failed to compile list-syscalls for $arch" >&2
> +		if grep -Fxq "$arch" "${SUPPORTED_ARCH}"; then
> +			return 1
> +		fi
> +		return 0
> +	}

> -	${TEMP}/list-syscalls >"${TEMP}/${arch}.in.tosort"
> +	"${TEMP}/list-syscalls" >"${TEMP}/${arch}.in.tosort"

>  	sort -k2,2n "${TEMP}/${arch}.in.tosort" >"${TEMP}/${arch}.in"
>  }

>  generate_list_syscalls_c() {
> -	(
> -		printf "
> -		#include <stdio.h>
> -		#include <asm/unistd.h>
> -
> -		int main(void)
> -		{
> -		"
> -		for syscall in $(cat ${TEMP}/syscall-names.txt); do
> -			printf "
> -		#ifdef __NR_$syscall
> -			printf(\"$syscall %%d"
> -			# i know the following print is ugly, but dash and bash
> -			# treat double quoted strings in a different way and we
> -			# really need to inject '\n' character in the C code
> -			# rather than carriage return
> -			printf '\\n'
> -			printf "\", __NR_$syscall);
> -		#endif
> -		"
> -		done
> -		printf " return 0;
> -		}"
> -	) >${TEMP}/list-syscalls.c
> +	{
> +		echo "#include <stdio.h>"
> +		echo "#include <asm/unistd.h>"
> +		echo
> +		echo "int main(void)"
> +		echo "{"

I suppose you prefer many echo calls, but using cat is a standard way which is
IMHO more readable (specially if you store awk output into a variable so that
you can use single cat).

	cat << EOF
#include <stdio.h>
#include <asm/unistd.h>

int main(void)
{
EOF

> +		awk '{ printf "#ifdef __NR_%s\n\tprintf(\"%s %%d\\n\", __NR_%s);\n#endif\n", $1, $1, $1 }' \
> +			"${TEMP}/syscall-names.txt"
> +		echo "	return 0;"
> +		echo "}"
> +	} >"${TEMP}/list-syscalls.c"
>  }

>  export_headers() {
> @@ -128,16 +120,16 @@ do_all_tables() {
>  		extraflags=

>  		case ${arch} in
> -		Kconfig)
> -			continue
> -			;;
> -		um)
> +		Kconfig|um)

+1, at least newer model can write a decent code.

I still consider it brave to have long shell script (specially if one generates
them with LLM) :).

>  			continue
>  			;;
>  		esac

> +		if [ ! -f "${archdir}/Makefile" ] && [ ! -f "${archdir}/Kconfig" ]; then
I would check only for Kconfig, that's enough (there is no arch which would not
have it).

> +			continue
> +		fi
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
