From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jul 2021 15:02:12 +0200
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <YPlsK8fsMI8T+H7c@pevik>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <20210712075223.10682-2-aleksei.kodanev@bell-sw.com>
 <YPkkZ0Zq9DyHKBaT@pevik> <YPlhMeRRsNnemT05@yuki>
 <YPlsK8fsMI8T+H7c@pevik>
Message-ID: <YPlsVD2gbIiX8JJk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think that we allready discussed this in another thread:
> 
> > https://lists.linux.it/pipermail/ltp/2021-July/023831.html
> 
> Thanks, I forgot this. In that case my approach (not using <=, but count
> segments in /proc/sysvipc/shm before testing) might be more precise.
> But no strong feeling about that, both solutions fix the test, let's chose one
> and merge.

As I said previously, there are many SysV IPC tests that do expect that
nobody will add/remove IPC shm/queue/semaphores during the testrun and
some of the testcases cannot even be implemented without this
expectation.

Hence I wouldn't complicate the test here and just count how many
segments are there at the start and be done with it.

-- 
Cyril Hrubis
chrubis@suse.cz
