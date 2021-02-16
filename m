From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Feb 2021 08:59:01 +0100
Subject: [LTP] [PATCH v2 2/2] close_range02: Add simpler test and Check
 invalid params
In-Reply-To: <20210216074748.6873-2-rpalethorpe@suse.com>
References: <20210216074748.6873-1-rpalethorpe@suse.com>
 <20210216074748.6873-2-rpalethorpe@suse.com>
Message-ID: <YCt7RUD/PeRkupr7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> This adds some coverage for invalid parameters and a min fd above or
> on the limits. There is also some overlap with close_range01, but this
> test is simpler and has less requirements.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---

> V2: Try Closing the path file descriptor at the end if it was opened
>     to prevent hitting the FD limit with -i

Thanks! And yes, using close_range() is much better than plain close().

Waiting little longer for feedback before merging.

Kind regards,
Petr
