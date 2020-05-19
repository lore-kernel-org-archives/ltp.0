From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 19 May 2020 07:10:51 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Warn about setup/cleanup
 function not loaded
In-Reply-To: <20200518130132.19312-2-pvorel@suse.cz>
References: <20200518130132.19312-1-pvorel@suse.cz>
 <20200518130132.19312-2-pvorel@suse.cz>
Message-ID: <033366de-ed10-f494-600a-51aed8639613@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

this looks good, just one small typo. And I guess I would raise this to 
TBROK, but that
is just my personal preference :)

Am 18.05.2020 um 15:01 schrieb Petr Vorel:
> +		if type "$TST_CLEANUP" >/dev/null 2>&1; then
> +			$TST_CLEANUP
> +		else
> +			tst_res TWARN "cleanup function set (TST_SETUP='$TST_CLEANUP'), but not found (test bug)"
This should probably be TST_CLEANUP=....


J?rg
