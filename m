From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Aug 2020 14:41:52 +0800
Subject: [LTP] [PATCH] Drop the mem01 test
In-Reply-To: <20200806162356.16920-1-mdoucha@suse.cz>
References: <20200806162356.16920-1-mdoucha@suse.cz>
Message-ID: <CAEemH2c0xkd8HwQ9NP8BdL3309wgbk-q+giWbdJfQoJdHBHCyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 7, 2020 at 12:24 AM Martin Doucha <mdoucha@suse.cz> wrote:

> The mem01 test often fails on PPC systems mainly because it doesn't take
> into
> account page sizes larger than 4KB. Test scenario review revealed that it's
> not particularly useful because it doesn't have any more specific goal than
> filling large amount of memory and the hardcoded allocation limits are too
> low for modern and future systems. The useful part of this test mostly
> overlaps with coverage by existing OOM tests.
>

Agree, we also use some other memory eater or stress tools
do the same testing, this mem01 test way looks not very necessary and older.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200807/07e59c58/attachment-0001.htm>
