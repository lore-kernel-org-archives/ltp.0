From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Aug 2017 15:36:16 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/fanotify0[89]: add sanity check
 for FAN_CLOEXEC
In-Reply-To: <1502719311-18774-4-git-send-email-xzhou@redhat.com>
References: <20170811084138.GA3341@rei.lan>
 <1502719311-18774-1-git-send-email-xzhou@redhat.com>
 <1502719311-18774-4-git-send-email-xzhou@redhat.com>
Message-ID: <20170815133616.GD30800@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/syscalls/fanotify/fanotify08.c | 77 +++++++++++++++++++++++++
>  testcases/kernel/syscalls/fanotify/fanotify09.c | 77 +++++++++++++++++++++++++

There is no reason to put these tests into two separate files.

We even have that described in the tutorial:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#6-split-the-test

-- 
Cyril Hrubis
chrubis@suse.cz
