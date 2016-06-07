From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jun 2016 12:25:41 +0200
Subject: [LTP] [PATCH V3-2 0/9] tracing: make ftrace tests to be extended
In-Reply-To: <1629088162.56102032.1465270703540.JavaMail.zimbra@redhat.com>
References: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
 <20160606154513.GC21264@rei>
 <1629088162.56102032.1465270703540.JavaMail.zimbra@redhat.com>
Message-ID: <20160607102541.GA32299@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for the patience on reviewing the patch and the excellent ideas!
> 
> I really like your two proposed tool to verify bashism code, paste it here
> again and hope it can help others too.
> 
> 1) Check bashism issue through dash, compile it from source:
>     http://gondor.apana.org.au/~herbert/dash/files/
> 
> 2) debian devel perl script that can check for bashism,
>     https://anonscm.debian.org/cgit/collab-maint/devscripts.git/tree/scripts/checkbashisms.pl

I've added note about these into test-writing-guidelines:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style

-- 
Cyril Hrubis
chrubis@suse.cz
