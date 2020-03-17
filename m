From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 19:21:20 +0100
Subject: [LTP] [PATCH 3/3] zram/zram_lib.sh: set the compression
 algorithms back to default after test
In-Reply-To: <20190710072305.25806-4-po-hsu.lin@canonical.com>
References: <20190710072305.25806-1-po-hsu.lin@canonical.com>
 <20190710072305.25806-4-po-hsu.lin@canonical.com>
Message-ID: <20200317182120.GB11295@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Po-Hsu,

> Set the compression algorithm back to the default one in the end of the
> zram_compress_alg() test.

Why is this needed? We remove zram in zram_cleanup() anyway.
This would make sense if we detect whether zram was loaded before testing and
try to restore the setup of originally loaded module instead of always removing it.

Kind regards,
Petr
