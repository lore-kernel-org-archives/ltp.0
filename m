From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Aug 2018 10:42:40 +0200
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare
 according to behaviour difference.
In-Reply-To: <20180831083713.GA11320@dell5510>
References: <20180831132453.6461-1-junchi.chen@intel.com>
 <20180831083713.GA11320@dell5510>
Message-ID: <20180831084240.GB16417@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > ISSUE:
> >   The case is designed to test the behaviour diverse caused by kernel
> >   commit 0fb44559ffd6. And it failed for the new behaviour.
> 
> > ACTION:
> >   Add a version compare to split part of the test.
> 
> > Signed-off-by: Junchi Chen <junchi.chen@intel.com>
> 
> Merged, thanks!

I think that this should be reverted, until at least we got a clear
reply from kernel developers...

-- 
Cyril Hrubis
chrubis@suse.cz
