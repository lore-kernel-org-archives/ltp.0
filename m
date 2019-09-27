From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Sep 2019 10:25:10 +0200
Subject: [LTP] copy_file_range() errno changes introduced in v5.3-rc1
In-Reply-To: <CAOQ4uxisQx1C7DXrcmq0gma4-bxbaPS5UNwpwnoDOtjYVypXwA@mail.gmail.com>
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510>
 <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
 <20190926175700.GA12619@x230>
 <CAOQ4uxisQx1C7DXrcmq0gma4-bxbaPS5UNwpwnoDOtjYVypXwA@mail.gmail.com>
Message-ID: <20190927082510.GA12604@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > LTP hasn't defined yet any policy about changing errnos,
> > as it's probably best to check whether change was intentional
> > (like your obvious fixes) or not.


> IIUC, copy_file_range02 was written after v5.3 changes to verify that
> copy_file_range
> stays unbroken.
> As such, I would suggest that you check if kernel supports cross-fs copy, like
> copy_file_range01 does and if it doesn't, skip the test entirely.
> If some one ever backports cross-fs copy to any distro stable kernel, then one
> would better also backkport all of those API fixes, otherwise test will fail.
Thanks for a tip, I'll send a patch today.

> Thanks,
> Amir.

Kind regards,
Petr
