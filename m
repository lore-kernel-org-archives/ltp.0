From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Jan 2021 14:38:20 +0100
Subject: [LTP] [PATCH v6 2/3] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <20210112095759.11910-2-mdoucha@suse.cz>
References: <20210112095759.11910-1-mdoucha@suse.cz>
 <20210112095759.11910-2-mdoucha@suse.cz>
Message-ID: <YABJTK2hRHBjJ6lc@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int tst_secureboot_enabled(void)
> +{
> +	int fd;
> +	char data[5];
> +
> +	if (access(EFIVAR_SECUREBOOT, F_OK)) {
> +		tst_res(TINFO, "Efivar FS not available");
> +		return -1;
> +	}
> +
> +	fd = open(EFIVAR_SECUREBOOT, O_RDONLY);
> +
> +	if (fd == -1) {
> +		tst_res(TINFO | TERRNO,
> +			"Cannot open SecureBoot Efivar sysfile");
> +		return -1;
> +	} else if (fd < 0) {
> +		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
> +		return -1;
> +	}

If we change the access() above to R_OK we can just do SAFE_OPEN() here, right?

Other than this the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
