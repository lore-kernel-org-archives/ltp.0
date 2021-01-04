From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Jan 2021 10:47:44 +0100
Subject: [LTP] [PATCH] containers/netns: update netns shell test to new
 API
In-Reply-To: <20201211172047.26640-1-kory.maincent@bootlin.com>
References: <20201211172047.26640-1-kory.maincent@bootlin.com>
Message-ID: <X/LkQDXDehooa9wu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  .../kernel/containers/netns/netns_breakns.sh  |  60 ++++-----
>  .../kernel/containers/netns/netns_comm.sh     |  95 ++++++--------
>  .../kernel/containers/netns/netns_helper.sh   |  69 +++++-----
>  .../kernel/containers/netns/netns_sysfs.sh    | 118 +++++++-----------
>  4 files changed, 140 insertions(+), 202 deletions(-)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Generally looks good to me.

Before merge I'll drop bogus '# TEST CASE #N' and add few TINFO messages, e.g.:
tst_res TINFO "controlling device over netlink"

Thanks!

Kind regards,
Petr
