From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 9 Jun 2018 17:06:17 +0200
Subject: [LTP] [PATCH] macsec: fix double delete the tmp file
In-Reply-To: <20180609104138.8375-1-sunlw.fnst@cn.fujitsu.com>
References: <20180609104138.8375-1-sunlw.fnst@cn.fujitsu.com>
Message-ID: <20180609150616.GA18572@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Sun,

> The virt_cleanup and tst_ipsec_cleanup in both in the cleanup() which will 
> double delete the tmp file. and result to report below info:
> "rm: cannot remove ‘/tmp/ltp-ddLUcf8ACl/macsec01.6YQ9qGRNuC’: No such file 
> or directory"
Thanks for your patch. I've noticed that, but didn't try to fix that as macsec
tests run under new API doesn't complain, because tst_test.sh (unlike test.sh)
actually check whether directory exist. (Next week hopefully I'm going to send
patch which rewrites tests which uses ipsec_lib.sh and virt_lib.sh).

Your test introduces duplicity with tst_ipsec_cleanup, it's here 3 times
+ code in macsec02.sh uses spaces instead of tabs.

As the issue isn't specific and it's going to be fixed just by migrating to new
API, I'd propose not to accept it. Alexey, what do you think?


Kind regards,
Petr
