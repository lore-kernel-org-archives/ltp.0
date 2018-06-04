From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Jun 2018 17:33:24 +0200
Subject: [LTP] [RFC PATCH 6/9] testcases: wc: Add "unrecognized option"
 as TCONF
In-Reply-To: <20180423094639.14612-7-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-7-mylene.josserand@bootlin.com>
Message-ID: <20180604153324.zr7yd6lj73egfeuo@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Myl=C3=A8ne,

> In case we are using Busybox, for example, some options
> may not available and leads to a test failure.
> This commit adds "unrecognized option" parsing to return the
> test as a TCONF and not FAIL anymore.
...
>  testcases/commands/wc/wc01.sh | 2 +-
...
> -		grep -q -E "unknown option|invalid option" temp
> +		grep -q -E "unknown option|invalid option|unrecognized option" temp

Pushed, thanks!


Kind regards,
Petr
