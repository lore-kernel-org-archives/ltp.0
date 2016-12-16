From: Han Ning <ningx.han@intel.com>
Date: Fri, 16 Dec 2016 08:31:07 +0800
Subject: [LTP] [PATCH ltp] su01: do pre-checking to avoid annoying
	warnings
In-Reply-To: <20161215121237.GC29787@rei.suse.cz>
References: <1481504194-30726-1-git-send-email-ningx.han@intel.com>
 <20161215121237.GC29787@rei.suse.cz>
Message-ID: <20161216003107.GA16352@ninghanx>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Dec 15, 2016 at 01:12:37PM +0100, Cyril Hrubis wrote:
> Hi!
> > -        userdel $TEST_USER1
> > +        getent passwd $TEST_USER1 && userdel $TEST_USER1
> 
> Shouldn't we redirect the output from getent to /dev/null here?
Yes, we should. I'll send another patch for this. 

> 
> Otherwise it looks fine.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
