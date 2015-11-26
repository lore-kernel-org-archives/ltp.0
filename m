From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Nov 2015 15:50:39 +0100
Subject: [LTP] mtest01 parent/child process synchronization issue
In-Reply-To: <565591C8.7060308@redhat.com>
References: <564CACAF.1080201@redhat.com> <5652E62A.3090403@redhat.com>
 <565591C8.7060308@redhat.com>
Message-ID: <20151126145039.GE9276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am new to the list and I am not sure what the rules for posting
> patches are. Should I use 'git send-email', sign the patch or
> something?

The usual workflow is to tell git your name and email (git config
user.email foo_bar@email.com and git config user.name Foo Bar) and use
git commit -s. Then both git format-patch and git send-email would
produce signed patches.

> From 05227cd214ed7fcb5ba9e5234d06c3866bfe98dc Mon Sep 17 00:00:00 2001
> From: jvohanka <jvohanka@redhat.com>
> Date: Wed, 18 Nov 2015 14:39:21 +0100
> Subject: [PATCH] Watch for SIGCHLD in mtest01 in case the child gets killed by
>  oom-killer
> 
> The mtest01 checks that a specified amount of memory could be allocated.
> The memory allocation is performed by several child processes. Each
> child allocates certain amount of memory and then sends SIGRTMIN to
> the parent. The parent waits until it receives SIGRTMIN from all child
> processes or until the amount of free memory is decreased by at least
> the amount it tasked the children to allocate.
> The problem is that in certain situations the child process gets killed
> by oom-killer. The parent never receives SIGRTMIN from that process and
> there is not sufficient decrease in the amount of free memory, so
> the parent keeps waiting indefinitely.
> This patch fixes the above issue. It modifies the test in such a way that
> it also waits for SIGCHLD signal (which is sent when the oom-killer
> terminates the child process). If SIGCHLD is received the test FAILS.

Ah, and new patch is hidden as an atachement in the reply to the email.
I nearly missed it. Ideally new version of patch should be send (inline)
as a separate email with [PATCH vN] (where N increments with each
version) in subject.

-- 
Cyril Hrubis
chrubis@suse.cz
