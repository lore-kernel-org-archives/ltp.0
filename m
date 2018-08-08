From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 16:06:10 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
 supported" error
In-Reply-To: <20180808153150.19d1f172@windsurf>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
 <20180802141251.1571-2-mylene.josserand@bootlin.com>
 <1ef13fe5-debb-57ff-422b-b2b5d3460523@oracle.com>
 <20180808130512.GD19147@rei> <20180808153150.19d1f172@windsurf>
Message-ID: <20180808140610.GE19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That will possibly break on embedded systems that have everything
> > compiled-in kernel, not sure if there are any out there.
> 
> Perhaps LTP should require the kernel to be compiled with
> CONFIG_IKCONFIG_PROC=y, so that LTP tests can check in /proc/config.gz
> whether a given kernel feature is available or not ?

The problem is that several major distributions does not do that, so
it's not an option.

-- 
Cyril Hrubis
chrubis@suse.cz
