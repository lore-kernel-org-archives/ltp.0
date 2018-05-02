From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 May 2018 16:45:43 +0200
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: TCONF on basename error when
 setting TST_ID
In-Reply-To: <20180502134553.5429-1-pvorel@suse.cz>
References: <20180502134553.5429-1-pvorel@suse.cz>
Message-ID: <20180502144542.4wmenub3p3c7kega@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
>  if [ -z "$TST_ID" ]; then
> -	filename=$(basename $0)
> +	filename=$(basename $0) || \
> +		tst_brk TBROK "Failed to set TST_ID from \$0 ('$0'), fix it with setting TST_ID before sourcing tst_test.sh"
                ^
Here is going to be TCONF.

Kind regards,
Petr
