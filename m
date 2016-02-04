From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Feb 2016 15:28:30 +0100
Subject: [LTP] [PATCH] ftrace_stress_test: check if tracing_enabled is
 supported
In-Reply-To: <1450934523-69837-1-git-send-email-chuhu@redhat.com>
References: <1450934523-69837-1-git-send-email-chuhu@redhat.com>
Message-ID: <20160204142830.GA11527@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When running the tests on RHEL7, got message as below:
> ---------
> /mnt/testarea/ltp/testcases/bin/ftrace_stress/ftrace_tracing_enabled.sh: line 25: /mnt/testarea/ltp/testcases/bin/debugfs/tracing/tracing_enabled: Permission denied
> /mnt/testarea/ltp/testcases/bin/ftrace_stress/ftrace_tracing_enabled.sh: line 26: /mnt/testarea/ltp/testcases/bin/debugfs/tracing/tracing_enabled: Permission denied
> ---------
> 
> The reason is that the tracing_enabled file has been removed
> since kernel v3.8 by commits:
> 
> 02404ba tracing: Remove deprecated tracing_enabled file
> 0fb9656 tracing: Make tracing_enabled be equal to tracing_on
> 6752ab4 tracing: Deprecate tracing_enabled for tracing_on

Looking at the commits shouldn't we use tracing_on instead of
tracing_enabled on newer kernels?

-- 
Cyril Hrubis
chrubis@suse.cz
