From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 21:10:08 +0100
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <20210129194144.31299-7-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz>
Message-ID: <YBRroFhaxdqCLv2i@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +	TST_TIMEOUT=$((dev_num*200))
Actually on heavy loaded machine this is not enough due BTRFS.
I can add something like dev_num*600 or even -1 (then previous commit would not
be needed, but IMHO still useful).

Kind regards,
Petr
