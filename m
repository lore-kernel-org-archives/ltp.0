From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Mar 2018 11:41:47 +0100
Subject: [LTP] [PATCH] mallocstress: extend test time on arm
In-Reply-To: <981e2a8523db8616a4ed442635a493928376489d.1520589632.git.jstancek@redhat.com>
References: <981e2a8523db8616a4ed442635a493928376489d.1520589632.git.jstancek@redhat.com>
Message-ID: <20180309104146.GA28698@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Arm systems with lot of memory and THP enabled are
> hitting a timeout at ~5 minute mark as reported here:
>   mallocstress poor performance with THP on arm64 system
>   https://marc.info/?l=linux-mm&m=151864950330870&w=2
> 
> Extend the timeout to 10m (only for arm).

What about extending it unconditionally? It's not like it will hurt in
generall case and there are possible other slow systems that would
benefit from that as well.

Or do you have a strong reason to extend the timeout only on arm?

-- 
Cyril Hrubis
chrubis@suse.cz
