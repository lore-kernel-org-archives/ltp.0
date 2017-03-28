From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 14:27:08 +0200
Subject: [LTP] Failing tests (aio01/aio02) show up in log file but not
 failed list
In-Reply-To: <201703272218.v2RMIp4R006418@sellcey-dt.caveonetworks.com>
References: <201703272218.v2RMIp4R006418@sellcey-dt.caveonetworks.com>
Message-ID: <20170328122708.GE1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I noticed an odd thing when running LTP.  There are two tests that
> show up as FAIL in my results/LTP*.log file (aio01 and aio02) but are
> not listed in the LTP*.failed list in the output directory.

Can you post a snippet of the log that shows the failure?

I glanced over the code, but there does not seem to be any obvious
mistakes.

> Does anyone know why these tests don't get listed?  All my other
> failures show up in both places.

Without further debugging, no idea.

-- 
Cyril Hrubis
chrubis@suse.cz
