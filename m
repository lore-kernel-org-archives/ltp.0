From: Chunyu Hu <chuhu@redhat.com>
Date: Mon, 6 Jun 2016 23:38:23 -0400 (EDT)
Subject: [LTP] [PATCH V3-2 0/9] tracing: make ftrace tests to be extended
In-Reply-To: <20160606154513.GC21264@rei>
References: <1462966591-3895-1-git-send-email-chuhu@redhat.com>
 <20160606154513.GC21264@rei>
Message-ID: <1629088162.56102032.1465270703540.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it, liwang@redhat.com
> Sent: Monday, June 6, 2016 11:45:13 PM
> Subject: Re: [PATCH V3-2 0/9] tracing: make ftrace tests to be extended
> 
> Hi!
> I've reorganized the patchset so that fixes are before new testcases and
> pushed, thanks.

Thanks for the patience on reviewing the patch and the excellent ideas!

I really like your two proposed tool to verify bashism code, paste it here
again and hope it can help others too.

1) Check bashism issue through dash, compile it from source:
    http://gondor.apana.org.au/~herbert/dash/files/

2) debian devel perl script that can check for bashism,
    https://anonscm.debian.org/cgit/collab-maint/devscripts.git/tree/scripts/checkbashisms.pl

 
