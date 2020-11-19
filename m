From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 13:12:14 +0100
Subject: [LTP] [PATCH v4 2/3] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <20201119115230.8829-2-mdoucha@suse.cz>
References: <20201119115230.8829-1-mdoucha@suse.cz>
 <20201119115230.8829-2-mdoucha@suse.cz>
Message-ID: <20201119121214.GJ2785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN");

So this is being used in the test library, I guess that having the
config parsed here is inevitable, but still I do not want this function
to be exported for testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
