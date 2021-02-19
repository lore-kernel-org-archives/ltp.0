From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Feb 2021 10:18:06 +0100
Subject: [LTP] [PATCH 1/1] cve-2015-3290: Add -fomit-frame-pointer
In-Reply-To: <20210219075906.23914-1-pvorel@suse.cz>
References: <20210219075906.23914-1-pvorel@suse.cz>
Message-ID: <YC+CTiMZ7B9kM7ha@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> -cve-2015-3290:	CFLAGS += -pthread
> +cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer

Patch merged with slightly adjusted commit message.

Kind regards,
Petr
