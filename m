From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 5 Feb 2016 01:09:59 -0500 (EST)
Subject: [LTP] [PATCH] ftrace_stress_test: check if tracing_enabled is
 supported
In-Reply-To: <20160204142830.GA11527@rei.lan>
References: <1450934523-69837-1-git-send-email-chuhu@redhat.com>
 <20160204142830.GA11527@rei.lan>
Message-ID: <1334084235.16071004.1454652599010.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Thanks & Regards
Name: Chunyu Hu (???)
Team: kernel QE  --general
Phon: 8388193 , 861062608193  
IRC : chunyu
Mail: chuhu@redhat.com
Red Hat China R&D Branch (Raycom)

----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chuyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it, srostedt@redhat.com
> Sent: Thursday, February 4, 2016 10:28:30 PM
> Subject: Re: [LTP] [PATCH] ftrace_stress_test: check if tracing_enabled is supported
> 
> Hi!
> > When running the tests on RHEL7, got message as below:
> > ---------
> > /mnt/testarea/ltp/testcases/bin/ftrace_stress/ftrace_tracing_enabled.sh:
> > line 25: /mnt/testarea/ltp/testcases/bin/debugfs/tracing/tracing_enabled:
> > Permission denied
> > /mnt/testarea/ltp/testcases/bin/ftrace_stress/ftrace_tracing_enabled.sh:
> > line 26: /mnt/testarea/ltp/testcases/bin/debugfs/tracing/tracing_enabled:
> > Permission denied
> > ---------
> > 
> > The reason is that the tracing_enabled file has been removed
> > since kernel v3.8 by commits:
> > 
> > 02404ba tracing: Remove deprecated tracing_enabled file
> > 0fb9656 tracing: Make tracing_enabled be equal to tracing_on
> > 6752ab4 tracing: Deprecate tracing_enabled for tracing_on
> 
> Looking at the commits shouldn't we use tracing_on instead of
> tracing_enabled on newer kernels?

Hi,

Thanks for review.Each script in this case is just responsible for one
trace file, In order to make this script aligned with the file name and
other scripts in this case,I didn't switch the tracing_enabled to tracing_on
in this script.It is just a light fix for avoiding the 'permission denied' 
warning log during testing.

There was a period that both the tracing_on and tracing_enabled exist in the tracing
directory.So remain the ftrace_tracing_enabled.sh there just for testing the
tracing_enabled file(through read/write parameter from/to the file) for old kernels that
supported this.And let it check if its target test file is there before reading/writing
against the file, if it's not there in new kernels,it will just keep sleeping in the loop.
And we have another script to test the 'tracing_on'.



> --
> Cyril Hrubis
> chrubis@suse.cz
>
