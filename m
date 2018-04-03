From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Apr 2018 16:28:46 +0200
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
In-Reply-To: <20180330052307.b57csmyaqg74typ2@XZHOUW.usersys.redhat.com>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <20180326143313.GE27423@rei>
 <20180330052307.b57csmyaqg74typ2@XZHOUW.usersys.redhat.com>
Message-ID: <20180403142846.GA21301@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Finally get this helper working but does not reproduce the original
> bug we are trying to cover. I guess the testcase re-exec is necessary
> here.

Can't we have the helper to re-exec itself?

-- 
Cyril Hrubis
chrubis@suse.cz
