From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 11 May 2016 07:01:38 -0400 (EDT)
Subject: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
In-Reply-To: <20160510141300.GB20387@rei>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
 <1460966656-28328-9-git-send-email-chuhu@redhat.com>
 <1460966656-28328-10-git-send-email-chuhu@redhat.com>
 <20160504145630.GE12244@rei.lan>
 <1857309330.43401385.1462376568052.JavaMail.zimbra@redhat.com>
 <1504573593.43522272.1462434296013.JavaMail.zimbra@redhat.com>
 <20160510141300.GB20387@rei>
Message-ID: <254083806.45357031.1462964498566.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: liwan@redhat.com, ltp@lists.linux.it
> Sent: Tuesday, May 10, 2016 10:13:00 PM
> Subject: Re: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
> 
> Hi!
> > After i changing it to kill directly and retest it, i hit err message:
> > 
> > ftrace_trace_pipe.sh: line 18: kill: SIGKILL: invalid signal specification
> 
> That is because POSIX only accepts symbolic names without the SIG prefix
> while kill from procps works with both.
> 
> The correct way to send SIGKILL is 'kill -KILL $pid'.

Thanks. Really makes sense.  Will fix it with V3-2. please ignore the previous V3. that's not complete
considering this.

> --
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Regards,
Chunyu Hu

