From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Nov 2020 11:38:20 +0100
Subject: [LTP] [PATCH v2 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <CAEemH2cOcAuoPcks4FPaTaS-THtjPvy+=uB3oGsnTSNp_umpMg@mail.gmail.com>
References: <20201027110446.20416-1-chrubis@suse.cz>
 <20201027110446.20416-3-chrubis@suse.cz>
 <CAEemH2cOcAuoPcks4FPaTaS-THtjPvy+=uB3oGsnTSNp_umpMg@mail.gmail.com>
Message-ID: <20201102103820.GA7653@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> But a tiny issue was found from my test, the tst_kconfig_check() would be
> failed to parse expression if reverse the sequence of the above string.
> 
> i.e.
> -       "CONFIG_MMU & CONFIG_EXT4_FS=m",
> +       "CONFIG_EXT4_FS=m & CONFIG_MMU",
> (Core dumped here)
> 
> But trying with =Num, it gets different errors:
> 
> "CONFIG_MMU & CONFIG_PGTABLE_LEVELS=4",
> (works well)
> 
> "CONFIG_PGTABLE_LEVELS=4 & CONFIG_MMU",
> (print Expression not satisfied!)

Looks like off by one in the strncmp() in the map() function, I will fix
that as well and send v3.

Thanks a lot for testing.

-- 
Cyril Hrubis
chrubis@suse.cz
