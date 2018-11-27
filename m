From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 17:29:28 +0100
Subject: [LTP] [Automated-testing] [PATCH v2] lib: Add library function
 for parsing kernel config
In-Reply-To: <20181127132117.21326-1-chrubis@suse.cz>
References: <20181127132117.21326-1-chrubis@suse.cz>
Message-ID: <20181127162928.GA5152@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice patch.

> +	/* Debian and derivatives */
> +	snprintf(path_buf, path_buf_len, "/boot/config-%s", un.release);
/boot/config-$(uname -r) use also non Debian (and it's derivates) distros :).

Kind regards,
Petr
