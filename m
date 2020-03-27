From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 16:11:02 +0100
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: Add uart01 test
In-Reply-To: <20200327134707.4532-3-chrubis@suse.cz>
References: <20200327134707.4532-1-chrubis@suse.cz>
 <20200327134707.4532-3-chrubis@suse.cz>
Message-ID: <20200327151102.GA6563@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> +uart01_9600 uart01 -b 9600
> +uart01_19200 uart01 -b 19200
> +uart01_38400 uart01 -b 38400
> +uart01_57600 uart01 -b 57600
> +uart01_115200 uart01 -b 115200
Tested-by: Petr Vorel <pvorel@suse.cz>
on all speeds.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for porting serialcheck.c to LTP.

Kind regards,
Petr
