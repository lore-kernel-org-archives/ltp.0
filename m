From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Jan 2017 15:34:44 +0100
Subject: [LTP] [PATCH] network: fix export for some non-bash shells
In-Reply-To: <20170110143256.wkmfloz3xr3ob6lj@dell5510>
References: <20161219125407.15954-1-pvorel@suse.cz>
 <20170110143256.wkmfloz3xr3ob6lj@dell5510>
Message-ID: <20170110143444.6mljcmalfnsgf3hq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi there,

> -export FOO=${FOO:-"foo with spaces"}
> +export "FOO=${FOO:-foo with spaces}"
Sorry I ment:
+export FOO="${FOO:-foo with spaces}"


Kind regards,
Petr
