From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 May 2016 16:13:00 +0200
Subject: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
In-Reply-To: <1504573593.43522272.1462434296013.JavaMail.zimbra@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
 <1460966656-28328-9-git-send-email-chuhu@redhat.com>
 <1460966656-28328-10-git-send-email-chuhu@redhat.com>
 <20160504145630.GE12244@rei.lan>
 <1857309330.43401385.1462376568052.JavaMail.zimbra@redhat.com>
 <1504573593.43522272.1462434296013.JavaMail.zimbra@redhat.com>
Message-ID: <20160510141300.GB20387@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> After i changing it to kill directly and retest it, i hit err message:
> 
> ftrace_trace_pipe.sh: line 18: kill: SIGKILL: invalid signal specification

That is because POSIX only accepts symbolic names without the SIG prefix
while kill from procps works with both.

The correct way to send SIGKILL is 'kill -KILL $pid'.

-- 
Cyril Hrubis
chrubis@suse.cz
