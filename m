From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Aug 2021 07:47:51 +0200
Subject: [LTP] [PATCH v2 1/2] shell: Add checkpoints api for new lib
In-Reply-To: <3b97b712-f9d3-c5d1-66ce-0f98f5f1cb4f@jv-coder.de>
References: <20210812043807.3497492-1-lkml@jv-coder.de>
 <YR+LAmVDEUcZ51Wt@pevik>
 <3b97b712-f9d3-c5d1-66ce-0f98f5f1cb4f@jv-coder.de>
Message-ID: <YSSIBzvto70b78th@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi Petr,

> On 8/20/2021 12:59 PM, Petr Vorel wrote:
> > Hi Joerg,

> > LGTM, good idea.

> > But I'd rename $LTP_IPC_PATH to $TST_IPC_PATH to follow conventions to new API
> > (There are also some LTP_* definitions in the legacy C API which were renamed as
> > TST_* in the new API).
> This would also require changing the C API, because the environment variable
> is used for communicating with it.
> I we want this, I guess it could be done in another changeset.
Ah, you right.


> > > +	if [ -n "$TST_NEEDS_CHECKPOINTS" -a -f "${LTP_IPC_PATH}" ]; then
> > nit (remove unnecessary {}):
> Could be changed while merging.
Sure.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
