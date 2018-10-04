From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Oct 2018 11:17:43 +0200
Subject: [LTP] [PATCH v2 1/4] Testing statx syscall Timestamp fields
In-Reply-To: <20180904080152.22488-1-subash@zilogic.com>
References: <20180904080152.22488-1-subash@zilogic.com>
Message-ID: <20181004091743.GA18007@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at these tests they are almost identical, it would make much
sense to keep them in a single test, so that we will format and mount
the device only once at the start of the test, then we can execute the
four different test scenarios. That should save at least half of a
minute of a runtime. What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
