From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Apr 2016 12:43:55 +0200
Subject: [LTP] [PATCH] pause01: race condition
In-Reply-To: <2025858883.19408123.1459936700109.JavaMail.zimbra@redhat.com>
References: <1459883500-11524-1-git-send-email-ynorov@caviumnetworks.com>
 <2025858883.19408123.1459936700109.JavaMail.zimbra@redhat.com>
Message-ID: <20160406104355.GB19271@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Alarm may come before pause() is called, and be hiddenly dropped by go()
> > handler. Next pause() call hangs test forever.
> > 
> > Next hack helps me, though it's not a proper fix. Frankly, I don't
> > realise how to fix the test properly because sequence of settimer() and
> > pause() is not atomic, and any il_value we choose is not safe.
> 
> I've seen this hang once in past. At the time I was thinking
> we use 2 processes. Parent will fork a child and wait.
> Just before child calls pause() we signal parent and
> parent will call tst_process_state_wait() to wait until
> child process falls asleep (on pause() call).
> Then parent can send a signal to child and check it wakes up.

I was about to suggest the same.

-- 
Cyril Hrubis
chrubis@suse.cz
