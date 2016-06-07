From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jun 2016 14:08:31 +0200
Subject: [LTP] [PATCH] linux_syscall_numbers: add sched_[get|set]attr
 for ppc and s390
In-Reply-To: <79dd48009e53a6a887967034b7c20f0c8665325d.1465301288.git.jstancek@redhat.com>
References: <79dd48009e53a6a887967034b7c20f0c8665325d.1465301288.git.jstancek@redhat.com>
Message-ID: <20160607120831.GA1801@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> sched_getattr and sched_setattr may fail on powerpc and s390
> on kernels > 3.14 with older userspace because LTP defines
> syscall numbers only for x86 and arm.
> 
> This patch adds also numbers for ppc and s390.

I would say that this falls into obviously right category, you should
have pushed this right away, nevertheless acked.

-- 
Cyril Hrubis
chrubis@suse.cz
