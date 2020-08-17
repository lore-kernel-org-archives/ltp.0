From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Aug 2020 14:34:03 +0200
Subject: [LTP] [PATCH 1/2] lib/tst_kvercmp: Add support to get distname
 for Ubuntu in tst_kvcmp_distname
In-Reply-To: <20200817120644.9401-2-po-hsu.lin@canonical.com>
References: <20200817120644.9401-1-po-hsu.lin@canonical.com>
 <20200817120644.9401-2-po-hsu.lin@canonical.com>
Message-ID: <20200817123403.GA8445@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> * 4.4.0-187-generic
> * 5.4.0-1021-kvm
> * 4.15.0-1093-azure
> 
> So it's better to grep for ^ID=ubuntu in /etc/os-release to determine
> the distname, instead of doing this from checking kver substring like
> what we did for RHEL / Oracle Linux
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  lib/tst_kvercmp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index dc3bb669b..349d45543 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -139,6 +139,11 @@ const char *tst_kvcmp_distname(const char *kver)
>  	if (strstr(kver, ".el6"))
>  		return "RHEL6";
>  
> +	// Special case for Ubuntu, kernel version cannot reveal the dist_name
> +	int rc = WEXITSTATUS(system("grep -q ^ID=ubuntu /etc/os-release 2>/dev/null"));
> +	if (rc == 0)
> +		return "UBUNTU";

Can we please properly parse the /etc/os-release file insetad of this
hackery?

It should be as easy as one SAFE_FILE_SCANF() in the case that the file
exists.

-- 
Cyril Hrubis
chrubis@suse.cz
