From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Apr 2020 13:00:36 +0200
Subject: [LTP] [PATCH 2/2] net/sendfile01.sh: Rewrite into new API
In-Reply-To: <20200416104548.27897-2-pvorel@suse.cz>
References: <20200416104548.27897-1-pvorel@suse.cz>
 <20200416104548.27897-2-pvorel@suse.cz>
Message-ID: <20200416110036.GA30159@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Minor grammar:

> +		if [ $ret -eq 0 ]; then
> +			tst_res TPASS "coped file is the same as the original"
Typo copied file.
> +		elif [ $ret -gt 1 ]; then
> +			tst_brk TFAIL "cannot compare files"
> +		else
> +			tst_res TFAIL "the copied file differs from the original"
I guess it should be without "the"

Kind regards,
Petr
