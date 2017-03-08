From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Mar 2017 12:19:30 +0100
Subject: [LTP] Running LTP results in read-only filesystem
In-Reply-To: <1488912047.22552.6.camel@caviumnetworks.com>
References: <1488912047.22552.6.camel@caviumnetworks.com>
Message-ID: <20170308111930.GA28037@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Has anyone run into a problem where running the LTP tests as root
> results in a read-only filesystem? ??I have been running LTP as root on
> an ubuntu 16.04 aarch64 system and it appears that when I do that my
> root filesystem gets set to read-only and then, when I reboot to try
> and fix the problem, the machine can't fsck itself and come back up
> without some human intervention. ??Has anyone else seen this problem?

I remember some FS journal corruptions on cheap SD cards being reported
some time agoI remember some FS journal corruptions on cheap SD cards
being reported some time ago. What filesystem do you use? Have you
checked dmesg output, is there anything related there?

-- 
Cyril Hrubis
chrubis@suse.cz
