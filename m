From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 12 Dec 2018 14:54:57 +0300
Subject: [LTP] [PATCH v2 5/6] shell: Add tst_security.sh helper
In-Reply-To: <20181207123516.30867-6-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
 <20181207123516.30867-6-pvorel@suse.cz>
Message-ID: <0fabb62a-e758-80f8-79e1-e3d4ccec7ede@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 07.12.2018 15:35, Petr Vorel wrote:
> It prints info about AppArmor and SELinux and allows to disable it.
> This is due some false positives because improper usage or bugs
> in AppArmor profiles (e.g. traceroute, dnsmasq).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> 
...
>  
> -	if [ "$TST_NEEDS_ROOT" = 1 ]; then
> +	if [ "$TST_NEEDS_ROOT" = 1 ] || [ "$TST_DISABLE_APPARMOR" = 1 ] || [ "$TST_DISABLE_SELINUX" = 1 ]; then
>  		if [ "$(id -ru)" != 0 ]; then
>  			tst_brk TCONF "Must be super/root for this test!"
>  		fi
>  	fi
>  
> +	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
> +	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
> +
> +	if [ "$TST_SECURITY_WARN" = 1 ]; then
> +		tst_apparmor_enabled && \
> +			tst_res TINFO "AppArmor enabled, this may affect test results. Disable it with TST_DISABLE_APPARMOR=1 (requires super/root)"
> +		tst_selinux_enabled && \
> +			tst_res TINFO "SELinux enabled, this may affect test results. Disable it with TST_DISABLE_SELINUX=1 (requires super/root)"
> +	fi
> +
>  	tst_test_cmds $TST_NEEDS_CMDS

Since it may not affect test results, I don't think we should complicate
the tests with TST_SECURITY_WARN parameter. The usage is not obvious either.
Whether the test used dnsmasq or ping, for example, can be obtained from
$TST_NEEDS_CMDS.

And it's better to write these messages only if the test fails, suggesting
to change configuration.
