From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Feb 2021 09:07:58 +0100
Subject: [LTP] [PATCH] netns_helper: Make iproute version check work
 correctly
In-Reply-To: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <YCOUXtwBk0ZPjDL3@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhu,

thank you for working on this. I also started to work on this before LTP
release, trying to fix it in the API, because there are more tests affected by
this (there is also mc_cmds.sh).

My WIP is to create tst_iproute_version.c, which would be used by shell and C tests.
I actually wanted to go little bit further to have general C helper for getting
version (but that'd have to wait after this is fixed). But as you were faster
I'll let you to finish it.

...
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> index a5b77a0..bec43ac 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -50,6 +50,15 @@ tst_check_iproute()
>  	local cur_ipver="$(ip -V)"
>  	local spe_ipver="$1"

> +	echo $cur_ipver | grep "ip utility, iproute2-ss" > /dev/null
> +	ret1=$?
> +	echo $cur_ipver | grep "ip utility, iproute2-" > /dev/null
> +	ret2=$?
> +
> +	if [ $ret1 -ne 0 -a $ret2 -eq 0 ]; then
> +		return
> +	fi
> +

FYI my shell version.

Kind regards,
Petr

--- testcases/kernel/containers/netns/netns_helper.sh
+++ testcases/kernel/containers/netns/netns_helper.sh
@@ -47,16 +47,21 @@ IFCONF_IN6_ARG=
 
 tst_check_iproute()
 {
-	local cur_ipver="$(ip -V)"
-	local spe_ipver="$1"
+	local current_ver="$(ip -V)"
+	local expected_ver="111010"
 
-	cur_ipver=${cur_ipver##*s}
+	current_ver=${current_ver##*s}
 
-	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
+	if [ -z "$current_ver" -o -z "$expected_ver" ]; then
 		tst_brk TBROK "failed to obtain valid iproute version"
 	fi
 
-	if [ $cur_ipver -lt $spe_ipver ]; then
+	# new version scheme since v5.7.0-77-gb687d1067169
+	if echo "$current_ver" | grep -q 'iproute2-v\?[0-9]\+\.'; then
+		return
+	fi
+
+	if [ $current_ver -lt $expected_ver ]; then
 		tst_brk TCONF "too old iproute version"
 	fi
 }
