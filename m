From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 May 2019 17:30:03 +0200
Subject: [LTP] [PATCH 2/2] net/tracepath: Rewrite into new API
In-Reply-To: <946495a7-4f75-4cca-163d-9447818bf1c3@oracle.com>
References: <20190429072800.23067-1-pvorel@suse.cz>
 <20190429072800.23067-2-pvorel@suse.cz>
 <946495a7-4f75-4cca-163d-9447818bf1c3@oracle.com>
Message-ID: <20190501153003.GA19942@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 29.04.2019 10:28, Petr Vorel wrote:
> > enhancements:
> > * Check for tracepath -6 when tracepath6 not available
> >   tracepath6 was removed in iputils s20161105 and replaced by tracepath -6,
> >   this way it's portable for both all iputils releases

> > * Print tracepath version if -V is available (added in inputils s20190324)

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../network/tcp_cmds/tracepath/tracepath01.sh | 60 +++++++++----------
> >  1 file changed, 29 insertions(+), 31 deletions(-)


> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Thanks for a review, merged.

Kind regards,
Petr
