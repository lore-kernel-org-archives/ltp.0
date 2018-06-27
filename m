From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jun 2018 15:44:30 +0200
Subject: [LTP] [RFC] [PATCH] tst_test: Fail the test subprocess cannot
	be	killed
In-Reply-To: <937810331.29259972.1530105689475.JavaMail.zimbra@redhat.com>
References: <20180627123606.27726-1-chrubis@suse.cz>
 <937810331.29259972.1530105689475.JavaMail.zimbra@redhat.com>
Message-ID: <20180627134430.GA32300@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Looks good to me.
> 
> I'm thinking if we shouldn't also try to gather some data
> that would help person looking at the logs. For example:
> collect /proc/<pid>/stack output or trigger sysrq-t or sysrq-w.

I guess that we can search for a process whoose process group matches
our test pid then dump the stack into a log, I will look into that.

-- 
Cyril Hrubis
chrubis@suse.cz
