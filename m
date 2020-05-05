From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 17:14:17 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2016-8655
In-Reply-To: <cdd26392-10a9-b952-361d-8308585c3980@suse.cz>
References: <20200505102456.13004-1-mdoucha@suse.cz>
 <20200505131724.GA21884@dell5510>
 <cdd26392-10a9-b952-361d-8308585c3980@suse.cz>
Message-ID: <20200505151417.GB9949@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> On 05. 05. 20 15:17, Petr Vorel wrote:
> > I wanted to propose after release dropping gcc 4 support by deleting CentOS 6
> > from Travis (but maybe we should drop it even now). To keep the support, it'd be
> > good to add lapi/if_packet.h with this definition.

> I don't really care about CentOS 6 either way but I'll add the new LAPI
> header and resubmit.
Thanks a lot!

And we should really decide when drop it.

Kind regards,
Petr
