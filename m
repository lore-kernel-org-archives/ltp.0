From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Apr 2021 19:38:52 +0200
Subject: [LTP] [PATCH v2] pec: Fix multiple event test
In-Reply-To: <20210415090542.960158-1-lkml@jv-coder.de>
References: <20210415090542.960158-1-lkml@jv-coder.de>
Message-ID: <YHnLrGS1lXy5Awvk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

...
> +# Find a free file handle
> +free_fd()
> +{
> +	local fd
> +
> +	for fd in $(seq 200); do
> +		# Sapwn a new sh, because redirecting to a non existing file handle
> +		# will trigger a syntax error.
> +		/bin/sh -c ": 2>/dev/null >&$fd || : 2>/dev/null <&$fd" 2>/dev/null
Probably better to use sh -c "..."

> +		if [ $? -eq 2 ]; then
> +			echo $fd
> +			return
> +		fi
> +	done

maybe I do something wrong, but this version fails for me
(and I'm still testing it only on bash):

cn_pec 1 TINFO: timeout per run is 0h 5m 0s
cn_pec 1 TINFO: Test process events connector
cn_pec 1 TINFO: Testing fork event (nevents=10)
cn_pec 1 TBROK: No free filehandle found

I guess there is something wrong free_fd().

Kind regards,
Petr
