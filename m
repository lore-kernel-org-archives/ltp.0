From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2017 12:43:31 +0100
Subject: [LTP] [PATCH 1/4] getcwd01.c: cleanup && convert to new API
In-Reply-To: <20170117113818.GB10880@rei>
References: <1483949756-8685-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170117113818.GB10880@rei>
Message-ID: <20170117114330.GC10880@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm not sure if the newly added check for ERANGE is good idea, since
> depending on ordering of the checks in kernel it may either reutrn
> ERANGE, if size is checked first, or EFAULT if the buffer pointer is
> checked first. It may start to fail for no good reason if the order of
> kernel chesk ends up reversed.

And looks like glibc has non-standard extension to allocate the buffer
if NULL pointer is passed. The we should ifdef the case with

#ifdef __GLIBC__

#endif

-- 
Cyril Hrubis
chrubis@suse.cz
