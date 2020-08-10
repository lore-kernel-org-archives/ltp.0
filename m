From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Aug 2020 04:24:32 -0400 (EDT)
Subject: [LTP] [PATCH] Drop the mem01 test
In-Reply-To: <20200806162356.16920-1-mdoucha@suse.cz>
References: <20200806162356.16920-1-mdoucha@suse.cz>
Message-ID: <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> The mem01 test often fails on PPC systems mainly because it doesn't take into
> account page sizes larger than 4KB. Test scenario review revealed that it's
> not particularly useful because it doesn't have any more specific goal than
> filling large amount of memory and the hardcoded allocation limits are too
> low for modern and future systems. The useful part of this test mostly
> overlaps with coverage by existing OOM tests.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Acked-by: Jan Stancek <jstancek@redhat.com>

I'm fine with dropping it. Just curious, how is it failing? Do you see it
hit TFAIL, OOM or something else?

