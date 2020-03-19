From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 19 Mar 2020 22:39:57 +0800
Subject: [LTP] [PATCH 3/3] zram/zram_lib.sh: set the compression
 algorithms back to default after test
In-Reply-To: <20200317182120.GB11295@dell5510>
References: <20190710072305.25806-1-po-hsu.lin@canonical.com>
 <20190710072305.25806-4-po-hsu.lin@canonical.com>
 <20200317182120.GB11295@dell5510>
Message-ID: <CAMy_GT9S6a7tFhjXHxmj+-+djjLbRzZP_HjXViX0QZSYF6kAHw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Yes you're right, the zram_cleanup() will kick in after zram01.sh finishes,
so this can be dropped for the moment I think.

Thanks for the review!


On Wed, Mar 18, 2020 at 2:21 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Po-Hsu,
>
> > Set the compression algorithm back to the default one in the end of the
> > zram_compress_alg() test.
>
> Why is this needed? We remove zram in zram_cleanup() anyway.
> This would make sense if we detect whether zram was loaded before testing and
> try to restore the setup of originally loaded module instead of always removing it.
>
> Kind regards,
> Petr
