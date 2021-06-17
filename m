From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Jun 2021 14:41:22 +0200
Subject: [LTP] [PATCH v3] ssh-stress: Convert to new api
In-Reply-To: <38b6582d-fdfa-b661-27f9-bdcd2962b96b@jv-coder.de>
References: <20210616081856.3026223-1-lkml@jv-coder.de>
 <YMrbQPcfS9xFOBpO@pevik>
 <38b6582d-fdfa-b661-27f9-bdcd2962b96b@jv-coder.de>
Message-ID: <YMtC8usB3gZsN8cd@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi Petr,

> On 6/17/2021 7:18 AM, Petr Vorel wrote:
> > Hi Joerg, Alexey,

> > merged! Thanks both for your time.
> thanks, but you should have removed my "changes in v3" from the commit
> message :)
Oh yes, although I usually check commit message, I haven't noticed.

> Was I supposed to place stuff like that somewhere else in the mail, to
> prevent it from being merged?

Anything after first '---' in git format-patch output won't be included in
commit message imported by git am. example: [1]

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210512100746.5907-1-pvorel@suse.cz/
