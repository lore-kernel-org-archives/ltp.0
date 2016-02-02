From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:02:15 +0100
Subject: [LTP] [PATCH V2 23/32] ptrace: Use int instead of enum
 __ptrace_request
In-Reply-To: <1452302060-103643-23-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-23-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202170215.GL19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> __ptrace_request is only available with glibc

Hmm the 'man ptrace' states that the first parameter is the
enum __ptrace_request, which hints that the type should be system
defined...

But I'm not agains fixing this, however I find the #ifdef useless. Let's
defined it as int everywhere instead.

-- 
Cyril Hrubis
chrubis@suse.cz
