From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Feb 2021 17:00:21 +0100
Subject: [LTP] [PATCH 1/2] lib: Add function to detect FIPS mode
In-Reply-To: <20210202130441.17861-1-pvorel@suse.cz>
References: <20210202130441.17861-1-pvorel@suse.cz>
Message-ID: <YCamFRCWW6a4zgLv@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef TST_FIPS_H__
> +#define TST_FIPS_H__
> +
> +#define PATH_FIPS	"/proc/sys/crypto/fips_enabled"

I'm not sure that this belongs to the header, at least it's not prefixed
with TST_.

Other than that Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
