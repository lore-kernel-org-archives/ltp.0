From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jul 2021 14:14:41 +0200
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <YPkkZ0Zq9DyHKBaT@pevik>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <20210712075223.10682-2-aleksei.kodanev@bell-sw.com>
 <YPkkZ0Zq9DyHKBaT@pevik>
Message-ID: <YPlhMeRRsNnemT05@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In different patch [1] (I forget you already send patches to fix this) I counted
> items in /proc/sysvipc/shm. Not sure what is safer: <= looks a bit drastic
> (how about bug which reports ENOSPC much earlier than it should be?), but
> obviously new mapping from other program created in the middle of testing.

I think that we allready discussed this in another thread:

https://lists.linux.it/pipermail/ltp/2021-July/023831.html

-- 
Cyril Hrubis
chrubis@suse.cz
