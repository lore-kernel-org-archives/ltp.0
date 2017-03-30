From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 17:43:58 +0200
Subject: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New
 API
In-Reply-To: <20170328032239.11917-1-liwang@redhat.com>
References: <20170328032239.11917-1-liwang@redhat.com>
Message-ID: <20170330154358.GC886@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Seems the failed reason in oom02/5 is not testcase issue, it just because New API sets
> test time in 5mins.

The test_test structure has .timeout variable that, if set, overrides
the default timeout. All you need to do is to to measure how long the
test takes, then multiply it by something as 2 to be on a safe side
and set the .timeout correspondingly.

-- 
Cyril Hrubis
chrubis@suse.cz
