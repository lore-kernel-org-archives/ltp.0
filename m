From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Feb 2016 15:57:29 +0100
Subject: [LTP] [PATCH 3/5] open_posix: condvar/schedule: remove useless
 waiting
In-Reply-To: <e33f0c95db65876824502f08c6e994dad29f4de8.1455875648.git.jstancek@redhat.com>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
 <e33f0c95db65876824502f08c6e994dad29f4de8.1455875648.git.jstancek@redhat.com>
Message-ID: <20160222145729.GA7406@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If high prio thread wakes up, test is done, there's no point waiting
> another 3 seconds for low prio thread to end its busy loop.
> 
> If test PASS-es, we save 3 seconds per test.

Looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
