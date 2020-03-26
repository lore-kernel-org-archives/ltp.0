From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 11:13:41 +0100
Subject: [LTP] [PATCH 1/2] Update syscalls/fsync02 to new API
In-Reply-To: <20200326111040.0bb5eb66@daedruan>
References: <20200324143837.51d2df15@daedruan>
 <4be42fd5-51e1-3716-2646-07cd06602262@suse.cz>
 <20200326111040.0bb5eb66@daedruan>
Message-ID: <20200326101341.GA12365@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jozef, Martin,

> > >  	f_bavail = (stat_buf.f_bavail * stat_buf.f_frsize) /
> > > BLOCKSIZE;  

> > Looks like the original test has another bug here. The correct
> > calculation is:
> > f_bavail = (stat_buf.f_bavail * stat_buf.f_bsize) / BLOCKSIZE;

> > f_frsize is the fragment size, a fraction of a real block used for
> > features like tail packing (stuffing multiple small files into the
> > same physical block). But file systems which don't support tail
> > packing generally have f_frsize == f_bsize.

> > Sorry for not noticing this earlier. Could you include a fix for this
> > in the second patch?
Martin, thanks for catching this.

> No problem Martin, I will fix it.

Thanks, Jozef. Waiting for v2.

Kind regards,
Petr
