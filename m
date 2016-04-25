From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Apr 2016 17:07:35 +0200
Subject: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open()
 + O_TMPFILE'
In-Reply-To: <571E33E0.5040807@oracle.com>
References: <1454069150-27889-1-git-send-email-alexey.kodanev@oracle.com>
 <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
 <1689676802.79541.1461594932412.JavaMail.zimbra@redhat.com>
 <571E33E0.5040807@oracle.com>
Message-ID: <20160425150735.GE20158@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If the issue with mode... it can be because glibc doesn't process mode
> argument unless O_CREAT is found. In our case we have O_TMPFILE instead.
> 
> Here is the link to bugzilla:
> 
> "open() and openat() ignore 'mode' with O_TMPFILE"
> https://sourceware.org/bugzilla/show_bug.cgi?id=17523

What I see matches the the behavior in Comment 5.

-- 
Cyril Hrubis
chrubis@suse.cz
