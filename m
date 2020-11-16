From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 16 Nov 2020 19:19:53 +0100
Subject: [LTP] [PATCH] Define SYS_futex on 32bit arches using 64-bit
 time_t
In-Reply-To: <CAMKF1srem0H=hkjkD_Yb1qzyygbbosB06y9x6=g+PasASQrqRQ@mail.gmail.com>
References: <20201116003345.3261577-1-raj.khem@gmail.com>
 <20201116070857.GB81864@pevik>
 <CAMKF1sqjVMexm38VVt=grmL-K63=hyfA-0aoNyi=53TyFVXJ0w@mail.gmail.com>
 <20201116170320.GC152616@pevik>
 <CAMKF1srem0H=hkjkD_Yb1qzyygbbosB06y9x6=g+PasASQrqRQ@mail.gmail.com>
Message-ID: <20201116181953.GD152616@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

...
> I tested https://github.com/pevik/ltp/commit/a20107ab47554798e0de0347dd4d7259f01675af
> and it works fine. So please use this one.

Thanks for a confirmation, merged.

Kind regards,
Petr
