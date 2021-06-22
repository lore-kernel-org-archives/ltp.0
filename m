From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 22 Jun 2021 17:11:20 +0100
Subject: [LTP] [PATCH] tst_rtnetlink: pass error codes using rtnl_errno
 variable
In-Reply-To: <20210622154804.19946-1-mdoucha@suse.cz>
References: <20210622154804.19946-1-mdoucha@suse.cz>
Message-ID: <871r8t6frr.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_rtnetlink.h |  2 ++
>  lib/tst_netdevice.c     | 26 +++++++++++++++-----------
>  lib/tst_rtnetlink.c     |  6 ++++--
>  3 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/include/tst_rtnetlink.h b/include/tst_rtnetlink.h
> index 12ec258f2..7c28f795d 100644
> --- a/include/tst_rtnetlink.h
> +++ b/include/tst_rtnetlink.h
> @@ -21,6 +21,8 @@ struct tst_rtnl_message {
>  	size_t payload_size;
>  };
>  
> +extern int rtnl_errno;

This is polluting the name space. I suppose it can be prepended
with tst_, but does the test author need to see this? Or you could even
just merge tst_netdevice and tst_rtnetlink.

Otherwise I think this approach is fine.

-- 
Thank you,
Richard.
