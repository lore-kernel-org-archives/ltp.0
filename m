From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 16:08:34 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <36530f0d-15ed-e9a4-4740-60805f33faf9@oracle.com>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
 <20180808130512.GD19147@rei>
 <36530f0d-15ed-e9a4-4740-60805f33faf9@oracle.com>
Message-ID: <20180808140834.GF19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That will possibly break on embedded systems that have everything
> > compiled-in kernel, not sure if there are any out there.
> 
> modprobe looks for modules.builtin as well and will just return 0 if
> it finds the driver there. But it might not be available for kernels
> before 2.6.33: bc081dd6e9f6 ("kbuild: generate modules.builtin").

I was also thinking of embedded hardware that does not even install
modprobe, but maybe I'm overthinking it and such special cases will have
to manualy specify what is supported and what is not, which would be at
least doable if we added a library function for checking what is
suppored.

-- 
Cyril Hrubis
chrubis@suse.cz
