From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Feb 2017 10:37:01 +0100
Subject: [LTP] [PATCH] syscalls/mq_open: fix limits for queues_max
In-Reply-To: <1608152395.5261795.1487182761583.JavaMail.zimbra@redhat.com>
References: <1486384930-28588-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170215152406.GB29673@rei.lan>
 <956936356.5228861.1487177447794.JavaMail.zimbra@redhat.com>
 <1608152395.5261795.1487182761583.JavaMail.zimbra@redhat.com>
Message-ID: <20170216093701.GB5543@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Oh, I see, the testcase has changed:
>  8e49ed6b0fa2 "syscalls/mq_open: fix old tests + convert to use new API"
> I was using ltp-20170116. git HEAD fails for me too:

Yep, all but the fist testcase were ifdefed out, so we never tried to
set the max_queues to 0 at all, that explains it.

-- 
Cyril Hrubis
chrubis@suse.cz
