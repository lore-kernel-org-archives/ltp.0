From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 09:47:53 +0100
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Use CLOCK_MONOTONIC for -I
 option.
In-Reply-To: <2120958980.3059541.1516696262620.JavaMail.zimbra@redhat.com>
References: <20180122141931.12464-1-chrubis@suse.cz>
 <2120958980.3059541.1516696262620.JavaMail.zimbra@redhat.com>
Message-ID: <20180123084753.GB28385@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > CLOCK_MONOTONIC has been added to linux in the 2.5 development branch so
> > this syscall is available in all 2.6 kernels hence it's reasonable to be
> > used it in the test library at this point it has been 15 years after
> > all.
> 
> LGTM.
> Compile tested on rhel59 rhel62 rhel69 rhel7 rhel6i386.

After thinking about this yesterday I think that we should do the same
for the old library just to keep testcase behavior consistent.

I will look into that and send follow up patch today.

-- 
Cyril Hrubis
chrubis@suse.cz
